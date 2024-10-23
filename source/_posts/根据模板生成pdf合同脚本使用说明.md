---
title: 根据模板生成pdf合同脚本使用说明
id: 根据模板生成pdf合同脚本使用说明
date: 2023-01-25 12:33:49
categories: 工具
description: 根据模板生成pdf合同脚本使用说明
---

## 0.0 背景
最近朋友有两个工作上小的需求，需要找外包开发个程序，想要一个桌面应用。他的需求是用模板根据不同用户的信息生成不同的合同，另一个本质就是一个计算器需求，根据几个变量参数计算税金的结果。

## 1.0 实现方法
第二个计算器没有什么特殊的，第一个根据网上现有的一些库看了看不同的实现方法，决定用一个比较简单去操作且性价比很高的方法。首先语言可以有多种选择，并且每种实现都会有对应的库来搞定这个需求。

1. JS + Electron，使用DocxTemplater(模板生成doc)、libre office(转化成pdf)
2. python + QT5，使用python-docx(模板生成doc)、docx2pdf、openpyxl

这次使用了第二种方法来实现，因为电脑没有配置electron一套的开发环境，就直接用python来实现了。这个方法的缺点就是有些局限，没法多端同步需要重写开发。QT的使用我觉得用处不大，目前仅仅是一个启动和一个生成文件名的显示，其实不用也可以，先留着给计算器需要的时候用吧。

## 2.0 使用方法

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f9027476954741e9ae101bc2fad3ae69~tplv-k3u1fbpfcp-watermark.image?)

- main.exe 脚本程序
- 1.docx 模板(支持多模板生成)
- data 数据生成表格(名称不能更改)

将main.exe文件放在项目工程的一级目录下,运行后点击生成即可。同级目录下的DocResults和PdfResults分别存放生成后的输出文件，没有此文件夹会先自动创建一个。

![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ac77780d65304e988eb490fca8b739ca~tplv-k3u1fbpfcp-watermark.image?)

### 2.1 data数据结构
1.docx
<img src="" alt="" width="50%" />
![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/65cb6f2814e843e6bcfe873ee2768687~tplv-k3u1fbpfcp-watermark.image?)

data.xlsx

![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/74d6f586fcf14fd6952df2d63b20a070~tplv-k3u1fbpfcp-watermark.image?)


data表中表头字段除了#模板号外需要与替换模板中一对一匹配，第一列为使用的模板参数，如需支持多个模板即创建同名模板放置在1级目录即可。只需维护好模板和data的对应即可，每一次生生成都会全量更新即每次更新都为最新结果。

## 后续优化
1. 不确定数量很多时会不会有问题，使用多线程进行生成操作
3. 对源码进行一个整理重构，使用QT信号更新UI。
4. 后续会将脚本上传Github
5. 第一种实现方案也放上参考链接 https://juejin.cn/post/7092775366317572104