# 基础语法

## 简介

### Java程序执行过程

> 半编译、半解释执行
>
> ![1017829A-591C-46BC-B79F-41FB4421AB7E](https://tva1.sinaimg.cn/large/007S8ZIlly1gg7yz4h3haj30ic076q3v.jpg)
>

### JVM

> JVM(Java Virtual Machine) , Java虚拟机
>
> JVM是Java平台无关性实现的关键

### JDK

> JDK (Java Development Kit) , Java语言的软件开发工具包。
>
> 两个主要组件:
>
> javac-编译器,将源程序转成字节码
>
> java-运行编译后的java程序( .class后缀的)

### JRE

> JRE(Java Runtime Environment)
>
> 包括Java虚拟机(JVM )、Java核心类库和支持文件
>
> 如果只需要运行Java程序,下载并安装JRE即可
>
> 如果要开发Java软件,需要下载JDK，在JDK中附带有JRE

### JDK、JRE和JVM三者的关系

> <img src="https://tva1.sinaimg.cn/large/007S8ZIlly1gg7z1pmpd6j307m07sta5.jpg" alt="3B405C4B-FB52-4EEC-B237-BD5EAA64F49D" style="zoom:67%;" align="left" />JRE = JVM+JavaSE标准类库
>
> JDK=JRE+开发工具集(例如Javac编译工具等)







### Java平台

> ![63556683-F207-4871-A64D-726C9952C14B](https://tva1.sinaimg.cn/large/007S8ZIlly1gg84eyu4wdj30lt048q4e.jpg)
>

## 编码

### ASCII码

简介

> ASCII (American Standard Code for Information Interchange ,美国标准信息交换代码)
>
> 基于拉丁字母的一套电脑编码系统
>
> 主要用于显示现代英语和其他西欧语言

ASCI码表示

> 使用7位或8位二进制数组合来表示128或256种可能的字符。
>
> 标准ASCI码使用7位二进制来表示所有的大写字母和小写字母数字0-9,标点符号,以及在美式英语种使用的控制字符。
>
> 后128个称为扩展ASCI码,用于表示特殊符号、外来语字母和图形符号。

### Unicode编码

> Unicode表示法,在值前加前缀\u
>
> char c= \u005d'   
>
> - （十六进制）005d =（二进制）1011101
> - 一位十六进制用4bit存储

## 变量与常量

### 内存存储

> 内存划分为栈、堆、常量池区三个区域
>
> 方法区：在java的虚拟机中有一块专门用来存放已经加载的类信息（常量、静态变量以及方法代码）的内存区域，叫做方法区。
>
> 本地方法栈、程序计数器：JVM中的运行时内存区域还包括本地方法栈和程序计数器
>
> ![B592A6BB-527B-48C5-B5D7-F52F21F6BD29](https://tva1.sinaimg.cn/large/007S8ZIlly1gg82jk2i7tj30p90ertb9.jpg)
>

### 标识符

**我们所认识的标识符**

> 如：类名HelloWorld

**标识符的命名规则**

> 标识符可以由字母、数字、下划线(-)和美元符($)组成,不能以数字开头
>
> 标识符严格区分大小写
>
> 标识符不能是Java关键字和保留字
>
> 标识符的命名最好能反映出其作用
>

### 关键字

![B8B11283-55A7-487B-AB87-25442611A316](https://tva1.sinaimg.cn/large/007S8ZIlly1gg7zagcxttj30oa08fwkp.jpg)

### 变量

**变量名的命名规则**

> 满足标识符命名规则
>
> 符合驼峰法命名规范
>
> 尽量简单,做到见名知意
>
> 变量名的长度没有限制
>

**类的命名规则**

> 满足Pascal命名法规范
>

**数据类型**

![1608CF59-9A6F-4350-9D67-43FB7DD283BF](https://tva1.sinaimg.cn/large/007S8ZIlly1gg7zosb8pmj30jx09iabe.jpg)

**基本数据类型**

![2050375F-8D52-470C-AFB9-DA6842D3C64C](https://tva1.sinaimg.cn/large/007S8ZIlly1gg7zpmnbkej30k30afq6q.jpg)

| 类型说明符 | 比特数(字节数) | 有效数字 | 数的范围                  |
| ---------- | -------------- | -------- | ------------------------- |
| float      | 32(4)          | 8        | 10的-38次方到10的38次方   |
| double     | 64(8)          | 17       | 10的-308次方到10的308次方 |

### 进制表示

**八进制**

> 以0开头,包括0-7的数字
>
> 如：037，056
>

**十六进制**

> 以0x或0X开头,包括0-9的数字,及字母a-f, A-F
>
> 如： 0x12 , 0xabcf , OXABCFF
>

**整型字面值**

> Java中有三种表示整数的方法:十进制、八进制、十六进制
>
> 如: 123 , 023 , 0x1357 , 0X3c , OxlabcL
>

**变量定义**

```java
int octal = 037; //定义int类型变量存放八进制数据

long longNumber=0xa2cdf3ffL; //定义变量存放十六进制长整型数据

short shortNumber=123; //定义变量存放短整型数据-byte b=10; //定义变量存放byte类型数据
```

### 字面值

#### 整型字面值

> 默认情况下是int类型,如果表示长整型则在末尾加1或L

#### 浮点型字面值

> 默认情况下表示double类型,也可以在值后加d或D
>
> 如: 123.43d或123.43D   
>
> 表示float类型,则需要在字面值后加fF
>
> 如: 23.4f23.4F

#### 布尔类型字面值

> 布尔值只能定义为true和false
>
> 例: boolean b=true;
>

#### 字符串字面值

> 双引号引起来的0个或多个字符。
>

### 转义字符

> \：原意输出
>

![33CA796C-CD96-492A-8CF8-00BB208B3BF7](https://tva1.sinaimg.cn/large/007S8ZIlly1gg8145fpn2j30h109ggoo.jpg)

### 类型转换

> 类型转换分为自动类型转换和强制类型转换
>

#### 自动类型转换顺序

![CED11488-08D0-4E38-B53A-006A4F7757B2](https://tva1.sinaimg.cn/large/007S8ZIlly1gg817t8vfyj30my0ayq4x.jpg)

#### 强制类型转换

> 如果A类型的数据表示范围比B类型大,则将A类型的值赋值给B类型,需要强制类型转换
>
> 如: double d=123.4;
>
> float f=(float)d;
>

### 常量

> 如：final int n = 5;
>

## 运算符

### 分类

![11DD30F4-AABB-464E-9FE1-30CBCD4F66D4](https://tva1.sinaimg.cn/large/007S8ZIlly1gg825i6b1uj30o2061ju3.jpg)

### 优先级

![AFAD4139-C29E-43DB-B78F-CBA2C244D396](https://tva1.sinaimg.cn/large/007S8ZIlly1gg824j4zdtj30ly0a1gq9.jpg)

### 算术运算符

> 算术运算符主要用于进行基本的算术运算,如加法、减法、乘法和除法等。
>

![6F0076B8-101C-416A-86FB-0DAA9D2A6C7A](https://tva1.sinaimg.cn/large/007S8ZIlly1gg81v71585j30kf08ctby.jpg)

### 自增自减运算符

> 自增/减：++I与i++区别：先自增再赋值、先赋值再自增
>

![1F802208-BDC9-4F3A-9F87-2162FD30A972](https://tva1.sinaimg.cn/large/007S8ZIlly1gg81x1w25fj30oj08paet.jpg)

### 赋值运算符

> 格式:变量=表达式;
>
> 例: int n=3; //将3赋值给变量n
>
> 注意:赋值运算符是从右往左运算!
>
> 注意:赋值运算符的左边不能是常量!
>

### 复合赋值运算符

![A041B3A9-A0A9-4424-9434-BD65DE053243](https://tva1.sinaimg.cn/large/007S8ZIlly1gg81yhcu3dj30oe06cdiu.jpg)

### 关系运算符

> 比较运算符用于判断两个数据的大小,如大于
>
> 比较的结果是一个布尔值
>

![60EF198B-B4ED-4C65-872B-8CEC6E284AC7](https://tva1.sinaimg.cn/large/007S8ZIlly1gg81z648c3j30ob07841u.jpg)

```css
A' > "B'结果为false,比较的是两个字符的ASCII值
5!=6结果为true, 比较两个数值是否相等true == false结果为false ,两个布尔值不相等

float f=5.0f;   long l=5;   f==l;
结果为true,浮点数与整数进行比较,只要值相等就返回true
```

### 逻辑运算符

![E28D4BE0-B203-4EA4-870D-EE9B8D4EBE27](https://tva1.sinaimg.cn/large/007S8ZIlly1gg822u7msrj30hn04q764.jpg)

**!运算符**

> 对原条件进行取反：
>
> !(3<5) ,结果为false!

### 条件运算符(三目)

Java中的条件运算符是三目运算符

> 语法:
>
> 布尔表达式?表达式1:表达式2
>
> 当布尔表达式的值为true,则返回表达式1的值,否则返回表达式2的值
>

### 位运算符

| 符号 | 描述 | 运算规则                                                     |
| ---- | ---- | ------------------------------------------------------------ |
| &    | 与   | 两个位都为1时，结果才为1                                     |
| \|   | 或   | 两个位都为0时，结果才为0                                     |
| ^    | 异或 | 两个位相同为0，相异为1                                       |
| ~    | 取反 | 0变1，1变0                                                   |
| <<   | 左移 | 各二进位全部左移若干位，高位丢弃，低位补0                    |
| >>   | 右移 | 各二进位全部右移若干位，对无符号数，高位补0，有符号数，各编译器处理方法不一样，有的补符号位（算术右移），有的补0（逻辑右移） |

```css
与运算：
0&0=0  0&1=0  1&0=0  1&1=1

总结：两位同时为1，结果才为1，否则结果为0。
```

```css
或运算：
0|0=0  0|1=1  1|0=1  1|1=1

总结：参加运算的两个对象只要有一个为1，其值为1。
```

```css
异或运算：
0^0=0  0^1=1  1^0=1  1^1=0

总结：参加运算的两个对象，如果两个相应位相同为0，相异为1。
```

```css
取反运算：
~1=0
~0=1

总结：对一个二进制数按位取反，即将0变1，1变0。
```

```css
左移运算符（<<）

定义：将一个运算对象的各二进制位全部左移若干位（左边的二进制位丢弃，右边补0）。

设 a=1010 1110，a = a<< 2 将a的二进制位左移2位、右补0，即得a=1011 1000。

若左移时舍弃的高位不包含1，则每左移一位，相当于该数乘以2。
```

```css
右移运算符（>>）

定义：将一个数的各二进制位全部右移若干位，正数左补0，负数左补1，右边丢弃。

例如：a=a>>2 将a的二进制位右移2位，左补0 或者 左补1得看被移数是正还是负。

操作数每右移一位，相当于该数除以2。
```
```css
复合赋值运算符

位运算符与赋值运算符结合，组成新的复合赋值运算符，它们是：

&=    	例：a&=b  	相当于   a=a&b
|=    	例：a|=b  	相当于   a=a|b
>>=   	例：a>>=b  	相当于   a=a>>b
>><<=   例：a<<=b`    相当于   a=a<<b
>>^=    例：a^=b 	 	相当于   a=a^b

不同长度的数据进行位运算：如果两个不同长度的数据进行位运算时，系统会将二者补0按右端对齐，然后进行位运算。
```

## 流程控制

### 条件判断语句

> if语句、if-else语句、switch语句；
>

```java 
switch(表达式){
    case 常量表达式1:
        语句1; 
        break;
    case 常量表达式2:
        语句2;
        break;
    default:
        语句3;
}
```

### 循环执行语句

> do while语句、while语句、for语句；
>

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

### 转向语句

> break语句、continue语句、return语句
>
> break：跳出本层循环，本层循环语句结束
>
> continue：跳过本次循环中continue语句后尚未执行的语句，接着进行下一次循环条件的判断。 
>
> return：从当前方法（函数）退出，并返回一个值
>
> - 面向对象的语言叫方法
>
>   面向过程的语言叫函数
>

### 补充：结构体（C语言）

> C 数组允许定义可存储相同类型数据项的变量，**结构**允许存储不同类型的数据项。
>

```c
struct Books
{
   char  title[50];
   char  author[50];
   char  subject[100];
   int   book_id;
} book = {"C 语言", "RUNOOB", "编程语言", 123456};
 
int main()
{
    printf("title : %s\nauthor: %s\nsubject: %s\nbook_id: %d\n", book.title, book.author, book.subject, book.book_id);
}
```

```c
struct Books
{
   char  title[50];
   char  author[50];
   char  subject[100];
   int   book_id;
};
/* 函数声明 */
void printBook( struct Books book );
int main( )
{
   struct Books Book1;        /* 声明 Book1，类型为 Books */
   struct Books Book2;        /* 声明 Book2，类型为 Books */
   /* Book1 详述 */
   strcpy( Book1.title, "C Programming");
   strcpy( Book1.author, "Nuha Ali"); 
   strcpy( Book1.subject, "C Programming Tutorial");
   Book1.book_id = 6495407;
   /* Book2 详述 */
   strcpy( Book2.title, "Telecom Billing");
   strcpy( Book2.author, "Zara Ali");
   strcpy( Book2.subject, "Telecom Billing Tutorial");
   Book2.book_id = 6495700;
   /* 输出 Book1 信息 */
   printBook( Book1 );
   /* 输出 Book2 信息 */
   printBook( Book2 );
   return 0;
}
void printBook( struct Books *book )
{
   printf( "Book title : %s\n", book->title);
   printf( "Book author : %s\n", book->author);
   printf( "Book subject : %s\n", book->subject);
   printf( "Book book_id : %d\n", book->book_id);
}
```

## 数组

> 数组是相同类型的数据按顺序组成的一种引用数据类型

### 一维数组

#### 数组声明

> 语法格式:
>
> 1. 数据类型[] 数组名;
>
> 2. 数据类型 数组名[];

```java
int[] myIntArray;

int mylntArray[];
```

#### 数组创建

1. 语法格式一:先声明后创建数据类型口数组名;

```java
数组名= new数据类型[数组长度]

int[] arr;

arr=new int[10];

创建一个长度为10的整型数组
```

2. 语法格式二:声明的同时创建数组

```java
数据类型口数组名= new 数据类型[数组长度];

int[] arr=new int[10];

创建长度为10的整型数组arr
```

**注意:数组长度必须指定**

#### 数组初始化

> 声明数组的同时给数组赋值,叫做数组的初始化。
>
> 例:int[] arr=(1,2,3,4,5,6,7,8,9,10;
>
> 数组的长度就是初始化时所给数组元素的个数 

#### 数组元素引用

![04D75CBB-431B-47C5-82CB-C4DF4D770FC4](https://tva1.sinaimg.cn/large/007S8ZIlly1gg98t0f3hlj30ff04f3zu.jpg)

#### 数组长度

> int[] a=(1,2,3,4,5,6,7,8,9,10);
>
> 属性length表示数组的长度,如a.length

### 二维数组

#### 二维数组的创建

1. 先声明后创建

数组名 = new 数据类型 \[行][列];

```java
//创建一个三行三列的int类型的数组
//声明int类型的二维数组(先声明,后创建)
int[][] intArray;
intArray=new int[3][3]
```

2. 声明数组的同时创建

```java
//创建一个三行三列的int类型的数组
int[][] intArray=new int[3][3];
创建数组时，可以只指定行数，如：
float[][] floatArray=new float[3][];
这时候列数并没有指定,每行相当于一个一维数组,需要分别创建。
floatArray[0]=new float[3);//第一行有三列floatArray[1]=new float[4];//第二行有四列floatArray[2]=new float[5]://第三行有5列
每一行的数据数量是可以不相同的。
```

#### 数组元素引用

> 与一维数组相似,行列的index值均从0开始。
>
> 如:已知一个三行三列的整型二维数组intArray ,它的第三行第二列元素表示为intArray\[2][1].

#### 数组初始化

> 与一维数组类似,创建的同时为数组元素赋值,即为数组初始化。
>
> 如: inti[]\[] num={{12,3},{4,5,6},{7,8,9}};
>
> 创建了一个三行三列二维数组。num\[1][2]的值为6

#### #### 数组的遍历

```java 
//初始化一个二维数组
int[][] num1 = {{78,98},{65,75,63}{98}};
//循环输出二维数组的内容
for(int i=0;i<numl.length;i++){
    for(intj=0;j <num1[i].length;j++){
        System.out.print(num1[i][j]+" ");
    }
    System.out.printin();
}
```

## 方法

### 方法声明

语法格式：

```java
访问修饰 符返回类型 方法名(参数列表){
    方法体;
}
```

### 方法重载

> 方法名相同，参数列表不同

### 可变参数列表

> **可变参数：适用于参数个数不确定，类型确定的情况，java把可变参数当做数组处理。**

（1）只能出现在参数列表的最后； 一个参数列表中至多有一个可变参数！可变参数的实参可以为0个或任意多个。

（2）... 位于变量类型和变量名之间，前后有无空格都可以；

（3）调用可变参数的方法时，编译器为该可变参数隐含创建一个数组，在方法体中以数组的形式访问可变参数。

```java
public static void main(String[] args) {
    System.out.println(add(2, 3));
    System.out.println(add(2, 3, 5));
}
public static int add(int x, int... args) {
    int sum = x;
    for (int i = 0; i < args.length; i++) {
        sum += args[i];
    }
    return sum;
}
```

## 命名规范

### 命名法

小驼峰式命名法（lower camel case）：

> 第一个单字以小写字母开始；第二个单字的首字母大写，例如：firstName、lastName，也被称为Camel命名法。

大驼峰式命名法（upper camel case）：

> 每一个单字的首字母都采用大写字母，例如：FirstName、LastName、CamelCase，也被称为Pascal命名法。

匈牙利标记法

> 在以Pascal标记法的变量前附加小写序列说明该变量的类型。如：intDocCount

### 包
> 包名命名,所有字母都应该小写。
>
> 互联网上的域名称是不会重复的，所以多数开发人员
> 用互联网上的域名称作为自己程序包的唯一前缀。例如： com.imoc.base.*.*.类

个人项目包的命名：

>  a) indi ：个体项目，指个人发起，但非自己独自完成的项目，可公开或私有项目， 版权主要属于发起者。
>
> 例如：包名为 indi.发起者名.项目名.模块名*....* 
>
> b) pers ：个人项目，指个人发起，独自完成，可分享的项目，版权主要属于个人。 
>
> 例如：包名为 pers.个人名.项目名.模块名*...*  
>
> c) priv ：私有项目，指个人发起，独自完成，非公开的私人使用的项目，版权属于个人。
>
> 例如：包名为 priv.个人名.项目名.模块名*...* 例如：

团队项目包的命名

>  a) team： 团队项目指由团队发起，并由该团队开发的项目，版权属于该团队所 有。
>
> 例如：包名为 team.团队名.项目名.模块名*...* 
>
> b) com：公司项目：由项目发起的公司所有。
>
> 例如：包名为 com.公司名.项目名.模块名...

### 类

> 类名命名,所有单词的首字母大写。
>
> 符合大驼峰命名法（pascal）。

### 方法名

> 首字母小写,如果是由多个单词组成的话,第一个单词的首字母小写,其余的单词首字母应大写。
>
> 符合小驼峰命名法（camel）。

### 变量名

> 使用匈牙利标记法，基本结构为：typeVaribleName， 它使用 1-3 字符前缀来表示数据类型，3 个字符的前缀必须小写，前缀后面是由表意性强的一个单词或多个单词组成的名字，符合大驼峰命名。
>
> 如：记录文档数量: intDocCount

# 面向对象

## 简介

**万物皆对象、客观存在的事物**

> 对象：用来描述客观事物的一个实体,由一组属性和方法构成
>
> 面向对象：人关注对象；人关注事物信息
>
> 类：类是模子,确定对象将会拥有的特征(属性)和行为(方法)

**面向对象五个基本原则**(SOLID）

SRP：单一责任原则

OCP：开放封闭原则

LSP：里氏替换原则

DIP：依赖倒置原则

ISP：接口分离原则

```css
单一职责原则：

一个类,应该有且只有一个引起变化的原因，即把不同的变化原因,封装到不同的类中。
```

```css
开放封闭原则：

开放接口，封闭修改
```

```css
里氏替换原则：
    
派生类型（子类）必须能够替换掉它们的基类型（父类）。
Sub extends Base;
对于所有使用基类的方法：
    method(Base b);
对于每一个派生类，可以这样使用:
	method(new Sub());
但反之则不行，定义：
    method(Sub b);
不可以这样使用：
    method(new Base())
```

> ```css
> 依赖倒置原则：
> 
> 主要作用是解耦，让对象与对象之间松耦合。
> 高层模块不应该依赖底层模块，他们都应该依赖抽象。抽象不应该依赖于细节，细节应该依赖于抽象。
> ```
>
> `Dao`类通过调用`MysqlConnection`类的`executeQuery`方法执行`sql`语句
>
> ![37009FE0-47D6-44DA-B6DE-EDE24CBF846E](https://tva1.sinaimg.cn/large/007S8ZIlly1gga7njttlyj30ce0320ti.jpg)
>
> 这里就违反了依赖倒置原则，高层模块`DAO`强耦合了底层模块`MysqlConnection`。如果系统需要更换数据库为`SqlServer`，我们就不得不去修改`Dao`类，增加一个`SqlserverConnection`类，这又违反了面向对象设计的开闭原则。例子中的`Dao`是一个不稳定、随时会因为底层模块的变更而出现BUG的类。
>
> ![A99823E5-0EE4-440D-BBE6-0121E1B3B41E](https://tva1.sinaimg.cn/large/007S8ZIlly1gga7p1ptlej30bn077myk.jpg)修改后的`Dao`类依赖于`Connection`抽象接口，`MysqlConnection`类也以实现接口的方式依赖于`Dao`类。这时如果要更换为`SqlServer`数据库，只要增加一个`SqlserverConnection`类并实现`Connection`接口就完成了，不需要去修改`Dao`类了，大大的降低了耦合度。

```
接口分离原则：

尽量将臃肿庞大的接口拆分成更小的和更具体的接口，让接口中只包含客户感兴趣的方法。

单一职责原则注重的是职责，而接口隔离原则注重的是对接口依赖的隔离。
单一职责原则主要是约束类，它针对的是程序中的实现和细节；接口隔离原则主要约束接口，主要针对抽象和程序整体框架的构建。
```

## 类和对象

**类**

> - 类是对象的类型
>
> - 具有相同属性和方法的一组对象的集合
>
> 属性:对象具有的各种静态特征-----"有什么"
>
> 方法:对象具有的各种动态行为-----“能做什么"
>
> 类是抽象的概念,仅仅是模板

**对象**

> 是一个你能够看得到、摸得着的具体实体

**类和对象的关系**

> 类是对象的类型
>
> **对象**是特定类型的**数据**
>
> 具体开发过程中，先定义类再实例化对象

## 对象内存存储

![611C69DF-AC9E-40B4-A6B0-BC8B5D88A3D5](https://tva1.sinaimg.cn/large/007S8ZIlly1gga4pipz0cj30uy099wj5.jpg)

对象必须被实例化之后才能使用

对象间的引用传递,实际上传递的是堆内存空间的使用权

## 构造方法

只能在对象实例化的时候调用

> 构造方法的语句格式:
>
> <img src="https://tva1.sinaimg.cn/large/007S8ZIlly1gga50h0qfgj30ai05bgn2.jpg" alt="F70D2D03-194F-4DB0-8735-62A539AF7ADA" style="zoom: 67%;" align="left"/>
>
> 当没有指定构造方法时,系统会自动添加无参的构造方法
>
> 当有指定构造方法,无论是有参、无参的构造方法,都不会自动添加无参的构造方法
>
> 一个类中可以有多个构造方法

## 封装

> 将类的某些信息隐藏在类内部,不允许外部程序直接访问
>
> 通过该类提供的方法来实现对隐藏信息的操作和访问
>
> 隐藏对象的信息
>
> 留出访问的接口

![2333D26E-2866-46FD-9E9D-0436206AC7C2](https://tva1.sinaimg.cn/large/007S8ZIlly1gga80nqo6wj30d908tmzq.jpg)

## 包

**作用**

> 1、管理Java文件
>
> 2、解决同名文件冲突

**语法**

> package 包名:
>
> 例: package  com.imooc.animal;
>
> 注意:
>
> - 必须放在Java源文件中的第一行
>
> - 一个Java源文件中只能有一个package语句
>
> - 包名全部英文小写
>
> - 命名方式：域名倒序+模块+功能

**注意**

> 命名：包名一般为小写,而类名的第一个字母一般为大写,这样在引用时,可以明显的分辨出包名和类名。如果在类的定义之前没有使用package定义包名,那么该类就属于缺省的包。
>
> 使用了包机制后,如果在一个类中使用了其他包中的类,需要使用import来引入。

## 导包

**语法**

> import包名.类名;
>
> 导入包中全部类：import com.imooc.*;
>
> - 导入此包的类，而不包含子包的类
>
> 导入包中指定类：import com.imooc.animal.Cat;
>
> import语句在所有类定义之前,在package定义之后。import只告诉编译器及解泽器哪里可以找到类、变量、方法的定义,而并没有将这些定义引入代码中。
>
> 如果import引入的不同的包中包含有相同的类名那么这些类的使用必须加上包名。

**常用系统包**

> java.lang：包含java语言基础的类
>
> - java.lang不需要导入
>
> - java中底层加载的时候就用java.lang
>
> java.util：包含java语言中各种工具类
>
> java.io：包含输入、输出相关功能的类
>
> java.awt：包含用于创建图形用户界面（GUI）和绘制图形图像的所有分类

## 注解

> 注解的本质就是一个继承了 Annotation 接口的接口

**注解的分类**

![44706FF7-E716-44C6-8C61-59A884D9C956](https://tva1.sinaimg.cn/large/007S8ZIlly1ggagymnqcyj30hj06wdig.jpg)

**元注解**

元注解是用于修饰注解的注解，通常用在注解的定义上

元注解一般用于指定某个注解生命周期以及作用目标等信息。如：

```java
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.SOURCE)
public @interface Override {
}
```

**JAVA 中有以下几个--元注解：**

- @Target：注解的作用目标

> 指明注解是用来修饰方法的？修饰类的？还是用来修饰属性的。

- @Retention：注解的生命周期
- @Documented：注解是否应当被包含在 JavaDoc 文档中
- @Inherited：是否允许子类继承该注解

**JAVA 的内置三大注解**

- @Override：重写

> 它没有任何的属性，所以并不能存储任何其他信息。它只能作用于方法之上，编译结束后将被丢弃。

- @Deprecated：不推荐使用

> 永久存在，可以修饰所有的类型，作用是标记当前的类或者方法或者属性等已经不再被推荐使用了

- @SuppressWarnings：压制 java 的警告

> 它有一个 value 属性需要你主动的传值，这个 value 代表的就是需要被压制的警告类型。既不再产生警告
>
> ```java
> @SuppressWarning(value = "deprecated")
> public static void main(String[] args) {
>  Date date = new Date(2018, 7, 11);
> }
> ```

## 继承

> 类：单继承，多实现（接口）
>
> 接口：多继承接口

### 简介

一种类与类之间的关系

使用已存在的类的定义作为基础建立新类

新类的定义可以增加新的数据或新的功能,也可以用父类的功能,但不能选择性地继承父类

父类：基类

子类：派生类

使用extends实现继承

### 方法重写&重载

![4719E49E-F23E-40A2-8F6A-B9946A0A6D8E](https://tva1.sinaimg.cn/large/007S8ZIlly1ggahf83y4dj30in06gtbd.jpg)

### 访问修饰符

> 默认：default

![5F2A632C-E952-4B50-A2C7-B961950F0968](https://tva1.sinaimg.cn/large/007S8ZIlly1ggadoikmnvj30ab03jmy4.jpg)

### 实例化顺序

![BDAC0C83-4D84-44BE-9B41-26B8B906B013](https://tva1.sinaimg.cn/large/007S8ZIlly1ggahd9qeftj30dt0663zy.jpg)

> 对象构造：属性(赋值)、构造代码块、构造方法

## Object类

### 简介

Object类是所有类的父类

一个类没有使用extends关键字明确标识继承关系,则默认继承Object类(包括数组)

Java中的每个类都可以使用Object中定义的方法

### Object类的常用方法

![E3D79569-E93C-4427-83E1-22F67BF87A04](https://tva1.sinaimg.cn/large/007S8ZIlly1ggagt39jpoj30fb05qtbq.jpg)

## 多态

### 简介

> 多态( Polymorphism )按字面的意思就是"多种状态" ,是面向对象的程序设计语言最核心的特征。
>
> 从一定角度来看,封装和继承几乎都是为多态而准备的。

如：现实中,动物们都有吃东西,跑,跳,叫的方法,不同的动物表现方式不同

### 多态的分类

1、编译时多态(设计时多态) :方法重载。

2、运行时多态: JAVA运行时系统根据调用该方法的实例的类型来决定选择调用哪个方法则被称为运行时多态。

我们平时说得多态,多指运行时多态

> 一个引用变量倒底会指向哪个类的实例对象,该引用变量发出的方法调用到底是哪个类中实现的方法,必须在由程序运行期间才能决定。

### 详述

#### 多态必要条件

> 满足继承关系
>
> 父类引用指向子类对象

#### 向上转型( Upcast ) 

> 将子类型转换为父类型
>
> - Animal a = new Dog();  //所有狗狗都是动物
>
> 隐式/自动类型转换,是小类型到大类型的转换
>
> 对于向上的类型转换,不需要显示指定,即不需要加上前面的小括号和父类类型名

注意：

> （1）当一个子类对象向上转型父类类型以后,就被当成了父类的对象,所能调用的方法会
> 减少,只能调用子类重写了父类的方法以及父类派生的方法(如set(), get()方法)而不能调用子类独有的方法。
>
> （2）父类中的静态方法是不允许被子类重写的。
>
> - 如父类 Pen 中含有静态方法 draw( ) ，当子类 Pencil 中也定义同名方法时，此时 draw( )算 Pencil 类自己独有的方法。
>
> ```java
> public static void draw(){
>     System.out.println("笔可以用来画画");
> }
> public static void draw(){
>     System.out.printIn("铅笔用来素描");
> }
> Pen pc=new Pencil();//向上转型
> pc.draw();
> 
> 返回结果为:
> 笔可以用来画画
> ```

#### 动态绑定

多态的实现可以通过向上转型和动态绑定机制来完成,向上转型实现了将子类对象向上转型为父类类型,而动态绑定机制能识别出对象转型前的类型,从而自动调用该类的方法,两者相辅相成。

绑定就是将一个方法调用同一个方法所在的类连接到一起就是绑定。绑定分为静态绑定和动
态绑定两种。

静态绑定:在程序运行之前进行绑定(由编译器和链接程序完成的),也叫做前期绑定。

```java
Chinese c =new Chinese();
c. speak();
American a =new American();
a. speak();
British b =new British();
b.speak();

这种调用方式是在代码里指定的,编译时编译器就知道c调用的是Chinese的speak( ),a
调用的是American的speak()。
```

动态绑定:在程序运行期间由JVM根据对象的类型自动的判断应该调用哪个方法,也叫做
后期绑定。

```java
//生成父类对象数组,数组长度为5
Human[] human=new Human[5];
int n;
for(int i=0;i<human.length;i++){
    n=(int) (Math.random() *3);//随机产生从0到2中一个数
    switch(n){
        case 0:human[i]=new Chinese(); break;
        case 1:human[i]=new American(); break;
        case 2:human[i]=new British(); break;
    }
}
//循环输出,循环体中每个对象分别调用speak()方法
for(int i=0;ik human .length; i++){ 
    human[i]. speak();
}

此时, Human类中随机生成Chinese类、American类和British类的对象,编译器不能根据代码直接确定调用哪个类中的speak( )方法,直到运行时才能根据产生的随机数n的值来确定humant[i]到底代表哪一个子类的对象,这样才能最终确定调用的是哪个类中的speak()方法,这就是动态绑定。
```

#### 向下转型( Downcast ) 

> 将父类型转换为子类型。
>
> - Dog d = (Dog) new Animal();
>
> 将一个指向子类对象的父类引用赋值给一个子类的引用
>
> 强制类型转换,是大类型到小类型
>
> 父类型的引用必须指向转型的子类的对象,即指向谁才能转换成谁。不然也会编译出错

注意：

> 向下转型后,可以调用子类自己独有的方法。
>
> 兄弟类之间不能进行强制类型转换。
>
> ```java
> //父类Pen类派生出另一个子类Brush
> Pen b=new Brush();
> Pencil p=(Pencil)b;
> //Exception in thread "main" java.lang.classCastException:
> ```



#### 注意

> 通过instanceof运算符,来判断引用对象的类型,避免类型转换的安全性问题,提高代码的健壮性。
>
> 父类引用指向子类实例时,可以调用子类重写父类的方法以及直接继承父类的方法,无法调用子类特有的方法。
>
> 静态static方法属于特殊情况,静态方法只能继承,不能重写。调用的时候用谁的引用,则调用谁的静态方法。

## 抽象类

### 简介

Java中使用抽象类,限制实例化

```java
public abstract class Animal{}
```

### 应用场景

某个父类只是知道其子类应该包含怎样的方法,但无法准确知道这些子类如何实现这些方法。

```java
public abstract class Animal{
    public void eat(){
        ...
    }
}
代码问题：每个子类中的具体方法都应有不同的实现
```

### 抽象方法

抽象方法没有方法体

抽象方法必须在抽象类里

抽象方法必须在子类中被实现,除非子类是抽象类

```java
public abstract void eat();
```

### 抽象类&抽象方法

**使用规则**

1. abstract定义抽象类
2. 抽象类不能直接实例化,只能被继承,可以通过向上转型完成对象实例
3. abstract定义抽象方法,不需要具体实现
4. 包含抽象方法的类是抽象类
5. 抽象类中可以没有抽象方法
6. 子类如果没有重写父类所有的抽象方法,则也要定义为抽象类
7. abstract不能与static, final, private共存
8. 抽象方法在子类实现时访问权限必须大于等于父类方法

**抽象类的意义**

(1)为其子类提供一个公共的类型(父类引用指向子类对象)

(2)封装子类中的重复内容(成员变量和方法);

(3)将父类设计成抽象类后,既可借由父子继承关系限制子类的设计随意性,在一定程度上避免了无意义父类的实例化。

## 接口

### 简介

接口定义了某一批类所需要遵守的规范

接口不关心这些类的内部数据,也不关心这些类里方法的实现细节它只规定这些类里必须提供某些方法

### 语法

```java
[修饰符] interface 接口名[extends父接口1,父接口2..]
{
    零个到多个常量定义...
    零个到多个抽象方法的定义...
    零个到多个默认方法的定义...(jdk1.8新增) 
    零个到多个静态方法方法的定义...(jdk1.8新增)
}
```

### 语法规则

> 接口及接口成员默认的访问权限为: public或默认
>
> 常量默认添加 static final关键字
>
> 抽象方法默认添加abstract关键字
>
> 只有default方法及static方法可以添加方法体
>
> 实现接口的类如果不能实现所有接口中待重写的方法,则必须设置为抽象类
>
> 当一个类同时实现多接口,且其中同时具有相同方法时,实现类需重写该方法,否则会编译报错

## 接口&抽象类

### 概念比较

![C69097A5-B932-4A45-9EA7-6EE5C13B6EFB](https://tva1.sinaimg.cn/large/007S8ZIlly1ggdp9sq48ij30g80jsjz8.jpg)

### 代码比较

什么时候用接口？什么时候用抽象类？

> 如超人Superman类继承自父类People类, People类中除了包含超人,还包括一般人、蜘蛛侠、绿巨人等这时便可以将People类声明为一个抽象类。而超人Superman不仅是拥有People走路和跑步的功能,他还拥有一般人类没有的功能"飞",而很多东西都具有飞的功能,比如鸟飞、气球飞、飞机飞….这些东西都抽象不出来一个公共的父类,所以就将"飞"这个功能定义为一个接口,以便其它生物如鸟去调用飞的功能。
>
> - 既：一类相同类型且个体间有差异的事物使用抽象类，不能抽像出一个公共类的功能使用接口

```java
//接口: fly
public interface IFly { void fly();}
//父类: people类
public abstract class People {
    //声明抽象方法walk()和run()
    public abstract void walk();
    public abstract void run();}
//子类superman类
public class Superman extends People implements IFly{ 
    public void walk(){System.out.println("超人可以走路");}
    public void run(){System.out.println("超人可以奔跑");}
    public void fly(){System.out.println("超人可以飞");}
```

## 内部类

### 简介

> 在Java中,可以将一个类定义在另一个类里面或者一个方法里面,这样的类称为内部类
>
> 与之对应,包含内部类的类被称为外部类。
>
> 内部类提供了更好的封装,可以把内部类隐藏在外部类之内,不允许同一个包中的其他类访问该类,更好的实现了信息隐藏。

### 分类

#### 成员内部类

内部类中最常见的就是成员内部类,也称为普通内部类

```java
public class Person{
    int age://年龄
    public Heart getHeartot(){ return new Heart}:
    class Heart{public String beatit(){return 心在跳动;}}
}
//成员内部类实例化
Person.Heart heart = Person.new Heart();

```

> 内部类相当于外部类的一个成员变量,可以使用任意访问修饰符。
>
> 内部类中定义的方法可以直接访问外部类中的数据,而不受访问控制符的影响。
>
> 外部类不能直接使用内部类的成员和方法,需要借由内部类对象完成。
>
> 需要通过外部类对象来创建内部类实例。
>
> 如果外部类和内部类具有相同的成员,内部类默认优先访问自己的成员:可以通过"外部类.this.对象成员"以及“外部类.静态成员"的方式访问外部类成员。
>
> 编译后产生:外部类$内部类.class

#### 静态内部类

> 静态内部类对象可以不依赖于外部类对象,直接创建。
>
> 静态内部类不能直接访问外部类的非静态成员,但可以通过"外部类对象.成员"的方式访问。
>
> 外部类中可以通过“类名.成员名"的方式直接访问内部类中静态成员

```java
public class Person{
    int age://年龄
    public Heart getHeartot(){ return new Heart}:
    class Heart{public String beatit(){return 心在跳动;}}
}
//静态内部类实例化
Person.Heart heart = new Person.Heart();
```

#### 方法内部类

> 定义在外部类方法中的内部类，也称局部内部类。
>
> 方法内部类只在其定义所在的方法的内部可见,即只在该方法内可以使用。
>
> 方法内部类不能使用访问控制符和static修饰符,但可以使用final和abstract修饰。
>
> 编译后产生:外部类$数字+内部类.class

#### 匿名内部类

> 匿名子类声明和匿名子类对象创建同时进行

**概念：**

> 匿名内部类也就是没有名字的内部类
>
> 正因为没有名字,所以匿名内部类只能使用一次,它通常用来简化代码编写
>
> 但使用匿名内部类还有个前提条件:必须继承一个父类或实现一个接口

**适用场景:**

> 只用到类的一个实例
>
> 类在定义后马上用到
>
> 给类命名并不会导致代码更容易被理解

**注意：**

> 编译后的文件命名:外部类$数字. class
>
> 无法使用public, private, abstract. static修饰,匿名内部类不能出现抽象方法
>
> 无法编写构造方法,但可以添加构造代码块
>
> 不能出现静态成员
>
> 匿名内部类可实现接口也可以继承类,但是不可兼得
>
> 匿名内部类不能是抽象的,它必须要实现继承的类或者实现接口的所有抽象方法
>
> - 建立匿名内部类的关键点是重写或实现父类/接口的方法，而不是创建新的方法。因为用父类的引用不可能调用父类本身没有的方法,创建新的方法是多余的。

**初始化**

> 一般都是利用构造器来完成某个实例的初始化工作的,但是匿名内部类是没有构造器的,那怎么来初始化匿名内部类呢?使用构造代码块!利用构造代码块能够达到为匿名内部类创建一个构造器的效果。

```java
public interface InnerClass{
    public String getName();
    public int getAge();}

public class OutClass {
    public InnerClass getInnerClass (final int age,final string name){
        return new InnerClass() {
            int age_;
            string name_;
            //构造代码块完成初始化工作
            {
                if(0< age && age < 200){
                    age_ = age;
                    name_ = name;}
            }
            public string getName() { return name_;}
            public int getAge() { return age_;}
        }
    }
    public static void main(String[] args) { 
        OutClass out = new OutClass();
        InnerClass inner_1 = out.getInnerClass (201, "chenssy");
        System.out.println(inner_1.getName());
        InnerClass inner_2 = out.getInnerClass(23, "chenssy");
        System.out.println(inner_2.getName());
    }
}
```

**实例**

> 由下面三个例子可以看出,只要一个类是抽象的或是一个接口,那么其子类中的方法都可以使用匿名内部类来实现。最常用的情况就是在多线程的实现上,因为要实现多线程必须继承Thread类或是实现Runnable接口

继承式的匿名内部类:

```java
abstract class Car {
    public abstract void drive();
}
class Test{
    public static void main(String[] args) {
        Car car = new Car(){//匿名内部类
            public void drive(){ 
                System.out.println("Driving another car!");
            }
        };
        car.drive();
    }
}

注意：引用变量不是引用Car对象,而是Car匿名子类的对象
```

接口式的匿名内部类：

```java
interface Vehicle{ 
    public void drive();
}
class Test{
    public static void main(String[] args) {
        Vehicle v = new Vehicle(){
            public void drive(){ 
                System.out.println("Driving a car!");
            }
        };
        v.drive();
    }
}

注意：上面的代码很怪,好像是在实例化一个接口。事实并非如此,接口式的匿名内部类是实
现了一个接口的匿名类。而且只能实现一个接口。
```

参数式的匿名内部类:

```java
abstract class Bar{
    void doStuff(Foo f){}
}
class BarOne extends Bar{ 
    void dostuff(Foo f){}
}
interface Foo{ 
    void foo();
}
class Test{
    static void go(){
        Bar b = new BarOne();
        b.dostuff(new Foo(){ 
            public void foo(){
                System.out.println("foofy");
            }
        });
    }
}
```

Thread类的匿名内部类实现:

```java
public class Demo {
    public static void main(String[] args) { 
        Thread t=new Thread() {
            public void run() {
                for (int i=1; i <= 5; i++) {
                    System.out.print(i + " ");
                }
            }
        };
        t.start();
    }
}
```

Runnable接口的匿名内部类实现:

```java
public class Demo {
    public static void main(String[] args) { 
        Runnable r = new Runnable() {
            public void run() {
                for (int i =1; i <= 5; i++) {
                    System.out.print(i +" ");
                }
            }
        };
        Thread t = new Thread(r);
        t.start();
    }
}
```

### 接口中的内部类

> 在实际开发过程中,如果想要创建某些公共代码,使得它们可以被某个接口的所有不同实现所共用,那么接口内部的嵌套类会显得很方便。也就是说,在接口中可以含有内部类。

1. 首先创建接口,接口中定义了普通内部类InnerClass和抽象内部类AbInnerClass

```java
package com.imooc.inter;
//接口IOuterInterface
public interface IouterInterface {
    int TEMP=100; //常量
    void abMethod(); //抽象方法
    public default void deMethod(){ System.out.printIn("接口中默认方法");}
    public static void stMethod(){System.out.print1n("接口中静态方法");}
    //普通内部类
    public class InnerClasst{
        public void show(){
            System.out.println("接口中可定义普通成员内部类");
        }
    }
    //抽象内部类
    public abstract class AbInnerClassf{
        public abstract void abInfo();
        public void info(){
            System.out.printIn("接口中可定义抽象成员内部类");
        }
    }
}
```

2. 普通成员内部类的实例化

```java
--创建接口的实现类ClassDemo
package com.imooc.inter;
//实现类ClassDemo
public class ClassDemo implements IOuterInterface {
    @Override
    public void abMethod() {
        System.out.println("实现类");
    }
    //获取接口中内部类方法
    public InnerClass getInner(){ 
        return new InnerClass();
                                }
}

--获取普通内部类对象,调用方法
package com.imooc.test;
import com.imooc.inter.ClassDemo;
import com.imooc.inter. IOuterInterface;
import com.imooc.inter. IOuterInterface. InnerClass;
//测试类:普通成员内部类
public class Test {
    public static void main(String[] args) {
        /*第一种实例化对象方式:
		*通过接口名,类名进行实例化*/
        IOuterInterface. InnerClass inner=new IOuterInterface. InnerClass();
        inner.show();
        /*第二种实例化对象方式：
		*通过在实现类中创建接口中内部类获取方法
		*用实现类对象调用获取方法*/
        ClassDemo demo=new ClassDemo();
        demo.getInner().show();
        /*第三种实例化对象方式:
		*将内部类导入后,直接实例化*/
        InnerClass innerTwo = new InnerClass();
        innerTwo.show();
    }
}
```

3. 抽象成员内部类的实例化

```java
--创建接口的实现类AbClassDemo
package com.imooc.inter;
//实现类AbClassDemo
public class AbClassDemo implements IouterInterface {
    @override
    public void abMethod() {
    }
    //继承抽象类AbInnerClass
    public class AbDemo extends AbInnerClass{ 
        @Override
        public void abInfo() {
            System.out.println("重写接口фh象类фt象i法");
        }
    }
}

--获取抽象内部类对象,调用方法
package com.imooc.test;
import com.imooc.inter.AbClassDemo;
import com.imooc.inter.IOuterInterface;
//测试类:抽象成员内部类
public class TestOne {
    public static void main(String[] args) {
        /*第一种实例化对象方式
通过接口名,类名进行实例化
但是对于抽象类而言,不能直接实例化,所以这里可使用匿名内部类的方式*/
        IOuterInterface.AbInnerClass abInner=new IOuterInterface.AbInnerClass(){ public void abInfo(){
            system.out.println("重写抽象类中的抽象方法");
        }
                                                                               };
        abInner. abInfo();
        abInner.info();
        System.out.println("===============");
        /*第二种实例化方法:
*在实现类中定义内部类继承接口中的抽象内部类*/
        IOuterInterface.AbInnerClass abInnerOne=new AbClassDemo().new AbDemo();
        abInnerOne.abInfo();
        abInnerOne.info();
    }
}
```



# 关键字

## static

> 1. static+属性---静态属性
>
> 2. static+方法---静态方法
>
> 3. static+类---不存在
> 4. static+方法内局部变量---不存在
>
> 静态成员随类加载产生,直至类销毁才回收

**静态方法**

> 可以直接调用同类中的静态成员
>
> 不可以直接调用同类中的非静态成员
>
> 可以通过实例化对象后,对象调用的方式完成非静态成员调用

**代码块**

> 通过{}可以形成代码块
>
> 方法内的代码块称为:普通代码块
>
> 类内的代码块称为:构造代码块
>
> 构造代码块前+static :静态代码块

**代码块执行顺序**

> 静态代码块：
>
> - 无论实例产生多少对象,静态代码块只执行一次
> - 在main函数前执行
> - 这样可在类中写代码语句（调用对象及方法）
>
> 构造代码块随实例化过程调用
>
> 普通代码块随方法调用执行

## this

this的使用:在本类中

- 调用成员变量
- 调用成员方法
- 调用构造方法

> this:在类中就是代表当前对象,可以通过this关键字完成当前对象的成员属性、成员方法和构造方法的调用
>
> 当在定义类中的方法时,如果需要调用该类对象,就可以用this来表示这个对象。也就是说,但凡在本类功能内部使用到了本类对象,都用this表示。至于代表哪个对象,就看其所在功能被哪个对象调用,这样就知道谁在参与运算。
>
> ![D081D0C2-C8B8-40A8-869F-0521D17A3352](https://tva1.sinaimg.cn/large/007S8ZIlly1gga558gjphj30jb08fdjo.jpg)
>

```java
调用构造函数：

public thisTest() {
  System.out.println("我是无参构造");
}
public thisTest(String name) {
  this();//必须是构造方法第一条语句，调用被重载的（既无参）构造方法；如过this（arg），则调用相同形参的构造函数
  this.name=name;
  System.out.println("我是单参构造");
}
```

## super

super的使用:在子类中

- 调用父类成员变量
- 调用父类成员方法
- 调用父类构造方法

> 访问父类成员方法
>
> ```java
> super.print();
> ```
>
> 访向父类成员变量（属性）
>
> ```java
> super.name;
> ```
>
> 访向父类构造方法
>
> ```java
> super();//根据形参不同确定调用哪个构造函数
> 
> public Son() {
>         super();  //此时调用父类无参构造方法。其实这里不写super()也可以起到同样的作用，因为Java在调用子类构造方法时默认调用父类的无参构造方法，不过这两种可行的前提是父类中还留有无参构造方法。
>         System.out.println("Son的无参构造方法");
>     }
> ```

**子类的构造的过程中必须调用其父类的构造方法**

> 如果子类的构造方法中没有显示调用父类的构造方法,则系统系默认调用父类无参的构造方法
>
> 如果子类构造方法中既没有显式调用父类的构造方法,而父类又没有无参的构造方法,则编译出错
>
> 使用super调用父类指定构造方法,必须在子类的构造方法的第一行

## super&this

![D9ED3751-4F9F-41EE-A1A5-20C080F5EC8C](https://tva1.sinaimg.cn/large/007S8ZIlly1ggaghrtd74j30hw06swie.jpg)

> 构造方法调用时, super和this不能同时出现（隐式调用了super（），既调用了父类无参构造时可以）

## final

**使用final修饰可以提高性能,但会降低可扩展性**

1.修饰变量  

> final变量经常和static关键字一起使用，作为常量。
>
> final修饰基本数据类型的变量时，必须赋予初始值且不能被改变，修饰引用变量时，该引用变量不能再指向其他对象

2.修饰方法

> final也可以声明方法。方法前面加上final关键字，代表这个方法不可以被子类的方法重写。如果你认为一个方法的功能已经足够完整了，子类中不需要改变的话，你可以声明此方法为final。final方法比非final方法要，因为在编译的时候已经静态绑定了，不需要在运行时再动态绑定。

3.修饰类

> 使用final来修饰的类叫作final类。final类通常功能是完整的，它们不能被继承。Java中有许多类是final的，譬如String, Interger以及其他包装类。

## instanceof 

> instanceof 是 Java 的一个二元操作符。
>
> instanceof 是 Java 的保留关键字。它的作用是测试它左边的对象是否是它右边的类的实例，返回 boolean 的数据类型。

```java
if (o instanceof Vector)
      System.out.println("对象 o 是 java.util.Vector 类的实例");
```

```java
//父类Parents类, Father类和Mother类分别为它的两个子类
//对象实例化
Parents f=new Father();
Parents m=new Mother();
//用instanceof运算符判断对象是否满足某个特定对象实例特征
System.out.println(m instanceof Father);
System.out.println(m instanceof Mother);
System.out.println(m instanceof Object);
System.out.println(f instanceof Father);

运行结果为:
false
true
true
true
注:java中所有类都直接或间接继承于Object类。
```






