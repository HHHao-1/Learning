# 异常处理

什么是异常

如何处理异常try-catch-finally

throw

throws

自定义异常

异常链

## 异常简介

异常：意外、例外

异常本质上是程序上的错误。

在程序运行过程中,意外发生的情况,背离我们程序本身的意图的表现,都可以理解为异常。

**可分为：①编译期间错误   ②运行期间错误**

> ```java
> //编译期间错误：
>     
> 括号没有正常的配对
>     
> 语句结束后少写了分号
>     
> 关键宇编写错误
> ```
>
> ```java
> //运行期间错误：
> 
> 使用空的对象引用调用方法
> string str=null;
> 5ystem.out.printin(str.length());
> 
> 类型转换时无法正常转型
> 
> 数组访问时下标越界
> 
> 算术运算时除数为0
> ```
>

## Throwable介绍

**java通过Throwable和其相关子类对异常进行描述**

![9130DECB-36FF-4348-898D-D191D8CF20B3](https://tva1.sinaimg.cn/large/007S8ZIlly1ghf389yjryj30jl0a4ad2.jpg)



- **Error：**是程序无法处理的错误,表示运行应用程序中较严重问题；代码运行时java虚拟机出现了一系列问题

常见错误：

```css
虚拟机错误：VirtualMachineError
内存溢出：OutOfMemoryError
线程死锁：ThreadDeath
```

> 这些错误是不可查的，它们在应用程序的控制和处理能力之外,而且绝大多数是程序运行时不允许出现的状况；
>
> 对于设计合理的应用程序来说,即使确实发生了错误,本质上也不应该试图去处理它所引起的异常状况。

- **Exception：**是程序本身可以处理的异常；异常处理通常指针对这种类型异常的处理。

可分为：非检查异常和检查异常

**非检查异常Unchecked Exception**

> 编译器不会产生提示信息，编写代码时可以放任不管也可以捕获异常
>
> 编译器不要求强制处置的异常，包含**RuntimeException**以及它的子类异常
>

```css
空指针异常：NullPointerException
数组下标越界异常：ArrayIndexOutofBoundsException
算数异常：ArithmeticException
类型转换异常：ClassCastException
```

**检查异常Checked Exception：**

> 编译器要求必须处理的异常
>
> 除RuntimeException以及它的子类异常外，都是检查异常
>
> 如：IO异常IOException、SQL异常SOLException等等

## 异常处理机制

1. 在Java应用程序中,异常处理机制为:

- 抛出异常

- 捕捉异常

> 抛出异常：当一个方法中出现错误引发异常时，方法会创建异常对象并交付给运行时的系统来进行处理
>
> ![B97E3BD6-6BF9-4D22-9562-19F62A73F6F4](https://tva1.sinaimg.cn/large/007S8ZIlly1ghf3awd2taj30cz05qwf4.jpg)
>
> 捕获异常：当运行时系统捕获到这个异常
>
> 运行时系统逐步的去寻找合适的处理器，如果找到了与抛出异常匹配的处理器，它就会执行相关的处理逻辑，如果始终没有找到，运行时系统将会终止，意味着java程序停止了 
>

2. 对于错误、运行时异常或检查异常, Java技术所要求的异常处理方式不同.

> Java规定：
>
> 对于可查异常必须捕捉、或者声明抛出
>
> 允许忽略不可查的RuntimeException(含子类)和Error(含子类)。

![FE5BC741-51FE-45DC-B1BA-E3AFF6171073](https://tva1.sinaimg.cn/large/007S8ZIlly1ghf3m2bk73j30fz086wh1.jpg)

```java
public void method(){
    try{
        //代码段:
        //产生异常的代码段2
    }catch (异常类型 ex){
        //对异常进行处理的代码段3
    }
    finally{
        //代码段4
    }
}
```

> try块；用于捕获异常
>
> catch块；用于处理try捕获到的异常
>
> finally块；无论是否发生异常代码总能执行
>
> try块后可接零个或多个catch块,如果没有catch块则必须跟一个finally块
>
> - 通常在多重catch块当中最后一个catch添加父类异常（Exception e），用来兜底，顺序上一定是在最后
>
> try不能单独存在，catch、finally没有try也不能单独存在

```java
catch(Exception e){

    e.printStackTrace; 
    //打印出错误的堆栈信息，包括：错误的描述、错误的类型、错误出现的位置
    //堆栈信息输出结果出现位置相对比较随机，并没有一个特别固定的位置
    //异常提示行数：大概22行;异常出现位置：在经历导入包中类的若干方法最后抛出异常
    //异常从最后一层开始看，是最外层的展示，
}
```

### 终止程序执行

```java
system.exit(int status) 
system.exit(1) 和 system.exit(0)用法与作用
    
正常退出
status为0时为正常退出程序，也就是结束当前正在运行中的java虚拟机。

非正常退出
status为非0的其他整数（包括负数，一般是1或者-1），表示非正常退出当前程序。
    
注意：不管status为何值都会退出程序。和return 相比有以下不同点：
     return是回到上一层，而System.exit(status)是回到最上层
    
关于正常退出与非正常退出
正常退出，是指如果当前程序还有在执行的任务，则等待所有任务执行完成以后再退出；
非正常退出，只要时间到了，立刻停止程序运行，不管是否还有任务在执行。这个效果就类似于linux 里面的 kill -9 和 kill -15
//kill -9 PID 是操作系统从内核级别强制杀死一个进程.
//kill -15 PID 可以理解为操作系统发送一个通知告诉应用主动关闭.
```

### return关键字

```java
public static void main(String[] args) {
    int result=test();
    System. out.println("one和two的商是: "+ result);
}
public static int test(){
    Scanner input= new Scanner(System.in);
    System. out.println("=-==运算开始====s");
    try{
        System.out.print("请输入第一个整数: ");
        int one=input.nextInt();
        System.out.print("请输入第二个整数: ");
        int two=input.nextInt();
        return one/two;
    }catch(ArithmeticException e){
        System.out.println("除数不允许为零");
        return 0;
    }finally{
        System. out.println("=====运算结束=====");
        return -100000;
    }
}

输出：
one和two的商是: -100000//值取到最后一个返回值
```

### throw & throws

通过throws声明将要抛出何种类型的异常

通过throw将产生的异常抛出

> 如果一个方法可能会出现异常，但没有能力处理这种异常，可以在方法声明处用throws子句来声明抛出异常；这时则谁调用由谁处理

1. throws

```java
public void method() throws Exception1,Exception2,... ExceptionN {
//可能产生异常的代码
}
```

通过throws抛出异常时,针对可能出现的多种异常情况,解决方案:

①throws后面接多个异常类型,中间用逗号分隔

②throws后面接Exception

**小技巧：**

> 非检查异常编译器不会提示，写上文档注释，放在方法调用用处可看到抛出的异常
>
> ![8DF560B0-1966-45D8-961E-D3E493444DA8](https://tva1.sinaimg.cn/large/007S8ZIlly1ghg2nn45juj30p30bb796.jpg)

2. throw

```
//throw用来抛出一个异常。
throw new IOException0;
```

两种使用方案

1.自己抛出，自己设置异常处理

```java
public void method(){
    try {
        //代码段1
        throw new异常类型() ;
    } catch (异常类型ex){
        //对异常进行处理的代码段2
    }
}
```

2. 谁调用谁处理

```java
public void method() throws 异常类型{
    //代码段1
	throw new异常类型( ) ;
}
```

![35994B2E-3C91-4911-B1E5-EBE3D0201BEE](https://tva1.sinaimg.cn/large/007S8ZIlly1ghg2rdf91hj30h005t400.jpg)

**注意：**

trows可以跟抛出的异常或其父类

不提倡主动抛出非检查类型，编译器对此异常约束力度不大

## 异常的作用

1. 规避可能出现的风险

2. 完成一些程序的逻辑

```java
//描述酒店的入住规则:限定年龄, 18岁以下, 80岁以上的住客必须由亲友陪同
public static void testAgeC) {
    try {
        System. out.printIn("请输入年龄: ");
        Scanner input = new Scanner(System. in);
        int age =input.nextIntO);
        if (age < 18 1l age > 80) {
            throw new Exception("18岁以下, 80岁以上的住客必须由亲友陪同");
        } else {
            System. out.println("欢迎入住本酒店");
            了
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
```

![27D71735-2994-421E-9642-13917A93EF28](/Users/hao/Library/Application Support/typora-user-images/27D71735-2994-421E-9642-13917A93EF28.png)

![07047A45-1A77-41CE-A3C8-B8D2394A1D06](/Users/hao/Library/Application Support/typora-user-images/07047A45-1A77-41CE-A3C8-B8D2394A1D06.png)

## 自定义异常

> 使用Java内置的异常类可以描述在编程时出现的大部分异常情况。
>
> 也可以通过自定义异常描述特定业务产生的异常类型。
>
> 所谓自定义异常,就是定义一个类,去继承Throwable类或者它的子类。

```java
public class HotelAgeException extends Exception { 
    public HotelAgeException(){
        super("18岁以下, 80岁以上的住客必须由亲友陪同");
    }
}

public static void testAge() throws HotelAgeException {
    System. out.println("请输入年龄: ");1
        Scanner input = new Scanner(System. in);
    int age = input.nextIntO);
    if (age < 18 I1 age> 80) {
        throw new HotelAgeException():
    } else {
        System. out.println("欢迎入住本酒店");
    }
}

public class TryDemoFour {
    public static void main(String[] args) { 
        try { 
            testAge();
        } catch (HotelAgeException e) { 
            System. out.printIn(e.getMessage());
            System. out.println("酒店前台工作人员不允许办理入住登记");
        }catch(Exception e){
            e.printstackTraceC);
        }
    }
}

//输出：
请输入年龄:5
18岁以下, 80岁以上的住客必须由亲友陪同
酒店前台工作人员不允许办理入住登记
```

## 异常链

![45921C25-D7BE-48F1-84C6-C21324ADBB26](https://tva1.sinaimg.cn/large/007S8ZIlly1ghlujvm2ufj30ow091jv9.jpg)

```java
public class TryDemoFive {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
			testThree();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void testOne() throws HotelAgeException {
		throw new HotelAgeException();
	}

	public static void testTwo() throws Exception {
		try {
			testOne();
		} catch (HotelAgeException e) {
			throw new Exception("我是新产生的异常1",e);//保留异常
		}
	}

	public static void testThree() throws Exception {
		try {
			testTwo();
		} catch (Exception e) {
            //throw new Exception("我是新产生的异常2"）//若这样会导致之前的异常信息丢失，只能得到异常2的信息
			Exception e1 = new Exception("我是新产生的异常2");
			e1.initCause(e);//用一个异常信息初始化一个新的异常//Throwble类的方法
			throw e1;
			//throw new Exception("我是新产生的异常2",e);//保留异常，Throwble类的构造方法
		}
	}
}
```

```java
//保留异常链中之前的异常信息，有两种方法
public Throwable(String message,Throwable cause);
public Throwable initCause(Throwable cause);
```

## 总结

> 在程序运行过程中,意外发生的情况,背离我们程序本身的意图的表现,都可以理解为异常。
>
> 利用Java中的异常机制,我们可以更好地提升程序的健壮性。
>
> 在Java中,通过Throwable及其子类描述各种不同的异常类型。

**在Java应用程序中,异常处理机制为:抛出异常、捕捉异常**

![DBA308B4-4F32-45CC-BB60-91139545FAF8](https://tva1.sinaimg.cn/large/007S8ZIlly1ghg4iwgvefj30w20ecain.jpg)

![6C908CB0-44D7-46F5-939D-7ED350B872F3](https://tva1.sinaimg.cn/large/007S8ZIlly1ghluu76dwej30m50cx43v.jpg)

**实际应用中的经验与总结**

> 处理运行时异常时，采用逻辑去合理规避同时辅助try-catch处理
>
> - 对于不确定的代码,也可以加上try-catch ,处理潜在的异常
>
> 在多重catch块后面,可以加一个catch ( Exception )来处理可能会被遗漏的异常
>
> 尽量去处理异常,切忌只是简单的调用printStackTrace()去打印输出
>
> - 具体如何处理异常,要根据不同的业务需求和异常类型去决定
>
> 尽量添加finally语句块去释放占用的资源

## 常见异常及分析

1. NullPointerException异常

> 顾名思义, NullPointerException是空指针异常。但是在Java中没有指针,怎么会有空指针异常呢?
>
> 在C++中,声明的指针需要指向一个实例(通过new方法构造),这个指针可以理解为地址。在Java中,虽然没有指针,但是有引用(通常称为对象引用,一般直接说对象),引用也是要指向一个实例对象(通过new方法构造)的,从这种意义上说, Java中的引用与C++中的指针没有本质的区别,不同的是,处于安全的目的,在Java中不能对引用进行操作,而在C++中可以直接进行指针的运算,例如book++等。
>
> 所以这里的NullPointerException虽然不是真正的空指针异常,但本质上差不多,是因为引用没有指向具体的实例,所以当访问这个引用的方法的时候就会产生这种异常。

```java
String str ="这是一个测试用的字符串! ";
System.out.println(str.length());
//这段代码没有问题,但是如果改成下面的代码:
String str=null ;
System.out.println(str.length());
//就会产生NullPointerException异常了:

说明:这个时候你的str就出现空指针异常,因为你只是声明了这个String类型的对象并没有创建对象,所以它的堆里面没有地址引用,切忌你要用对象调用方法的时候一定要先创建对象。
```

2. ClassCastException异常

> 从字面上看,是类型转换错误,通常是进行强制类型转换时候出的错误。
>
> 强制类型转换的前提是父类引用指向的对象的类型是子类的时候才可以进行强制类型转换,如果父类引用指向的对象的类型不是子类的时候将产生javalang.ClassCastException异常。
>
> **遇到这样的异常的时候如何解决呢?**
>
> 如果你知道要访问的的对象的具体类型,直接转换成该类型即可。如果不能确定类型可以通过下面的两种方式进行处理(假设对象为o):
>
> - 通过o.getClass0.getName0得到具体的类型,可以通过输出语句输出这个类型,然后根据类型进行进行具体的处理。
> - 通过if(o instanceof 类型)的语句来判断o的类型是什么。

3. ArrayIndexOutOfBoundsException异常

   > 这是一个非常常见的异常,从名字上看是数组下标越界错误

4. UnsupportedClassVersionError

> 编译Java和运行Java所使用的Java的版本不一致。例如,编译的时候使用的Java版
> 本是6,运行时候使用的Java版本是5。
>
> 解决方案：修改运行环境的Java版本或者修改编译环境的Java版本,让两者保持一致。

5. NumberFormatException异常

> 数字转换异常,在把一个表示数字的字符串转换成数字类型的时候可能会报这个异常，原因是作为参数的字符串不是由数字组成的。

6. 堆栈溢出和内存溢出

> 在递归调用的时候可能会产生堆栈溢出的情况,因为在递归调用的时候需要把调用的状态保存起来,如果递归的深度达到一定程度,将产生**堆栈溢出**的异常。
>
> 如果虚拟机的内存比较小,而程序对内存的要求比较高,则可能产生**内存溢出**错误。

7. 常见的异常类

| 异常                     | 说明                            |
| ------------------------ | ------------------------------- |
| RuntimeException         | Java.lang包中多数运行异常的基类 |
| ArithmeticException      | 算术错误,如除以0                |
| IlleqalArqumentException | 方法收到非法参数                |
| SecurityException        | SecurityException               |
| ClassNotFoundException   | 不能加载请求的类                |
| AWTException             | AWT中的异常                     |
| IOException              | I/O异常的根类                   |
| FileNotFoundException    | 不能找到文件                    |
| EOFException             | 文件结束                        |
| IlleqalAccessException   | 对类的访问被拒绝                |
| NoSuchMethodException    | 请求的方法不存在                |
| InterruptedException     | 线程中断                        |

# 包装类

## 简介

**包装类的作用：**

> 基本数据类型没有属性、方法，无法进行对象化交互
>
> 包装类拥有属性、方法，可以对象化交互

**Java语言提供了八种基本类型：**

**六种数字类型(四个整数型,两个浮点型),一种字符类型,还有一种布尔型**

![A12621D9-3C19-48A2-8079-0F50A90ABF72](https://tva1.sinaimg.cn/large/007S8ZIlly1ghm14upua3j30sw0dp415.jpg)

**基本类型与对应包装类：**

- 所有包装类都用final修饰，既不可继承
- 数值型都继承自number类
- 字符型和布尔型继承自object类

| 基本数据类型 | 初始值   | 大小(字节) | byte包装类 |
| ------------ | -------- | ---------- | ---------- |
| byte         | 0        | 1          | Byte       |
| short        | 0        | 2          | Short      |
| int          | 0        | 4          | Integer    |
| long         | 0L       | 8          | Long       |
| float        | 0.0f     | 4          | Float      |
| double       | 0.0d     | 8          | Double     |
| char         | '\u0000' | 2          | Character  |
| boolean      | false    | -          | Boolean    |

| 数据类型     | 初始值 |
| ------------ | ------ |
| 所有引用类型 | null   |

> 注意：
>
> 1. \u表示unicode编码；Java采用unicode编码，2个字节来表示一个字符。
> 2. **当变量作为作为类成员使用时，java才确保给定其初始值**，防止程序运行时错误
> 3. 基本数据类型的包装类都属于引用类型
> 4. null本身虽然能代表一个不确定的对象，但就null本身来说，它不是对象，也不知道是什么类型，也不是java.lang.Object的实例
> 5. Java中的包装类还包括：BigInteger. BigDecimal，它们没有相对应的基本类型,主要应用于高精度的运算, BigInteger支持任意精度的整数, BigDecimal支持任意精度带小数点的运算.

## 装箱拆箱
**装箱:把基本数据类型转换成包装类**

- 自动装箱

- 手动装箱

**拆箱：把包装类转换成基本数据类型**

- 手动拆箱

- 自动拆箱

**示例：**

```java
public static void main(StringD args) { 

    //装箱:把基本数据类型转换成包装类
//1、自动装箱
int t1=2;
Integer t2=t1;
//2、手动装箱
Integer t3=new Integer(t1);
//测试
System. out.println("int类型变量t1="+t1);
System. out.println("Integer类型对象t2="+t2);
System. out.println("Integer类型对象t3="+t3);
}

//拆箱:把包装类转换成基本数据类型
//1、自动拆箱
int t4=t2;
//2、手动抵箱
int t5=t2.intValue();
//测试
System. out.println("Integer类型对象t2="+t2);
System. out.println("自动拆箱后, int类型变量t4="+t4);
System. out.printin("手动拆箱后, int类型变量t5="+t5);
```

## 字符串与基本数据类型转换

**①基本数据类型转换为字符串**

- 使用包装类的toString0方法

②字符串转换为基本数据类型

- 自动拆箱：调用包装类的parsexxx()静态方法

> 字符串只能是数字

- 自动拆箱：调用包装类的valueOf()方法转换为基本类型的包装类

> 字符串只能是数字

```java
public static void main(String[] args) {
        //基本数据类型转换为字符串，包装类的tostring方法
        int t1=2;
        String t2 = Integer.toString(t1);
        //测试
        System. out.println("int类型转换为String类型对象t2="+t2);

        //字符串转换为基本数据类型
        //1、包装类的parse方法
        int t3 = Integer.parseInt(t2);
        //2、包装类的valueof先将字符串转换为包装类,再通过自动拆箱完成基本类型转换
        int t4 = Integer.valueOf(t2);
        //测试
        System. out.println("String类型转换为int类型变量t3="+t3);
        System. out.println("String类型转换为int类型变量t4="+t4);
    }
```

## 包装类对象间的比较

```java
public static void main(String[] args) {
    Integer one=new Integer(100);
    Integer two=new Integer(100);
    System.out.println("one==two的结果:"+(one==two)); //false
    //自动装箱
    Integer three=100;
    //three==100 自动拆箱
    System.out.println("three==100的结果:"+(three==100)); //true
    //相当于：Integer four-Integer. valueof(100)
    Integer four=100;
    System.out.println("three==four的结果:"+(three==four)); //true
    Integer five=200;
    System.out.println("five==200的结果:"+ (five==200)); //true
    Integer six=200;
    System.out.println("five==six的结果:"+(five==six)); //false
}
```

1. 如果一边是包装类，一边是基本类型时：两边进行比较，都会进行值比较
2. 如果发现 == 两边都是对象，它就直接比较引用，而不是值

## 对象常量池

![0B59ED7E-82DA-4592-A1E3-C443C228799A](https://tva1.sinaimg.cn/large/007S8ZIlly1ghm2z96tgij309v04v0u2.jpg)               ![B3FF615F-1A3A-43B3-B745-73E261EA0E90](https://tva1.sinaimg.cn/large/007S8ZIlly1ghm33ru2auj30ck08pabq.jpg)

> 注意：除Float和Double外，其它包装类都可以应用对象常量池的概念

## Number类

抽象类Number是父类, Number的子类必须提供将表示的数值转换成byte、 double、float、long、int、short的方法。Number类的方法被Number的各子类所实现，方法如下：

> 
>
> 子类： Byte，Double，Float，Integer，Long， Short
>
> 方法：如Integer中byteValue()-----以字节形式返回此Integer的值。

| Modifier and Type | Method and Description                                       |
| :---------------- | :----------------------------------------------------------- |
| `byte`            | `byteValue()`<br />Returns the value of the specified number as a `byte`, which may involve rounding or truncation. |
| `abstract double` | `doubleValue()`<br />Returns the value of the specified number as a `double`, which may involve rounding. |
| `abstract float`  | `floatValue()`<br />Returns the value of the specified number as a `float`, which may involve rounding. |
| `abstract int`    | `intValue()`<br />Returns the value of the specified number as an `int`, which may involve rounding or truncation. |
| `abstract long`   | `longValue()`<br />Returns the value of the specified number as a `long`, which may involve rounding or truncation. |
| `short`           | `shortValue()`<br />Returns the value of the specified number as a `short`, which may involve rounding or truncation. |