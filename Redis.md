简介

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

| 配置项          | 示例                | 说明                                                         |
| --------------- | ------------------- | ------------------------------------------------------------ |
| daemonizeport   | deamonize yes       | 是否启用后台运行,默认no                                      |
| Port            | port 6379           | 设置端口号,默认6379                                          |
| logfile         | logfile "redis.log" | 设置日志文件                                                 |
| databases       | databases 255       | 设置redis数据库总量                                          |
| dir             | dir ./              | 设置数据文件存储目录<br />(文件：dump.rdp【redis的全量复制】) |
| requirepass     | requirepass 12345   | 设置使用密码                                                 |
| protected- mode | protected- mode yes | 是否开启保护模式<br />开启：只允许指定ip访问此redis服务      |
| bind            | bind 0.0.0.0        | 表示所有ip的主机都可以访问进来<br />在线上环境为服务器安全，要指明远程ip地址 |

以配置文件方式启动：

```shell
$ cd redis
$ ./src/redis- server redis. conf
#linux防火墙开放端口，permanent代表永久生效，否则系统重启防火墙设置会被重置
$ firewall-cmd --zone-public--add-port-6379/tcp --permanent
#加载防火墙设置
$ firewall-cmd --reload
$ ./src/redis- cli -p 端口号
> auth 密码
```

## 关闭

```shell
$ kill -9 PID #kill进程
$ ./src/redis- cli shutdow
```

## Redis通用命令

| 命令      | 示例             | 说明                               |
| --------- | ---------------- | ---------------------------------- |
| selectset | select 0         | 选择0号数据库                      |
| Set       | set name lily    | 设置key=name,value-lily            |
| get       | get name         | 获得key=name的结果                 |
| keys      | keys he*/ keys * | 根据Pattern表达式查询符合条件的Key |
| dbsize    | dbsize           | 返回key的总数                      |
| exists    | exists a         | 检查key=a是否存在                  |
| del       | del a            | 删除key=a的数据                    |
| expire    | expire hello 20  | 设置key=hello 20秒后过期           |
| ttl       | ttl hello        | 查看key=a的过期剩余时间            |
| flushall  |                  | 清除所有库所有key数据              |
| flushdb   |                  | 清除单个库所有key数据              |

# Redis数据类型

**注：键唯一**

## String字符串类型

<img src="https://tva1.sinaimg.cn/large/007S8ZIlly1gg4svda4x9j30gs0fhwj3.jpg" alt="3F1B87D1-5020-4113-84C6-CD51274C3DBD" style="zoom: 80%;" />

![2B4BD1B6-59C0-49E6-AB3A-77641A6ACAF2](https://tva1.sinaimg.cn/large/007S8ZIlly1gg4svuk7lsj30yx0evtiq.jpg)

## Hash键值类型

![B7DEB5B5-ADAF-400D-94A9-97BF55E18C09](https://tva1.sinaimg.cn/large/007S8ZIlly1gg4t28fproj30pw0cddj4.jpg)

![2F9C9C53-A28A-4023-BBD6-C1FDA6D8D26D](https://tva1.sinaimg.cn/large/007S8ZIlly1gg4t2u0gsbj31050fhqee.jpg)

> 注：hlen获取指定键的属性数量

## List列表类型

> - List列表就是一系列字符串的“数组" ,按插入顺序排序
>
> - List列表最大长度为2的32次方-1,可以包含40亿个元素
> - 通常用于保存同一类型的数据

**List命令**

![1050DC33-C21B-4B27-BCAF-E9C1799058CB](https://tva1.sinaimg.cn/large/007S8ZIlly1gg4tlohm6cj30un03lgnm.jpg)

> rpush listkey c b a-右侧插入
>
> Ipush listkey f e d-左侧插入
>
> rpop listkey-右侧弹出 （弹出顺序：a-->b-->c-->...)
>
> lpop listkey-左侧弹出  （弹出顺序：d-->e-->f-->...)
>
> llen listkey-获取长度
>
> lrange key start stop-输出指定列表起始到结束范围内的所有元素 
>
> - 如：lrange list 0  -1  （-1表示末尾）

## Set与Zset集合类型

> 集合成员唯一，List成员不唯一
>
> Set集合是字符串的无序集合，集合成员是唯一的
>
> Zset集合是字符串的有序集合,集合成员是唯一的

**Set命令**

> sadd set1 a ---创建集合并设置成员
>
> smembers set1---查看集合成员
>
> sinter set1 set2---集合运算（交集）
>
> sunion set1 set2---集合运算（并集）
>
> sdiff set1 set2---集合运算（差集）
>
> - sdiff set1 set2---set1中没有在set2出现的元素
> - sdiff set2 set1---set2中没有在set1出现的元素

**Zset命令**：在set基础上增加了一个分数，让集合有序

> zadd  zset1 100 a- -----创建集合并按分数设置成员
>
> zadd  zset1 101 b -----创建集合并按分数设置成员
>
> zrange zset1 o-1
>
> - a
> - b
>
> zrange zset1 0-1 withscores
>
> - a
> - 100
> - b
> - 101
>
> zrangebyscore zset1 100 103---按分数删选数据

# Jedis

## 简介

Jedis是Java语言开发的Redis客户端工具包

Jedis只是对Redis命令的封装

## 基本使用

```java
public class JedisTestor {
  public static void main(String[] args) {
    Jedis jedis = new Jedis("127.0.0.1", 6379);
    try {
      jedis.auth("12345");
      jedis.select(0);
      System.out.println("Redis连接成功");
      //字符串类型
      jedis.set ("sn","17781-9938");
      String sn = jedis.get ("sn");
      System. out.println (sn);
      jedis.mset (new String[] {"title","1婴幼儿奶粉" , "num" , "20"});
      List<String> goods = jedis.mget(new String[]{"sn" , "title","num"});
      System.out.println(goods);
      Long num = jedis.incr("num");
      System.out.println(num);
      //Hash
      jedis.hset ("student:3312" ,  "name" ,"小明");
      String name = jedis.hget ( "student:3312" ,"name");
      System. out.println (name) ;
      Map<String, String> studentMap = new HashMap<String, String> ();
      studentMap.put ("name", "李兰");
      studentMap.put ("age", "18") ;
      studentMap.put ("id", "3313");
      jedis.hmset ("student:3313", studentMap);
      Map<String,String> smap = jedis.hgetAll("student:3313");
      System.out.println(smap);
      //List
      jedis.del("letter");
      jedis.rpush("letter",new String[]{"d","e","f"});
      jedis.lpush("letter",new String[]{"c","b","a"});
      List<String> letter = jedis.lrange("letter",0,-1);
      //这里再次运行会产生重复数据，因为每次运行push都会进行数据追加
      //解决方法：在push前添加清除数据语句
      jedis.lpop("letter");
      jedis.rpop("letter");
      //这里letter只保留了当时复制的瞬时状态
      //解决方案：再次赋值
      letter = jedis.lrange("letter", 0, -1);
      System.out.println(letter);
    } catch (Exception err) {  
      err.printStackTrace();
    } finally {
      jedis.close();
    }
  }
}
```

## 缓存数据

```java 
@Data
public class Goods { 
    private Integer goodsId;
    private string goodsName;
    private strinq description;
    private Float price;
}
```

```java
//缓存数据
public class CacheSample {
    public CacheSample () {
        Jedis jedis = new Jedis("127.0.0.1",6379);

        try {
            List<Goods> goodsList =new ArrayList<Goods>();
            goodsList. add (new Goods (8818,"红富士苹果","",3.5f));
            goodsList. add (new Goods (8819,"进口脐橙","",5f));
            goodsList. add (new Goods (8820,"进口香蕉","",10.5f));
            jedis.auth("12345");
            jedis.select(1);
            //对象序列化到内存
            for (Goods goods : goodsList){
                String json = JSON.toJSONString(goods);
                System.out.println(json);
                String key = "goods:"+goods.getGoodsId();
                jedis.set(key,json);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            jedis.close();
        }
    }
    public static void main(String[] args) {
        new CacheSample();
    }
}
```

```java
//测试、提取数据
public static void main(String[] args) {
    new CacheSample();
    System. out.printf ("请输入要查询的商品编号: ");
    String goodsId = new Scanner(System.in) .next ();
    Jedis jedis = new Jedis("127.0.0.1",6379);
    try {
        jedis.auth("12345");
        jedis.select(1);
        String key = "goods:"+goodsId;
        if(jedis.exists(key)){
            String json = jedis.get(key);
            System.out.println(json);
            //json字符串对象转换回java对象
            Goods g = JSON.parseObject(json,Goods.class);
            System.out.println(g.getGoodsId());
        }else
        {
            System.out.println("编号不存在");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        jedis.close();
    }
}
```



# 问题记录

1. **redis中文**

> 汉字在redis中以unicode方式保存避免乱码，用三个字节表示一个汉字
>
> redis-cli显示中文方法：./redis-cli --raw

