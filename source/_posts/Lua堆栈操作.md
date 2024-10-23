---
title: Lua堆栈操作
id: Lua堆栈操作
date: 2022-02-09 23:23:24
categories:
    - Lua
description: Lua堆栈基本操作及常用API
---

### Lua和 C交互
Lua和C的所有交互都是通过了栈。用简单的话来讲就是这个数据结构让Lua可以从栈中取数据和放数据，也可以让C来取数据和放数据。栈中的数据通过索引值进行定位，所有进栈的东西都有一个标号，这个标号就是index。

栈顶为-1，栈底为1（代表第一个入栈的元素）。正数表示相对于栈底的位置(第几位)，负数表示相遇栈顶的位置。

### 常用的几个C-API
- **lua_gettop()**

用于返回栈中元素的个数，同事也是栈顶元素的索引。栈中有多少个元素，就会return几。返回值是栈中元素个数，也同样是栈顶元素的index。

- **lua_settop(lua_State L, int index)**
用于把对战的栈顶索引设置为指定的数值。例如，一个栈有8个元素，调用函数index = 7，相当于堆栈的栈顶元素index 由 8 -> 7，操作相当于删除了栈顶元素。使用正数为从栈顶开始计算位置，如果使用负数为从栈底开始计算位置。

- **lua_pushvalue(lua_State L, int index)**
函数说明：Push a copy of the element at the given valid index onto the stack

10 20 30 40 50 * ->
lua_pushvalue(L, 3) ->
10 20 30 40 50 30 *
- **lua_remove(lua_State L, int index)**
lua_remove 删除指定给定索引的元素，并将这一所引致上的元素来填补空缺,
- **lua_replace(lua_State L, int index)**
lua replace将栈顶元素压入指定位置而不移动任何元素(因此指定位置的元素的值被替换)
10 20 30 40 50* -> lua_replace(L, 2) -> 10 50 30 40*

### C加载lua函数的用法
- **lua_getglobal(lua_State L, const char name)**
将全局name的值压到栈顶

- **lua_is(lua_State L, int index)**
检查变量是不是某个类型，index指示变量顺序，栈顶为-1

- **lua_to(lua_State L, int index)**
获取栈中的变量， 然后转化为某个指定的类型并且返回

- **lua_close()**
销毁所有在指定的Lua State上的所有对象，同时释放所有该State使用的动态分配的空间
