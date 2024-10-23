---
title: Lua热加载实现方案
id: Lua热加载实现方案
date: 2022-06-05 20:07:24
categories:
    - Unity
description: Lua热加载的实现方法
---
# 前言
游戏开发的日常开发中，每当进行了View层或者逻辑代码的修改之后都需要重新启动引擎，如果修改的代码是C#则需要重新编译，如果是Lua、Python等脚本语言则需要重新执行启动main入口进行脚本的加载。常见的Lua热更新都是在客户端下载所有Lua代码之后重启游戏，实现重载所有数据和函数的目的。

除了热更新之外，还可以实现运行时热更。在玩家运行有的时候进行无感知的代码加载。Lua中可以使用require对文件进行加载以实现更新。简单的require会将数据层的模块修改，旧的数据或者缓存会被重置。

要实现比较合理的运行时热更新，除了设计热更的逻辑之外，前提是遵循一些约定。在规定热更新约定之前，先了解一下Lua热更新涉及的原理。

## 常见的热更新方案
本人公司的项目中使用了Lua进行逻辑层面的开发，项目中也支持Unity编辑器下的热重载功能，我对这个功能进行了一个简单的了解。Lua脚本语言可以依靠虚拟机的动态加载实现重载，C# 代码需要进行编译后执行。

### Lua热重载大致思路
编辑器下热重载的主要思路就是监听某个文件夹下的所有文件的变化，当有变化发生的时候重新require。这里面需要保持的原则就是更新替换新的function但是保持原有lua模块中的所有值，使用debug库获取upvalue进行数据的迁移，最后再替换旧的table并刷新_G表。

### 1. 实现监听文件变化
- Unity API: AssetPostprocessor

``` C#
List<string> hotLoadFiles = new List<stirng>();

class MyAllPostprocessor : AssetPostprocessor
{
    static void OnPostprocessAllAssets(string[] importedAssets, string[] deletedAssets, string[] movedAssets, string[] movedFromAssetPaths)
    {
        foreach (string str in importedAssets)
        {
            // str是文件的全路径，Reimported Asset: Assets/Lua/Test 1.lua
            // 匹配出Test1部分然后使用requre去加载
            if (!str.EndsWith(".lua") || str.Contains("Main.lua"))
                continue;
           
            hotLoadFiles.Add(str);
            -- 首先执行一遍热更新的逻辑控制代码
            for (int i = 0; i < hotLoadFiles.Count; i++) {
                 -- Todo 系统模块代码进行读值重载操作
                 LuaHotModule.Reload(hotLoadFiles[i]);
            }
            
            Debug.Log("Reimported Asset: " + str);
        }
        foreach (string str in deletedAssets)
        {
            Debug.Log("Deleted Asset: " + str);
        }

        for (int i = 0; i < movedAssets.Length; i++)
        {
            Debug.Log("Moved Asset: " + movedAssets[i] + " from: " + movedFromAssetPaths[i]);
        }
    }
}
```

- 使用Unity编辑器下的FileSystemWatcher

``` c#
if (!Directory.Exists(dirPath)) 
	return;
var watcher = new FileSystemWatcher();
watcher.IncludeSubdirectories = true;
watcher.Path = dirPath;
watcher.NotifyFilter = NotifyFilters.LastWrite;
watcher.Filter = "*.lua";
watcher.Changed += handler;
watcher.EnableRaisingEvents = true;
watcher.InternalBufferSize = 10240;
```
### 2. 实现Lua文件的热重载
#### require机制

Lua中对模块的管理可以使用Require函数来实现，把公用的代码放在一个目录下，然后用API接口进行调用。实现代码的解耦和重用。

Lua中的module是由变量、函数、和数据table组成。一个模块就是Lua中的一个table就可以作为一个模块，只要在lua文件中将其return就可以供外部进行使用，其使用方法和Javascript的模块管理使用方法类似。

```lua
-- test.lua
local test = Class()

test.name = "test"

function test:OnCreated()
end

function test:OnUpdated()
end

return test

-- main.lua
local testCls = require("test")
或
local testCls = require "test"

```
require之后，Lua本身会在package.loaded的table中缓存一份test.lua的模块数据，并且多次require只会执行一次，当loaded中有就返回package.loaded["test"]。实现模块的更新就是清空原有的模块数据，并且执行加载新的模块，如果只进行这种处理的化会发先，是模块中的缓存数据也会被清空，很多数据都只会在登录的时候进行赋值。所以实现热重载就需要更新模块的function，但是不更新模块中的upvalue。热重载不希望数据被覆盖或清空。使用Lua提供的API debug.getupvalue和debug.setupvalue可以对指定table进行数据的缓存和更新。函数在Lua中也会被当做upvalue,所以对对象需要判断是不是function类型。对于函数使用新的，对于数据使用旧的，对于table类型需要递归处理。

```lua
local oldModule = require "test"
package.loaded["test"] = nil
local newModule = require "test"

for i = 1, math.huge do
    local name, value = debug.getupvalue(oldModule, i)
    if not name then
        break
    end
    debug.setupvalue(newModule, i, value)
end

```
### 热更新规则
1. 遍历模块的所有数据，对象是table就保留旧模块的，对象是function就保存新得
2. function本身使用新的，function对象中的upvalue使用旧的
3. 使用debug.getmetatable获取table中的metatable进行更新和覆盖
