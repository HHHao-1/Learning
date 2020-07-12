# Java语法

1.截取字符串

> substring() 方法返回字符串的子字符串。
>
>
> public String substring(int beginIndex)
>
> public String substring(int beginIndex, int endIndex)
>
> 参数：
>
> beginIndex -- 起始索引（包括）
>
> endIndex -- 结束索引（不包括）

```java
//获取文件名
String realName="F:/and/name.txt";
String extension = realName.substring(realName.lastIndexOf('/'),realName.indexOf("."));
String truename = extension.replace("/", "");
System.out.println(truename);// name
```

2. String和Date相互转换

``` java
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String dateStr = sdf.format(new Date()));
        
Date date = null;
try {
    // 注意格式需要与上面一致，不然会出现异常
    date = sdf.parse("2005-12-15 15:30:23");
} catch (ParseException e) {
    e.printStackTrace();
}
System.out.println("字符串转换成时间:" + date);
}
```

3. String[] args

> String[] args是main函数的形式参数,可以用来获取命令行用户输入进去的参数
>
> args是arguments的缩写默认名

```java
public class test {
  public static void main(String[] args) {
    for (int i = 0; i < args.length; i++) {
      System.out.println(args[i]);}}}
```

```js
➜  java测试 java test.java 测试1 测试2
测试1
测试2
```

4. 类实现序列化

```java
//作用：给实体增加一个持久化的能力
public class User implements Serializable {}
```

5. 输入接收

```java
Scanner sc = new Scanner(System.in)
sc.close()
```

6. 标签

```java
loop1: for(;;) {
   inner: for(;;) {
     break loop1;
   }
}

for循环中的loop是continue和break的标记，可以在for前面写任意的标记；∑
比如loop1，loop2，在循环中可以break loop1；continue loop1
```

7. jpcap

java自带的类库能够实现网络层及以上层次的编程，但是对于数据链路层无能为力。jpcap是一个能够帮助java程序实现对数据链路层操作的jar包。值得一提的是，jpcap是基于winpcap或者libpcap的，winpcap是windows系统的，而libpcap是linux系统的（包括ubuntu等衍生系统），jpcap是中间部件，通过调用winpcap/libpcap的方法实现对网卡的操作。java通过使用jpcap屏蔽了底层系统的差异。

8. IKVM.NET

基于.NET的Java虚拟机，我们可以让Java程序跑在.NET上，可以通过虚拟机这个中介让Java程序和.NET应用程序一起协同工作。更难能可贵的是，IKVM同时支持微软的.NET Framework 和 Mono。

Mono：

# Java Web

1. 获取路径

> 工程名为TEST为例：
>
> (1)得到包含工程名的当前页面全路径：request.getRequestURI()
> 结果：/TEST/test.jsp
>
> (2)得到工程名：request.getContextPath()
> 结果：/TEST
>
> (3)得到当前页面所在目录下全名称：request.getServletPath()
> 结果：如果页面在jsp目录下 /TEST/jsp/test.jsp
>
> (4)得到页面所在服务器的全路径：application.getRealPath("页面.jsp")
> 结果：D:\resin\webapps\TEST\test.jsp
>
> (5)得到页面所在服务器的绝对路径：absPath=new java.io.File(application.getRealPath(request.getRequestURI())).getParent();
> 结果：D:\resin\webapps\TEST
