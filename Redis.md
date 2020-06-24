# 简介

**概念**

> Redis是Key-Value型NoSQL数据库
>
> Redis将数据存储在内存中,同时也能持久化到磁盘
>
> Redis常用于缓存,利用内存的高效提高程序的处理速度

**特点**

> 速度快
>
> 持久化
>
> 主从复制
>
> 广泛的语言支持
>
> 多种数据结构
>
> 分布式与高可用

**安装**

> 使用以下命令下载，提取和编译Redis：
>
> ```shell
> $ wget http://download.redis.io/releases/redis-6.0.5.tar.gz
> $ tar xzf redis-6.0.5.tar.gz
> $ cd redis-6.0.5
> #make命令在linux中底层依赖gcc：yum instal gcc
> #make编译源码为可执行文件
> $ make
> ```

# 快速使用

## 启动

 启动Redis服务器：

 ```shell
 $ src/redis-server
 ```

 启动Redis客户端连接：

 ```shell
 $ src/redis-cli
 redis> set foo bar
 OK
 redis> get foo
 "bar"
 ```

## 配置

Redis的常用基本配置

配置文件：redis.conf

| 配置项        | 示例                | 说明                                                         |
| ------------- | ------------------- | ------------------------------------------------------------ |
| daemonizeport | deamonize yes       | 是否启用后台运行,默认no                                      |
| Port          | port 6379           | 设置端口号,默认6379                                          |
| logfile       | logfile "redis.log" | 设置日志文件                                                 |
| databases     | databases 255       | 设置redis数据库总量                                          |
| dir           | dir ./              | 设置数据文件存储目录<br />(文件：dump.rdp【redis的全量复制】) |
| requirepass   | requirepass 12345   | 设置使用密码                                                 |

以配置文件方式启动：

```shell
$ cd redis
$ ./src/redis- server redis. conf
$ ./src/redis- cli -p 端口号
> auth 密码
```

## 关闭

```shell
$ kill -9 PID #kill进程
$ ./src/redis- cli shutdow
```

## Redis通用命令

| 命令      | 示例            | 说明                               |
| --------- | --------------- | ---------------------------------- |
| selectset | select 0        | 选择0号数据库                      |
| Set       | set name lily   | 设置key=name,value-lily            |
| get       | get name        | 获得key=name的结果                 |
| keys      | keys he*        | 根据Pattern表达式查询符合条件的Key |
| dbsize    | dbsize          | 返回key的总数                      |
| exists    | exists a        | 检查key=a是否存在                  |
| del       | del a           | 删除key=a的数据                    |
| expire    | expire hello 20 | 设置key=hello 20秒后过期           |
| ttl       | ttl hello       | 查看key=a的过期剩余时间            |

