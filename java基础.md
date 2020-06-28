 ## java初识

Java程序执行过程

![1017829A-591C-46BC-B79F-41FB4421AB7E](https://tva1.sinaimg.cn/large/007S8ZIlly1gg7yz4h3haj30ic076q3v.jpg)

JVM

JVM(Java Virtual Machine) , Java虚拟机

JVM是Java平台无关性实现的关键

JDK

JDK (Java Development Kit) , Java语言的软件开发工具包。

两个主要组件:

javac-编译器,将源程序转成字节码

java-运行编译后的java程序( .class后缀的)

JRE

JRE(Java Runtime Environment)

包括Java虚拟机(JVM )、Java核心类库和支持文件

如果只需要运行Java程序,下载并安装JRE即可

如果要开发Java软件,需要下载JDK

在JDK中附带有JRE

JDK, JRE和JVM三者的关系

JRE=JVM+JavaSE标准类库

JDK=JRE+开发工具集(例如Javac编译工具等)

![3B405C4B-FB52-4EEC-B237-BD5EAA64F49D](https://tva1.sinaimg.cn/large/007S8ZIlly1gg7z1pmpd6j307m07sta5.jpg)

Java平台

Java SE

桌面程序

Java标准版

Java EE

Web程序

Java企业版

Java ME

移动设备

Java微型版

## 变量与常量

内存中存储

内存可分为几个区域

![B592A6BB-527B-48C5-B5D7-F52F21F6BD29](https://tva1.sinaimg.cn/large/007S8ZIlly1gg82jk2i7tj30p90ertb9.jpg)

标识符

我们所认识的标识符如:类名HelloWorld

标识符的命名规则

标识符可以由字母、数字、下划线(-)和美元符($)组成,不能以数字开头

标识符严格区分大小写

标识符不能是Java关键字和保留字

标识符的命名最好能反映出其作用

关键字

![B8B11283-55A7-487B-AB87-25442611A316](https://tva1.sinaimg.cn/large/007S8ZIlly1gg7zagcxttj30oa08fwkp.jpg)

变量

什么是变量

变量的三个元素:变量类型、变量名和变量值。

变量名的命名规则

满足标识符命名规则

符合驼峰法命名规范

尽量简单,做到见名知意

变量名的长度没有限制

类的命名规则

满足Pascal命名法规范

- 小驼峰式命名法（lower camel case）：

第一个单字以小写字母开始；第二个单字的首字母大写，例如：firstName、lastName，也被称为Camel命名法。

- 大驼峰式命名法（upper camel case）：

每一个单字的首字母都采用大写字母，例如：FirstName、LastName、CamelCase，也被称为Pascal命名法。

数据类型

![1608CF59-9A6F-4350-9D67-43FB7DD283BF](https://tva1.sinaimg.cn/large/007S8ZIlly1gg7zosb8pmj30jx09iabe.jpg)

基本数据类型

![2050375F-8D52-470C-AFB9-DA6842D3C64C](https://tva1.sinaimg.cn/large/007S8ZIlly1gg7zpmnbkej30k30afq6q.jpg)

进制表示

八进制:以0开头,包括0-7的数字

如：037，056

十六进制表示:以0x或0X开头,包括0-9的数字,及字母a-f, A-F

如： 0x12 , 0xabcf , OXABCFF

整型字面值

Java中有三种表示整数的方法:十进制、八进制、十六进制

如: 123 , 023 , 0x1357 , 0X3c , OxlabcL

变量定义

int octal-037; //定义int类型变量存放八进制数据

long longNumber=Oxa2cdf3ffL;

//定义变量存放十六进制长整型数据

short shortNumber=123;

//定义变量存放短整型数据-byte b=10; //定义变量存放byte类型数据

说明:

整型字面值默认情况下是int类型,如果表示长整型则在末尾加1或L



浮点型字面值

浮点型字面值默认情况下表示double类型,也可以在值后加d或D

如: 123.43d或123.43D

如表示float类型,则需要在字面值后加fF

如: 23.4f23.4F

| 类型说明符 | 比特数(字节数) | 有效数字 | 数的范围                  |
| ---------- | -------------- | -------- | ------------------------- |
| float      | 32(4)          | 8        | 10的-38次方到10的38次方   |
| double     | 64(8)          | 17       | 10的-308次方到10的308次方 |

ASCI码

ASCII (American Standard Code for Information Interchange ,美国标准信息交换代码)

基于拉丁字母的一套电脑编码系统

主要用于显示现代英语和其他西欧语言

ASCI码表示

使用7位或8位二进制数组合来表示128或256种可能的字符。

标准ASCI码使用7位二进制来表示所有的大写字母和小写字母数字0-9,标点符号,以及在美式英语种使用的控制字符。

后128个称为扩展ASCI码,用于表示特殊符号、外来语字母和图形符号。

Unicode编码

char c= \u005d'   

（十六进制）005d =（二进制）1011101，一位十六进制用4bit存储

Unicode表示法,在值前加前缀\u

布尔类型字面值

布尔值只能定义为true和false

例: boolean b=true;

字符串字面值

双引号引起来的0个或多个字符。

转义字符

\：原意输出

![33CA796C-CD96-492A-8CF8-00BB208B3BF7](https://tva1.sinaimg.cn/large/007S8ZIlly1gg8145fpn2j30h109ggoo.jpg)

类型转换

类型转换分为自动类型转换和强制类型转换

自动类型转换顺序

![CED11488-08D0-4E38-B53A-006A4F7757B2](https://tva1.sinaimg.cn/large/007S8ZIlly1gg817t8vfyj30my0ayq4x.jpg)

强制类型转换

如果A类型的数据表示范围比B类型大,则将A类型的值赋值给B类型,需要强制类型转换

如: double d=123.4;

float f=(float)d;

常量

final int n = 5;

final关键字基本用法

1.修饰变量  

final变量经常和static关键字一起使用，作为常量。

final修饰基本数据类型的变量时，必须赋予初始值且不能被改变，修饰引用变量时，该引用变量不能再指向其他对象

2.修饰方法

final也可以声明方法。方法前面加上final关键字，代表这个方法不可以被子类的方法重写。如果你认为一个方法的功能已经足够完整了，子类中不需要改变的话，你可以声明此方法为final。final方法比非final方法要，因为在编译的时候已经静态绑定了，不需要在运行时再动态绑定。

3.修饰类

使用final来修饰的类叫作final类。final类通常功能是完整的，它们不能被继承。Java中有许多类是final的，譬如String, Interger以及其他包装类。

## 运算符

表达式

表达式由运算符和操作数组成如:

sum = numl+num2

运算符

算术运算符

算术运算符主要用于进行基本的算术运算,如加法、减法、乘法和除法等。

![6F0076B8-101C-416A-86FB-0DAA9D2A6C7A](https://tva1.sinaimg.cn/large/007S8ZIlly1gg81v71585j30kf08ctby.jpg)

自增自减运算符

自增/减：++I与i++区别：先自增再赋值、先赋值再自增

![1F802208-BDC9-4F3A-9F87-2162FD30A972](https://tva1.sinaimg.cn/large/007S8ZIlly1gg81x1w25fj30oj08paet.jpg)

赋值运算符

格式:变量=表达式;

例: int n=3; //将3赋值给变量n

注意:赋值运算符是从右往左运算!

注意:赋值运算符的左边不能是常量!

复合赋值运算符

![A041B3A9-A0A9-4424-9434-BD65DE053243](https://tva1.sinaimg.cn/large/007S8ZIlly1gg81yhcu3dj30oe06cdiu.jpg)

关系运算符

比较运算符用于判断两个数据的大小,如大于

比较的结果是一个布尔值

![60EF198B-B4ED-4C65-872B-8CEC6E284AC7](https://tva1.sinaimg.cn/large/007S8ZIlly1gg81z648c3j30ob07841u.jpg)

例:
A' > "B'结果为false,比较的是两个字符的ASCI值5!-6结果为true,比较两个数值是否相等true\==false结果为false ,两个布尔值不相等
float f=5.0f; long l-5; f==l;
结果为true,浮点数与整数进行比较,只要值相等就返回true

逻辑运算符

![E28D4BE0-B203-4EA4-870D-EE9B8D4EBE27](https://tva1.sinaimg.cn/large/007S8ZIlly1gg822u7msrj30hn04q764.jpg)

!运算符

对原条件进行取反例:(3<5) ,结果为false!

条件运算符

Java中的条件运算符是三目运算符

语法:

布尔表达式?表达式1:表达式2

当布尔表达式的值为true,则返回表达式1的值,否则返回表达式2的值

位运算符

| 符号 | 描述 | 运算规则                                                     |
| ---- | ---- | ------------------------------------------------------------ |
| &    | 与   | 两个位都为1时，结果才为1                                     |
| \|   | 或   | 两个位都为0时，结果才为0                                     |
| ^    | 异或 | 两个位相同为0，相异为1                                       |
| ~    | 取反 | 0变1，1变0                                                   |
| <<   | 左移 | 各二进位全部左移若干位，高位丢弃，低位补0                    |
| >>   | 右移 | 各二进位全部右移若干位，对无符号数，高位补0，有符号数，各编译器处理方法不一样，有的补符号位（算术右移），有的补0（逻辑右移） |

```
0&0=0  0&1=0  1&0=0  1&1=1
```

总结：两位同时为**1**，结果才为**1**，否则结果为**0**。

```
0|0=0  0|1=1  1|0=1  1|1=1
```

总结：参加运算的两个对象只要有一个为1，其值为1。

```
0^0=0  0^1=1  1^0=1  1^1=0
```

总结：参加运算的两个对象，如果两个相应位相同为0，相异为1。

```
~1=0
~0=1
```

总结：对一个二进制数按位取反，即将0变1，1变0。

## 左移运算符（<<）

定义：将一个运算对象的各二进制位全部左移若干位（左边的二进制位丢弃，右边补0）。

设 a=1010 1110，`a = a<< 2` 将a的二进制位左移2位、右补0，即得a=1011 1000。

若左移时舍弃的高位不包含1，则每左移一位，相当于该数乘以2。

## 右移运算符（>>）[ ](https://www.cnblogs.com/yueshutong/p/11244534.html#2076073887)

定义：将一个数的各二进制位全部右移若干位，正数左补0，负数左补1，右边丢弃。

例如：a=a>>2 将a的二进制位右移2位，左补0 或者 左补1得看被移数是正还是负。

操作数每右移一位，相当于该数除以2。

## 复合赋值运算符[ ](https://www.cnblogs.com/yueshutong/p/11244534.html#1403549556)

位运算符与赋值运算符结合，组成新的复合赋值运算符，它们是：

```
&=`    例：`a&=b  `相当于   `a=a&b
|=`    例：`a|=b  `相当于   `a=a|b
>>=`   例：`a>>=b  `相当于   `a=a>>b
<<=`   例：`a<<=b`   相当于   `a=a<<b
^=`    例：`a^=b  `相当`于  a=a^b
```

运算规则：和前面讲的复合赋值运算符的运算规则相似。

**不同长度的数据进行位运算：**如果两个不同长度的数据进行位运算时，系统会将二者补0按右端对齐，然后进行位运算。



运算符

![11DD30F4-AABB-464E-9FE1-30CBCD4F66D4](https://tva1.sinaimg.cn/large/007S8ZIlly1gg825i6b1uj30o2061ju3.jpg)

运算符的优先级

![AFAD4139-C29E-43DB-B78F-CBA2C244D396](https://tva1.sinaimg.cn/large/007S8ZIlly1gg824j4zdtj30ly0a1gq9.jpg)

## 流程控制

(1). 条件判断语句

if语句、if-else语句、switch语句；

```java 
switch(表达式){
    case常量表达式1:
        语句1; 
        break;
    case常量表达式2:
        语句2;
        break;
    default:
        语句3;
}
```

(2) .循环执行语句

do while语句、while语句、for语句；

```java
do{
    语句;
} while(循环条件);
```

```java
for(int i=0;i<100;i++){
    语句;
}

for(Integer num: list){
    语句;
}
```

(3). 转向语句

break语句、continue语句、return语句

break：跳出本层循环，本层循环语句结束

continue：跳过本次循环中continue语句后尚未执行的语句，接着进行下一次循环条件的判断。 

return：从当前方法退出，并返回一个值









## 集合

为什么使用集合,而不用数线

应用场景

无法预测存储数据的数量

同时存储具有一对一关系的数据

需要进行数据的增删改查

数据重复问题

集合框架的体系结构

![8CB72A2E-68DB-45F3-992D-C2E8B6C43B69](https://tva1.sinaimg.cn/large/007S8ZIlly1gg7y1w67sqj30dt07f75y.jpg)

List(列表）

List是元素有序并且可以重复的集合,称为序列

List可以精确的控制每个元素的插入位置,或删除某个位置的元素

List的两个主要实现类是ArrayList和LinkedList

- ArrayList可变长的动态数组
- LinkedList是一个链表
- 与ArrayList一样, LinkedList也按照索引位置排序,但它的元素之间是双向链接的
- 适合快速地插入和删除元素
- LinkedList实现List和Queue两个接口

ArrayList

ArrayList底层是由数组实现的

动态增长，以满足应用程序的需求

在列表尾部插入或删除数据非常有效

更适合查找和更新元素

ArrayList中的元素可以为null