---
title: Lua奇淫小技巧
id: Lua奇淫小技巧
date: 2022-12-10 19:16:31
categories: 
    - 编程语言
description: Lua奇淫小技常见的小坑
---
## 背景
工作中的项目主要是使用Unity + Lua的开发模式，日常需求基本使用lua开发各类模块。相比于传统的C# C++等常见语言，Lua有一些特别的小点会需要区分一下

### [Logical Operators 逻辑运算处理](http://www.lua.org/manual/5.4/manual.html#3.4.5) 
运算符有三种 and、or 和 not。所有的逻辑运算符值把false和nil都当做false进行处理，其余值都为true。
1. not ： negation总是返回false 或者 true
2. and : conjunction 如果第一个参数是false或者nil，就返回第一个参数，否则返回第二个参数

```Lua
nil and 10          --> nil
false and error()   --> false
false and nil       --> false
10 and 20           --> 20
nil == nil and 10   --> 10
```

3. or : disjunction 如果第一个参数不是false或者nil，则返回第一个参数，否则返回第二个参数
``` Lua
10 or 20            --> 10
10 or error()       --> 10
10 or 20            --> 10
10 or error()       --> 10
false or nil        --> nil
```
4. 开发中通常会使用两种方式使用，一个是类似三元运算符的用法，一个是设置默认值得方法
```Lua
-- 默认值设置
function set(val)
local a  = val or defaultVal

-- 三元判断
local bool = a and b or c
-- 此处有个常见的易错带你
业务中常用if进行判断一个对象是空nil还是有值if table[i] then
此时如果用同样的方法会得到错误的结果
a 如果为空 则直接返回nil而不是输出结果c，如果使用判断则需要注意将a需要是个boolean

local bool = a == nil and b or c
true and b -> b, 返回 b or c
false and b -> false, 返回false or c
如果a是空，则返回b 否则返回c
```
5. [运算符的优先度 ](http://www.lua.org/manual/5.4/manual.html#3.4.8)

当多个逻辑判断条件混用的时候，lua中需要注意一下顺序，not > ~ > and > or 
```Lua
     or
     and
     <     >     <=    >=    ~=    ==
     |
     ~
     &
     <<    >>
     ..
     +     -
     *     /     //    %
     unary operators (not   #     -     ~)
     ^
```
### [The Length Operator #长度运算符](http://www.lua.org/manual/5.4/manual.html#3.4.7)
能够做为长度索引的条件在Lua中是这样定义border的，当是个连续的sequence会return only border。当#对象不是一个sequence，结果是不定的。
```Lua
     (border == 0 or t[border] ~= nil) and
     (t[border + 1] == nil or border == math.maxinteger)
```
不适用默认的#运算规则，也可以自己重写__len metamethods
