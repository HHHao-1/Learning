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

通过throw将产生的异常抛出。

如果一个方法可能会出现异常，但没有能力处理这种异常，可以在方法声明处用throws子句来声明抛出异常。谁调用由谁处理

![C136C0E6-13DA-450F-873D-6DD973A2E4EA](https://tva1.sinaimg.cn/large/007S8ZIlly1ghg2fumgknj30u30co448.jpg)

通过throws抛出异常时,针对可能出现的多种异常情况,解决方案:

1, throws后面接多个异常类型,中间用逗号分隔

2、 throws后面接Exception

非检查异常编译器不会提示，写上文档注释，放在方法调用用处可看到抛出的异常

![8DF560B0-1966-45D8-961E-D3E493444DA8](https://tva1.sinaimg.cn/large/007S8ZIlly1ghg2nn45juj30p30bb796.jpg)

![A437F455-0FF7-4260-81D7-276C34F2A973](https://tva1.sinaimg.cn/large/007S8ZIlly1ghg2p4j1maj30un09bjug.jpg)

两种使用方案

1.自己抛出自己设置异常处理

![6756A9AE-DF70-40F4-A798-02D7412B2D38](https://tva1.sinaimg.cn/large/007S8ZIlly1ghg2pt9c4nj30e70b4mzh.jpg)

2.谁调用谁处理

![35994B2E-3C91-4911-B1E5-EBE3D0201BEE](https://tva1.sinaimg.cn/large/007S8ZIlly1ghg2rdf91hj30h005t400.jpg)

异常可用来：1、规避可能出现的风险
2、完成一些程序的逻辑

![176E52F6-5758-408C-A6D4-D5324F411535](https://tva1.sinaimg.cn/large/007S8ZIlly1ghg2ysdob3j30pz0fzn6z.jpg)

![16FCD266-5C32-434D-AA80-8CE878D8DB5A](https://tva1.sinaimg.cn/large/007S8ZIlly1ghg334bojvj30pm0bw46t.jpg)

trows可以跟抛出的异常或其父类

不提倡主动抛出非检查类型，编译器对此异常约束力度不大

![3AB65740-CC18-452F-A0E5-1118950CE80B](https://tva1.sinaimg.cn/large/007S8ZIlly1ghg3cw5broj30su0fhwjb.jpg)![4D454DB0-7BE5-4F3E-A0CE-A039011B1E07](https://tva1.sinaimg.cn/large/007S8ZIlly1ghg3is1ynoj30iu043jtd.jpg)

![ED1C8EB0-234F-4007-A259-D379CA61F208](https://tva1.sinaimg.cn/large/007S8ZIlly1ghg3jhcyu5j30nu08idkp.jpg)

![6BD2B38B-56DB-4E60-9A10-D1830BFF72B9](https://tva1.sinaimg.cn/large/007S8ZIlly1ghg3k1guoej30nq0esq8g.jpg)

![70575182-A7E9-462E-B6E7-E834EEFD5681](https://tva1.sinaimg.cn/large/007S8ZIlly1ghg3hw8629j30rt0e278w.jpg)

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
			Exception e1=new Exception("我是新产生的异常2");//Throwble类的方法
			e1.initCause(e);//用一个异常信息初始化一个新的异常
			throw e1;
// throw new Exception("我是新产生的异常2"）若这样会导致异常信息丢失，只能得到异常2的信息
//			throw new Exception("我是新产生的异常2",e);//保留异常，Throwble类的构造方法
		}
	}
}
```

```
//保留异常链中之前的异常信息
public Throwable(String message,Throwable cause);
public Throwable initCause(Throwable cause);
```

![98B0A669-5A01-44D0-A5AD-DE3A5942B636](https://tva1.sinaimg.cn/large/007S8ZIlly1ghg41iuh14j30ra0bugpi.jpg)

而形成的一种链条

总结

程序中的异常
在程序运行过程中,意外发生的情况,背离我们程序本身的意图的表现,都可以理解为异常。
利用Java中的异常机制,我们可以更好地提升程序的健壮性。
在Java中,通过Throwable及其子类描述各种不同的异常类型。



在Java应用程序中,异常处理机制为:抛出异常、捕捉异常

![DBA308B4-4F32-45CC-BB60-91139545FAF8](https://tva1.sinaimg.cn/large/007S8ZIlly1ghg4iwgvefj30w20ecain.jpg)

![2D36D441-A123-48F5-B925-87DF7A843BB9](https://tva1.sinaimg.cn/large/007S8ZIlly1ghg4k8gvzuj30kx0cdtcw.jpg)![E6FBEB82-2376-497A-B539-EC5D0C3C368F](https://tva1.sinaimg.cn/large/007S8ZIlly1ghg4jzohdxj30f90bugnv.jpg)![811DE4D8-A672-4D88-AD72-71DF40211329](https://tva1.sinaimg.cn/large/007S8ZIlly1ghg4kwvtoyj30hs0cnad8.jpg)

![88C34F1B-3CD4-43A2-95CB-CAF1F5273A9C](https://tva1.sinaimg.cn/large/007S8ZIlly1ghg4l6s11ej30jq0d1wir.jpg)

实际应用中的经验与总结
处理运行时异常时,采用逻辑去合理规避同时辅助try-catch处理
在多重catch块后面,可以加一个catch ( Exception )来处理可能会被遗漏的异常

对于不确定的代码,也可以加上try-catch ,处理潜在的异常

尽量去处理异常,切忌只是简单的调用printStackTrace()去打印输出

,具体如何处理异常,要根据不同的业务需求和异常类型去决定

尽量添加finally语句块去释放占用的资源

# 包装类

![B6D56858-D3C2-4B8D-BA1A-B0FAD0059029](https://tva1.sinaimg.cn/large/007S8ZIlly1ghlgfmjl5rj313z0p0nax.jpg)

![403D2D07-7EB1-48E3-A8EA-D156276A442A](https://tva1.sinaimg.cn/large/007S8ZIlly1ghlgm0dpvij30tc0bh41v.jpg)

![EF6F0DF7-A015-4C0F-82EF-3C696B84BC9D](https://tva1.sinaimg.cn/large/007S8ZIlly1ghlgraz0s2j30pf0gjwi5.jpg)