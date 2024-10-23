---
title: Unity渲染优先级总结
id: Unity渲染优先级总结
date: 2021-09-08 11:17:24
categories:
    - Unity
description: Unity渲染物体和组件规律总结
---
# Unity中的渲染类图关系

![image.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a8efd1550c7d4f1b8a852bf088996237~tplv-k3u1fbpfcp-watermark.image)

# UGUI系统中的渲染优先级
![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2e3f2635f85840aba7d16cd345fc3b54~tplv-k3u1fbpfcp-watermark.image)

## 显示优先级总共分为4类
### 1. 当Canvas为ScreenSpace-Overlay模式
在这种模式下，UGUI内容永远优先显示在所有物体前面，Canvas本身的渲染根据在Hireachy中的先手顺序有关，不同Canvas根据sortinglayer值决定。所有的3D物体均在Canvas之下渲染。

### 2. WorldSpace VS ScreenSpace模式
canvas渲染根据实际gameobject的z轴和sorting order或者是order in layer决定。

![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/d6d0fe7c0dcb49eab89e84a99f866d92~tplv-k3u1fbpfcp-watermark.image)

![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/6265c40808bb4702bc6f78f012ea4b45~tplv-k3u1fbpfcp-watermark.image)
### 3. SpriteRender与canvas的非Overlay模式
当canvas处于WorldSpace和ScreenSpace-Camera模式下时，基本就相当于SpriteRenderer，渲染方式是一致的。

如果把SpriteRenderer和WorldSpace、ScreenSpace-Overlay并列起来，可以看到这三者之中任何两者相交的渲染方式的影响参数和参数优先级是一致的(也就是上面思维导图中绿色背景内容)。
这里可以统一把这三种叫做 “三维空间中的平面渲染对象”。
### 4. MeshRender与三位空间平面渲染对象比较
规律根据导图橙色部分决定，MeshRender不受sorting order控制，只受position.z控制，z值越小越显示在更上层。