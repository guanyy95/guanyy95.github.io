---
title: Unity优化篇-Texture纹理
date: 2025-02-28 10:55:05
categories:
    - 性能优化
tags:
description: Unity中Texture静态资源优化点总结整理
---

## Texture纹理
### 导入设置

1. Alpha Source选择Input Texture Alpha
2. Alpha Is Transparency: 默认不勾选
3. Igonre Png file gamma: 默认不勾选
   
Advanced:
1. Read/Write: 默认不开启
2. Mipmap: 2D或摄像机固定视角远近没有改变，不开启。

CheckList:
1. 纹理资源大小长宽均为2的幂次
2. 纹理过大的问题，纹理尺寸大于1024 * 1024
3. 纹理图集利用率偏低
4. 同一图集中的纹理生命周期不同，导致纹理资源长期贮存内存
5. 过大不合理的半透明我呢里，增加了Overdraw
6. 大量的2D序列帧动画
7. 大量重复纹理与不合理的通道图
8. 可以使用九宫格的进行切图操作，减小资源占用大小