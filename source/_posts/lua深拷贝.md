---
title: lua深拷贝
id: lua深拷贝
date: 2021-09-22 08:48:10
categories:
    - Lua
description: 实现Lua的深拷贝
---
```lua
function DeepCopy1(obj)
    local InTable = {}
    local function Func(obj)
        if type(obj) ~= "table" then
            return obj
        end
        local NewTable = {}
        InTable[obj] = NewTable
        for k, v in pairs(obj) do
        NewTable[Func(k)] = Func(v) 
        end
        return setmetatable(NewTable, getmetatable(obj))
    end
    return Func(obj)
end
```

```lua
function DeepCopy2(obj)
    function copy(obj)
        if type(obj) ~= "table" then
            return obj
        end

        local newTable = {}
        for k,v in pairs(obj) do
            newTable[copy(k)] = copy(v)
        end
        return setmetatable(newTable, getmetatable(obj))
    end

    return copy(obj)
end
```

