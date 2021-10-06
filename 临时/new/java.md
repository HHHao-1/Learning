# 谈谈你对Java的理解

1. 一次编译，到处运行，二进制字节码

   1. javac a.java

   2. java a.class

   3. javap 查看字节码 反汇编 -c

      ![image-20210909135149977](https://tva1.sinaimg.cn/large/008i3skNly1guabxr9qzlj60m6090js102.jpg)

      ![image-20210909134534746](https://tva1.sinaimg.cn/large/008i3skNly1guabr9l4qwj60rm0hsgnw02.jpg)

      ![image-20210909134659558](https://tva1.sinaimg.cn/large/008i3skNly1guabsq9fl6j614w0j20vd02.jpg)

      code：里就是午餐欧早函数要执行的内容

      1. 对base进行操作

      2. 调用父类构造方法super

      3. 退出构造函数

         不指定类的构造函数，编译器会默认制定一个不带参的构造函数

      main函数：这里主要是java堆栈中的栈操作，因为这里主要是局部变量

      0. 把常量1放到栈里

      1. 将栈顶的值放到局部变量1当中

      2. 将5放到栈里

      3. 将栈顶的值放到局部变量2当中

      4. ++操作

      5. ++操作

      6. 获取printstream的静态域对象，将其压入栈顶

      7. 将本地变量i的值推送至栈顶

      8. 调用PrintStream.println打印

         再对变量2调用同样的方法

         最后退出方法

      这些指令就是java虚拟机所能理解的字节码

      ![image-20210909135849488](https://tva1.sinaimg.cn/large/008i3skNly1guac51w8xpj615i0fwgo102.jpg)

      jvm ios就将class文件解析 为ios对应的机器码

      java 指令一定要有相关的package目录，要不就找不到或者无法加载主类

      ![image-20210909140642867](https://tva1.sinaimg.cn/large/008i3skNly1guacd99hp3j611e05gwf402.jpg)

      ![image-20210909140813225](https://tva1.sinaimg.cn/large/008i3skNly1guacf3ncmnj616u040js502.jpg)

      1.  直接编译成机器码，每次都要检查、校验、补全；做重复的事情
      2. rubby，scala等
      3. 平台无关性

      ![image-20210909141041509](https://tva1.sinaimg.cn/large/008i3skNly1guachgepqoj614m0h2jt102.jpg)

2. gc:不用手动释放内存

3. 泛型 反射 lambda表达式

4. 封装 继承 多态

5. 集合 、并发库、网络库、io、nio？

6. 异常

![image-20210909134220226](https://tva1.sinaimg.cn/large/008i3skNly1guabnxjdrrj60oq0gi74y02.jpg)

1. java虚拟机

一般我们不需要关注虚拟机运行原理，只需关注java代码就可以了，屏蔽底层操作系统平台的不同，并且减少基于原生语言开发的复杂性，只要虚拟机厂商在特定系统上实现了虚拟机，定义如何将字节码解析成本操作系统可执行的二进制码，java便能跨越各种平台

最值得学习的：jvm内存结构模型、GC;程序调优的关键

jvm是一个内存中的虚拟机，jvm的存储就是内存

![image-20210909141659314](/Users/hao/Library/Application Support/typora-user-images/image-20210909141659314.png)

1. class loader：加载符合格式要求的class文件
2. class文件能不能运行由execution engine负责；解释器；对命令解析，解析完就提交到真正的 操作系统去执行
3. 需要性能更高操作时，调用其他语言原生库 c c++；不重复造轮子的原则 实际生产中某个库用到别的语言进行开发 就直接调用它；具体做法 method中标记 native方法，execution执行时加载native libaraies

![image-20210909142511809](https://tva1.sinaimg.cn/large/008i3skNly1guacwhb1dbj615k0muada02.jpg)

Class.forName() 实现就有用到native方法

# 反射

![image-20210909142823097](https://tva1.sinaimg.cn/large/008i3skNly1guaczsjcymj60sa0fsq4a02.jpg)

## 举一个例子

![image-20210909143028897](https://tva1.sinaimg.cn/large/008i3skNly1guad21gjdej60pi076aar02.jpg)

 getDeclareMethod 不能获取继承、实现接口的方法；既只能获取它本身的方法，所有方法；

getMethod：获取public方法，继承、实现的public方法

获取字段也类似；获取字段值field.get(实例)

![image-20210909160332726](https://tva1.sinaimg.cn/large/008i3skNly1guafqtydrdj614s0e4n0902.jpg)

反射就是把java类中的各种成分映射成一个个java对象，Class Method Field等

![image-20210909162156429](https://tva1.sinaimg.cn/large/008i3skNly1guag9z46o3j61000ggdhk02.jpg)

![image-20210909162243296](https://tva1.sinaimg.cn/large/008i3skNly1guagawaz8cj60ty0n876502.jpg)

1. 核心类是被签名过的不能被替换

2. 用户可见，可放用户自定义jar包（不可见的c++写的，必须看jvm代码）

3. 加载类路径擦classpath

   ![image-20210909163106156](https://tva1.sinaimg.cn/large/008i3skNly1guagjhnzvsj60u2020gly02.jpg)

![image-20210909163709740](https://tva1.sinaimg.cn/large/008i3skNly1guagpuc2t5j60ly0cojs702.jpg)

自定义：defineClass：字节码以byte[]传入

 作用：1.自定义目录加载class文件

2.访问远程网络，获取格式正确的二进制流，通过defineClass调用；既远程调用？

3.对敏感class加密，在findClass里进行解密

4.对生成的二进制流做修改，给类添加信息

5.也可以实现aop  

```java
public class MyClassLoader extends ClassLoader {
    private String path;
    private String classLoaderName;

    public MyClassLoader(String path, String classLoaderName) {
        this.path = path;
        this.classLoaderName = classLoaderName;
    }

    //用于寻找类文件
    @Override
    public Class findClass(String name) {
        byte[] b = loadClassData(name);
        return defineClass(name, b, 0, b.length);
    }

    //用于加载类文件
    private byte[] loadClassData(String name) {
        name = path + name + ".class";
        InputStream in = null;
        ByteArrayOutputStream out = null;
        try {
            in = new FileInputStream(new File(name));
            out = new ByteArrayOutputStream();
            int i = 0;
            while ((i = in.read()) != -1) {
                out.write(i);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                out.close();
                in.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return out.toByteArray();
    }
}

public class ClassLoaderChecker {
    public static void main(String[] args) throws ClassNotFoundException, IllegalAccessException, InstantiationException {
        MyClassLoader m = new MyClassLoader("/Users/baidu/Desktop/", "myClassLoader");
        Class c = m.loadClass("Wali");
        System.out.println(c.getClassLoader());
        System.out.println(c.getClassLoader().getParent());
        System.out.println(c.getClassLoader().getParent().getParent());
        System.out.println(c.getClassLoader().getParent().getParent().getParent());
        c.newInstance();
    }
}
```

![image-20210909165747664](https://tva1.sinaimg.cn/large/008i3skNly1guahb9jk76j616m0lymzk02.jpg)

![image-20210909170017815](https://tva1.sinaimg.cn/large/008i3skNly1guahe4vhd1j60uk04sgm302.jpg)

各个类加载器各司其职，让它们相互协作形成一个整体的机制--双亲委派

同步锁，可能会有多个线程调用同一个classLoader去加载同一个类

![image-20210909170534847](https://tva1.sinaimg.cn/large/008i3skNly1guahjksjpuj60wy05u3ze02.jpg)

![image-20210909170735863](https://tva1.sinaimg.cn/large/008i3skNly1guahlnuebwj60se0iytb202.jpg)

上述代码在ClassLoader，每个ClassLoader都会直接或间接继承他，ClassLoader是个抽象类；如果加载过这个class就直接返回这个class；否则进入if里；如果parent不为空，这里如果是自定义classLoader，那parent就是Appclassloader, 调用aooclassloader的loadClass；如果判断没加载此类，调用父类的loadClass，又是上述代码，一样的代码，又到if判断，向上递增，知道botstrap,它是c++，ext的parent是null--》c = findBpotstrapClassorNull (name);；如果找到直接返回，如果没有装载过，就去BpotstrapClassLoader下扫描，看有没有这个文件，有装载进来，没有就进行下一步，往下走；告诉extLoader，进入第二个if

![image-20210909173019036](https://tva1.sinaimg.cn/large/008i3skNly1guai95p0vlj60z00bmwfy02.jpg)

 调用自己的findCLass方法，在自己的路径去找，如果找到就返回Class对象，没有就调用AppClassLoader的findCLass，然后再自定义的findClass

![image-20210909173828364](https://tva1.sinaimg.cn/large/008i3skNly1guaiho0gqij613m08ymyz02.jpg)

![image-20210909173856188](https://tva1.sinaimg.cn/large/008i3skNly1guaii1z1xnj60pg03y3yu02.jpg)

![image-20210909174139246](https://tva1.sinaimg.cn/large/008i3skNly1guaikwn5w2j60wk0ly76x02.jpg)

![image-20210909175942760](https://tva1.sinaimg.cn/large/008i3skNly1guaj3ol3kjj60x804azkt02.jpg)

1. 内存没必要保存相同的类对象Class

![image-20210909181106564](https://tva1.sinaimg.cn/large/008i3skNly1guajfjlpl9j60ug08qaao02.jpg)

![image-20210909181204949](https://tva1.sinaimg.cn/large/008i3skNly1guajgk033hj60pa0bmwev02.jpg)

还有一个调用类的静态成员时

临时加载不用newinstance；但不能进行有参构造调用，需要反射获取构造方法；内部类class类名ttt$t；forname会加载static，loadclass不会？

、、loadClass , forNames区别
类变量随类型信息存放在方法区当中，生命周期很长，使用不当容易内存泄漏；这里初始值是指类型变量默认初始值，而不是要赋的初始值

![image-20210909184555796](https://tva1.sinaimg.cn/large/008i3skNly1guakft0mn2j610k0mmgnu02.jpg)

loadclass的resolve参数：是否要解析，也就是连接这个类，默认是false

![image-20210909184750893](https://tva1.sinaimg.cn/large/008i3skNly1guakhs2s0bj60ns0j4mzl02.jpg)

链接指定类

![image-20210909184828799](https://tva1.sinaimg.cn/large/008i3skNly1guakifbovpj60oe0e8mys02.jpg)

forName是默认初始化类的

![image-20210909184908906](https://tva1.sinaimg.cn/large/008i3skNly1guakj4i9wnj611m06caav02.jpg)

![image-20210909184923566](https://tva1.sinaimg.cn/large/008i3skNly1guakjdiwklj60tk0d2gmo02.jpg)

![image-20210909185923812](https://tva1.sinaimg.cn/large/008i3skNly1guaktslarzj60qc05mq3n02.jpg)

这里忘了loadclass? 

连接mysq就要用forname，里面有静态代码段

![image-20210909185902989](https://tva1.sinaimg.cn/large/008i3skNly1guaktgp5tuj60r609gq3z02.jpg)

loadClass场景：springMVC读取bean配置文件时，使用classpath方式加载，就使用loadclass，这个与spring ioc的lazy loading有关，延迟加载，加快初始化速度

# 内存模型

![image-20210913221548779](https://tva1.sinaimg.cn/large/008i3skNly1gufczyb7byj314q0qyadf.jpg)

![image-20210913221706887](https://tva1.sinaimg.cn/large/008i3skNly1gufd1b8jfnj312a0qgjuh.jpg)

## 程序计数器

一段较小的内存空间

jvm多线程：是通过线程轮流切换， 并分配处理器执行时间的方式来实现的，在任何一个确定的时刻，一个处理器只会执行一条线程中的指令，因此为了线程切换后能恢复到正确的执行位置，每条线程都需要一个独立的程序计数器，各线程之间的计数器互不影响，独立存储，既线程私有的内存

如果正在执行java方法，计数器记录的是正在执行的虚拟机字节码指令的地址，如果native记录为undefined

知识记录行号，不必担心内存泄漏的问题

是逻辑计数器而非物理计数器

![image-20210913222539995](https://tva1.sinaimg.cn/large/008i3skNly1gufda73tsbj615c0j0tb002.jpg)

## 虚拟机栈

方法调用结束或抛出未捕获的异常时，栈帧出栈。

![image-20210913222811289](https://tva1.sinaimg.cn/large/008i3skNly1gufdctonj3j61540iimz302.jpg)

操作数栈： 在执行字节码指令过程中被用到，这种方式类似原生cpu寄存器，大部分jvm字节码把时间花在操作数栈的操作上，包括入栈、出栈、复制、交换、产生消费变量；

![image-20210913223230951](https://tva1.sinaimg.cn/large/008i3skNly1gufdhbp6b0j61440owwgk02.jpg)

![image-20210913223410362](https://tva1.sinaimg.cn/large/008i3skNly1gufdj2wjb1j617w0f6whx02.jpg)

口语化的方式反编译

![image-20210913223453952](https://tva1.sinaimg.cn/large/008i3skNly1gufdju1rhgj60gu0fwq3t02.jpg)

stack，操作数栈2，locals：本地变量3；args_size参数两个   

lineNumberTable：line5：0--代码第五行对应字节码第0行

下图长方形代表栈帧

![image-20210913224800757](https://tva1.sinaimg.cn/large/008i3skNly1gufdxhwrssj61au0jkwgb02.jpg)

iconst_0：int值0压入操作数栈之中，同时入参是1和2

istore_2：将操作数栈中栈顶元素0给pop出来，加入局部变量表，从零开始第二个元素

iload_0:将第0个局部变量压入操作数栈

*load入栈；store出栈*

iload_1:将第1个局部变量压入操作数栈

iadd:将1，2弹出操作数栈进行运算，再压入

istore_2：将操作数栈中栈顶元素3给pop出来，加入局部变量表，从零开始第二个元素

iload_2:将第2个局部变量压入操作数栈

ireturn:将栈顶元素返回

局部变量列表给操作数栈提供必要的数据支撑，就像局部变量是数据库（物理内存），操作数栈是内存

![image-20210913231535439](https://tva1.sinaimg.cn/large/008i3skNly1gufeq53d7tj311q06kjs9.jpg)

调用一个方法是就会创建一个栈帧

方法执行完毕就会将栈帧出栈

每个线程的虚拟机栈深度是固定的

解决：限制递归的次数；使用循环的方法替换递归；

![image-20210913232114964](https://tva1.sinaimg.cn/large/008i3skNly1gufew1ovecj612o0no76q02.jpg)

虚拟机栈可以动态申请时，如果无法申请足够多的内存

每个栈帧方法调用时产生，调用结束弹出，既虚拟栈的内存不需要GC去回收，而会自动释放

## 本地方法栈

![image-20210913232457391](https://tva1.sinaimg.cn/large/008i3skNly1gufezvzn0hj610o0aogmj02.jpg)

## 元空间、永久代

jdk8以后开始把类的元数据放在本地堆内存中，这一块区域就叫MetaSpace，这块区域在jdk7及以前是属于永久代的

元空间和永久代都是用来存储Class的相关信息，包括Class对象的method和field；

元空间和永久代都是方法区的实现，实现有所不同，方法区只是一种jvm的规范

java7及之后，原先位于方法区里的字符串常量池已被移动到了java堆中，之前字符创常量池存在于永久代中，并在jdk8之后，使用元空间代替永久代，这解决了内存溢出，也不能无相放大，jvm在运行中动态设置其大小

metaspace没有了字符串常量池，jdk7中已经被移动到了堆中

![image-20210913234027702](https://tva1.sinaimg.cn/large/008i3skNly1guffg16kv8j612s0bewfh02.jpg)

![image-20210913234200534](https://tva1.sinaimg.cn/large/008i3skNly1guffhmm6laj612q0fgabv02.jpg)

永久代是hotspot特有的，其他没有，用元空间可以更好地集成

# 永久代，老年代，新生代？

java对，jvm管理的内存中最大的一块

java堆可以处于物理上不连续的内存空间中，只要逻辑上是连续的即可

主流虚拟机java堆大小都是根据可扩展来实现的，既通过-XMX等配置来控制

如果java堆中没有内存去完成实例分配，并且堆也无法再扩展时，就会旁出内存溢出异常

有时也被称为GC堆

从内存回收的角度看，现在收集器基本都是采用分代收集算法，所以java堆中还可以细分为新生代、老年代，再细致一点Eden、。。。。

![image-20210913235433781](https://tva1.sinaimg.cn/large/008i3skNly1guffup7baqj615g0gut9z02.jpg)

![image-20210914152339711](https://tva1.sinaimg.cn/large/008i3skNly1gug6phknoaj60zc078t9902.jpg)

初始值不够时扩容，扩容到-Xmx；一般这两设置一样，因为当heap不够用扩容时，会发生内存抖动，影响程序运行时稳定性

![image-20210914152859450](https://tva1.sinaimg.cn/large/008i3skNly1gug6uz1zk0j60yu0da75b02.jpg)

静态存储：不允许程序中有可变数据结构、递归、嵌套结构；因为它们导致搬移程序无法计算准确的存储空间

堆式存储：如可变字符串和对象实例，堆由大片的可利用块或空闲块组成，堆中内存可根据任意顺序分配、释放

![image-20210914153327613](https://tva1.sinaimg.cn/large/008i3skNly1gug6zmqqbzj616k0d60ul02.jpg)

联系：引用对象在没有变量引用时，才会变成垃圾，在之后某个不确定时间才会被GC回收

![image-20210914153519522](https://tva1.sinaimg.cn/large/008i3skNly1gug71k41jej614m0j040102.jpg)

GC不是实时的，可能使堆内存的内存碎片累积起来

静态分配是本身由编译器分配好了，而动态分配可能根据情况有所不同，是个运行时级别的的内存；对空间即使有GC，还是要考虑内存释放的问题

![image-20210914154235048](https://tva1.sinaimg.cn/large/008i3skNly1gug7941v95j61160hw40502.jpg)

栈空间相比堆空间弱点是：灵活程度不够，特别是在动态管理的时候；堆空间最大的优点在于动态分配，底层可能是个双向链表，操作复杂但灵活

![image-20210914154446200](https://tva1.sinaimg.cn/large/008i3skNly1gug7be5wj7j60vk0k4q5202.jpg)

元空间存储：Class对象信息 方法 字段 还有System类对象信息 及字段和方法

堆：类实例，String实例

栈：lineNo系统自带的行号lineNumber记录代码的执行，方便对程序追踪

![image-20210914155236723](https://tva1.sinaimg.cn/large/008i3skNly1gug7jjx4z3j61200jw0x302.jpg)

intern将字符串塞到字符串常量池里面

jdk6，常量池在永久代，频繁调用intern会将池引爆，内存溢出 

jdk7以前只能方副本进常量池，7及以后可以放引用进去

![image-20210914160101857](https://tva1.sinaimg.cn/large/008i3skNly1gug7sax9k7j60c6020q2s02.jpg)

设置永久代大小

类似：-Xmx和-Xms

![image-20210914160906930](https://tva1.sinaimg.cn/large/008i3skNly1gug80qki81j60q80cqdgz02.jpg)

![image-20210914161042993](https://tva1.sinaimg.cn/large/008i3skNly1gug82e4af5j615m0iwwhf02.jpg)

![image-20210914161049528](https://tva1.sinaimg.cn/large/008i3skNly1gug82hlj4nj60zq0643zq02.jpg)

jdk7，字符串常量池从永久代移动到堆内存，可以成功

![image-20210914161247538](https://tva1.sinaimg.cn/large/008i3skNly1gug84jw1w1j614y06omyy02.jpg)

1.8没有永久代

![image-20210914161404834](https://tva1.sinaimg.cn/large/008i3skNly1gug85w1cpxj614c06m40w02.jpg)

new出来的String对象在heap创建；字面量对象在字符串常量池创建

引号声明的字符串会被放到字符串常量池，包括new里面的字符串，new又会

1.6 false false

![image-20210914162143231](https://tva1.sinaimg.cn/large/008i3skNly1gug8duva5lj61860iuwgk02.jpg)

jdk7及以上 false true

# GC

jvm自动化解决两个问题：1. 对象内存分配 2. 回收给对象分配的内存

判定为垃圾就会被回收：

![image-20210915175412312](https://tva1.sinaimg.cn/large/008i3skNgy1guhgofiksvj60py07ewex02.jpg)

两个算法判定对象不再被引用

![image-20210915175442852](https://tva1.sinaimg.cn/large/008i3skNgy1guhgovvvhrj60m007e74c02.jpg)

![image-20210915175558258](https://tva1.sinaimg.cn/large/008i3skNgy1guhgq7s4wwj61280estag02.jpg)

![image-20210915175703085](https://tva1.sinaimg.cn/large/008i3skNgy1guhgrbzyzlj60x40dsdgr02.jpg)

*内存泄漏*（Memory Leak）是指程序中已动态分配的堆内存由于某种原因程序未释放或无法释放，造成系统内存的浪费，导致程序运行速度减慢甚至系统崩溃等严重后果。

循环引用； 

![image-20210915175950023](/Users/hao/Library/Application Support/typora-user-images/image-20210915175950023.png)

主流虚拟机使用可达性分析算法：

![image-20210917154349275](/Users/hao/Library/Application Support/typora-user-images/image-20210917154349275.png)

![image-20210917155250725](https://tva1.sinaimg.cn/large/008i3skNgy1gujoep7gqhj613i0luabp02.jpg)

从离散数学中的图论引入，程序吧所有的引用关系看作一张图，通过一系列的名为gc roots的对象作为起始点，从这些起始点开始向下搜索，搜索所走过的路径就被称为引用链，既reference-chain，当一个对象从gcroots没有任何引用链相连，从图论而言从gcroots到这个对象是不可达的，标记为垃圾 

gc根对象可达 不可达

![image-20210917155213257](https://tva1.sinaimg.cn/large/008i3skNgy1gujoe2e2zlj60us0hewg002.jpg)

![image-20210917155403397](/Users/hao/Library/Application Support/typora-user-images/image-20210917155403397.png)

使用可达性算法进行标记

会产生大量内存碎片，既不连续的内存空间，当后续对象无法分配足够内存时，不得不再一次触发垃圾收集，不断进行收集，直到有足够连续内存或outofmemory

![image-20210917155958498](https://tva1.sinaimg.cn/large/008i3skNgy1gujom4tayzj60v20iqdgx02.jpg)

![image-20210917160118915](https://tva1.sinaimg.cn/large/008i3skNgy1gujoniumr1j611q07ajs202.jpg)

将可用内存按容量、按一定比例划分为两块或多个块，并选择其中一块或者两块作为对象面，其他的作为空闲面

这个算法适合对象存活率低的算法

![image-20210917160409996](https://tva1.sinaimg.cn/large/008i3skNly1gujoqhkh46j60r40femy702.jpg)

![image-20210917160509614](https://tva1.sinaimg.cn/large/008i3skNgy1gujorl52j4j61780jqdhg02.jpg)

若果对象存活率高，需要进行很多复制操作，效率低

标记整理算法适合老年代

![image-20210917160701715](https://tva1.sinaimg.cn/large/008i3skNgy1gujotgt7r7j614q0fw76d02.jpg)

![image-20210917160911541](/Users/hao/Library/Application Support/typora-user-images/image-20210917160911541.png)

![image-20210917161036469](/Users/hao/Library/Application Support/typora-user-images/image-20210917161036469.png)

jdk7以前，java堆内存一般可分为，年轻代、老年代、永久代

![image-20210917161155293](/Users/hao/Library/Application Support/typora-user-images/image-20210917161155293.png)

jd8及以后，永久代被去掉

![image-20210917161235762](/Users/hao/Library/Application Support/typora-user-images/image-20210917161235762.png)

年轻代：存活率低采用复制算法

老年代：存活率高采用标记清除算法或标记整理算法

年轻代：所有java对象出生的地方，java对象申请的内存在这，大部分对象不需要长久存活；是GC收集垃圾的频繁区域；

大部分对象朝生夕死

Minor GC：发生在年轻代中的垃圾收集动作，采用复制算法；

full GC与老年代相关：对老年代的回收会伴随着年轻代的回收，

![image-20210917161911112](https://tva1.sinaimg.cn/large/008i3skNgy1gujp64bub5j612g0b2mxc02.jpg)

![image-20210917162135998](/Users/hao/Library/Application Support/typora-user-images/image-20210917162135998.png)

对象一般在eden中出生，不够了就放survivor；再不够放老年代

谁是from，shuishito，不固定，可能随垃圾回收的变化而变化

每次使用eden和其中的一块survivor，进行垃圾回收时，将eden和一个survivor中的对象，一次性复制到另一个survivor中，最后清理掉eden和用过的survivor，survivor不够用时就需要用到老年代

s0 from

![image-20210917162606620](https://tva1.sinaimg.cn/large/008i3skNly1gujpdbciy5j614i0k4gmy02.jpg)

复制到survivor后年龄加1

![image-20210917162640392](https://tva1.sinaimg.cn/large/008i3skNly1gujpdx06poj612q0jsmy902.jpg)

![image-20210917162716113](/Users/hao/Library/Application Support/typora-user-images/image-20210917162716113.png)

时

s1从to区变为from区，

s0从from区变为to区

![image-20210917162743264](/Users/hao/Library/Application Support/typora-user-images/image-20210917162743264.png)

完成第二次minor gc

![image-20210917162959858](https://tva1.sinaimg.cn/large/008i3skNly1gujphcwvzij612a0kaabb02.jpg)

![image-20210917163125145](https://tva1.sinaimg.cn/large/008i3skNly1gujpiuew18j612c0k8q4h02.jpg)

 默认当对象年龄达到15岁时，变为老年代，也不是一定的，当较大对象eden和survivor都装不下时，也会放到老年代

可通过这个参数调整岁数

![image-20210917163238198](/Users/hao/Library/Application Support/typora-user-images/image-20210917163238198.png)

![image-20210917163617607](https://tva1.sinaimg.cn/large/008i3skNgy1gujpnzu12pj61440gw0ul02.jpg)

eden放不下时，先进行一次gc；

![image-20210917163937516](/Users/hao/Library/Application Support/typora-user-images/image-20210917163937516.png)

![image-20210917164034416](/Users/hao/Library/Application Support/typora-user-images/image-20210917164034416.png)

老年代的回收伴随着新生代的回收

![image-20210917164156260](https://tva1.sinaimg.cn/large/008i3skNgy1gujptrvb32j60yq0a63yw02.jpg)

老年代对象大部分从survivor过来，所以full gc不会有minor gc那么频繁

元空间代替永久代，降低full gc频率

当对老年代CMS GC时

![image-20210917164715414](https://tva1.sinaimg.cn/large/008i3skNgy1gujpzbenp4j616i0js40i02.jpg)

system.gc 提醒虚拟机full gc，但回不回收还是虚拟机决定

stop-the-word：除了gc线程，其他线程都处于等待中

![image-20210917173613361](/Users/hao/Library/Application Support/typora-user-images/image-20210917173613361.png)

达到安全点再停止线程，尽心GC

![image-20210917173915566](/Users/hao/Library/Application Support/typora-user-images/image-20210917173915566.png)

client 启动较快，server较慢；启动后稳定，server运行速度快，重量级虚拟机

![image-20210917174038728](/Users/hao/Library/Application Support/typora-user-images/image-20210917174038728.png)

java -version可看到当前虚拟机处于那种模式

![image-20210917174256985](https://tva1.sinaimg.cn/large/008i3skNgy1gujrl9kulgj60sw0ieq4202.jpg)

![image-20210917174355010](https://tva1.sinaimg.cn/large/008i3skNgy1gujrm9jcarj61160nctbd02.jpg)

parnew server模式首选

默认线程数，就是cpu核数，也可以通过参数设置

![image-20210917174535150](/Users/hao/Library/Application Support/typora-user-images/image-20210917174535150.png)

tpu运行用户代码时间，与cpu总消耗时间

![image-20210917174704610](/Users/hao/Library/Application Support/typora-user-images/image-20210917174704610.png)

![image-20210917174818077](/Users/hao/Library/Application Support/typora-user-images/image-20210917174818077.png)

更关注吞吐量（cpu敏感），其他更关注系统停顿时间

![image-20210917174938727](/Users/hao/Library/Application Support/typora-user-images/image-20210917174938727.png)

![image-20210917175108701](/Users/hao/Library/Application Support/typora-user-images/image-20210917175108701.png)

cms更小的停顿时间

![image-20210917175533388](/Users/hao/Library/Application Support/typora-user-images/image-20210917175533388.png)

初始标记和重新标记是需要短暂的stop-the-word

初始标记只扫描gc root到与它直接关联的对象

垃圾收集与用户线程同时工作，一遍丢垃圾一边打扫

会有内存碎片化问题，如果需要较大空间，只能触发一次gc了

![image-20210917175925425](/Users/hao/Library/Application Support/typora-user-images/image-20210917175925425.png)

既用于年轻代，又用于老年代的收集器，G1收集器

![image-20210917180128722](/Users/hao/Library/Application Support/typora-user-images/image-20210917180128722.png)

![image-20210917180348448](https://tva1.sinaimg.cn/large/008i3skNgy1gujs6zffn0j61b00l6q5l02.jpg)

![image-20210917180448974](https://tva1.sinaimg.cn/large/008i3skNgy1gujs80jwi4j61900j4q4m02.jpg)

CMS JDK5 退出的第一块垃圾收集线程与用户线程并发运行的垃圾收集器

析构函数与构造函数相反，生命周期结束时被调用，既对象被删除时做的一些操作，如果没定义，编译器会为该类生成一个默认的析构函数，只不过函数体是空的

垃圾回收器宣告一个对象死亡时，至少要经过两次标记过程；对象没有和gc root相连接的引用链，则第一次被标记，并且判断是否执行finalize方法，如果对象覆盖finalize方法，放置F-queue队列中，之后有虚拟机建立的一个低优先级的finalize线程去触发fanlize方法，由于优先级低，不承诺等待其运行结束，既方法执行随时可能会被终止

作用：创造最后一次逃脱死亡的机会

![image-20210917181811973](/Users/hao/Library/Application Support/typora-user-images/image-20210917181811973.png)

![image-20210917182101929](https://tva1.sinaimg.cn/large/008i3skNgy1gujsowlms1j61a20nsaf302.jpg)

![image-20210917182604689](/Users/hao/Library/Application Support/typora-user-images/image-20210917182604689.png) finalize不一定被执行，且开销较大，不建议使用

![image-20210917182806162](https://tva1.sinaimg.cn/large/008i3skNgy1gujsw90e0rj61bg0hqq5j02.jpg)

![image-20210917183019190](/Users/hao/Library/Application Support/typora-user-images/image-20210917183019190.png)

每次gc只要发现弱引用就会回收，但不一定很快发现，gc线程优先级比较低

![image-20210917184421069](/Users/hao/Library/Application Support/typora-user-images/image-20210917184421069.png)

![image-20210917184757192](/Users/hao/Library/Application Support/typora-user-images/image-20210917184757192.png)

gc在回收一个对象时，如果发现该对象具有虚引用，在回收之前，会首先将搞对象的虚引用加入到与之关联的引用队列当中，程序可以判断引用队列是否已经加入虚引用，来了解被引用的对象是否被GC回收，因此起到一个哨兵的作用；

![image-20210917185354707](/Users/hao/Library/Application Support/typora-user-images/image-20210917185354707.png)

![image-20210917185441883](/Users/hao/Library/Application Support/typora-user-images/image-20210917185441883.png)

![image-20210917195238725](https://tva1.sinaimg.cn/large/008i3skNgy1gujvc7urf5j615209owfj02.jpg)

![image-20210917195324807](https://tva1.sinaimg.cn/large/008i3skNgy1gujvd0mw5qj60pm0b20tl02.jpg)

![image-20210917195506427](/Users/hao/Library/Application Support/typora-user-images/image-20210917195506427.png)

![image-20210917200944830](/Users/hao/Library/Application Support/typora-user-images/image-20210917200944830.png)

![image-20210917201040302](/Users/hao/Library/Application Support/typora-user-images/image-20210917201040302.png)

![image-20210917201144314](/Users/hao/Library/Application Support/typora-user-images/image-20210917201144314.png)

referencequeue的意义，在外部对referencequeue进行监控，轮询reference对象get方法是否返回null，判断对象是否被回收

直接通过reference的get是否为null判断对象是否被回收，不适用于虚引用，它的get始终为null

对于一个普通的对象,如果没有其他的引用关系,只要超过了引用的作用域或者显示地将相应(强)引用复制为null,就是可以当做垃圾被收集了,当然具体回收时机还是要看垃圾收集策略。

被强引用的对象永远不会被回收：

一般说强，软，弱，虚引用，都有一个**隐含的条件**就是到gc root是可达的，且其到gc root的引用链之间都是同一种引用。

一个GCRoot不可达的对象，会立刻被垃圾回收吗？

一个GCRoot不可达的对象，不会立刻被垃圾回收，首先还会判断是否包含了finalize方法，如果有那就先执行finalize方法，如果这样的对象比较多，那么这部分对象及时GCRoot不可达，变得没用了，也会留在内存中，影响程序的效率。

Mat工具是一个插件，也可以自己下载一个。下载完成之后打开我们刚刚生成的a.dump即可。

下面这张图就是分析的结果：

![img](https://tva1.sinaimg.cn/large/008i3skNgy1gujwlj2v86j60hy0adaa302.jpg)


a这块的内容就是Finalizer，也就是我们的Fdd对象，b包含的比较多，乱七八糟的剩余信息。当然你也可以查看一些其他的信息。都在MAT工具上。还有一些正在执行的finalizer和准备执行的。