# 异常处理

什么是异常
如何处理异常try-catch-finally
throw
throws
自定义异常异常链

异常本质上是程序上的错误。
异常：
意外、例外

错误在我们编写程序的过程中会经常发生,包括编译期间和运行期间的错误。

```
编译
括号没有正常的配对
语句结束后少写了分号
关键宇编写错误
```

```
运行
使用空的对象引用调用方法
string str=null;
5ystem.out.printin(str.length());
类型转换时无法正常转型
class Animal t
数组访问时下标越界int[] ary={1,2,3};
for(int i=0;i<=3;i+t)
) System.out.println(ary[i]);
class Dog extends Animal t
class Cat extends Animalf
।
算术运算时除数为0int one =12;
int two=0;
System.outprintin(one/two);
public class Test t
public statis void main(string[] args) Animal a1 =new Dog();
Animal a2 = new Cat();
Dog d1= (Dog)a1;
Dog d2=(Dog) a2;
```

在程序运行过程中,意外发生的情况,背离我们程序本身的意图的表现,都可以理解为 异常。

java通过throwable和其相关子类对异常进行描述

![7D90828F-889D-4829-899E-793C0864065C](https://tva1.sinaimg.cn/large/007S8ZIlly1ghf2ydu9i9j309w048dgc.jpg)

Error是程序无法处理的错误,表示运行应用程序中较严重问题。代码运行时java虚拟机出现了一系列问题，

常见错误

```
虚拟机错误
VirtualMachineError
内存溢出
OutOfMemoryError
线程死锁
ThreadDeath
```

这些错误是不可查的，它们在应用程序的控制和处理能力之外,而且绝大多数是程序运行时不允许出现的状况；对于设计合理的应用程序来说,即使确实发生了错误,本质上也不应该试图去处理它所引起的异常状况。

Exception是程序本身可以处理的异常。异常处理通常指针对这种类型异常的处理。

非检查异常Unchecked Exception

编译器不会产生提示信息，编写代码时可以放任不管也可以捕获异常

编译器不要求强制处置的异常，包含RuntimeException以及它的子类异常

```
空指针异常
NullPointerException
数组下标越界异常ArrayIndexOutofBoundsException
算数异常
ArithmeticException
类型转换异常
ClassCastException
```

检查异常Checked Exception：

编译器要求必须处置的异常。

除RuntimeException以及它的子类异常外，都是检查异常

如：IO异常IOException、SQL异常SOLException等等

![9130DECB-36FF-4348-898D-D191D8CF20B3](https://tva1.sinaimg.cn/large/007S8ZIlly1ghf389yjryj30jl0a4ad2.jpg)

在Java应用程序中,异常处理机制为:
抛出异常
捕捉异常

抛出异常：当一个方法中出现错误引发异常时，方法会创建异常对象并交付给运行时的系统来进行处理

![B97E3BD6-6BF9-4D22-9562-19F62A73F6F4](https://tva1.sinaimg.cn/large/007S8ZIlly1ghf3awd2taj30cz05qwf4.jpg)

捕获异常：当运行时系统捕获到这个异常

运行时系统逐步的去寻找合适的处理器，如果找到了与抛出异常匹配的处理器，它就会执行相关的处理逻辑，如果始终没有找到，运行时系统将会终止，意味着java程序停止了 

对于运行时异常、错误或可查异常, Java技术所要求的异常处理方式不同.

Java规定
-对于可查异常必须捕捉、或者声明抛出允许忽略不可查的RuntimeException
(含子类)和Error(含子类)。

![FE5BC741-51FE-45DC-B1BA-E3AFF6171073](https://tva1.sinaimg.cn/large/007S8ZIlly1ghf3m2bk73j30fz086wh1.jpg)

```java
public void method(){
    try{
        //代码段:
        1/产生异常的代码段2
    }catch (异常类型ex){
        //对异常进行处理的代码段3)
    }
    finally{
        //代码段4
    }
}

	try块:
用于捕获异常
    catch块:
用于处理try
捕获到的异常
    finally块:
无论是否发生异常代码总能执行
    try块后可接零个或多个catch块,如果没有catch块则必须跟一个finally块。
    try不能单独存在，catch、finally没有try也不能单独存在
    
    catch(Exception e){
e.printStackTrace); //打印出错误的堆栈信息，包括：错误的描述、错误的类型、错误出现的位置
        //堆栈信息输出结果出现位置相对比较随机，并没有一个特别固定的位置
       //异常从最后一层开始看，是最外层的展示，
}
通常在多重catch块当中最后一个catch添加父类异常（Exception e），用来兜底，顺序上一定是在最后
```

异常提示行数：大概22行

异常出现位置：在经历导入包中类的若干方法最后抛出异常

```
强制终止finally执行

```

