# SNMP

## 简介

### 概述

SNMP（Simple Network Management Protocol，简单网络管理协议）是目前UDP/IP网络中应用最为广泛的网络管理协议，它提供了一个管理框架来监控和维护互联网设备。SNMP结构简单，使用方便，并且能够屏蔽不同设备的物理差异，实现对不同设备的自动化管理，所以得到了广泛的支持和应用，目前大多数网络管理系统和平台都是基于SNMP的。

SNMP的最大优势就是设计简单，他既不需要复杂的实现过程，也不会占用太多的网络资源，便于使用。SNMP的基本功能包括监视网络性能、检测分析网络差错和配置网络设备等。在网络正常工作时，SNMP可实现统计、配置和测试等功能；当网络出故障时，可实现各种错误检测和恢复功能。

### 管理框架

**SNMP包括三个网络元素：SNMP管理者(SNMP Manager)，SNMP代理(SNMP Agent)，MIB库（Management Information Base，管理信息库）**

> **SNMP管理者：**运行在SNMP客户端程序的工作站，提供了非常友好的人机交互页面，方便网络管理员完成绝大多数的网络设备管理工作。

> **SNMP代理：**驻留在被管理设备上的一个进程，负责接受、处理来自SNMP管理者的请求报文。在一些紧急情况下，SNMP代理也会通知SNMP管理者事件的变化。

> **MIB库：**被管理对象的集合。它定义了被管理对象的一系列的属性：对象的名字、对象的访问权限和对象的数据类型等。每个SNMP代理都有自己的MIB。SNMP管理者根据权限可以对MIB中的对象进行读/写操作。

SNMP管理者是SNMP网络的管理者，SNMP代理是SNMP网络的被管理者，他们之间通过SNMP协议来交互管理信息。SNMP管理者、SNMP代理、MIB库三者的关系如图所示。

![C6C868BC-A8E0-44FA-B1C7-7D31A07A9D14](https://tva1.sinaimg.cn/large/007S8ZIlly1ggg2i4q7lnj30m607vq56.jpg)

### 协议版本

本交换机提供了SNMPv3的管理功能，同时兼容SNMPv1和SNMPv2，SNMP管理者和SNMP代理的SNMP版本需要一致，它们之间才能相互通信，可以根据自己的应用需求，选择不同安全级别的管理模式。

> **SNMPv1：**采用团体名（Community Name）认证。团体名用来定义SNMP管理者和SNMP代理的关系。如果SNMP报文携带的团体名没有得到设备的认可，该报文将被丢弃。团体名起到了类似于密码的作用，用来限制SNMP管理者对SNMP代理的访问。

> **SNMPv2c：**也采用团体名认证。它在兼容SNMPv1的同时又扩充了SNMPv1的功能。

> **SNMPv3：**SNMPv3在前两个版本v1、v2c的基础上大大加强了安全性和用户可控制性，他采用了VACM（View-based Access Control Model，基于视图的访问控制模型）及USM（User-Based Security Model，基于用户的安全模型）的认证机制。用户可以设置认证和加密功能，认证用于验证报文发送方的合法性，避免非法用户的访问；加密则是对SNMP管理者和SNMP代理之间的传输报文进行加密，以免被窃听。通过有无认证和有无加密等功能组合，可以为SNMP管理者和SNMP代理之间的通信提供更高的安全性。

## 通信

受SNMP管理的被管理设备可与位于网络某处的SNMP管理设备通信,有两种通信方式:**轮询(polling)和中断(interrupt-based)**

> **1. 轮询**：通常在一定时间间隔内由网络管理设备与被管理的设备进行通信,代理软件不断地收集统计数据,并把这些数据记录到一个MIB中,接受轮询的设备由管理设备询问当前的状态或统计信息。
>
> 缺点：信息的实时性差,尤其是出现错误时的实时性差。轮询间隔时间太长,则关于一些大的灾难事件的通知太慢,如果轮询间隔时间太短,则容易造成网络拥塞。

> **2. 中断：**当被管理的设备出现异常时,主动向管理设备发送消息。
>
> 优点：实时性很强。
>
> 问题：如产生错误或自陷需要系统资源,这将消耗掉系统时钟周期,从而降低系统的工作效率

## 实现模型

下图表示SNMP的实现模型。图中1、2、3、4、5分别表示获得请求get-request、获得下一个请求get-next-request、设置请求set-request、获得响应get-response、陷阱trap等操作。(SNMPv3定义了8个操作)

![B4A4996F-E3FD-4366-B920-79E75C605C22](https://tva1.sinaimg.cn/large/007S8ZIlly1ggg3z130wij30i20arq64.jpg)

## 典型配置

下图使用SNMP的典型配置。整个系统必须有一个管理站。在管理站内运行管理进程。在每个被管设备中一定要有代理进程。
管理进程和代理进程利用SNMP报文进行通信, **SNMP报文使用UDP来传送**。

![4A31DE40-6C33-4D19-8850-E9A8A133CD7A](https://tva1.sinaimg.cn/large/007S8ZIlly1ggg3y0hfb0j30jj0dawih.jpg)

## 报文格式

一个SNMP报文由三个部分组成:

> 公共SNMP首部
>
> get/set首部或trap首部
>
> 变量绑定(Variable-bindings)

下图PDU类型0-4

![A6F6E2B2-CBAB-41A0-A490-9320F9ACE98B](https://tva1.sinaimg.cn/large/007S8ZIlly1ggg41unnoij30k30e00vy.jpg)



![22132D17-9419-43C1-8383-FB0629BA64E6](https://tva1.sinaimg.cn/large/007S8ZIlly1gggeiqefnjj30t10fdqb4.jpg)

### 公共首部

共有三个字段:

(1)版本：写入版本字段的是版本号减1。对于SNMPv1应写入0。

(2)共同体(community) ：共同体就是一个字符串,作为管理进程和代理进程之间的明文口令,常用的是6个字符"public".

(3) PDU(协议数据单元)类型：根据PDU的类型,填入0-4中的一个数字。其对应关系如下表所示。

![B62575F1-48C4-4850-9900-0BB2D78A50C2](https://tva1.sinaimg.cn/large/007S8ZIlly1ggg48ytewjj30ez0ak0vs.jpg)

1.1 管理进程和代理进程的交互操作

SNMPv1定义了5种管理进程和代理进程之间的交互报文:

> get-request操作:从代理进程处提取一个或多个参数值。
>
> get-next-request操作:从代理进程处提取一个或多个参数的下一个参数值。
>
> set-request操作:设置代理进程的一个或多个参数值。
>
> get-response操作:返回的一个或多个参数值,这个操作是由代理进程发出的。它是前面3种操作的响应操作。
>
> trap操作:代理进程主动发出的报文,通知管理进程有某些事情发生。

前3个操作由管理进程向代理进程发出

后2个是代理进程发给管理进程的

代理进程端用熟知端口161来接收get或set报文

管理进程端用熟知端口162来接收response或trap报文

![657E93A1-807A-4726-B927-03C35EB7C4EE](https://tva1.sinaimg.cn/large/007S8ZIlly1ggg4ewbjkzj30jc0a2ach.jpg)

### get/set首部

 对于get/set首部：

请求标识ID (request ID) ：由管理进程设置的一个整数值。代理进程在发送get-response报文时也要返回此请求标识ID。匹配请求与响应。

差错状态(error status) ：由代理进程回答时填入0-5中的一个数字(下表详述)

差错索引(error index)：当出现noSuchNamebad Value、或readOnly差错时,由代理进程在回答时设置的一个整数,它指明有差错的变量在变量列表中的偏移。

![AAAF96D4-7746-404F-A6F7-3DA409062A2D](https://tva1.sinaimg.cn/large/007S8ZIlly1ggg4jvnrm7j30j40c343u.jpg)

### trap首部

企业(enterprise) ：填入产生trap报文的网络设备的对象标识符。此对象标识符肯定是在下图（给出了一个网络中所的数据结构）的对象命名树上的enterprises结点{1.3.6.1.4.1)下面的一棵子树上。

![C00BBDEC-DA23-463B-AECD-072723D3F90B](https://tva1.sinaimg.cn/large/007S8ZIlly1ggg4r09bekj30k80c0whk.jpg)

trap类型：此字段正式的名称是generic-trap,共分为下表所列7种(类型0-6) :

> 当使用下述类型2、3和5时,在报文后面变量部分的第一个变量应标识相应的接口。

![7838411A-079D-4705-998C-81EA2C89AD27](https://tva1.sinaimg.cn/large/007S8ZIlly1ggg4rwzp0mj30k707dtee.jpg)



特定代码(Specific-code) ：若trap类型为6,则指明代理自定义的事件,否则为0。

时间戳(timestamp) ：指明自代理进程初始化到trap报告的事件发生所经历的时间。

### 变量绑定

指明一个或多个变量的名和对应的值。在get或get-next请求报文中,变量的值应忽略。

## SMI

管理信息结构(SMI)

> 管理信息结构SMI定义了SNMP框架所用信息的组织、组成和标识, SMI是对公共结构和一般类型的描述。
>
> 名字+类型+编码

### 命名

**名字用标号串或用点分十进制数表示。**

SMI使用ASN.1标识MIB中的对象。

其一,对象标识是一种数据类型,它指明一种"授权”命名的对象。

其二,对象标识是一个整数序列以点(". ")分隔。这些整数构成一个树型结构,类似于DNS,对象标识从树的顶部开始,顶部没有标识,以root表示。对象标识如下图所示,对于因特网,用ASN.1记法来表示为:

```css
 iso(1) org(3)dod(6)internet(1),也可以用一种简单的格式(例如1.3.6.1)来表示。
```

![E6C94891-B824-4618-8587-6A0438228DF5](https://tva1.sinaimg.cn/large/007S8ZIlly1ggg8kjj46zj30js0dvtaz.jpg)

### 类型

MIB由一系列对象组成,部分对象类型是用抽象语法记法ASN.1 (abstract syntax notation one, ASN.1)表示的, ASN.1类似于C语言中的struct结构,SNMP为保持简单性,仅用到其中的一个子。

SNMP中的数据类型包括通用类型和应用类型等。

#### 通用类型

SNMP中常用的有简单类型和构造类型。

(1)简单类型

**INTEGER**整型,常用于表示枚举类型。有些整型变量定义一个特定的范围,例如, UDP和TCP的端口号就从0到65535。

**OCTET STRING**位组串,表示0或多个8bit字节,每个字节值在0~255之间。

**NULL**空,代表相关的变量没有值。例如,在get或get-next请求操作中,变量的值就是NULL,因为这些值还有待到代理进程处去取。

**OBJECT IDENTIFIER**对象标识符,表示对象的名字,用点分十进制表示,反映了它在互联网全局命名树中的位置。(1.3.6.1.2.1)

(2)构造类型

**SEQUENCE**序列,用于列表。一个SEQUENCE包括0个或多个元素,每一个元素又是另一个ASN.1数据类型。

**SEQUENCE OF**是一个向量的定义,用于表格,其所有元素具有相同的类型。

#### 应用类型

应用类型用于特定应用,常见的有:

**IpAddress**: IpAddress是4字节长度的OCTET STRING,每个字节代表IP地址的一个字段。

**PhysAddress**: PhysAddress是OCTET STRING类型,代表物理地址,例如以太网物理地址（Mac地址）为6个字节长度。

**Counter**: Counter是非负的整数,可从0递增到2^32^-1 (4294976295) ,达到最大值后归0。

**Gauge**: Gauge是非负的整数,取值范围为从0到4294976295,达到最大值后锁定,直到复位。

> 例如, MIB中的tcpCurrBstab就是这种类型的变量的一个例子,它代表目前在DSTABLISHED或CLOSE WAIT状态的TCP连接数。

**TimeTicks**: TimeTicks表示时间计数器,以0.01秒为单位递增,但是不同的变量可以有不同的递增幅度。所以在定义这种类型的变量的时候,必须指定递增幅度。

### 编码

SMI采用BER (Basic Encoding Rule)对传输的数据进行编码。

BER编码格式如下:

![22687D8E-1201-4524-93CF-B40E9148D371](https://tva1.sinaimg.cn/large/007S8ZIlly1ggg8r1nkj0j30gd017dg8.jpg)

1. 标记（tag）：指明数据的类型,占用1个字节,常见的类型有:

   ![A97F99F6-A757-4728-9E82-7ADC3D0845AD](https://tva1.sinaimg.cn/large/007S8ZIlly1ggg96v2y9cj30ee04x766.jpg)

2. 长度(length):指明值域的长度,长度不等,一般为一到三个字节。其格式可分为短格式（后面的值域长度<=127）、长格式
                 

2.1 短格式

![3C8B2BD8-FBC4-4CDC-8DF0-FB85369BCB67](https://tva1.sinaimg.cn/large/007S8ZIlly1ggg99seom0j30ah01idgf.jpg)

```
 length=30=>1E（30没有超过127，长度域为0001 1110）
```

2.2 长格式

![1AF2811F-2278-43C0-B22A-2D4E19DE2295](https://tva1.sinaimg.cn/large/007S8ZIlly1ggg9af92zsj30jl03ktb7.jpg)

长格式的表示方法： 1（1bit） K（7bit） K个八位组长度（K Byte）

```
length=169=>81 A9(169的十六进制)（169超过127，长度域为 1000 0001 1010 1001，169是后8位的值，前8位的第一个1表示这是长格式的表示方法，前8位的后7位表示后面有多少个字节表示针对的长度，这里，是000 0001，后面有一个字节表示真正的长度，1010 1001是169。
```

```
length=1500=>82 05 DC（1000 0010 0000 0101 1101 1100，先看第一个字节，表示长格式，后面有2个字节表示长度，这两个字节是0000 0101 1101 1100 表示1500）。
```

3. 值

例如: INTEGER 10的编码为

> 02 04 00 00 00 0A

例如: IPAddress 130.10.20.1的编码为

> 40 04 82 0A 14 01

## MIB

### 概览

MIB是以树状结构进行存储的。树的节点表示被管理对象，它可以用从根开始的一条路径唯一地识别，被管理对象可以用一串数字唯一确定，这串数字是被管理对象的OID（Object Identifier，对象标识符）。MIB的结构如图所示。图中，B的OID为{1.2.1.1}，A的OID为{1.2.1.1.5}。

![7F343397-A8D7-4050-9911-1FAC4E045199](https://tva1.sinaimg.cn/large/007S8ZIlly1ggg2ohl6vyj30bi0afmxr.jpg)

### MIB信息

MIB定义网络管理系统控制的数据对象,是监控网络设备标准变量的集合。网络管理员可以直接或通过管理代理软件来控制这些数据对象,以实现对网络设备的配置和监控。

每个被管理的SNMP设备均维护MIB, MIB的每一项包含一些信息:对象(名称)、语法(数据类型)、访问字段及状态字段等。

> 对象：为项的名称,通常为简单的名字。
>
> 语法：是一个值字段,通常为字符串或整,并不是所有的MIB的项均包含值字段。
>
> 访问字段：用于定义项的访问权限,通常有以下四类:只读、可读/写、只可写和不可访问。
>
> 状态字段：包含指示值,标明MIB项是否为必需的、可选的或作废。
>
> - 必需的---表示被管理的设备必须执行该项;
> - 可选的---表示被管理的设备可以选择执行该项;
> - 作废---表示不执行。

### MIB结构

MIB指明了网络元素所维持的变量(即能够被管理进程查询和设置信息) 。下图给出了一个网络中所有可能的被管理对象集合的数据结构。

![C00BBDEC-DA23-463B-AECD-072723D3F90B](https://tva1.sinaimg.cn/large/007S8ZIlly1ggg4r09bekj30k80c0whk.jpg)

> 由图可知,对象命名树的顶级对象有三个,即ISO, ITU-T (ccitt)和这两个组织的联合体。在ISO的下面有4个结点,其中的一个(标号3)是被标识的组织。接下一层有一个美国国防部(Department of Defense)的子树(标号6) ,再下面就是internet (标号1)
>
> 在只讨论因特网中的对象时,可只画出internet以下的子树,并在internet结点旁边标注上{1.3.6.1}即可。
>
> 在internet结点下面的第二个结点是mgmt (管理) ,标号是2。再下面是管理信息库,标号是1,原先的结点名是mib。1991年定义了新的版本MIB-II,故mib结点名现改为mib-2,其标识为{1.3.6.1.2.1},或{internet(1).2.1},这种标识为对象标识符。

最初的MIB将其所管理的信息分为8个类别,见下表。现在的mib-2所包含的信息类别已超过40个。

![4F5D19A6-9A2C-42B2-8B83-231180AD0166](https://tva1.sinaimg.cn/large/007S8ZIlly1ggga8gsr44j30km0c0789.jpg)

### 管理MIB

MIB的定义与具体的网络管理协议无关,这对于厂商和用户都有利。厂商可以在产品(如路由器)中包含SNMP代理软件,并保证在定义新的MIB项目后该软件仍遵守标准。

用户可以使用同一网络管理客户软件来管理具有不同版本的MIB的多个路由器,当然,一个没有新的MIB项目的路由器不能提供相关项目的信息。

网管中的对象(1.3.6.1.4.1},即enterprises(企业) ,其所属结点数已超过3000。例如IBM为{1.3.6.1.4.1.2}, Cisco为{1.3.6.1.4.1.9}, Novell为{1.3.6.1.4.1.23}等。世界上任何一个公司、学校都可以申请获得一个结点名。这样各厂家就可以定义自己的产品的被管理对象名,使它能用SNMP进行管理。

# SNMP4j

## 简介

SNMP4J是一个用Java来实现SNMP(简单网络管理协议)协议的开源项目.它支持以命令行的形式进行管理与响应。SNMP4J是纯面向对象设计与SNMP++(用C++实现SNMPv1/v2c/v3)相类似

## API特性

- 支持MD5和SHA验证，DES，3DES,AES128、AES192和AES256加密的SNMPv3。
- 支持SNMPv1,SNMPv2C和SNMPv3，带执行的可阻塞的信息处理模块。
- 全部PDU格式。
- 可阻塞的传输拓扑。支持UPD、TCP、TLS 。
- 可阻塞的超时模块。
- 同步和异步请求。
- 命令发生器以及命令应答器的支持。
- 基于Apache license的开源免费。
- JAVA 1.4.1或更高版本(2.0或更高版本需要jdk1.6及以上的支持)。
- 基于LOG4J记录日志。
- 使用GETBULK实现Row-based的有效的异步表格获取。
- 支持多线程。

## 重要类&接口

> Target（接口）、PDU、Snmp、TransportMapping（接口）

Target、PDU、Snmp三者的关系：

**Target代表远程设备或者远程实体**

**PDU代表管理端同Target通信的数据**

**Snmp代表管理者管理功能（其实就是数据的收发）的具体执行者。**

> 打个比方：Target就是你远方的恋人，PDU就是你们之间传递的情书，而Snmp就是负责帮你寄信收信的邮差。

### Target

> 表示被管理的设备，Target接口和CommunityTarget类、UserTarget类

对于一个被管理的设备，它有以下一些属性：Address、协议版本version、community、访问它的用户名和密码、超时时间、重传次数等等。有如下方法：

（1）获取或者设置ip地址

```java
void setAddress(Address address)
Address getAddress()
```

（2）设置或者获取版本号（支持V1，V2c，V3）

```java
void setVersion(int ver)
int  getVersion()
```

（3）超时时间 （ 单位：milliseconds ）

```java
void  setTimeout(long out）
long getTimeout()
```

（4）重传次数

```java
void  setRetries(int retries)
int  getRetries()
```

（5）最大PDU大小值

```java
void setMaxSizeRequestPDU(int max)
int  getMaxSizeRequestPDU()
```

注意：

[1] 上面这些对于Snmp三个版本都是相同的，不同的只是在于安全方面，具体来说，Snmpv1，v2c采用共同体（community）方式，安全性很差；SnmpV3采用基于用户的安全（USM）方式，安全性能得到很大提高。

[2] 对于Snmpv1，v2c，使用Target派生出一个子类CommunityTarget，增加了对Community的方法：

```java
void setCommunity(OctetString community)
OctetString getCommunity()
```

 [3] 对于Snmpv3，使用其子类UserTarget，增加了一些有关USM安全方面的设置，比如采用的安全模型、安全级别、访问该设备的用户名以及权威引擎ID（authoritative engine ID）：

> 1）安全级别（支持三种安全级别）
>
> ```java
> void setSecurityLevel(int level)
> int  getSecurityLevel()
> ```
>
> 2）访问用户名（该访问用户名称必须在设置USM的时候添加其相应的UsmUser）
>
> ```java
> void setSecurityName(OctetString name)
> OctetString  getSecurityName()
> ```
>
> 3）安全模型（支持三种安全模型）
>
> ```java
> void setSecurityModel(int model)
> int  getSecurityModel()
> ```
>
> 4）权威引擎ID（authoritative engine ID）
>
> ```java
> void  setAuthoritativeEngineID(byte[] id)
> byte[] getAuthoritativeEngineID（）
> ```

[4]对于Target的代码示例：

**CommunityTarget**

```java
CommunityTarget target = new CommunityTarget();
target.setCommunity(new OctetString("public"));
target.setAddress(targetAddress);
target.setVersion(SnmpConstants.version1);
```

**UserTarget**

```java
UserTarget target = new UserTarget();
target.setAddress(targetAddress);
target.setRetries(1);
// set timeout to 500 milliseconds -&gt; 2*500ms = 1s total timeout
target.setTimeout(500);
target.setVersion(SnmpConstants.version3);
target.setSecurityLevel(SecurityLevel.AUTH_PRIV);
target.setSecurityName(new OctetString("MD5DES"));
```

### PDU 

> 协议数据单元，PDU类和ScopedPDU类

PDU（协议数据单元），用来表示管理站跟代理站点进行通信的数据。包括PDU的类型、传输的数据集合、错误说明等。

除Snmpv1 Trap外，其他操作类型的PDU大致相同。

Snmp4j针对Snmp的各个版本，开发了三个有关PDU的类。PDU（针对Snmpv2c）、PDUv1（针对Snmpv1）、ScopedPDU（针对Snmpv3），但三个类除各自特别的一些参数外，都基本相同。所以Snmp4j在设计的时候，将PDU设计成另外两个的超类，使他们能够共享大部分功能。

**[1] PDU基本介绍**

1）pdu类型（Snmpv1支持5种，get、set、getnext、trap、getresponse,Snmpv2c增加了getbulk、inform）

```java
int  getType()
void  setType(int type)
```

2）错误（主要有6种错误，请参见RFC）

```java
void  setErrorStatus(int  status)
int  getErrorStatus()
String  getErrorStatusText()
void  setErrorIndex(int index)
int  getErrorindex()
```

3）变量

```java
void add(VariableBinding vb) // 对于除get、getnext、getbulk外
void addAll(VariableBinding[] vbs) // 对于除get、getnext、getbulk外的
void addOID(VariableBinding vb) // 对于get、getnext、getbulk
void addAllOID(VariableBinding[] vbs) // 对于get、getnext、getbulk
VariableBinding get（int i）
VariableBinding[] toArray()
Vector getVariableBindings()
void set(int i，VariableBinding vb)
void remove(int i)
void clear()
int  size()
```

**[2] PDUv1**

> PDUv1继承了PDU，除Snmp v1 trap操作外 ，其它都跟PDU相同。因为Snmp v1的Trap设计PDU不同于其他操作的PDU，它包括：对象标识符（OID）、代理ip地址（agent-addr）、时间戳（time-stamp）、通用代理类型（generic-trap）、特定代理类型（specific-trap)。所以相应的增加了对这些字段的get/set操作。具体参见API文档。

**[3] ScopedPDU**

> SnmpV3采用了不同安全策略，它的PDU也增加了有关安全方面的几个字段：上下文名称（ContextName）、上下文引擎ID（contextEngineID）等，其它PDU字段属于USM来管理。所以ScopedPDU在PDU的基础上增加了相应的get/set操作。参见API。

**[4.]代码示例**

**SNMPv1/v2c GETNEXT PDU**

```java
PDU pdu = new PDU();
pdu.add(new VariableBinding(new OID("1.3.6.1.2.1.1.1"))); // sysDescr
pdu.add(new VariableBinding(new OID("1.3.6.1.2.1.2.1"))); // ifNumber
pdu.setType(PDU.GETNEXT);
```

**SNMPv3 GETBULK PDU**

```java
ScopedPDU pdu = new ScopedPDU();
pdu.add(new VariableBinding(new OID("1.3.6.1.2.1.2.1"))); // ifNumber
pdu.add(new VariableBinding(new OID("1.3.6.1.2.1.2.2.1.10"))); // ifInOctets
pdu.add(new VariableBinding(new OID("1.3.6.1.2.1.2.2.1.16"))); // ifOutOctets
pdu.setType(PDU.GETBULK);
pdu.setMaxRepetitions(50);
// Get ifNumber only once
pdu.setNonRepeaters(1);
// set context non-default context (default context does not need to be set)
pdu.setContextName(new OctetString("subSystemContextA"));
// set non-default context engine ID (to use targets authoritative engine ID
// use an empty (size == 0) octet string)
pdu.setContextEngineID(OctetString.fromHexString("80:00:13:70:c0:a8:01:0d"));
```

**SNMPv1 TRAP PDU**

```java
PDUv1 pdu = new PDUv1();
pdu.setType(PDU.V1TRAP);
pdu.setGenericTrap(PDUv1.COLDSTART);
```

**SNMPv2c/SNMPv3 INFORM PDU**

```java
ScopedPDU pdu = new ScopedPDU();
pdu.setType(PDU.INFORM);
// sysUpTime
long sysUpTime = (System.currentTimeMillis() - startTime) / 10;
pdu.add(new VariableBinding(SnmpConstants.sysUpTime, new TimeTicks(sysUpTime)));
pdu.add(new VariableBinding(SnmpConstants.snmpTrapOID, SnmpConstants.linkDown));
// payload
pdu.add(new VariableBinding(new OID("1.3.6.1.2.1.2.2.1.1"+downIndex),
                            new Integer32(downIndex)));
```

### Snmp

Snmp类是SNMP4J的核心，它提供了发送和接收SNMP PDUs的方法，所有的SNMP PDU类型都可以采用同步或者异步的方式被发送。

Snmp采用独立的传输协议，通过TransportMapping接口调用addTransportMapping(TransportMapping transportMapping)方法或者采用默认的构造函数来实现传输映射，以此来实现信息的传输。

Snmp类提供了一套有关Snmp的功能接口。具体来讲，就是发送、接收、创建Snmp消息。

一个Snmp对象是一个Session，而在SNMP4J中，一个Session可以同多个远程设备通信。

### TransportMapping接口

　该接口代表了SNMP4J所使用的传输层协议。这也是SNMP4J一大特色的地方。按照RFC的规定，SNMP是只使用UDP作为传输层协议的。而SNMP4J支持管理端和代理端使用UDP或者TCP进行传输。该接口有两个子接口。

## 两种消息发送模式

**SNMP4J支持两种消息发送模式:同步发送模式和异步发送模式。**

> 同步发送模式也称阻塞模式。当管理端发送出一条消息之后,线程会被阻塞,直到收到对方的回应或者时间超时。同步发送模式编程较为简单,但是不适用于发送广播消息。
>
> 异步发送模式也称非阻塞模式。当程序发送一条消息之后,线程将会继续执行,当收到消息的回应的时候,程序会对消息作出相应的处理。要实现异步发送模式,需要实例化一个实现了ResponseListener接口的类的对象。ResponseListener接口中有一个名为onResponse的函数。这是一个回调函数,当程序收到响应的时候,会自动调用该函数。由该函数完成对响应的处理。
>

## 实现管理端步骤

### 初始化

1. 明确SNMP在传输层所使用的协议

> 一般情况下,我们都使用使用UDP协议作为SNMP的传输层协议,所以我们需要实例化的是一个DefaultUdpTransportMapping接口对象;
>

2. 实例化一个snmp对象

> 在此过程中,我们需要将1中实例化的DefaultUdpTransportMapping接口的对象作为参数,传入snmp类的构造函数中。另外,如果实现的SNMPV3协议,我们还需要设置安全机制,添加安全用户等等;
>

3. 监听snmp消息

> 在此,我们可以调用刚刚实例化的DefaultUdpTransportMapping的接口对象的listen方法,让程序监听snmp消息。
>

### 构造发送目标

> 如果实现的是SNMPV2c或者说SNMPV1,需要实例化一个CommunityTarget对象。如果实现的是SNMPv3程序,则需要实例化一个UserTarget对象。
>
> 之后,我们还需要对实例化的对象做一些设置。如果是CommunityTarget的对象,则需要设置使用的Snmp版本,重传时间和等待时延。如果是UserTarget对象,我们不仅需要设置版本、重传时间、等待时延,还需要设置安全级别和安全名称。
>

### 构造发送报文

> 如果发送的是SNMPV2c或者说SNMPV1的报文,我们需要实例化一个PDU类的对象。
>
> 如果发送的是SNMPv3的报文,我们则需要实例化一个ScopedPDU类的对象。之后,我们还需要生成一个OID对象,其中包含了我们所需要获取的SNMP对象在MIB库中的ID,然后我们需要将OID和之前生成的PDU对象或者是ScopedPDU对象绑定,并且设置PDU的报文类型(五种SNMP报文类型之一)。
>

### 构造响应监听对象(异步模式)

> 当使用异步模式的时候,我们需要实例化一个实现了Responselistener接口的对象,作为响应消息的监听对象。在构造该对象的过程中,我们需要重写ResponseListener的OnResponse 函数,该函数是一个回调函数,用来处理程序收到响应后的一些操作。
>

### 发送消息

> 当所有上述操作都设置完毕之后,就可以发送消息了。同步模式和异步模式发送消息调用的函数名字均为send,但是两个函数所需参数不一样。同步模式的参数仅为构造的目标对象和报文对象,而异步模式还需要构造的监听对象。
>
> 同步模式发送消息后便等待响应的到达,到达之后会返回一个ResponseEvent对象,该对象中包含了响应的相应信息。
> 异步模式发送消息之后便会继续执行,当收到响应消息时便会调用监听对象的OnResponse函数。该函数中的语句便是我们对响应的处理

## 管理端代码实现

1、设定远程实体

> snmp4j中,用CommunityTarget对象来表示远程实体(要进行snmp消息通信的远程主机,使用snmp的v2版本)
>

2、指定远程实体的地址

> snmp4j中使用Address接口对象来表示, Address对象需要通过实现该接口的类的对象向上转型来实例化
>

3、设定远程实体属性

> 通过CommunityTarget以及其父接口中提供的setX方法来设定远程实体的属性,如设定远程实体的snmp共同体属性、远程实体的地址、超时时间、重传次数、snmp版本等

4、设定使用的传输协议

> snmp4j中,用TransportMapping接口的对象来表示传输协议(tcp/udp)
>

5、启动监听进程

> 调用TransportMapping中的listen()方法,启动监听进程,接收消息,由于该监听进程是守护进程,最后应调用closel)方法来释放该进程

6、创建SNMP对象,用于发送请求PDU

> a、创建请求pdu,即创建PDU类的对象,调用PDU类中的add()方法绑定要查询的OID,调用PDU中的setType()方法来确定该pdu的类型(与snmp中五种操作想对应)
>
> b、通过PDU的构造方法 public SNMP(TransportMapping transportingMapping),或者其他构造方法来生成pdu,之后调用ResopnseEvent send(PDU pdu,Target target)发送pdu,该方法返回一个ResponseEvent对象

7、获取应答pdu

> 通过ResponseEvent对象来获得SNMP请求的应答pdu,方法: public PDU getResponse()

8、获取mib信息

> 通过应答pdu获得mib信息(之前绑定的OID的值) ,方法: VaribleBinding get (int index)

# 完整示例

## SNMPv1和SNMPv2c版本

```java
import org.snmp4j.CommunityTarget;
import org.snmp4j.PDU;
import org.snmp4j.Snmp;
import org.snmp4j.TransportMapping;
import org.snmp4j.event.ResponseEvent;
import org.snmp4j.mp.SnmpConstants;
import org.snmp4j.smi.*;
import org.snmp4j.transport.DefaultUdpTransportMapping;
import java.io.IOException;

public class Snmpv1_v2c {
    public static void main(String[] args) throws Exception {

        try {
            // 设定CommunityTarget
            CommunityTarget myTarget = new CommunityTarget();
            // 定义远程主机的地址
            Address deviceAdd = GenericAddress.parse("udp:10.211.55.7/161");
            // 定义本机的地址
            //Address localAdd = GenericAddress.parse("udp:localhost/161");
            // 设定远程主机的地址
            myTarget.setAddress(deviceAdd);
            // 设定本地主机的地址
            //myTarget.setAddress(localAdd);
            // 设置snmp共同体
            myTarget.setCommunity(new OctetString("public"));
            // 设置超时重试次数
            myTarget.setRetries(2);
            // 设置超时的时间
            myTarget.setTimeout(5 * 60);
            // 设置使用的snmp版本
            myTarget.setVersion(SnmpConstants.version2c);

            // 设定采取的协议
            TransportMapping transport = new DefaultUdpTransportMapping();// 设定传输协议为UDP
            // 调用TransportMapping中的listen()方法，启动监听进程，接收消息，由于该监听进程是守护进程，最后应调用close()方法来释放该进程
            transport.listen();
            // 创建SNMP对象，用于发送请求PDU
            Snmp protocol = new Snmp(transport);
            // 创建请求pdu,获取mib
            PDU request = new PDU();
            // 调用的add方法绑定要查询的OID
            request.add(new VariableBinding(new OID(
                "1.3.6.1.2.1.1.1")));
            request.add(new VariableBinding(new OID(new int[] { 1, 3, 6, 1, 2,
                                                               1, 1, 2 })));
            // 调用setType()方法来确定该pdu的类型
            request.setType(PDU.GETNEXT);
            // 调用 send(PDU pdu,Target target)发送pdu，返回一个ResponseEvent对象
            ResponseEvent responseEvent = protocol.send(request, myTarget);
            // 通过ResponseEvent对象来获得SNMP请求的应答pdu，方法：public PDU getResponse()
            PDU response = responseEvent.getResponse();
            // 输出
            if (response != null) {
                System.out.println("request.size()=" + request.size());
                System.out.println("response.size()=" + response.size());
                // 通过应答pdu获得mib信息（之前绑定的OID的值），方法：VaribleBinding get(int index)
                VariableBinding vb1 = response.get(0);
                VariableBinding vb2 = response.get(1);
                System.out.println(vb1);
                System.out.println(vb2);
                // 调用close()方法释放该进程
                transport.close();

                /**
                 * 输出结果： request.size()=2 response.size()=2 1.3.6.1.2.1.1.1.0 =
                 * Hardware: x86 Family 6 Model 58 Stepping 9 AT/AT COMPATIBLE -
                 * Software: Windows 2000 Version 5.1 (Build 2600 Multiprocessor
                 * Free) 1.3.6.1.2.1.1.2.0 = 1.3.6.1.4.1.311.1.1.3.1.1
                 */
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

## SNMPv3版本

```java
import org.snmp4j.*;
import org.snmp4j.Snmp;
import org.snmp4j.event.ResponseEvent;
import org.snmp4j.event.ResponseListener;
import org.snmp4j.mp.MPv3;
import org.snmp4j.mp.SnmpConstants;
import org.snmp4j.security.*;
import org.snmp4j.smi.*;
import org.snmp4j.transport.DefaultUdpTransportMapping;
import java.io.IOException;

//未调试
public class Snmp_remote {
    private Snmp snmp = null;
    private int version;

    public Snmp_remote(int version) {
        try {
            this.version = version;
            TransportMapping transport = new DefaultUdpTransportMapping();
            snmp = new Snmp(transport);
            if (version == SnmpConstants.version3) {
                //设置安全模式
                USM usm = new USM(SecurityProtocols.getInstance(),
                                  new OctetString(MPv3.createLocalEngineID()), 0);
                SecurityModels.getInstance().addSecurityModel(usm);
            }
            //开始监听消息
            transport.listen();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void sendMessage(Boolean syn, final Boolean bro, PDU pdu, String addr)
        throws IOException {//生成目标地址对象
        Address targetAddress = GenericAddress.parse(addr);
        Target target = null;
        if (version == SnmpConstants.version3) {
            //添加用户
            snmp.getUSM().addUser(new OctetString("MD5DES"),
                                  new UsmUser(new OctetString("MDSDES"),
                                              AuthMD5.ID,
                                              new OctetString("MD5DESUserAuthPassword"),
                                              PrivDES.ID,
                                              new OctetString("MDSDESUserPrivPassword")));
            target = new UserTarget();
            //设置安全级别
            ((UserTarget) target).setSecurityLevel(SecurityLevel.AUTH_PRIV);
            ((UserTarget) target).setSecurityName(new OctetString("MD5DES"));
            target.setVersion(SnmpConstants.version3);
            target = new CommunityTarget();
            if (version == SnmpConstants.version1) {
                target.setVersion(SnmpConstants.version1);
                ((CommunityTarget) target).setCommunity(new OctetString("public"));
            } else {
                target.setVersion(SnmpConstants.version2c);
                ((CommunityTarget) target).setCommunity(new OctetString("public"));
            }
        }
        //目标对象相关设置
        target.setAddress(targetAddress);
        target.setRetries(5);
        target.setTimeout(1000);

        if (!syn) {
            //发送报文并且接受响应
            ResponseEvent response = snmp.send(pdu, target);
            //处理响应
            System.out.println("Synchronize(同步)message(消息)from(来自)" + response.getPeerAddress()
                               + "\r\n" + "request(发送的请求):" + response.getRequest() + "\r\n" + "response(返回的响应):"
                               + response.getResponse());
            /**
             *输出结果:
             *Synchronize(同步) message(消息) from(来自) 192.168.1.23/161
             * request(发送的请求):GET[requestID=632977521,errorStatus-Success(0), errorIndex-0, VBS[1.3.6.1.2.1.1
             * .5.0 = Null]]
             * response(返回的响应):RESPONSE[requestID=632977521,errorStatus=Success(0), errorIndex-0, VBS[1.3.6.1
             * .2.1.1.5.0 = WIN-667H6TS3U37]]
             * */
        } else {
            //设置监听对象
            ResponseListener listener = new ResponseListener() {
                public void onResponse(ResponseEvent event) {
                    if (bro.equals(false)) {
                        ((Snmp) event.getSource()).cancel(event.getRequest(), this);
                    }
                    //处理响应
                    PDU request = event.getRequest();
                    PDU response = event.getResponse();
                    System.out.println("Asynchronise(异步)message(消息)from(来自)" +
                                       event.getPeerAddress() + "\r\n" + "request(发送请求):" + request + "\r\n" +
                                       "response(返回的响应):" + response);
                }
            };
            //发送报文
            snmp.send(pdu, target, null, listener);
        }
    }

    public static void main(String[] args) {
        //Snmp的三个版本号
        //int ver3 =SnmpConstants.version3;
        int ver2c = SnmpConstants.version2c;
        //int ver1 = SnmpConstants.version1;
        Snmp_remote manager = new Snmp_remote(ver2c);
        //构造报文
        PDU pdu = new PDU();
        //PDU pdu =new ScopedPDU();
        //设置要获取的对象ID,这个OID代表远程计算机的名称
        OID oids = new OID("1.3.6.1.2.1.1.5.0");
        pdu.add(new VariableBinding(oids));
        //设置报文类型
        pdu.setType(PDU.GET);
        //(ScopedPDU) pdu).setContextName(new OctetString("priv"));
        try {
            //发送消息其中最后一个是想要发送的目标地址
            manager.sendMessage(false, true, pdu,"udp:10.211.55.7/161");
            //192.168.1.229 Linux服务器
            //manager.sendMessage(false, true, pdu, "udp:192.168.1.233/161");
            //192.168.1.233 WinServer2008服务器
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

# 常用OID

| 系统参数（1.3.6.1.2.1.1） |                    |                   |          |
| ------------------------- | ------------------ | ----------------- | -------- |
| OID                       | 描述               | 备注              | 请求方式 |
| .1.3.6.1.2.1.1.1.0        | 获取系统基本信息   | SysDesc           | GET      |
| .1.3.6.1.2.1.1.3.0        | 监控时间           | sysUptime         | GET      |
| .1.3.6.1.2.1.1.4.0        | 系统联系人         | sysContact        | GET      |
| .1.3.6.1.2.1.1.5.0        | 获取机器名         | SysName           | GET      |
| .1.3.6.1.2.1.1.6.0        | 机器坐在位置       | SysLocation       | GET      |
| .1.3.6.1.2.1.1.7.0        | 机器提供的服务     | SysService        | GET      |
| .1.3.6.1.2.1.25.4.2.1.2   | 系统运行的进程列表 | hrSWRunName       | WALK     |
| .1.3.6.1.2.1.25.6.3.1.2   | 系统安装的软件列表 | hrSWInstalledName | WALK     |



| 网络接口（1.3.6.1.2.1.2） |                                    |                |          |
| ------------------------- | ---------------------------------- | -------------- | -------- |
| OID                       | 描述                               | 备注           | 请求方式 |
| .1.3.6.1.2.1.2.1.0        | 网络接口的数目                     | IfNumber       | GET      |
| .1.3.6.1.2.1.2.2.1.2      | 网络接口信息描述                   | IfDescr        | WALK     |
| .1.3.6.1.2.1.2.2.1.3      | 网络接口类型                       | IfType         | WALK     |
| .1.3.6.1.2.1.2.2.1.4      | 接口发送和接收的最大IP数据报[BYTE] | IfMTU          | WALK     |
| .1.3.6.1.2.1.2.2.1.5      | 接口当前带宽[bps]                  | IfSpeed        | WALK     |
| .1.3.6.1.2.1.2.2.1.6      | 接口的物理地址                     | IfPhysAddress  | WALK     |
| .1.3.6.1.2.1.2.2.1.8      | 接口当前操作状态[up\|down]         | IfOperStatus   | WALK     |
| .1.3.6.1.2.1.2.2.1.10     | 接口收到的字节数                   | IfInOctet      | WALK     |
| .1.3.6.1.2.1.2.2.1.16     | 接口发送的字节数                   | IfOutOctet     | WALK     |
| .1.3.6.1.2.1.2.2.1.11     | 接口收到的数据包个数               | IfInUcastPkts  | WALK     |
| .1.3.6.1.2.1.2.2.1.17     | 接口发送的数据包个数               | IfOutUcastPkts | WALK     |



| CPU及负载                  |                                 |                 |          |
| -------------------------- | ------------------------------- | --------------- | -------- |
| OID                        | 描述                            | 备注            | 请求方式 |
| . 1.3.6.1.4.1.2021.11.9.0  | 用户CPU百分比                   | ssCpuUser       | GET      |
| . 1.3.6.1.4.1.2021.11.10.0 | 系统CPU百分比                   | ssCpuSystem     | GET      |
| . 1.3.6.1.4.1.2021.11.11.0 | 空闲CPU百分比                   | ssCpuIdle       | GET      |
| . 1.3.6.1.4.1.2021.11.50.0 | 原始用户CPU使用时间             | ssCpuRawUser    | GET      |
| .1.3.6.1.4.1.2021.11.51.0  | 原始nice占用时间                | ssCpuRawNice    | GET      |
| . 1.3.6.1.4.1.2021.11.52.0 | 原始系统CPU使用时间             | ssCpuRawSystem. | GET      |
| . 1.3.6.1.4.1.2021.11.53.0 | 原始CPU空闲时间                 | ssCpuRawIdle    | GET      |
| . 1.3.6.1.2.1.25.3.3.1.2   | CPU的当前负载，N个核就有N个负载 | hrProcessorLoad | WALK     |
| . 1.3.6.1.4.1.2021.11.3.0  | ssSwapIn                        | GET             |          |
| . 1.3.6.1.4.1.2021.11.4.0  | SsSwapOut                       | GET             |          |
| . 1.3.6.1.4.1.2021.11.5.0  | ssIOSent                        | GET             |          |
| . 1.3.6.1.4.1.2021.11.6.0  | ssIOReceive                     | GET             |          |
| . 1.3.6.1.4.1.2021.11.7.0  | ssSysInterrupts                 | GET             |          |
| . 1.3.6.1.4.1.2021.11.8.0  | ssSysContext                    | GET             |          |
| . 1.3.6.1.4.1.2021.11.54.0 | ssCpuRawWait                    | GET             |          |
| . 1.3.6.1.4.1.2021.11.56.0 | ssCpuRawInterrupt               | GET             |          |
| . 1.3.6.1.4.1.2021.11.57.0 | ssIORawSent                     | GET             |          |
| . 1.3.6.1.4.1.2021.11.58.0 | ssIORawReceived                 | GET             |          |
| . 1.3.6.1.4.1.2021.11.59.0 | ssRawInterrupts                 | GET             |          |
| . 1.3.6.1.4.1.2021.11.60.0 | ssRawContexts                   | GET             |          |
| . 1.3.6.1.4.1.2021.11.61.0 | ssCpuRawSoftIRQ                 | GET             |          |
| . 1.3.6.1.4.1.2021.11.62.0 | ssRawSwapIn.                    | GET             |          |
| . 1.3.6.1.4.1.2021.11.63.0 | ssRawSwapOut                    | GET             |          |
| .1.3.6.1.4.1.2021.10.1.3.1 | Load5                           | GET             |          |
| .1.3.6.1.4.1.2021.10.1.3.2 | Load10                          | GET             |          |
| .1.3.6.1.4.1.2021.10.1.3.3 | Load15                          | GET             |          |



| 内存及磁盘（1.3.6.1.2.1.25） |                                         |                          |          |
| ---------------------------- | --------------------------------------- | ------------------------ | -------- |
| OID                          | 描述                                    | 备注                     | 请求方式 |
| .1.3.6.1.2.1.25.2.2.0        | 获取内存大小                            | hrMemorySize             | GET      |
| .1.3.6.1.2.1.25.2.3.1.1      | 存储设备编号                            | hrStorageIndex           | WALK     |
| .1.3.6.1.2.1.25.2.3.1.2      | 存储设备类型                            | hrStorageType[OID]       | WALK     |
| .1.3.6.1.2.1.25.2.3.1.3      | 存储设备描述                            | hrStorageDescr           | WALK     |
| .1.3.6.1.2.1.25.2.3.1.4      | 簇的大小                                | hrStorageAllocationUnits | WALK     |
| .1.3.6.1.2.1.25.2.3.1.5      | 簇的的数目                              | hrStorageSize            | WALK     |
| .1.3.6.1.2.1.25.2.3.1.6      | 使用多少，<br />跟总容量相除就是占用率  | hrStorageUsed            | WALK     |
| .1.3.6.1.4.1.2021.4.3.0      | Total Swap Size(虚拟内存)               | memTotalSwap             | GET      |
| .1.3.6.1.4.1.2021.4.4.0      | Available Swap Space                    | memAvailSwap             | GET      |
| .1.3.6.1.4.1.2021.4.5.0      | Total RAM in machine                    | memTotalReal             | GET      |
| .1.3.6.1.4.1.2021.4.6.0      | Total RAM used                          | memAvailReal             | GET      |
| .1.3.6.1.4.1.2021.4.11.0     | Total RAM Free                          | memTotalFree             | GET      |
| .1.3.6.1.4.1.2021.4.13.0     | Total RAM Shared                        | memShared                | GET      |
| .1.3.6.1.4.1.2021.4.14.0     | Total RAM Buffered                      | memBuffer                | GET      |
| .1.3.6.1.4.1.2021.4.15.0     | Total Cached Memory                     | memCached                | GET      |
| .1.3.6.1.4.1.2021.9.1.2      | Path where the disk is mounted          | dskPath                  | WALK     |
| .1.3.6.1.4.1.2021.9.1.3      | Path of the device for the partition    | dskDevice                | WALK     |
| .1.3.6.1.4.1.2021.9.1.6      | Total size of the disk/partion (kBytes) | dskTotal                 | WALK     |
| .1.3.6.1.4.1.2021.9.1.7      | Available space on the disk             | dskAvail                 | WALK     |
| .1.3.6.1.4.1.2021.9.1.8      | Used space on the disk                  | dskUsed                  | WALK     |
| .1.3.6.1.4.1.2021.9.1.9      | Percentage of space used on disk        | dskPercent               | WALK     |
| .1.3.6.1.4.1.2021.9.1.10     | Percentage of inodes used on disk       | dskPercentNode           | WALK     |