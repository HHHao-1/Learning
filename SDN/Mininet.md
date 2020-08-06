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

## 快速使用

```shell
sudo mn  #创建拓扑

sudo mn --controller=remote,ip=127.0.0.1,port=6653   #连接远程控制器
```

![BA328AEA-AEFF-4568-9BD3-E26655950962](https://tva1.sinaimg.cn/large/007S8ZIlly1gg5yqqrs50j310p0is7cm.jpg)

##Mininet命令

### 命令图谱

![BD618E1F-29A6-41AF-9FE0-777135E9D208](https://tva1.sinaimg.cn/large/007S8ZIlly1gga5vkif1ej30ga0bgq4e.jpg)

### 网络构建参数：--topo

![19714255-8BF1-464D-8C12-F3DF22680F8A](https://tva1.sinaimg.cn/large/007S8ZIlly1gga5xy8bz3j30mm0aatby.jpg)

![89D27C30-C894-45A7-A871-727D6F610246](https://tva1.sinaimg.cn/large/007S8ZIlly1gga5z10iluj30lq0avadm.jpg)

### 网络构建参数：--switch

![E941741D-B796-47B9-BF8E-15DCEF5A2118](https://tva1.sinaimg.cn/large/007S8ZIlly1gga64eyd42j30mh0altay.jpg)

### 网络构建参数：--controller

--controller：定义要使用的控制器,如果没有指定则使用mininet中默认的控制器

连接远程控制器,可以指定存在于本机或者与之相连通设备上的控制器

指定远程控制器方法：

```shell
sudo mn --controller=remote,--ip=[controller IP],--port=[port]
```

### 网络构建参数：--mac

--mac ：自动设置设备的MAC地址；复杂网络容易读取

让MAC地址易读,即设置交换机的MAC、主机MAC及IP地址从小到大排序,且设置简单唯一,不仅让机器容易获取,也容易让肉眼很容易识别其ID，使用法:

```shell
sudo mn --topo=tree,depth=2,fanout=2,--mac
```

### 常用内部交互命令

![DA5084CA-4DD3-476C-9157-3F1019205734](https://tva1.sinaimg.cn/large/007S8ZIlly1ggamlybhckj314z0jk16j.jpg)

###拓扑扩展:添加主机

> py help(s1)  /  py help(h1)  :查看命令详情
>
> Py dir(s1)  /  py help(h1)：查看可用命令

```shell
py net.addHost('h3')

py net.addLink(s1,net.get ('h3'))

py sl.attach('s1-eth3')

py net.get('h3').cmd('ifconfig h3-eth0 10.3')

dump  #此时看不到h3主机ip，ping之后可看到

h1 ping h3

dump
```

## Mininet可视化

Miniedit可视化,直接在界面上编辑任意拓扑,生成python自定义拓扑脚本,简单方便。

Mininet 2. 2.0+内置miniedit。在mininet/examples下提供miniedit. py脚本,执行脚本后显示可视化界面,可自定义拓扑及配置属性。

**Miniedit三步走：**

> Miniedit启动
>
> 自定义创建拓扑,设置设备信息
>
> 运行拓扑并生成拓扑脚本

**Miniedit启动**

> 进入mininet/examples目录下,执行miniedit.py文件:
>
> sudo ./miniedit.py
>
> 注意:执行miniedit.py ,需要在桌面版系统下,或支持X11(Xquartz)的情况下使用. Linux桌面版系统下可直接执行;远程使用Mininet虚拟机,需使用Xmanager或Xming.

**自定义创建拓扑,设置设备信息**

<img src="https://tva1.sinaimg.cn/large/007S8ZIlly1ggbekqhd68j30hf0dkdhf.jpg" alt="ACF59222-78FF-4EC3-A14A-17DA4DE1382A" style="zoom:67%;" align="left" />

**运行拓扑并生成拓扑脚本**

> 菜单栏file->save保存为.mn脚本
>
> save level 2 script保存为.py脚本
>
> 注意：
>
> 先推出CLI再STOP，就可以安全退出了
>
> 出现未将之前定义的拓扑文件清除干净，使用 mn -c 清除即可

