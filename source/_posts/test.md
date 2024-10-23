---
title: test
categories:
    - Testing
date: 2021-08-17 23:25:26
description: 测试文章使用基本内容进行测试
---

# 这是我的第一篇测试draft
今天在这里我进行我的第一篇博客文章发布测试，修改了一些基础配置，准备部署到阿里云

<!-- more -->
进行修改
``` java test.main
public static void main(String[] args){
    System.out.prinln("Hello World");
}
```

``` javascript test.js
consolo.log("Hello World");
let f = function(a, b){
    return a + b;
}
```

# 文章标签测试2
主动关闭的一方收到对端发出的FIN报之后，就从FIN-WAIT-2状态切换到TIME-WAIT状态了，再等待2MSL时间才再切换到CLOSED状态。这么做的原因在于：

确保被动关闭的一方有足够的时间收到ACK，如果没有收到会触发重传。
有足够的时间，以让该连接不会与后面的连接混在一起。
TIME-WAIT状态如果过多，会占用系统资源。Linux下有几个参数可以调整TIME-WAIT状态时间：


# 子级title文章标签测试
然而，从TCP状态转换图可以看出，主动进行关闭的链接才会进入TIME-WAIT状态，所以最好的办法：尽量不要让服务器主动关闭链接，除非一些异常情况，如客户端协议错误、客户端超时等等。

![avatar](https://res.cloudinary.com/dxyfflwfe/image/upload/v1629449456/BlogPics/15379746990786527ab845a_c5_q75_864x486_i5cc89.jpg)