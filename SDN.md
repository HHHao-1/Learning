# SDN简介

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

# OpenDayLight

SDN控制器开发运行平台

## SDN三层架构

![3283ED4F-3D10-4C57-8E3F-BF0B90B516A2](https://tva1.sinaimg.cn/large/007S8ZIlly1gg38ki2tyhj30wj0g0n33.jpg)

## ODL:发布的版本

![6774E528-9DDC-4178-BC94-12F06F39B597](https://tva1.sinaimg.cn/large/007S8ZIlly1gg4hkyxa6qj30xz0fitl0.jpg)

## 背景知识之OSGi

### 简介

> OSGi (Open Service Gateway Initiative,直译为"开放服务网关" )实际上是一个由OSG联盟发起的以Java为技术平台的动态模块化规范, OSGi不是一个应用层面的框架,而是设计层面的规范。软件设计就不外乎复用、内聚、耦合三个主题, OSGi作为Java的模块化规范,也是为了更好地解决Java在这三个主题的问题。OSG规定了如何定义一个Module以及这些模块之间如何交互。
>
> 在OSGi规范中, Java模块被称为Bundle, OSGi规范就是指导怎么令这些Bundle能更好的有高内聚性、有松耦性,能更好地被复用。基于OSGi的应用,就是由一个一个Bundle组成的,通过OSGi把这些Bunde组织在一起,就形成了系统。

### OSGi框架

![1A7EFAF1-40D9-4E6A-B886-F6CCDCEB5CFF](https://tva1.sinaimg.cn/large/007S8ZIlly1gg4j4lz2i8j31070cxqan.jpg)

### Bundle概念

> Bundle是OSGi中最基本的单位,通俗地讲,如果说OSGi是基于Java平台的"模块化开发体系" ,那Bundle便是其中的"模块“
>
> 一个符合OSGi规范的Bundle首先必须是一个符合JAR文件格式规范的JAR包,JAR文件格式规范里定义的/META-INF/MANIFEST.MF文件用于描述JAR包的元数据信息,如JAR包的版本、数字签名信息等, Bundle在MANIFEST.MF文件中添加了大量扩展定义,如描述该Bundle可以提供哪些资源、依赖哪些其他Bundle、启动或卸载时要执行哪些动作等

### Bundle生命周期

> installed：bundle初始安装状态，有可能依赖没被完全满足  
>
> resolved：dundle依赖都被满足状态
>
> active：已经启动成功的状态
>
> uninstalled：卸载；starting、stopping：瞬时的状态 

![E515E949-027A-4ECE-82E8-0F9C83AB6814](https://tva1.sinaimg.cn/large/007S8ZIlly1gg4jhs9xftj30og0hfwhw.jpg)

### Bundle间的依赖

> OSGi对Java平台的类加载机制的一个重要改进就是支持包级别的类导入和导出。在OSGi中,每个Bundle都有自己的类加载器,该加载器能够看到BundleJar文件内部的类和资源。Bundle通过配置jar包中的MANIFEST.MF,可以控制从Bundle导出的包,而没有导出的包,则在Bundle外部是不能够访问的。这样就很好地完成了内部类和外部类的隔离。
>
> Import-Package
>
> Export-Package

## 背景知识之Karaf

### 简介

> Karaf,一个基于OSGi的运行环境,提供了一个轻量级的OSGi容器,可以用于部署各种组件和应用程序

![88DE9C27-CE0F-4F79-AA2D-B5DA8470A4BA](https://tva1.sinaimg.cn/large/007S8ZIlly1gg4k2teaagj30n20c9grm.jpg)

### Karaf容器的特点

> **系统服务:**
> 自带service wraper功能,把karaf包装成系统服务,设置为守护进程, kara项目可以一直运转
>
> **热部署**
> 尽管OSGi支持热部署,但并不是自动热部署,需要调用一些API去执行插拔的动作。
>
> **动态配置**
> Karaf在$KARAF HOME/etc文件夹中存储配置文件。这些配置内容可以在Karaf运行时动态修改。
>
> **日志处理**
> 基于Log4J的日志系统,同时支持多种日志API,如JDK 1.4, JCL, SLF4J, Avalon, Tomcat, OSGi等
>
> **控制台**
> 可以在控制台进行服务管理、安装bundle等操作。还可以扩展自己的控制台命令。可以通过SSH远程访问其他服务器上的Karaf控制台。
>
> **多实例管理**
> 一个服务器上可以运行多个Kara实例。对实例的管理可以在Karaf控制台中进行。
>
> **Bundle仓库**
> Karaf中内置了Pax URL的MVN协议,可以从Maven中央仓库安装bundle.
>
> **Bundle集合(Feature)**
> 类似Eclipse的Feature, Karaf中也支持Feature,即bundle的集合。使用Feature可以简化OSGi应用的部署。

### Feature概念

极大简化了bundle的配置和部署

![8ABB3D53-B747-4D83-AFA9-077623686836](https://tva1.sinaimg.cn/large/007S8ZIlly1gg4kftn8etj31260hmgzt.jpg)

### 安装ODL的feature

参考社区安装文档

> MD-SAL相关feature介绍
>
> 南向插件openflowplugin的相关feature介绍
>
> web界面相关的feature介绍

安装feature的两种方式

> 手动安装
>
> 默认配置加载



# Mininet

## 简介

- **是什么**

Mininet是由斯坦福大学基于Linux Container架构开发的一个进程虚拟化网络仿真工具,可以创建一个含有主机、交换机、控制器和链路的虚拟网络 其交换机支持OpenFlow协议,具有高度灵活的自定义软件定义网络。

![3EF5812A-C387-49C8-8909-C287AA77F189](https://tva1.sinaimg.cn/large/007S8ZIlly1gg4nxc94wyj31010bqais.jpg)

- **能做什么**

> 为OpenFlow应用程序提供一个简单、便宜的网络测试平台
>
> 启用复杂的拓扑测试,无需连接物理网络
>
> 具有拓扑感知和OpenFlow感知的CLI,用于调试或运行网络范围的测试
>
> 支持任意自定义拓扑,主机数可达4096,并包括一组基本的参数化拓扑
>
> 提供用于网络创建和实验的可扩展Python API

- **优点**

Mininet结合了许多仿真器、硬件测试床和模拟器的优点。

> **Compare to仿真器:**
>
> 启动速度快
>
> 扩展性大
>
> 带宽提供多
>
> 方便安装、易使用
>
> **Compare to模拟器:**
>
> 运行真实的代码
>
> 容易连接真实网络
>
> **Compare to硬件测试床:**
>
> 便宜
>
> 快速重新配置及重新启动

## 安装

### Ubuntu

> https://www.cnblogs.com/jianhaoscnu/p/12779084.html
>
> https://blog.csdn.net/Kangyucheng/article/details/89070966
>
> 1. 获取源代码:
>
> ```shell
> $ git clone https://github.com/mininet/mininet.git
> ```
>
> 2. 安装Mininet,需要涉及安装Mininet, user交换机及OVS软件,可根据#mininet/uti l/install. sh-h命令选择参数进行安装:
>
> 注：在docker容器中需要修改此.sh脚本，docker容器没有sudo命令
>
> ```shell
> #n指:mininet的核心文件与依赖
> #3指：OpenFlow的1.3版本协议
> #V 2.5.0指：OpenvSwitch版本
> $ mininet/util/install.sh -n3V 2.5.0
> #-a是默认安装在home目录下,不清楚各依赖版本时用它
> $ mininet/util/install.sh -a
> ```
>
> 注：解决错误apt --fix-broken install
>
> https://blog.csdn.net/zhouzhiyao960211/article/details/89716036
>
> ```shell
> $ sudo apt --fix-broken install
> ```
>
> 注：apt-get
>
> ```shell
> $ sudo apt-get update #更新apt-get
> $ sudo apt-get upgrade #升级
> ```
>
> 3. 安装OpenVSwitch交换机
>
> ```shell
> 切入root用户
> $ sudo su 
> 
> 安装系统组件及库文件以作为OVS正确运行的环境依赖
> $ apt-get install -y build-essential
> $ apt-get install libssl-dev
> $ apt-get install libcap-ng-dev
> $ apt-get install autoconf 
> $ apt-get install automake
> $ apt-get install libtool
> ```
>
> ```shell
> $ sudo apt-get update #更新apt-get
> 
> $ rmmod bridge   #可没有
>  
> $ sudo apt-get install openvswitch-switch
> 
> #查不到就重启
> $ sudo ovs-vsctl show
> $ ovs-vsctl --version
> 
> #重启服务
> $ killall ovsdb-server
> $ service openvswitch-switch force-reload-kmod
> ```
>
> 4. 安装完成后,使用命令测试Mininet是否安装成功:
>
> ```shell
> $ sudo mn --test pingall
> ```
>
> **备注：**
>
> **ubuntu系统中遇到的问题**
>
> gcc安装
>
> ```shell
> 方法一：
> sudo apt-get  build-dep  gcc  
> sudo apt-get  build-dep  gcc
> 
> 方法二：
> sudo apt-get  install  build-essential  
> sudo apt-get  install  build-essential
> 
> 安装完了可以执行如下的命令来查看版本，
> gcc --version  
> ```
>
> 更换源
>
> ```shell
> mv /etc/apt/sources.list /etc/apt/sourses.list.backup
> sudovi /etc/apt/sources.list
> ```
>
> vim
>
> ```shell
> $ sudo apt-get update 
> $ sudo apt-get install vim
> ```
>
> ssh
>
> ```shell
> 安装SSH的客户端和服务端：
> $ sudo apt-get install openssh-client
> $ sudo apt-get install openssh-server
> 
> 启动SSH服务
> $ sudo /etc/init.d/ssh start
> 
> 启动后通过以下指令判断SSH服务是否正确启动：
> $ ps -e | grep ssh
> 
> 修改SSH端口号
> SSH默认端口号为22,若有修改SSH端口号的需求，则运行以下指令打开SSH配置文件：
> $ sudo gedit /etc/ssh/sshd_config
> 
> 修改端口号（Port）后，重启SSH服务即可生效
> $ sudo /etc/init.d/ssh restart
> 
> 数据传输
> 是常用scp指令：
> $ scp -r usr@43.224.34.73:/home/lk   /root  //将远程IP地址为43.224.34.73的usr用户下路径为 /home/lk 的所有文件拷贝到本地 /root 文件夹中
> 
> $ scp usr@43.224.34.73:/home/lk/test.jar   /root  //将远程IP地址为43.224.34.73的usr用户下路径为 /home/lk 的test.jar文件拷贝到本地 /root 文件夹中
> 
> $ scp -r /root  usr@43.224.34.73:/home/lk    //将本地 /root 中的所有文件拷贝到远程IP地址为43.224.34.73的usr用户下路径为 /home/lk 的文件夹中
> 
> $ scp /root/test.jar   usr@43.224.34.73:/home/lk   //将本地 /root 中的test.jar文件拷贝到远程IP地址为43.224.34.73的usr用户下路径为 /home/lk 的文件夹中
> 
> scp的通用指令格式为：scp [参数] [原路径] [目标路径]
> 其中-r参数意为：递归复制整个目录
> ```
>
> ifconfig
>
> ```shell
> sudo apt install net-tools
> ```
>
> 设置密码
>
> ```shell
> sudo passwd root
> ```

### 快速使用

```shell
sudo mn  #创建拓扑

sudo mn --controller=remote,ip=127.0.0.1,port=6653   #连接远程控制器
```

![BA328AEA-AEFF-4568-9BD3-E26655950962](https://tva1.sinaimg.cn/large/007S8ZIlly1gg5yqqrs50j310p0is7cm.jpg)

