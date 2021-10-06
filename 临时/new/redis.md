# 引入目的

数据库数据存在磁盘中，虽然数据库层也有缓存，一般针对查询的内容，但粒度很小，一般只有数据没有变动时，cache才会发生作用；

io压力太大，缓存数据库应运而生，实现热点数据的高速缓存，实现用户的响应速度，极大缓解后端数据库的压力

![image-20210906204717136](https://tva1.sinaimg.cn/large/008i3skNly1gu7737brf7j60va0kmmym02.jpg)

当存储层（数据库）无法使用时，

让客户端请求直接打在缓存层上，不管有没有查到数据都直接返回；这样就能在有损的情况下提供服务

![image-20210906205134554](https://tva1.sinaimg.cn/large/008i3skNly1gu777nl0spj617i0luabu02.jpg)

分片（sharding）：大数据分布到多个物理节点上的分区方案

redis是单进程单线程模型的k-v数据库的,主线程是单线程，处理网络请求的线程；操作避免上下文切换和锁竞争

持久化时就是用子线程或子进程的方式执行

数据操作检点类似hashMap，查找操作的时间复杂度都是O(1)

![image-20210906210008078](https://tva1.sinaimg.cn/large/008i3skNly1gu77gke4sbj31980ky0ve.jpg)

IO多路复用模型：解决单线程IO阻塞问题

![image-20210907163228350](https://tva1.sinaimg.cn/large/008i3skNly1gu85cboobwj60y00cimyh02.jpg)

是一个整数

![image-20210907163449954](https://tva1.sinaimg.cn/large/008i3skNly1gu85es1pg8j60tc0je75j02.jpg)

当使用read或者write对一个文件描述符进行读写时，如果当前fd不可读或者不可写，整个redis就不会对其他服务做出响应，被block住；传统模型在需要处理多个客户端任务时，往往都不会使用阻塞模型；

![image-20210907163852024](https://tva1.sinaimg.cn/large/008i3skNly1gu85izdoikj60s40jmt9r02.jpg)

最重要的函数调用select系统调用

select方法能够同时监控多个文件描述符的可读可写情况，当某些文件描述符可读可写时select方法就会返回可读以及可写的文件描述符个数；既selector监听文件是否可读或者可写；监听的任务交给selector，程序就可以去做其他任务而不被阻塞了

还有其他多路复用函数，相比select函数更为优秀

linux中的epoll，mac os 中的kqueue

这些函数都是操作系统内核函数，都使用了内核内部服务，性能比select优秀；select在不同系统中都会实现，作为保底方案，扫描全部文件描述符，时间复杂度为N

![image-20210907165109786](https://tva1.sinaimg.cn/large/008i3skNly1gu85vs0vxbj61280h20uj02.jpg)

# 数据类型

String类型

既KV键值对

值最大能存储512M，是二进制安全的--既可以包含任何数据，如jpg图片，或者序列化的对象

redis的单个操作都是原子性的，一个事务是一个不可分割的最小单位，要么都做，要么都不做；不用考虑并发问题

![image-20210907165849104](https://tva1.sinaimg.cn/large/008i3skNly1gu863r5llvj614e0oojth02.jpg)

![image-20210907172746275](/Users/hao/Library/Application Support/typora-user-images/image-20210907172746275.png)

list可以轻松实现栈 lrange顺序就是出栈顺序，用push和pop可实现队列和栈，如最新消息排行榜

redis可以方便的求差集 并集等操作；像可以 微博粉丝、关注存在集合、可实现共同关注、共同喜好等功能

Zset，每个成员关联一个double类型的分度，通过分数进行排序，分数可以重复

但权重队列，普通消息分数1，重要消息2

全班同学 value为姓名 score为分数 天然排序

![image-20210907173959325](https://tva1.sinaimg.cn/large/008i3skNly1gu87anspplj61620oeq6i02.jpg)

![image-20210907202730738](https://tva1.sinaimg.cn/large/008i3skNly1gu8c4vzajvj311c03q0tc.jpg)

![image-20210907203220616](https://tva1.sinaimg.cn/large/008i3skNly1gu8c9x2bnej612m0f2abp02.jpg)

![image-20210907203634250](https://tva1.sinaimg.cn/large/008i3skNly1gu8ceb3jiwj617k0jatbw02.jpg)

![image-20210907203900308](https://tva1.sinaimg.cn/large/008i3skNly1gu8cgu7yj6j611c0lun0602.jpg)

![image-20210907204016486](https://tva1.sinaimg.cn/large/008i3skNly1gu8ci740ryj60m80iymyp02.jpg)

游标不一定递增，可能会取到重复key，需要在外部程序去重，如java程序每次调用scan 将结果存入set就可去重；

分批次去遍历，整体花费时间要比keys长；

![image-20210907204306087](https://tva1.sinaimg.cn/large/008i3skNly1gu8cl4juvbj60wm04awew02.jpg)

分布式锁：控制分布式系统之间访问共享资源的一种锁的实现。往往需要互斥，来防止干扰，进而保持一致性，

1. 既任一时刻只能有一个客户端获取锁
2. 锁只能被持有锁的客户端删除，不能被其他客户端删除
3. 获取锁的客户端因为某些原因而宕机，其他客户端再也无法获取锁，此时应该要有机制避免这种情况发生
4. 当有一些redis节点宕机时，客户端依旧能获取锁和释放锁

![image-20210907204806274](https://tva1.sinaimg.cn/large/008i3skNly1gu8cqbwomlj312g0j6myc.jpg)

初期使用setnx

![image-20210907205102533](https://tva1.sinaimg.cn/large/008i3skNly1gu8ctejy27j61320h2myq02.jpg)

![image-20210907210330677](https://tva1.sinaimg.cn/large/008i3skNly1gu8d6cdwdwj616m0oiack02.jpg)

风险？

分布式锁要是原子性的

执行完setnx后宕机，来不及expire

setnx+expire 原子操作加原子操作就不是原子性的了

redis 2.6.12开始就可以：

![image-20210907210741785](https://tva1.sinaimg.cn/large/008i3skNly1gu8dapg1kbj618m0qeadg02.jpg)

![image-20210907210843029](https://tva1.sinaimg.cn/large/008i3skNly1gu8dbsjtgwj60om066q3b02.jpg)

![image-20210907212244283](https://tva1.sinaimg.cn/large/008i3skNly1gu8dqcu7j5j61bw0b2q4v02.jpg)

![image-20210907212323928](https://tva1.sinaimg.cn/large/008i3skNly1gu8dr0xpmbj314k0cujsn.jpg)

lpop没有值说明消费完毕

![image-20210907212553859](https://tva1.sinaimg.cn/large/008i3skNly1gu8dtn8byjj619i0gu0uw02.jpg)

![image-20210907212814097](https://tva1.sinaimg.cn/large/008i3skNly1gu8dw28ntbj61a60c840102.jpg)

![image-20210907213010003](https://tva1.sinaimg.cn/large/008i3skNly1gu8dy3k27tj61740fqwg702.jpg)

频道既topic

![image-20210907213057863](https://tva1.sinaimg.cn/large/008i3skNly1gu8dywydinj617m0qy76p02.jpg)

![image-20210907213410125](https://tva1.sinaimg.cn/large/008i3skNly1gu8e2ae3szj615k0ts79e02.jpg)

![image-20210907213441827](https://tva1.sinaimg.cn/large/008i3skNly1gu8e2t2oewj319y0ammxy.jpg)

如果订阅者在发布者发布时下线，再上线，它是收不到消息的

![image-20210907213555112](https://tva1.sinaimg.cn/large/008i3skNly1gu8e4217ihj30n404oweq.jpg)

一旦服务器进程退出，redis数据就会丢失；

![image-20210907213759183](https://tva1.sinaimg.cn/large/008i3skNly1gu8e67b3vxj60cq04saa102.jpg)

900秒内有1条写入，就进行一次快照备份；设置三个？redis每个时段的读写请求肯定是不均衡的，为了平衡性能与数据安全

![image-20210907214010795](https://tva1.sinaimg.cn/large/008i3skNly1gu8e8hsunuj60nk02ot8x02.jpg)

当备份进程出错，主进程就停止写入操作；为了持久化数据一致性问题 

![image-20210907233027708](/Users/hao/Library/Application Support/typora-user-images/image-20210907233027708.png)

rdb文件是否压缩，因为rdb本身就是cpu密集型服务，开始压缩使用更多的cpu消耗 cpu成本比硬盘高得多

禁用rbd服务：save ”“

![image-20210907233239150](/Users/hao/Library/Application Support/typora-user-images/image-20210907233239150.png)

![image-20210907233346271](https://tva1.sinaimg.cn/large/008i3skNly1gu8hipi8fzj61g80n2n0n02.jpg)

![image-20210907233651238](https://tva1.sinaimg.cn/large/008i3skNly1gu8hlw2khej60k00nw40f02.jpg)

使用java程序定期执行bgsave；mv durp.rdb dumpxxx(时间戳).rdb;保存某个时间点的全量数据备份

![image-20210907234248973](https://tva1.sinaimg.cn/large/008i3skNly1gu8hs3boptj61am0lqdi102.jpg)

### debug reload

save当前的rdb文件，并清空当前数据库，重新加载rdb，加载与启动时加载类似，加载过程中只能服务部分只读请求（比如info、ping等）  

传统fork子进程时直接把所有资源复制给子进程，实现简单、效率低下、复制的资源可能对子进程毫无用处

linux为了降低创建子线程的成本，改进fork实现方式，既copy-on-write 既写时复制，简称cow；核心思想如下；当父进程创建子进程时内核只为子进程创建虚拟空间，父子两个进程使用的时相同的物理空间，只有子进程试图更改时才会为主进程分配独立的物理空间

![image-20210907235243651](https://tva1.sinaimg.cn/large/008i3skNly1gu8i2higqaj614m0oq40002.jpg)

![image-20210907235149061](https://tva1.sinaimg.cn/large/008i3skNly1gu8i1gp11hj616m0hugp902.jpg)

这样就保证了原子性和一定的读写效率；共享读；需要更改时创建；被修改后，更改指向该资源的指针；

redis持久化时会fork一个子进程，子进程将数据写到磁盘中的一个临时rdb文件中，完成后，将原来的rdb替换掉，主进程继续处理client的请求，子进程负责将内存内容写入到磁盘中，由于os的cow机制，父子进程共享同一个物理页面，父进程处理写请求时，os会为父进程要修改的页面创建副本，而不是写共享的页面，使用子进程地址空间内的数据是fork时刻的数据

redis启动时发现rdb会自动载入

rdb是一定时间间隔持久化一次，所以有丢失风险

如果不能丢失的话使用AOF

![image-20210908000644242](https://tva1.sinaimg.cn/large/008i3skNly1gu8igzkz8ij61c00g8wg202.jpg)

![image-20210908000748146](https://tva1.sinaimg.cn/large/008i3skNly1gu8ii3o4agj616q0g876602.jpg)

![image-20210908000929586](https://tva1.sinaimg.cn/large/008i3skNly1gu8iju4m4gj30lm05sglw.jpg)

![image-20210908000943611](https://tva1.sinaimg.cn/large/008i3skNly1gu8ik30w89j30cq03udfy.jpg)

一直：缓存区变化时；每隔一秒；no时，交由操作系统来决定；一般而言为了提高效率，操作系统等缓存区满了，才会填充缓存区数据到磁盘当中；一般就每秒

![image-20210908001326133](https://tva1.sinaimg.cn/large/008i3skNly1gu8inym859j30mk0h40u1.jpg)

如：一个数据修改100次，aof就会记录100次，我们其实只需一个命令 最后的一个命令就行；所以可以精简

所以需要重写aof文件，把当前内存的数据生成对应命令，并不需要读取老的aof文件进行分析或者命令的合并

![image-20210908001834318](https://tva1.sinaimg.cn/large/008i3skNly1gu8itb8rdwj61bu0pggoz02.jpg)

可以手动触发bgrewriteaof、也可以自动触发（配置里）

![image-20210908002047394](https://tva1.sinaimg.cn/large/008i3skNly1gu8ivlwgqyj60y00rwabo02.jpg)

![image-20210908002308656](https://tva1.sinaimg.cn/large/008i3skNly1gu8iy1wn9rj619s0ly0v802.jpg)

aof人类可读；rdb二进制

redis4.0之后，推出混合持久化方式，并且默认配置

![image-20210908002727740](/Users/hao/Library/Application Support/typora-user-images/image-20210908002727740.png)

优点：提高重写、恢复速度、也可以减少文件大小、还同时可以保证数据的完整性；结合rdb和aof的优点

1 子进程会把内存中的数据以RDB的方式写入aof中，

2 把重写缓冲区中的增量命令以AOF方式写入到文件

3 将含有RDB格式和AOF格式的AOF数据覆盖旧的AOF文件

![image-20210908003635658](https://tva1.sinaimg.cn/large/008i3skNly1gu8jc1k0gbj60r209gglx02.jpg)

一次传入多条指令去操作

![image-20210908003708404](https://tva1.sinaimg.cn/large/008i3skNly1gu8jcm2esqj60s007iabn02.jpg)

![image-20210908003659274](https://tva1.sinaimg.cn/large/008i3skNly1gu8jch5uolj60q407egmx02.jpg)

^M换行符

![image-20210908005508183](https://tva1.sinaimg.cn/large/008i3skNly1gu8jvcn9tyj61280jm76002.jpg)

![image-20210908005646337](https://tva1.sinaimg.cn/large/008i3skNly1gu8jx1szy4j310y0ngjsf.jpg)

一个写，多个读，数据备份时也选用一个slaver进行；支持数据的弱一致性，既最终一致性；不需要实时保证master和slaver之间的数据是同步的，但过一段时间后，它们的数据是趋于同步的

主从同步；从从同步

第一次同步时，主节点做一次bdsave，并同时将后续修改操作记录到内存的buffer里面，待完成后，将rdb文件全量同步到从节点，完成后从节点将rdb的镜像加载到内存中，加载完成后再通知主节点，将期间修改的操作记录，同步到从节点进行重放；

![image-20210908010508735](https://tva1.sinaimg.cn/large/008i3skNly1gu8k5rc7oyj61480nywhe02.jpg)

之后的写操作都是在master；读操作都是在slave；

增量同步：增删改就需要扩散了

对齐？确保从数据库是该操作所对应的数据库

![image-20210908010808670](https://tva1.sinaimg.cn/large/008i3skNly1gu8k8xccz0j616k0kqtat02.jpg)

主从模式弊端：不具备高可用性；master宕机就不能响应写操作，sentinel应运而生

redis sentinel：哨兵，redis集群管理工具；

本身也是一个独立运行的进程，能够监控多个master-slave集群；master宕机后能自动切换

主从切换：主宕机选择一个slave变为主，并让其他slave开始同步新的master；当客户端试图连接宕机的master时，哨兵也会向客户端返回新master地址，使得集群可以使用新的master代替失效的master

sentinel是一个分布式系统， 可以在一个架构中使用多个sentinel进程；这些进程使用gossip流言协议来接收主服务器是否下线的信息，并使用投票协议来决定是否执行自动故障迁移，以及选择哪一个从节点作为新的从节点，这根zookeeper比较类似

![image-20210908012526473](https://tva1.sinaimg.cn/large/008i3skNly1gu8kqw4d1pj616c0gu75w02.jpg)

gossip：反熵；熵代表杂乱无章

反熵既在杂乱无章中寻求一致

每个节点都会和其他节点杂乱无章的通信，最终所有节点状态达成一致

种子节点发送所拥有的节点列表

![image-20210908013221014](https://tva1.sinaimg.cn/large/008i3skNly1gu8ky2m3tij61600he76902.jpg)

redis另外一种非常常用的部署模式是哨兵模式，如果你的公司使用的是这种部署模式，它相对于单实例模式更加的高可用。
![img](https://img.kancloud.cn/2b/05/2b056e746876f200bb23bcf2e8914ea6_791x566.png)

- redis哨兵模式实际上是两种模式的组合，即主从模式和哨兵模式。当`Master`节点离线后，哨兵sentinel监控节点会把`Slave`节点切换为`Master`节点，保证服务的高可用
- 哨兵模式是在主从模式的基础上增加了哨兵sentinel监控节点。最简单的哨兵模式需要一个redis的`Master`节点、一个redis的`Slave`、另外三个哨兵监控节点。

![image-20210908120503478](https://tva1.sinaimg.cn/large/008i3skNly1gu938cq06uj60ju04kt8w02.jpg)

![image-20210908120530080](https://tva1.sinaimg.cn/large/008i3skNly1gu9399hlmtj615y0boab902.jpg)

redis cluster 去中心结构，每个节点保存数据和集群状态，每个节点都和其他节点之间连接，节点之间使用gossip协议，传播信息以及发现新节点

![image-20210908120738736](https://tva1.sinaimg.cn/large/008i3skNly1gu93bg2xdwj61760hgq4p02.jpg)

对key hash对服务器数量取模

![image-20210908121049053](https://tva1.sinaimg.cn/large/008i3skNly1gu93edmybkj618i0pw76e02.jpg)

![image-20210908121112988](https://tva1.sinaimg.cn/large/008i3skNly1gu93eruub3j60vy0owtat02.jpg)

![image-20210908121225932](https://tva1.sinaimg.cn/large/008i3skNly1gu93g1nfxmj60w40oqabs02.jpg)

最小化损失，一个服务器只会影响其顺时针闭环到上一个节点内的数据

![image-20210908121423865](https://tva1.sinaimg.cn/large/008i3skNly1gu93i3p67bj60vc0p0gnh02.jpg)

高容错、高扩展

![image-20210908121453715](https://tva1.sinaimg.cn/large/008i3skNly1gu93j1jwo8j60wo0poabu02.jpg)

在节点很少时容易因为节点分布不均匀早晨是管护局倾斜；既数据在某台服务其缓存特别多；为解决这个问题引入虚拟节点 ；对一个节点建立多个虚拟节点，并建立虚拟节点到真实节点的映射

![image-20210908122108336](https://tva1.sinaimg.cn/large/008i3skNly1gu93p3q3j4j60uy0ootai02.jpg)

![image-20210908122851552](https://tva1.sinaimg.cn/large/008i3skNly1gu93x4pj96j60mg0vawh802.jpg)

![image-20210908124532679](https://tva1.sinaimg.cn/large/008i3skNly1gu94ehfmirj6152044mxc02.jpg)

![image-20210908124552865](https://tva1.sinaimg.cn/large/008i3skNly1gu94eu1844j615008eglw02.jpg)