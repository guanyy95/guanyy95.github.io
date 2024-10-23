---
title: 【游戏开发】UGUI合批问题
id: 【游戏开发】UGUI合批问题
date: 2023-07-22 12:25:20
categories:
    - Unity
description: 【游戏开发】UGUI合批问题
---
## 前言
最近正在面试的过程中，会发现面试中问到的关注点在平时工作中过于负责上层的业务了没有关注到。这次面试过程进行的时候也同时学习和做个记录

参考文章：[# UGUI合批源码分析及优化](https://blog.csdn.net/qq826364410/article/details/80983861)
## UGUI渲染的规则
UGUI中所有的绘制都会传递给Canvans，合批是以canvas为单位进行批次生成和渲染，Canvas可以嵌套包含canvas。

### Batching流程
1. 查看canvas alpha是否为0，是否隐藏，隐藏时不产生合批
2. UI层次结构发生变化，更新Batch的顺序，对UI元素的覆盖了几个元素为依据生成当前的depth，不渲染的元素初始化为-1，后面没有覆盖元素的话为0，有则+1
3. 然后对所有VisiableList里面canvas节点下的元素进行排序（深度、materialInstanceID材质、textureInstanceID贴图），
4. 决定合批：按照VisiableList排序后的元素逐个进行合批判断，此时只看相邻的元素材质和贴图是否相同，相同则可合批

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/303c3925a15a45efa57dd2b2ff0bd23d~tplv-k3u1fbpfcp-watermark.image?)
![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/78c9b708d5254a8a87692bfb6815ddac~tplv-k3u1fbpfcp-watermark.image?)

注意：在Depth计算算法中，由于要遍历所有UI元素和已计算的底层UI元素（平方复杂度），源码中使用分组计算包围盒矩形的方法加快计算，即16个UI元素为一组计算Group Rect，检查是否与底层UI元素相交时，先计算是否与底层Group相交，如果相交再与Group中的元素做判定。

因此，UI元素数目过多和层次结构过于复杂，会影响排序和Batch更新速度，合理规划UI元素数量和层次结构可以提高UI性能。

**小结：**

从UGUI批次合并生成规则可以看出，提高UI性能尽量注意以下几点：

-   尽量避免使用Mask，使用Mask至少增加两个Drawcall，并可能导致本可以Batch的UI元素无法Batch，从而增加更多Drawcall。
-   避免在UI树形结构下（Canvas下）频繁删除/增加UI对象，UI层次结构发生变化会引起整个Canvas UI顺序更新，特别是复杂的UI树形结构。
-   避免频繁动态的更新UI元素的Vertex, Rect, Color, Material, Texture等，可能引起Canvas数据更新和Batch更新计算，有可能引起VBO Update（重新提交顶点数据）。
-   尽可能使用少的UI Material和贴图（使用图集），使得可以Batching。
-   相邻的UI元素（比如父节点与第一个子节点、相同层次结构下的节点），使用相同材质贴图的UI元素尽可能排在一起，便于合并。
-   同一父节点下所有子节点，保持相同的层次结构（如List控件下的item），便于底层相同depth下UI元素Batch。
-   避免UI元素数目过多和层次结构过于复杂影响Batch更新速度。
-   固定的Text考虑与背景图层合在一张图上（可能不便本地化，但可以减少drawcall）。
