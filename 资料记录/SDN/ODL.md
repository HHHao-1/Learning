# OpenDayLight

> SDN控制器开发运行平台
>

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

