---
title: UnityMono生命周期
id: UnityMono生命周期
date: 2021-08-27 12:48:23
categories:
    - Unity
description: Unity Mono脚本生命周期
---
![在这里插入图片描述](https://img-blog.csdnimg.cn/2021012911312691.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L0JJZ2d5R3Vhbg==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdn.net/20180802163246330?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTQzNjEyODA=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
1. **初始状态**：
	Awake() 唤醒：当物体载入时立即调用一次，用于在游戏开始前进行初始化，判断满足某种条件执行此脚本this.enable = true
	OnEnable() 可用：当脚本对象启用时调用
2. **物理阶段**：
	FixedUpdate() 固定更新： 脚本启用后，固定事件被调用，适用于对游戏对象做物理操作，移动。
	设置更新频率：Edit->Project Setting->Time->Fixed Timestep ,默认值0.02s。
3. **游戏逻辑**：
	Update() 更新：脚本启用后，每次渲染场景时调用，频率与设备性能及渲染有关。
	LateUpdate() 延迟更新：在Update函数被调用后执行，适用于跟随逻辑
4.  **加粗样式**：
	OnGUI() 渲染：渲染和处理GUI事件是调用
	OnBecameVisible() 当可见：当MeshRender在任何相机上可见时调用。
	OnBecameInvisible 当不可见：当Mesh Render在任何相机上不可见时调用。
5. **结束阶段**：
	OnDisable() 当不可用：对象变为不可用和附属游戏对象非激活状态时次函数被调用。
	OnDestroy() 当销毁：当脚本销毁或附属的游戏对象被销毁时调用。
	OnApplicationQuit 当程序结束时被调用
	  
