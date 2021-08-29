#  SDN简介

## 概念

SDN是一种新的网络体系结构,给传统网络带来最大的改变是网络可编程和开放性。网络用户追逐SDN的关键是想获得更多的网络可编程能力,获得更多的网络定制开发能力和自主权。SDN的开放分层架构加速了网络产业的参与度,越来越多的网络用户、网络软件公司和初创公司都加入到网络产业中来,这种开放竞争进一步加速整个产业的创新。

## SDN解读

> 网络开放可编程
>
> 数控分离（数据平面和控制平面的分离）
>
> 逻辑上集中控制

## 网络开放可编程发展

![1038B80C-0D25-425D-98D8-C44E1A9D812D](https://tva1.sinaimg.cn/large/007S8ZIlly1gg20qi3pgsj312z0dan6u.jpg)

## SDN的分层体系结构

![38794EFE-2395-41F4-A41B-8B19CB84BBF5](https://tva1.sinaimg.cn/large/007S8ZIlly1gg20skbiwfj30z10itgvv.jpg)

## SDN的工作原理

流表：Match, Action（匹配和操作）

![5CD0645A-980E-46B8-AB3C-37A1B25C7B3F](https://tva1.sinaimg.cn/large/007S8ZIlly1gg20vzlmyij30zz0j4ajg.jpg)

## SDN数据平面

![FFAC3DC0-648E-4687-A156-41839A8417E6](https://tva1.sinaimg.cn/large/007S8ZIlly1gg2107prxtj30xv0h5dnw.jpg)

## SDN控制平面

南向接口：管控下面的设备

东西向接口：控制器集群之间通信

![3F2D6C0F-4212-476B-949B-CB6D3588702E](https://tva1.sinaimg.cn/large/007S8ZIlly1gg216vk1cyj30xb0fmk2j.jpg)

## SDN控制平面发展历史

![D4996096-39DD-4A13-8345-1F6F6B69BE49](https://tva1.sinaimg.cn/large/007S8ZIlly1gg2196omhlj310e0fh78i.jpg)

## 开源SDN控制器比较

推荐：opendeylight、onos

![92EB15AD-8B2E-447A-B1A5-7AEC80882BF7](https://tva1.sinaimg.cn/large/007S8ZIlly1gg21azjka5j311y0ik10n.jpg)

##SDN典型应用

### 数据中心网络

> 多租户网络需求
>
> 传统问题：不停需要改变的虚机

![D3BA2A8A-8E35-4330-8C11-08EFCF6D86E7](https://tva1.sinaimg.cn/large/007S8ZIlly1gg21jf9iutj30o80im46n.jpg)

#### SDN在数据中心网络的应用

vSwitch：虚拟交换机，虚机和物理网络的一个接入功能

![3257C15E-8C37-43FB-B20D-99DD3673FF8B](https://tva1.sinaimg.cn/large/007S8ZIlly1gg21ncapajj30xy0ds46c.jpg)

两个解决方案：

> 1. 软件形式接入SDN控制器（NSX）
> 2. 升级硬件接入SDN控制器（ACI）

方案比较

![3211D846-6AEE-401C-831E-E1C49E85C65E](https://tva1.sinaimg.cn/large/007S8ZIlly1gg21srizmsj30t50dsn2t.jpg)

### 软件定义广域网-SDWAN

![E10C437A-66D6-4A2C-859E-1D60CF18DE68](https://tva1.sinaimg.cn/large/007S8ZIlly1gg227v5460j30vx0gj0zo.jpg)

### 其他应用场景

![0E1512E6-F981-4126-98EE-9253F9D70811](https://tva1.sinaimg.cn/large/007S8ZIlly1gg22fzdsp8j30so0h577q.jpg)

## 论文

> SDN论文至尊宝典
>
> SDN A Comprehensive Survey，2014-10 v3版本
>
> 科研方向：通用可编程数据平面、NPL（网络编程语言）、SDN和5G等交叉学科的融合

![9006186E-1D0B-40EA-A9BF-A50650BE8E00](https://tva1.sinaimg.cn/large/007S8ZIlly1gg22mxtfrpj30zg0i7doz.jpg)

