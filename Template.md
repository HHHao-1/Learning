# 简介 

**概述**

模板引擎是一种基于模板和要改变的数据， 并用来生成输出文本(HTML网页，电子邮件，配置文件，源代码等)的通用工具。在模板中，你可以专注于如何展现数据， 而在模板之外可以专注于要展示什么数据。

**Thymeleaf与FreeMarker比较**

1. Thymeleaf（Html里写模板）

```css
优点：

静态html嵌入标签属性，浏览器可以直接打开模板文件，便于前后端联调

动静结合
Thymeleaf 在有网络和无网络的环境下皆可运行，即它可以让美工在浏览器查看页面的静态效果，也可以让程序员在服务器查看带数据的动态页面效果。这是由于它支持 html 原型，然后在 html 标签里增加额外的属性来达到模板+数据的展示方式。浏览器解释 html 时会忽略未定义的标签属性，所以 thymeleaf 的模板可以静态地运行；当有数据返回到页面时，Thymeleaf 标签会动态地替换掉静态内容，使页面动态显示。

与SpringBoot完美整合
SpringBoot提供了Thymeleaf的默认配置，并且为Thymeleaf设置了视图解析器，我们可以像以前操作jsp一样来操作Thymeleaf。代码几乎没有任何区别，就是在模板语法上有区别。
```

```css
缺点

模板必须符合xml规范

js脚本必须加入/*<![CDATA[*/标识，否则一个&符号就会导致后台模板合成抛异常，而且错误信息巨不友好，害得我调试了好几个小时才明白是怎么回事。

js里面还好办，这样是在html里面含有&等符号，还需要转义？忒麻烦了！Thymaleaf的自定义方法较难实现完美的数据转换
```

2. FreeMarker（模板里写Html）

```css
优点：

严格的 MVC (模型 视图 控制器) 模式
宏的强大和自定义节点转换方法函数适合特殊、复杂数据的转化
```

```css
缺点
前后端联调不方便
```

# Tymeleaf 

## 快速使用

**我们的表达式写在一个名为：th:text的标签属性中，这个叫做指令**

```html
<!-- 引入命名空间前缀 -->
<html lang="en" xmlns:th="http://www.thymeleaforg">
<!-- 取值：先在request中找，然后session，再servlet context -->
<body>
  <h1 th:text="${msg}">test</h1>
</body>
```

```java
// 后台model将数据写入request
@GetMapping("test2")
public String test2(Model model){
    User user = new User();
    user.setAge(21);
    user.setName("Jackson");
    user.setFriend(new User("李小龙", 30));
    model.addAttribute("user", user);
    return "hello2";
}
```

```java
 String msg = "<h1>啦啦啦</h1>";
```

```html
th:text与th:utexte区别
<!-- 用th:text不会解析html，用th:utext会解析html，在页面中显示相应的样式 -->
 <p th:text="采用text标签： + ${msg}"></p>
<!-- 采用text标签：<h1>啦啦啦</h1> -->
 <p th:utext="采用utext标签： + ${msg}"></p>
<!-- 采用utext标签：
     啦啦啦 -->
```

## 语法

**变量（取值）、方法、条件判断、循环、运算、逻辑运算、布尔运算、比较运算、条件运算、其它**

```html
变量
<!-- 
如果不支持这种th:的命名空间写法，那么可以把th:text换成 data-th-text
获取变量值，我们使用的是经典的对象.属性名方式。
有些情况下，我们的属性名可能本身也是变量：例如：${user.name} 可以写作${user['name']}
 -->

变量_自定义变量
<h2>
    <p>Name: <span th:text="${user.name}">Jack</span>.</p>
    <p>Age: <span th:text="${user.age}">21</span>.</p>
    <p>friend: <span th:text="${user.friend.name}">Rose</span>.</p>
</h2>
<!-- 我们获取用户的所有信息，分别展示。
当数据量比较多的时候，频繁的写user.就会非常麻烦。因此，Thymeleaf提供了自定义变量来解决 -->
<h2 th:object="${user}">
    <p>Name: <span th:text="*{name}">Jack</span>.</p>
    <p>Age: <span th:text="*{age}">21</span>.</p>
    <p>friend: <span th:text="*{friend.name}">Rose</span>.</p>
</h2>
<!-- 首先在 h2上 用 th:object="${user}"获取user的值，并且保存
然后，在h2内部的任意元素上，可以通过 *{属性名}的方式，来获取user中的属性，这样就省去了大量的user.前缀了 -->

方法

方法_拼接
<span th:text="'欢迎您:' + ${user.name} + '!'"></span>
<!-- 字符串字面值需要用''，拼接起来非常麻烦，Thymeleaf对此进行了简化，使用一对|即可： -->
<span th:text="|欢迎您:${user.name}|"></span>

方法调用
<!-- ognl表达式本身就支持方法调用 -->
<h2 th:object="${user}">
    <p>FirstName: <span th:text="*{name.split(' ')[0]}">Jack</span>.</p>
    <p>LastName: <span th:text="*{name.split(' ')[1]}">Li</span>.</p>
</h2>
<!-- 这里我们调用了name（是一个字符串）的split方法。 -->

方法——内置对象：后面

运算
<span th:text="${user.sex} ? '男':'女'"></span>

循环
<tr th:each="user : ${users}">
    <td th:text="${user.name}">Onions</td>
    <td th:text="${user.age}">2.41</td>
</tr>
<tr th:each="user,stat : ${users}">
    <td th:text="${user.name}">Onions</td>
    <td th:text="${user.age}">2.41</td>
</tr>
<!-- 
stat对象包含以下属性：
index，从0开始的角标
count，元素的个数，从1开始
size，总元素个数
current，当前遍历到的元素
even/odd，返回是否为偶/奇，boolean值
first/last，返回是否为第一或最后，boolean值 
-->

逻辑判断if
<!-- 使用th:if 或者 th:unless ，两者的意思恰好相反。 -->
<!-- 如果表达式的值为true，则标签会渲染到页面，否则不进行渲染。 -->
<span th:if="${user.age} > 24">老油条</span>

分支控制switch
<!-- 需要注意的是，一旦有一个th:case成立，其它的则不再判断。与java中的switch是一样的。 -->
<!-- 另外th:case="*"表示默认，放最后。 -->
<div th:switch="${user.role}">
  <p th:case="'admin'">用户是管理员</p>
  <p th:case="'manager'">用户是经理</p>
  <p th:case="*">用户是别的玩意</p>
</div>

JS模板
<!-- 模板引擎不仅可以渲染html，也可以对JS中的进行预处理。为在纯静态环境下可以运行，Thymeleaf代码可被注释起来 -->
<!-- 在script标签中通过th:inline="javascript"来声明这是要特殊处理的js脚本 -->
<script th:inline="javascript">
    const user = /*[[${user}]]*/ {};
    const age = /*[[${user.age}]]*/ 20;
    console.log(user);
    console.log(age)
</script>
<!-- 语法结构：const user = /*[[Thymeleaf表达式]]*/ "静态环境下的默认值"; -->
<!-- 因为Thymeleaf被注释起来，因此即便是静态环境下， js代码也不会报错，而是采用表达式后面跟着的默认值。且User对象会被直接处理为json格式。 -->
```

**内置对象**

这些对象中提供了一些方法，方便我们来调用。获取这些对象，需要使用#对象名来引用。

**环境相关对象**

| 对象            | 作用                                          |
| --------------- | --------------------------------------------- |
| #ctx            | 获取Thymeleaf自己的Context对象                |
| #requset        | 如果是web程序，可以获取HttpServletRequest对象 |
| #response       | 如果是web程序，可以获取HttpServletReponse对象 |
| #session        | 如果是web程序，可以获取HttpSession对象        |
| #servletContext | 如果是web程序，可以获取HttpServletContext对象 |

**全局对象**  

| 对象       | 作用                             |
| ---------- | -------------------------------- |
| #dates     | 处理java.util.date的工具对象     |
| #calendars | 处理java.util.calendar的工具对象 |
| #numbers   | 用来对数字格式化的方法           |
| #strings   | 用来处理字符串的方法             |
| #bools     | 用来判断布尔值的方法             |
| #arrays    | 用来护理数组的方法               |
| #lists     | 用来处理List集合的方法           |
| #sets      | 用来处理set集合的方法            |
| #maps      | 用来处理map集合的方法            |

## 应用

```java
@GetMapping("test3")
public String show3(Model model){
    model.addAttribute("today", new Date());
    return "hello3";
}
```

```html
<p>
  今天是: <span th:text="${#dates.format(today,'yyyy-MM-dd')}">2018-04-25</span>
</p>
```


# FreeMarker 

## 快速使用

**数据（java）+模板（ftl）= 结果（html）**

```html
这里是ftl文件
<!-- 先在request中找，然后session，再servlet context -->
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
  </head>
  <body>
    <h1>你好： ${username}</h1>
  </body>
</html>
```

```java
java后台整合
//1.加载模板、创建核心配置对象
Configuration configuration = new Configuration (configuration. VERSION_2_3_28);
//设置加载的目录
// 在本类所在包中加载ft1文件, "代表当前包的意思confiquration.setclassForTemplateLoading(本类.class.")
//设置编码
configuration. setDefaultEncoding "UTF-8" );
// 得到模板对象
Template template- confiquration.getTemplate ("demo.ft1");
//2.处理数据
Map-String, Object> data = new HashMap-String, Object>();
data.put ("site", "百度");
data.put ("ur","www.baidu.com");
// 3.产生输出
// System.out向控制台输出,是一个printStream字节流,要转换为字符流
template.process (data, new outputstreamwriter(System.out));
```

```css
站点：${site}-- 地址：${ur}}
```

## 语法

**变量（取值）、方法、条件判断、循环、运算、逻辑运算、布尔运算、比较运算、条件运算、其它**

```properties
取值
$ {属性名} 可对属性进行计算
$ {属性名!默认值} 使用默认
$ {属性名?string} 格式化输出

示例
    {date?string("yyyy年MM月dd日HH:mm:ss SSS)}
    {number?string("0.00"}
    SN:${computer.sn}
    型号:${computer.model}
    状态:${computer.state}
    用户:${computer.user}
    采购时间:${computer.dop?string("yyyy年MM月dd日)}
    采购价格:${computer.price?string("0.00"}
    配置信息:
        CPU:${computer.info["cpu"]}
        内存:${computer.info["memory"] !"无内存信息"}
```

```properties
空值判断、处理
<!-- FreeMarker的变量必须赋值，否则就会抛出异常。而对于FreeMarker来说，null值和不存在的变量是完全一样的，因为FreeMarker无法理解null值。 -->
FreeMarker提供两个运算符来避免空值:

1. !：指定缺失变量的默认值
    !运算符有两种用法：
        variable!或variable!defaultValue
        第一种用法不给变量指定默认值，表明默认值是空字符串、长度为0的集合、或长度为0的Map对象。
    注意：使用!运算符指定默认值并不要求默认值的类型和变量类型相同。

测试空值：
    ${sss} <#--没有定义这个变量，会报异常！-->
    ${sss!} <#--没有定义这个变量，默认值是空字符串！-->
    ${sss!"abc"} <#--没有定义这个变量，默认值是字符串abc！-->

2. ??：判断变量是否存在
    ??运算符返回布尔值，如：variable??，如果变量存在，返回true，否则返回false。
```

```properties
assign指令：
用于为该模板页面创建或替换一个顶层变量
<#assign name=value [in namespacehash]>,
<!-- 这个用法用于指定一个名为name的变量,该变量的值为value
     此外,FreeMarker允许在使用assign指令里增加in子句
     in子句用于将创建的name变量放入namespacehash命名空间中. -->
  <#assign name="李四">
    姓名：${name}
  <#assign info={"name":"张三","address":"上海"}>
    姓名：${info.name}
    地址：${info.address}
  <#assign seq = ["foo", "bar", "baz"]>

字符串输出:
    ${"Hello ${name} !"} / ${"Hello " + name + " !"}
    <#assign cname=r"特殊字符完成输出(http:\www.baidu.com)">
    ${cname}

字符串截取 ： 
    通过下标直接获取下标对应的字母： ${name[2]}
    起点下标..结尾下标截取字符串：${name[0..5]}

算数运算：
    <#-- 支持"+"、"－"、"*"、"/"、"%"运算符 -->
    <#assign number1 = 10>
    <#assign number2 = 5>
    "+" : ${number1 + number2}
    "－" : ${number1 - number2}
    "*" : ${number1 * number2}
    "/" : ${number1 / number2}
    "%" : ${number1 % number2}

比较运算符：
<!-- 
      EQ 就是 EQUAL等于
      NE就是 NOT EQUAL不等于
      GT 就是 GREATER THAN大于　
      LT 就是 LESS THAN小于
      GE 就是 GREATER THAN OR EQUAL 大于等于
      LE 就是 LESS THAN OR EQUAL 小于等于 
-->
<!--freemarker里面不能包含 ">", "<" 所以要用到大于和小于,就要用gt,lt -->
  <#if number1 + number2 gte 12 || number1 - number2 lt 6>
      "*" : ${number1 * number2}
  <#else>
      "/" : ${number1 / number2}
  </#if>

内建函数：
    <#assign data = "abcd1234">
    第一个字母大写：${data?cap_first}
    所有字母小写：${data?lower_case}
    所有字母大写：${data?upper_case}
    <#assign floatData = 12.34>
    数值取整数：${floatData?int}
    获取集合的长度：${users?size}
    时间格式化：${dateTime?string("yyyy-MM-dd")}

空判断和对象集合：
  <#if users??>
      <#list users as user >
          ${user.id} - ${user.name}
      </#list>
  <#else>
      ${user!"变量为空则给一个默认值"}
  </#if>

Map集合：
  <#assign mapData={"name":"程序员", "salary":15000}>

  直接通过Key获取 Value值：${mapData["name"]}

  通过Key遍历Map：
  <#list mapData?keys as key>
      Key: ${key} - Value: ${mapData[key]}
  </#list>

  通过Value遍历Map：
  <#list mapData?values as value>
      Value: ${value}
  </#list>

List集合：
  <#assign listData=["ITDragon", "blog", "is", "cool"]>
  <#list listData as value>${value} </#list>

include指令：
  引入其他文件：<#include "otherFreeMarker.ftl" />

macro宏指令：
  <#macro mo>
    定义无参数的宏macro--${name}
  </#macro>
    使用宏macro: <@mo />
  <#macro moArgs a b c>
    定义带参数的宏macro-- ${a+b+c}
  </#macro>
    使用带参数的宏macro: <@moArgs a=1 b=2 c=3 />

命名空间：
  <#import "otherFreeMarker.ftl" as otherFtl>
  ${otherFtl.otherName}
  <@otherFtl.addMethod a=10 b=20 />
  <#assign otherName="修改otherFreeMarker.ftl中的otherName变量值"/>
  ${otherFtl.otherName}
  <#assign otherName="修改otherFreeMarker.ftl中的otherName变量值" in otherFtl />
  ${otherFtl.otherName}
```
