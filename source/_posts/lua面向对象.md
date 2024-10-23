---
title: lua面向对象
id: lua面向对象
date: 2021-09-23 12:38:34
categories:
    - Lua
description: lua实现实例化和继承
---

在Lua这门语言中，和Javascript面向对象的原理十分相像，使用原型的方式进行对元数据的拷贝复制和拓展。借助原表(metatable)来限定一个原型的基本行为。

```lua
Object = {}
--实例化
function Object:new()
    local obj = {}
    self.__index = self
    setmetatable(obj, self)
    return obj    
end

--继承
function Object:subClass(className)
    _G[className] = {}
    local obj = _G(className)

    obj.base = self
    self.__index = self
    setmetatable(obj, self)
end
```