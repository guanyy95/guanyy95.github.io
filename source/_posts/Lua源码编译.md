---
title: Lua源码编译
id: Lua源码编译
date: 2021-10-25 23:58:09
categories:
    - Lua
description: Lua源码编译完整过程
---
# Lua源码编译

## 1.下载lua源码解压缩
## 2. VS创建.lib静态库项目

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0234daa6d7314c3ca3e0fab322ab8579~tplv-k3u1fbpfcp-watermark.image?)

![image.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2fa633d870034c3fa1308f5760f80fe5~tplv-k3u1fbpfcp-watermark.image?)

![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/eed495cc72fc43a789f3867db01e1c7f~tplv-k3u1fbpfcp-watermark.image?)

![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ace5ccab3ba54fb3b086bd82758b425a~tplv-k3u1fbpfcp-watermark.image?)

![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/88a1d16af4054e8abc7342469bf3ad3f~tplv-k3u1fbpfcp-watermark.image?)

![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a029afd272a547deab1be359d4db458a~tplv-k3u1fbpfcp-watermark.image?)

Build Solution在工程Release文件夹中找到.lib文件，将文件拷贝到lua源码根目录下。

## 3.创建C++控制台Console Application

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/bebeec3ede794d9485aeb364e0ba802d~tplv-k3u1fbpfcp-watermark.image?)

![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ea06c7b7477b4cb290764fca256f4d2c~tplv-k3u1fbpfcp-watermark.image?)

选择链接器–输入–附加依赖项–输入我们所编译的lua5.4.1.lib库文件名称(刚才生成后拷贝到Lua源码目录下的静态链接库)。然后点击应用，确定就好了。

![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/37ba6abda01948c195da4341ee772798~tplv-k3u1fbpfcp-watermark.image?)

在C++工程中创建Main.lua文件脚本

![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8206f47f2c5d44ac969d0b3bca2aba5c~tplv-k3u1fbpfcp-watermark.image?)

Runlua.cpp作为虚拟机启动脚本

![image.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/12930d7e918b497f862100d26d4c95b9~tplv-k3u1fbpfcp-watermark.image?)

## 跑起项目输出lua脚本内容
