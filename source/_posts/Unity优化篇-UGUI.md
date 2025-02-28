---
title: Unity优化篇-UGUI
date: 2025-02-28 14:51:27
categories:
    - 性能优化
description: Unity中Texture静态资源优化点总结整理
---
## Unity UI性能四类问题
1. Cavas Re-batch时间过场
2. Canvas Over-dirty，Rebathc次数过多
3. 生成网格顶点时间过长
4. Fill-rate overutilization

### 合批
Canvas dirty了就无法进行合批, 将进行re-batch操作
1. 根据UI元素深度关系进行排序
2. 检查UI元素的覆盖关系
3. 检查元素材质并进行合批

### Rebuild过程
- WillRenderCanvases -> PerformUpdate::CanvasUpdateRegistry
  - Rebuild Dirty的Layout组件
  - 用过ClippingRegisttry.Cullf方法对已经注册了Mask的对象进行裁剪提出操作
  - Dirty的Graphics Components会被要求重新生成图形元素
- Layout Rebuild
  - UI元素位置, 大小，颜色
  - 优先计算靠近root节点，并根据层级深度排序
- Graphic Rebuild
  - 顶点数据被标记为dirty
  - 材质或贴图数据被标记dirty

### 使用Canvas基本规则
1. 可能打断合批的曾移到最下面的图层，避免UI元素出先重叠区
2. 拆分多个canvas减少 Canvas的Rebatch复杂度
3. 动态分离
4. 不使用Layout组件
5. canvas使用Overlay模式，减少camera开销

### Raycast 射线检测
1. 需要交互的开启Raycast Target
2. 在层级浅的UI节点开启检测
3. canvas overriderSorting 属性会打断射线，可以降低层级遍历的成本

## UI字体
1. 避免字体框重叠，造成合批打断
2. 字体网格重建
   1. UIText 组件发生变化
   2. 父级对象发生变化
   3. UI组件或对象enable/disable

## 滚动视图 Scroll View
1. 使用RectMask2d组件裁剪
2. 使用基于位置的对象池作为实例化缓存


## UI控件优化注意
1. 不需要交互的UI元素关闭Raycast Target选项
2. 较大的背景图UI元素使用Sprite九宫格拉伸处理，减小Sprite大小，提高atlas图集利用率
3. 对于不可见的UI，不要使用修改透明度和/active/deactive UI空间进行显隐，网格依然会绘制
4. 使用全屏UI时，隐藏后面的所有内容
5. 非全屏但模态对话框时，使用OnDemandRendering
6. 优化裁剪UI Shader,根据实际使用需求移除多余特性关键字