#  Object类

| 方法描述                                 |                                                              | 分类     |
| ---------------------------------------- | ------------------------------------------------------------ | -------- |
| String toString()                        | 返回对象的字符串表示形式。                                   | 常用     |
| boolean <br />equals(Object obj)         | 比较两个对象的值是否相等。                                   |          |
| int hashCode()                           | 返回对象的哈希码值。                                         |          |
| protected Object clone()                 | 创建并返回此对象的副本。                                     | 副本     |
| Class<?> getClass()                      | 返回此对象的运行时的类。                                     | 反射     |
| protected void finalize()                | 当垃圾回收器确定不再有对该对象的引用时，由垃圾回收器在对象上调用。 | 回收     |
| void wait()                              | 使当前线程等待，直到另一个线程为此对象<br />调用notify（）方法或notifyAll（）方法。 | 线程相关 |
| void <br />wait(long timeout)            | 使当前线程等待，直到另一个线程为此对象<br />调用notify（）方法或thenotifyAll（）方法，<br />或者经过指定的时间。 |          |
| void <br />wait(long timeout, int nanos) | 使当前线程等待，直到另一个线程为此对象<br />调用notify（）方法或notifyAll（）方法，<br />或其他线程中断了当前线程，或经过了一定的时间。 |          |
| void notify()                            | 唤醒正在此对象的监听器上等待的单个线程。                     |          |
| void notifyAll()                         | 唤醒正在此对象的监视器上等待的所有线程。                     |          |

**说明：**

- clone

> 在java语言中，有几种方式可以创建对象呢？
>
> 1、使用new操作符创建一个对象
>
> 2、使用clone方法复制一个对象

new操作符的本意是分配内存。程序执行到new操作符时， 首先去看new操作符后面的类型，因为知道了类型，才能知道要分配多大的内存空间。分配完内存之后，再调用构造函数，填充对象的各个域，这一步叫做对象的初始化，构造方法返回后，一个对象创建完毕，可以把他的引用（地址）发布到外部，在外部就可以使用这个引用操纵这个对象。

clone在第一步是和new相似的， 都是分配内存，调用clone方法时，分配的内存和源对象（即调用clone方法的对象）相同，然后再使用原对象中对应的各个域，填充新对象的域， 填充完成之后，clone方法返回，一个新的相同的对象被创建，同样可以把这个新对象的引用发布到外部。

![Untitled Diagram](https://tva1.sinaimg.cn/large/007S8ZIlly1gj7hgzggz4j30sk095dh2.jpg)

- 深拷贝与浅拷贝

> object.clone是浅拷贝的
>
> **浅拷贝：**值类型 — 拷贝数值；引用类型 — 拷贝引用（指向同一引用）
>
> **深拷贝：**值类型 — 拷贝数值；引用类型 — 拷贝内容；对于有多层对象的引用，每个对象都需要实现 `Cloneable` 并重写 `clone()` 方法，进而实现了对象的串行层层拷贝

![img](https://tva1.sinaimg.cn/large/007S8ZIlly1gj8ow6aadmj30j60ciq3s.jpg)

```java
Person p = new Person(23, "zhang");
Person p1 = (Person) p.clone();

String result = p.getName() == p1.getName() ? "clone是浅拷贝的" : "clone是深拷贝的";

System.out.println(result);
```

```java
String[] aa = {"123"};
String[] bb = {"123"};
String[] cc = bb;
String[] dd = bb.clone();
System.out.println(aa);
System.out.println(bb);
System.out.println(cc);
System.out.println(dd);

/* 输出：
[Ljava.lang.String;@3b9a45b3
[Ljava.lang.String;@7699a589
[Ljava.lang.String;@7699a589
[Ljava.lang.String;@58372a00

[：表示一维数组 
[[：表示二维数组 
L：表示一个对象 
java.lang.String：表示对象的类型 
@：后面表示该对象的hashCode
*/
```

- finalize

> 当对象bai不再被任何对象引用时，GC会调用该对象的finalize()方法
>
> 子类可以覆盖这个方法来做一些系统资源的释放或者数据的清理
>
> 可以在finalize()让这个对象再次被引用,避免被GC回收;但最常用的目的还是做cleanup

应尽量避免使用finalize()：

```java
1、不一定会被调用, 因为java的垃圾回收器的特性就决定了它不一定会被调用。

2、就算被调用, 它被调用的时间充满了不确定性, 因为程序中其他线程的优先级远远高于执行finalize（）函数线程的优先级。也许等到finalize()被调用, 数据库的连接池或者文件句柄早就耗尽了。

3、如果一种未被捕获的异常在使用finalize方法时被抛出，这个异常不会被捕获，finalize方法的终结过程也会终止，造成对象出于破坏的状态。被破坏的对象又很可能导致部分资源无法被回收, 造成浪费。

4、finalize()函数和垃圾回收器的运行本身要耗费资源, 也许会导致程序的暂时停止。
```

- wait

线程通常都有五种状态，`创建、就绪、运行、阻塞和死亡`。

`wait(long timeout, int nanos)`

参数：

timeout - 要等待的最长时间（以毫秒为单位）。

nanos - 额外时间（以纳秒为单位，范围是 0-999999）

此方法类似于一个参数的 wait 方法，但它允许更好地控制在放弃之前等待通知的时间量。用毫微秒度量的实际时间量可以通过以下公式计算：

```java
1000000*timeout+nanos// 一秒等于(1000)毫秒,(1000000)微秒,(1000 000 000)纳秒
```

# Objects类

> Objects类是final修饰的类，不可继承，方法都是static方法，是Object的工具类
>
> 多个判空方法

| **返回值**     | **方法名**                  | **作用**                                                     |
| -------------- | --------------------------- | ------------------------------------------------------------ |
| static int     | compare(T, T, Comparator)   | 如果参数a,b相同则返回0，否则返回c.compare(a, b)的结果        |
| static boolean | deepEquals (Object, Object) | 对比a,b参数是否深层次相等，假定a,b为数组，对比数组的每个参数 |
| static boolean | equals (Object, Object)     | 对比a,b参数是否相等，不会报空指针异常                        |
| static int     | hash (Object...)            | 为输入值序列生成哈希码                                       |
| static int     | hashCode (Object)           | 返回哈希码。如果obj为null则返回0                             |
| static boolean | isNull (Object)             | 如果obj参数为null返回true                                    |
| static boolean | nonNull (Object)            | 如果obj参数不为null返回true                                  |
| static T       | requireNonNull(T)           | 检查指定的对象引用不是 null，为null报空指针错误              |
| static T       | requireNonNull(T, string)   | 检查指定的对象引用不是null，并抛出自定义的NullPointerException（如果是） |
| static T       | requireNonNull(T, Supplier) | 检查指定的对象引用不是null，并抛出一个自定义的NullPointerException（如果是） |
| static String  | tostring(Object)            | 返回对象的字符串表示形式                                     |
| static String  | toString(Object, String)    | 如果第一个参数不是 null ，则返回第一个参数调用 toString的结果，否则直接将第二个参数返回 |

- 示例：

```java
//compare
Integer a = 123;
Integer b = 123;
Objects.compare(a, b, (o1,o2) -> {
  return o1.compareTo(o2);
});//等价，返回0
Objects.compare(a, b, (o1,o2) -> o1.compareTo(o2));//等价
Objects.compare(a, b, Integer::compareTo);//等价

//equals判断对象是否相同，deepEquals判断数组内容是否相同
int[] aa = {1,2};
int[] bb = {1,2};
System.out.println(Objects.equals(aa,bb));//false
System.out.println(Objects.deepEquals(aa,bb));//true

Objects.hash(1,2,3,4,5,null);//918073246

//Exception in thread "main" java.lang.NullPointerException: shi null
Integer a = Objects.requireNonNull(null,"shi null");
//一般使用在获取一个对象，对获取到的对象做非空判断
UserBean user = Objects.requireNonNull
  (dao.getUserById(id),"用户信息获取异常，无法进行积分操作");
//等效于
UserBean user = dao.getUserById(id)
if(Objects.isNull(user)){
    throw new NullPointerException("用户信息获取异常，无法进行积分操作");
}
//等效于
Integer a = Objects.requireNonNull(null,()->"123");
```

