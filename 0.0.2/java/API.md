# IO流

- 流家族

![img](https://tva1.sinaimg.cn/large/008eGmZEly1gmvasuwj0oj30iq0ktdhd.jpg)

- 常用流

![img](https://tva1.sinaimg.cn/large/008eGmZEly1gmvcdpvhwzj30po0bdq3l.jpg)

## 字节流

```java
/* 输入输出流 */
public static void ioTest1() throws IOException {
  File file = new File("src/com/a.txt");
  InputStream is = new FileInputStream(file);
  // OutputStream outputStream1 = new FileOutputStream(file1);//覆盖模式输出
  OutputStream os = new FileOutputStream(file, true);// 追加模式输出
  int i = 0;
  // 速度慢
  while ((i = is.read()) != -1) {
    System.out.println((char)i);
    System.out.println(Integer.toBinaryString(i));
    // System.out.println(Integer.toOctalString(i));
    // System.out.println(Integer.toHexString(i));
  }
  os.write("123,".getBytes());
  is.close();
  os.close();
}

/* try-whith-resource 语法*/
public static void ioTest2() throws IOException {
  File file = new File("src/com/a.txt");
  try (InputStream is = new FileInputStream(file);
       // 输出的目的地文件不存在，则会自动创建
       OutputStream os = new FileOutputStream("src/com/b.txt", true);) {
    // 输出回车换行,要写\r\n不能只写\n,因为不同文本编辑器或操作系统对换行符的识别存在差异性
    os.write("\r\n".getBytes());
    // 输出追加内容
    os.write("hello".getBytes());
    byte[] b = new byte[2];
    int i = 0;
    // 速度中
    while ((i = is.read(b)) != -1) {
      /*
         * public String(byte[] bytes, int offset, int length)
         * bytes：要解码为字符的byte
         * offset：要解码的第一个 byte 的索引
         * length： 要解码的 byte 数 的长度
         */
      System.out.println(new String(b, 0, i));
      // System.out.println(i);//文本内容123，输出2、1
    }
  }
}

/* 缓冲流 */
public static void ioTest3() throws IOException {
  File file = new File("src/com/a.txt");
  try (InputStream is = new FileInputStream(file);
       OutputStream os = new FileOutputStream(file, true);
       // 缓冲输入流（高效流）
       BufferedInputStream bis = new BufferedInputStream(is);
       // 缓冲输出流（高效流）
       BufferedOutputStream bos = new BufferedOutputStream(os);) {
    bos.write("hello".getBytes());
    byte[] b = new byte[20];
    int i = 0;
    // 速度快
    while ((i = bis.read(b)) != -1) {
      System.out.println(new String(b, 0, i));
    }
  }
}
```

## 字符流

```java
public static void ioTest4() throws IOException {
  File file = new File("src/com/a.txt");
  // try-whith-resource 语法
  try (Reader reader = new FileReader(file);
       Writer writer = new FileWriter(file, true);
       // 缓冲输入流（高效流）
       BufferedReader br = new BufferedReader(reader);
       // 缓冲输出流（高效流）
       BufferedWriter bw = new BufferedWriter(writer);) {
    bw.write("hello");;
    // int i;
    // while ((i = bufferedReader.read()) != -1) {
    // System.out.println((char)i);
    // }
    String str;
    // 按行读取
    while ((str = br.readLine()) != null) {
      System.out.println(str);
    }
  }
}
```

## 转换流

一般操作输入输出内容就需要字节流或字符流，但是有些时候需要将字符流变为字节流的形式，或者将字节流变为字符流的形式.

字符流与字节流比较：如果一个一个字节的往文件里输入，一个文件读写次数太大了，很毁硬盘，但如果一个一个字符的保存，硬盘读写次数就会少很多，甚至可以一行一行的保存。

```java
public static void ioTest5() throws IOException {
  File file = new File("src/com/a.txt");
  // try-whith-resource 语法
  try (InputStream is = new FileInputStream(file);
       OutputStream os = new FileOutputStream(file, true);
       InputStreamReader isr = new InputStreamReader(is, "GBK");
       OutputStreamWriter osw = new OutputStreamWriter(os, "utf-8");
       BufferedReader br = new BufferedReader(isr);
       BufferedWriter bw = new BufferedWriter(osw);) {
    bw.write("hello");
    String str;
    while ((str = br.readLine()) != null) {
      System.out.println(str);
    }
  }
}
```

## 缓冲流

> In/OutputStream（单独操作）：每次从硬盘读入一个字节到中转站， 再写入目的文件（硬盘）
>
> BufferedIn/OutputStream（批量操作）：一次读入n个字节到输入缓冲区，接着经中转站一个个写入到输出缓冲区，输入缓冲区为空时再次从硬盘读入批量数据，同理输出缓冲区满了以后再批量写入到目的文件（硬盘）。
>
> 缓冲流内置缓冲数组`byte buf[8192]，既8kb`,也可指定大小。

![image-20210121152321598](https://tva1.sinaimg.cn/large/008eGmZEly1gmvcgcsk12j30ot07ddik.jpg)

## 对象序列化

> 注意：
>
> 1. 对象要 `implements Serializable `
> 2. 对象输出流要写在对象输入流前面，否则可能异常

```java
public static void ioTest6() throws Exception {
  Goods good = new Goods("Mac", 1000);
  File file = new File("src/com/a.txt");
  try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(file));
       ObjectInputStream ois = new ObjectInputStream(new FileInputStream(file));) {
    oos.writeObject(good);
    Goods goods1 = (Goods) ois.readObject();
    // oos.writeBoolean(true);// 写入一个boolean类型变量true
    // Boolean boolean1 = ois.readBoolean();
    System.out.println(goods1);
  }
}
```

## Scanner

> 特点：
>
> 1. 获取用户的输入
> 2. 可以按行读取、按分割符去读取文件数据
> 3. 既可以读取String类型，也可以读取Int类型、Long类型等基础数据类型的数据

```java
public static void ioTest7() throws IOException {
  String fileName = "src/com/a.txt";

  // 从键盘接收数据
  try (Scanner sc = new Scanner(System.in);) {
    if (sc.hasNext()) {
      // if (sc.hasNextLine()) { // 两个没区别
      String str = sc.next();
      System.out.println(str);
    }
  }

  // try (Scanner sc = new Scanner(new FileInputStream(fileName))) { // 字节流
  try (Scanner sc = new Scanner(new FileReader(fileName))) { // 字符流
    // 按行读取字符串
    while (sc.hasNextLine()) {
      String line = sc.nextLine();
      System.out.println(line);
    }
  }

  try (Scanner sc = new Scanner(new FileReader(fileName))) {
    sc.useDelimiter(","); // 分隔符
    // 按分隔符读取字符串
    while (sc.hasNext()) {
      String str = sc.next();
      System.out.println(str);
    }
  }

  // sc.hasNextInt() 、hasNextFloat() 、等基础数据类型
  try (Scanner sc = new Scanner(new FileReader(fileName))) {
    sc.useDelimiter(","); // 分隔符
    // 按分隔符读取Int
    while (sc.hasNextInt()) {
      int intValue = sc.nextInt();
      System.out.println(intValue);
      // 文本：h,1,2,3,hhh； 输出：为空
      // 文本：,1,2,3,hhh； 输出：1\r\n2\r\n3
    }
  }
}
```

## Stream

> 特点：
>
> 1. 字符流
> 2. 按行读取，按流处理

```java
Path filePath = Paths.get("c:/temp", "data.txt");

// try-with-resources语法,不用手动的编码关闭流
// Files.lines()从path对应的文件中读取所有内容，并按行分割，返回一个 Stream<String>。
try (Stream<String> lines = Files.lines( filePath )) 
{
  List<String> filteredLines = lines
    .filter(s -> s.contains("password"))
    .collect(Collectors.toList());

  filteredLines.forEach(System.out::println);
} catch (IOException e) {
  e.printStackTrace();//只是测试用例，生产环境下不要这样做异常处理
}
```



# 文件

## File

| 构造方法                          |
| --------------------------------- |
| File(File parent, String child)   |
| File(String pathname)             |
| File(String parent, String child) |
| File(URI uri)                     |

```java
File file1=new File("src/com/a.txt");
File file1=new File("src/com","a.txt");
File file=new File("src/com");
File file1=new File(file,"a.txt");
File file = new File("src");
File file2 = new File(file.toURI());
System.out.println(file2.toURI());// file:/Users/hao/Desktop/测试/untitled/src/
```

## Path

> Path接口，以Paths类和Files工具类为核心，替代File类，**用于来表示文件路径和文件**。

- 获取Path对象

```java
1）Paths：
Path path = Paths.get("C:/", "Xmp");
Path path2 = Paths.get("C:/Xmp");

URI u = URI.create("file:///C:/Xmp/dd");        
Path p = Paths.get(u);

2）FileSystems构造：
Path path3 = FileSystems.getDefault().getPath("C:/", "access.log");

3）File和Path之间的转换：
File file = new File("C:/my.ini");
Path p1 = file.toPath();
p1.toFile();
file.toURI();
```

## Paths

> 此类仅由静态方法组成，通过转换路径字符串返回`Path`或`URI`。

| 类型和参数    | 方法和描述                                                   |
| :------------ | :----------------------------------------------------------- |
| `static Path` | `get(String first, String... more)`<br />将路径字符串或连接到路径字符串的字符串序列转换为 `Path` 。 |
| `static Path` | `get(URI uri)`<br />将给定的URI转换为`Path`对象。            |

## Files

> 该类只包含对文件，目录或其他类型文件进行操作的静态方法。
>
> 在大多数情况下，这里定义的方法将委托给相关的文件系统提供程序来执行文件操作。
>
> 对文件进行增、删、改、查等操作。

# 多线程

## 实现方式

### 1. 继承Thread类

```java
public class ThreadTest1 extends Thread {
  public ThreadTest1(String name) {
    // 设置当前线程的名字
    this.setName(name);
  }

  @Override
  public void run() {
    while (true) {
      System.out.println(ThreadTest1.currentThread().getName());
      try {
        ThreadTest1.sleep(1000);
      } catch (Exception e) {
        throw new RuntimeException(e);
      }
    }
  }

  public static void main(String[] args) throws Exception {
    // 注意：调用start方法才能启动线程，不能调用run方法
    new ThreadTest1("MyThread-01").start();
    // 创建多个线程实例，同时执行
    new ThreadTest1("MyThread-02").start();
    // 主线程继续向下执行
    while (true) {
      System.out.println(ThreadTest1.currentThread().getName());
      ThreadTest1.sleep(1000);
    }
  }
}
```

### 2. 实现Runnable接口

- 接口重写方法

```java
public class ThreadTest2 implements Runnable {

  @Override
  public void run() {
    System.out.println(Thread.currentThread().getName());
  }

  public static void main(String[] args) throws Exception {
    new Thread(new ThreadTest2()).start();
    new Thread(new ThreadTest2()).start();
    System.out.println(Thread.currentThread().getName());
  }
}
```

- lambda或匿名类

```java
public class ThreadTest3 {
  public static void main(String[] args) throws Exception {
    // lambda
    new Thread(() -> {
      System.out.println(Thread.currentThread().getName());
    }).start();
    // 匿名类
    new Thread(new Runnable() {
      @Override
      public void run() {
        System.out.println(Thread.currentThread().getName());
      }
    }).start();
    System.out.println(Thread.currentThread().getName());
  }
}
```

### 3. 实现Callable接口

- 有返回值
- 可抛异常
- 创建FutureTask指定Callable对象，做为线程任务

```java
public class ThreadTest5 {
  public static void main(String[] args) throws Exception {
    Callable<Integer> call = () -> {
      System.out.println(Thread.currentThread().getName());
      return 1;
    };
    FutureTask<Integer> task1 = new FutureTask<>(call);
    FutureTask<Integer> task2 = new FutureTask<>(() -> {
      System.out.println(Thread.currentThread().getName());
      int a = 1;
      if(a==1){
        throw new Exception("Bad flag value!");
      }else{
        return 2;
      }
    });
    new Thread(task1).start();
    new Thread(task2).start();
    // 这里是在线程启动之后，线程结果返回之前
    System.out.println("子线程结果返回之前");
    // 拿到线程的执行结果
    Integer result1 = task1.get();
    Integer result2 = 0;
    try {
      result2 = task2.get();
    } catch (Exception e) {
      e.printStackTrace();
    }
    System.out.println(result1 + "------" + result2);
  }
}
```

### 4. 创建定时器Timer

定时器可以说是一种基于线程的一个工具类。

```java
public class ThreadTest4 {
  private static final SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
  public static void main(String[] args) throws Exception {
    // 创建定时器，两个定时器创建两个线程
    Timer timer1 = new Timer();
    Timer timer2 = new Timer();
    
    // 定时执行
    timer1.schedule(new TimerTask() {
      @Override
      public void run() {
        System.out.println(Thread.currentThread().getName() + "任务在指定时间执行");
      }
    }, format.parse("2021-01-21 19:39:00"));
    
    // 间隔时间执行
    timer2.schedule(new TimerTask() {
      @Override
      public void run() {
        System.out.println(Thread.currentThread().getName() + "任务间隔时间重复执行");
      }
    }, new Date(), 1000);
    System.out.println(Thread.currentThread().getName());
  }
}
```

### 5. 线程池

线程和数据库连接这些资源都是非常宝贵的。每次需要的时候创建，不需要的时候销毁，这是非常浪费资源的。那么我们就可以使用缓存的策略，也就是使用线程池。

> Java通过Executors提供四种线程池：
>
> - ```java
>   // ExecutorService extends Executor
>   ExecutorService threadPool = Executors.newFixedThreadPool(10);
>   threadPool.execute(**)/threadPool.submit(**)
>   
>   // Executor
>   void execute(Runnable command);
>   
>   // ExecutorService
>   Future<T> submit(Callable<T> task);
>   Future<?> submit(Runnable task);
>   Future<T> submit(Runnable task, T result);
>   
>   List<Future<T>> invokeAll(Collection<? extends Callable<T>> tasks);
>   T invokeAny(Collection<? extends Callable<T>> tasks);
>   
>   void shutdown();
>   List<Runnable> shutdownNow();
>   boolean isShutdown();
>   boolean isTerminated();
>   boolean awaitTermination(long timeout, TimeUnit unit)
>   ```
>
> 1. newFixedThreadPool 
>
>    - 创建可容纳固定数量线程的池子，每个线程的存活时间是无限的，当池子满了就不再添加线程
>    - 适用：执行长期任务
>
>    ```java
>    public class ThreadTest6 {
>      public static void main(String[] args) throws Exception {
>        ExecutorService threadPool = Executors.newFixedThreadPool(10);
>        while (true) {
>          threadPool.execute(() -> {
>            System.out.println(Thread.currentThread().getName());
>          });}}
>    }
>    ```
>
> 2. newSingleThreadExecutor 
>
>    - 创建只有一个线程的线程池，当该线程正繁忙时，对于新任务会进入阻塞队列中
>    - 适用：按顺序执行任务的场景
>
>    ```java
>    ExecutorService pool = Executors.newSingleThreadExecutor();
>    pool.execute(() -> out.println(Thread.currentThread().getName()));
>    ```
>
> 3. newScheduledThreadPool 
>
>    - 创建一个固定大小的线程池，线程池内线程存活时间无限制，线程池可以支持定时及周期性任务执行
>    - 适用：执行周期性任务
>
>    ```java
>    ScheduledExecutorService scheduledThreadPool = Executors.newScheduledThreadPool(5);
>    Runnable r1 = () -> out.println(Thread.currentThread().getName());
>    // 3秒后执行
>    scheduledThreadPool.schedule(r1, 3, TimeUnit.SECONDS);
>    Runnable r2 = () -> out.println(Thread.currentThread().getName());
>    // 延迟2秒后每3秒执行一次
>    scheduledThreadPool.scheduleAtFixedRate(r2, 2, 3, TimeUnit.SECONDS);
>    Runnable r3 = () -> out.println(Thread.currentThread().getName());
>    // 普通任务
>    scheduledThreadPool.execute(r3);
>    ```
>
> 4. newCachedThreadPool 
>
>    - 创建一个可缓存的线程池。如果线程池的大小超过了处理任务所需要的线程，那么就会回收部分空闲（60秒不执行任务）的线程
>    - 适用：执行很多短期的异步任务
>
>    ```java
>    ExecutorService cachedThreadPool = Executors.newCachedThreadPool();
>    for (int i = 1; i <= 10; i++) {
>      try {
>        Thread.sleep(1000);
>      } catch (InterruptedException e) {
>        e.printStackTrace();
>      }
>      cachedThreadPool.execute(() -> System.out.println(Thread.currentThread().getName()));
>    }
>    // 有sleep只有一个线程，没sleep有多个线程
>    ```

### 6. parallelStream

```java
public class ThreadTest7 {
  public static void main(String[] args) throws Exception {
    Integer[] a = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
    // parallelStream默认使用了fork-join框架，其默认线程数是CPU核心数
    // 修改默认orkJoinPool线程数（全局修改）
    System.setProperty("java.util.concurrent.ForkJoinPool.common.parallelism", "3");
    Arrays.stream(a).parallel().forEach(s -> {
      System.out.println(Thread.currentThread().getName() + "---" + s);
    });
    // 修改默认orkJoinPool线程数（自定义线程池）
    ForkJoinPool myPool = new ForkJoinPool(2);
    myPool.submit(() -> Arrays.stream(a).parallel().forEach(s -> {
      System.out.println(Thread.currentThread().getName() + "---" + s);
    })).get();
  }
}
```

### 7. Spring @Async

> 注意：
>
> 1. 不要在私有方法之上使用@Async
> 2. 不要在调用Async方法的同一个类中编写Async方法

```java
// 必须由@Component等Scan注释扫描，或在标记为@Configuration的类中创建
@Component
public class AsyncMailTrigger {

  @Async
  public void senMail() {
    System.out.println("在新线程中发送邮件 :: "  + Thread.currentThread().getName());
  }
}
```

```java
public class AsyncCaller {

  @Autowired
  AsyncMailTrigger asyncMailTriggerObject;

  public void rightWayToCall() {
    System.out.println("从RightWayToCall线程调用 " + Thread.currentThread().getName());
    asyncMailTriggerObject.senMail(populateMap()); // 子线程异步执行
  }

  public void wrongWayToCall() {
    System.out.println("从错误的waytocall线程调用 " + Thread.currentThread().getName());
    AsyncMailTrigger asyncMailTriggerObject = new AsyncMailTrigger();
    asyncMailTriggerObject.senMail(populateMap()); // 主线程同步执行
  }
}
```

```java
@SpringBootApplication
@EnableAsync
public class DemoApplication {

  @Autowired
  AsyncCaller caller;

  public static void main(String[] args) {
    SpringApplication.run(DemoApplication.class, args);

  }

  @Bean
  public CommandLineRunner commandLineRunner(ApplicationContext ctx) {
    return args -> {
      caller.rightWayToCall();
      Thread.sleep(1000);
      System.out.println("-----");
      Thread.sleep(1000);
      caller.wrongWayToCall();
    };
  }
```

### 补充：Future

Future接口提供了异步执行结果获取，检查等方法。

```java
ExecutorService pool = Executors.newSingleThreadExecutor();
Future<Integer> future = pool.submit(() -> {
  System.out.println(Thread.currentThread().getName()); // pool-1-thread-1
  return 1;
});
System.out.println(future.get()); // 1
System.out.println(future.get(10,TimeUnit.SECONDS)); // 1 最多等待10秒返回结果
System.out.println(future.isDone()); // true
System.out.println(future.isCancelled()); // false
System.out.println(future.cancel(true)); // false
```

### 补充：@Bean

@Bean是一个方法级别上的注解，主要用在@Configuration、@Component、@SpringBootApplication注解的类里。添加的bean的id为方法名。

@Bean注解告诉Spring这个方法将会返回一个对象，这个对象要注册为Spring应用上下文中的bean。

以下两种配置等同：

```java
@Configuration
public class AppConfig {
  @Bean
  public TransferService transferService() {
    return new TransferServiceImpl();
  }
}
```

```xml
<beans>
    <bean id="transferService" class="com.acme.TransferServiceImpl"/>
</beans>
```

## 线程安全

### --- 原子性 ---

### 1. synchronized

synchronized关键字，是一种同步锁，**保证数据一致性**。它修饰的对象有以下4种： 

> 注意：
>
> - 当一个线程访问一个synchronized同步代码时，另一个线程仍然可以访问其他非synchronize代码
> - 修饰的代码块只能放在方法里

  　　1. 修饰一个代码块，其作用的范围是大括号{}括起来的代码，作用的对象是调用这个代码块的**<u>对象</u>**； 
       - 对象锁，当前对象锁定，一个线程执行，其他线程受阻；一个对象一把对象锁；

```java
public  void run() {
  synchronized (this){...}
}
```

2. 修饰一个方法，其作用的范围是整个方法，作用的对象是调用这个方法的**<u>对象</u>**； 

   - 对象锁，当前对象锁定，一个线程执行，其他线程受阻；一个对象一把对象锁；

   - 这里示例与上述修饰代码块，效果相同；既synchronized作用于方法有两种写法

```java
public synchronized void method(){...}
```

3. 修改一个静态的方法，其作用的范围是整个静态方法，作用的对象是这个**<u>类的所有对象（类锁）</u>**； 
   - 所有对象使用同一把类锁，多个线程保持线程同步

```java
public synchronized static void method() {...}
```

4. 修改一个类，其作用的范围是括号括起来的部分，作用的对象是这个**<u>类的所有对象（类锁）</u>**；
   - 所有对象使用同一把类锁，多个线程保持线程同步

```java
public void method() {
  synchronized(ClassA.class) {...}
}
```

### 2. 锁接口

> Lock和ReadWriteLock是两大锁的根接口，扩展了synchronized的功能：
>
> 1. Lock唯一实现类是ReentrantLock（可重入锁），实现一些锁的高级功能如：公平锁、中断锁、超时锁、共享锁等。
>    - ReentrantLock构造方法（不带参数 和带参数 true： 公平锁； false: 非公平锁）
>    - 在资源竞争不是很激烈的情况下，Synchronized的性能要优于ReetrantLock，但是在资源竞争很激烈的情况下，ReetrantLock的性能能维持常态。
>
> 2. ReadWriteLock（读写锁）的唯一实现类是ReentrantReadWriteLock，实现一些读取者可以共享写入者独占的锁的功能。

**注意：**

- 采用synchronized不需要手动释放锁，代码执行完后，系统会自动让线程释放锁；而Lock则必须要手动释放锁，如果没有主动释放锁，就有可能出现死锁现象。

#### 比较synchronized

占有锁的线程释放锁有三种情况：

1. 占有锁的线程执行完了该代码块，然后释放对锁的占有；
2. 占有锁线程执行发生异常，此时JVM会让线程自动释放锁；
3. 占有锁线程进入阻塞状态从而释放锁，例如在该线程中调用wait()方法等。

用Lock优化的三种情况：

1. 使用synchronized，占有锁的线程由于要等待IO或者其他原因（比如调用sleep方法）被阻塞了，但是又没有释放锁，那么其他线程就只能一直等待，这极大影响程序执行效率。
   - <u>tryLock(long time, TimeUnit unit)：只等待一定的时间</u>
   - <u>lockInterruptibly()：手动响应中断</u>
2. 使用synchronized，只有一个线程可以进行读操作。多线程下，读写操作、写写操作会冲突，但读读操作不会冲突。
   - <u>ReentrantReadWriteLock</u>
3. 使用synchronized，无法得知线程有没有成功获取到锁。
   - <u>ReentrantLock</u>

#### Lock接口

1. `void lock(); // 获取锁；`

```java
Lock lock = ...;
lock.lock();
try{
  //处理任务
}catch(Exception ex){
}finally{
  lock.unlock();   //释放锁
}
```

2. `boolean tryLock();// 获取锁；如果当前线程发现所被其他线程持有，返回false，而不是一直阻塞`

   `boolean tryLock(long time, TimeUnit unit);// 获取锁；给定等待时间内获取成功，返回true`

```java
Lock lock = ...;
if(lock.tryLock()) {
  try{
    //处理任务
  }catch(Exception ex){
  }finally{
    lock.unlock();   //释放锁
  } 
}else {
  //如果不能获取锁，则直接做其他事情
}
```

3. `void lockInterruptibly(); `

   `// 获取锁；线程.interrupt()可中断阻塞过程中的线程,这个方法可以手动中断阻塞线程，并触发异常 `

```java
Thread a = new Thread(() -> {
  Lock lock = new ReentrantLock();
  try {
    lock.lock();
    test++;
    for (;;) {
      System.out.println(Thread.currentThread().getName() + "test值：" + test);
      Thread.sleep(1000);
    }
  } catch (InterruptedException e) {
    System.out.println("异常");
  } finally {
    lock.unlock();
  }
});
Thread b = new Thread(() -> {
  Lock lock = new ReentrantLock();
  try {
    lock.lockInterruptibly();
    test++;
    for (int i = 0; i < 6; i++) {
      System.out.println(Thread.currentThread().getName() + "test值：" + test);
      Thread.sleep(1000);
    }
  } catch (InterruptedException e) {
    System.out.println("中断");
  } finally {
    lock.unlock();
  }
});

a.start();
Thread.sleep(1000);
b.start();
b.interrupt()
```

4. Condition newCondition();// 返回绑定到此 Lock 实例的新 Condition 实例
5. void unlock();// 释放锁 

#### ReadWriteLock接口

1. `Lock readLock() //返回用于读取操作的锁   `
2.  `Lock writeLock() //返回用于写入操作的锁  `

```java
lock.readLock().lock();
lock.readLock().unlock();

lock.writeLock().lock();
lock.writeLock().unlock();
```

### 3. Atomic

> Atomic通过CAS机制保证变量的原子性
>
> CAS并不是无阻塞，只是阻塞并非在语言、线程方面，而是在硬件层面，这样的操作更快更高效！

Atomic分类：

- 标量类：AtomicBoolean，AtomicInteger，AtomicLong，AtomicReference
- 数组类：AtomicIntegerArray，AtomicLongArray，AtomicReferenceArray
- 更新器类：AtomicLongFieldUpdater，AtomicIntegerFieldUpdater，AtomicReferenceFieldUpdater
- 复合变量类：AtomicMarkableReference，AtomicStampedReference
  - AtomicStampedReference可以知道，引用变量中途被更改了几次
  - AtomicMarkableReference可以知道，引用变量是否更改过

主要方法：

1. get() – 直接从主内存中读取变量的值，类似于volatile变量。
2. set() – 将变量写回主内存。类似于volatile变量。
3. lazySet() – 延迟写回主内存。一种常用的情景是将引用重置为null的情况。
   - <u>lazySet()优化：在不需要让共享变量的修改立刻让其他线程可见时，以设置普通变量的方式来修改共享状态，可以减少不必要的内存屏障，从而提高程序执行的效率。</u>
4. compareAndSet() – 执行CAS操作，成功返回true，失败返回false。
5. weakCompareAndSet() – 比较弱的CAS操作，不同的是它不执行happens-before操作，从而不保证能够读取到其他变量最新的值。

```java
public class AtomicTest {
  private static AtomicLongFieldUpdater<AtomicTest> updater = AtomicLongFieldUpdater.newUpdater(AtomicTest.class,"count");
  // 原子变量，使用volatile修饰，不能使用static修饰
  private volatile long count = 100;

  public static void main(String[] args) {

    AtomicInteger atomicInteger = new AtomicInteger(0);
    AtomicReference<String> atomicReference = new AtomicReference<>("test1");

    AtomicIntegerArray atomicIntegerArray1 = new AtomicIntegerArray(9);
    AtomicIntegerArray atomicIntegerArray2 = new AtomicIntegerArray(new int[]{1, 2, 3 });

    AtomicTest atomicTest = new AtomicTest();
    updater.compareAndSet(atomicTest, 100, 200);

    AtomicMarkableReference<Integer> at1 = new AtomicMarkableReference<Integer>(null, false);
    AtomicStampedReference<Integer> at2 = new AtomicStampedReference<Integer>(null, 0);

    atomicReference.set("test2");
    atomicReference.lazySet(null);
    Boolean bool1 = atomicReference.compareAndSet(null, "test3");
    Boolean bool2 = atomicReference.weakCompareAndSet("test3", "test4");
    at1.set(123, true);
    at2.set(123, 1);

    System.out.println(atomicInteger.get());
    System.out.println(atomicReference.get());
    System.out.println(atomicIntegerArray1.get(1));
    System.out.println(atomicIntegerArray2.get(2));
    System.out.println(updater.get(atomicTest));// 200
    System.out.println(at1.isMarked());
    System.out.println(at2.getStamp());
  }
}
```

### --可见性&有序性--

### 4. volatile

####  特点

> volatile 关键字三个特性：
>
> - 保证可见性
> - **不保证原子性**
> - 保证有序性（禁止指令重排）

- 可见性&原子性

```java
// 不能保证原子性
public volatile int inc = 0;
public void increase() {
  inc++;
}
```

```java
// 1. 保证原子性
public  int inc = 0;
public synchronized void increase() {
  inc++;
}

// 2. 保证原子性
public  int inc = 0;
Lock lock = new ReentrantLock();
public  void increase() {
  lock.lock();
  try {
    inc++;
  } finally{
    lock.unlock();
  }
}

// 3. 保证原子性
public  AtomicInteger inc = new AtomicInteger();
public  void increase() {
  inc.getAndIncrement();
}
```

- 有序性

```java
//x、y为非volatile变量
//flag为volatile变量
 
x = 2;        //语句1
y = 0;        //语句2
flag = true;  //语句3
x = 4;        //语句4
y = -1;       //语句5

// 由于flag变量为volatile变量，那么在进行指令重排序的过程的时候，不会将语句3放到语句1、语句2前面，也不会讲语句3放到语句4、语句5后面。但是要注意语句1和语句2的顺序、语句4和语句5的顺序是不作任何保证的。
```

#### 场景

- 使用场景【单例模式(DCL-Double Check Lock双重检查锁)】

```java
/* 
singleTon = new DCLSingleTon(); 可以分为以下3步完成:
1.分配对象内存空间
2.初始化对象
3.设置实例指向刚分配的内存地址,此时singleTon !=null;

步骤2和3都依赖于步骤1,所以步骤1肯定不会重排,但是,步骤2和步骤3不存在数据依赖关系,而且无论重排前还是重排后,在单线程中不会影响结果,所以这种重排优化是允许的,既：
1.分配对象内存空间
2.设置实例指向刚分配的内存地址,此时singleTon !=null;但是对象没有完成初始化
3.初始化对象

所以当一条线程访问实例不为null时,由于实例未必已经完成初始化,也就造成了线程安全问题;
*/
public class DCLSingleTon {
  private static DCLSingleTon singleTon;

  private DCLSingleTon() {
    System.out.println(Thread.currentThread().getName() + " 构造方法执行了");
  }

  public static DCLSingleTon getInstance() {
    // 加锁前后都做一次判断
    if (singleTon == null) {
      synchronized (DCLSingleTon.class) {
        if (singleTon == null) {
          singleTon = new DCLSingleTon();
        }}
    }
    return singleTon;
  }

  public static void main(String[] args) {
    // 多线程环境下,执行多次,构造方法只执行一次;说明只有一个对象
    for (int i = 1; i < 100; i++) {
      new Thread(new Runnable() {
        @Override
        public void run() {
          DCLSingleTon.getInstance();
        }
      }).start();
    }}
}
```

# Stream

## Reduce

reduce方法有三个重载方法：

```java
// 两个相同类型的入参，一个同类型出参
Optional<T> reduce(BinaryOperator<T> accumulator);

// 定义操作初始值；两个相同类型的入参，一个同类型出参
T reduce(T identity, BinaryOperator<T> accumulator); 

// 1. 初始值；2. 累加器； 3.合并器
// 1. 定义操作初始值；2. 两个入参，一个出参；3. 两个相同类型的入参，一个同类型出参
// 第二个参数可应用于，获得不同类型的返回值
// 第三个参数可随便指定（如：(a, b) -> null），并行操作时才会用到合并器
<U> U reduce(U identity,BiFunction<U, ? super T, U> accumulator,BinaryOperator<U> combiner);
```

## Collect

### toMap

```java
// 1. key；2. value；
Map<String, String> map1 = list.stream().collect(Collectors.toMap(GroupBrandCateBO::getVersion, GroupBrandCateBO::getGroupCode));

// 1. key；2. value；3.key冲突处理
Map<String, String> map2 = list.stream().collect(Collectors.toMap(item -> item.getVersion(), item -> item.getGroupCode(), (oldVal, currVal) -> oldVal));

// 1. key；2. value；3.key冲突处理；4. Map实现类
Map<String, String> map3 = list.stream().collect(Collectors.toMap(item -> item.getVersion(), item -> item.getGroupCode(), (oldVal, currVal) -> oldVal, LinkedHashMap::new));
```

```java
// list元素去重，属性合并

// toMap法
List<BillsNums> result = list.stream()
  .collect(Collectors.toMap(BillsNums::getId, a -> a, (o1, o2) -> {
    o1.setNums(o1.getNums() + o2.getNums());
    o1.setSums(o1.getSums() + o2.getSums());
    return o1;
  }))
  .values()
  .stream()
  .collect(Collectors.toList());

// 迭代法
public static List<BillsNums> merge(List<BillsNums> list) {
  Map<String, BillsNums> map = new HashMap<>();
  list.stream().forEach(billsNums -> {
    BillsNums last = map.get(billsNums.getId());
    if (null != last) {
      billsNums.setSums(billsNums.getSums() + last.getSums());
      billsNums.setNums(billsNums.getNums() + last.getNums());
      map.put(billsNums.getId(), billsNums);
    } else {
      map.put(billsNums.getId(), billsNums);
    }
  });
  return map.values().stream().collect(Collectors.toList());
}
```

