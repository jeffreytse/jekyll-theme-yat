---
layout: post
title: Extended commands
subtitle: Each post also has a subtitle
categories: markdown
tags: [Linux]
---

## mkpasswd 命令生成随机复杂密码

mkpasswd命令生成随机复杂密码，前提安装expect，然后执行mkpasswd命令即可生成随机的密码。

一、基本的命令安装
安装expect：   yum install -y expect


    -l #      (密码的长度定义, 默认是 9)
    -d #      (数字个数, 默认是 2)
    -c #      (小写字符, 默认是 3)
    -C #      (大写字符, 默认是 2)
    -s #      (特殊字符, 默认是  1)
    -v        (详细。。。)
    -p prog   (程序设置密码, 默认是 passwd)

详细参数，用如下命令查看：

创建了一个长度为20位,包括数字个数5个，包含小写字母个数5个，包含大写字母个数5个，包含特殊符号个数5个。

```
mkpasswd  -l 20 -d 5 -c 5 -C 5 -s 5 
Z}K7hp0UPJ6v@&,c5{d3
```

随机密码最短只能7位（两个数字，两个小写字母，两个大写字母，一个特殊符号）

```
mkpasswd -l 5
impossible to generate 5-character password with 2 numbers, 2 lowercase letters, 2 uppercase letters and 1 special characters.

```



## bc 计算器

bc 命令是任意精度计算器语言，通常在linux下当计算器用。它类似基本的计算器, 使用这个计算器可以做基本的数学运算。

- -i：强制进入交互式模式；
- -l：定义使用的标准数学库
- ； -w：对POSIX bc的扩展给出警告信息；
- -q：不打印正常的GNU bc环境信息；
- -v：显示指令版本信息；
- -h：显示指令的帮助信息。

+ quit： 退出

**通过管道符**

```
$ echo "15+5" | bc
20
```

scale=2 设小数位，2 代表保留两位:

```
$ echo 'scale=2; (2.777 - 1.4744)/1' | bc
1.30
```

bc 除了 scale 来设定小数位之外，还有 ibase 和 obase 来其它进制的运算:

```
$ echo "ibase=2;111" |bc
7
```

**进制转换**

```
#!/bin/bash

abc=192 
echo "obase=2;$abc" | bc
```

执行结果为：11000000，这是用bc将十进制转换成二进制。

```
#!/bin/bash 

abc=11000000 
echo "obase=10;ibase=2;$abc" | bc
```

执行结果为：192，这是用bc将二进制转换为十进制。

计算平方和平方根：

```
$ echo "10^10" | bc 
10000000000
$ echo "sqrt(100)" | bc
10
```
