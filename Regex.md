# 简介

正则表达式（英语：Regular Expression，在代码中常简写为regex、regexp或RE）

- 正则表达式是检查匹配字符串的表达式

- 正则表达式是描述规则,主流语言都有良支持

- 字符串校验、查找与替换是正则表达式主要使用场景

# 语法

## 元字符

| 代码 | 说明                       |
| ---- | -------------------------- |
| .    | 匹配除换行符以外的任意字符 |
| \w   | 字母、数字、下划线或汉字   |
| \s   | 匹配任意空白符             |
| \d   | 匹配数字                   |
| \b   | 匹配单词的开始或者结束     |
| ^    | 匹配字符串的开始           |
| $    | 匹配字符串的结束           |

## 重复

**常用的限定符**

| 代码/语法 | 说明               |
| --------- | ------------------ |
| *         | 重复0次或者更多次  |
| +         | 重复一次或者更多次 |
| ？        | 重复0次或者1次     |
| {n}       | 重复n次            |
| {n,}      | 重复n次或更多次    |
| {n,m}     | 重复n到m次         |

## 字符转义

> 如果你想查找元字符本身的话，比如你查找 `.` ,或者`*`,就出现了问题：你没办法指定它们，因为它们会被解释成别的意思。

这时你就得使用\来取消这些字符的特殊意义。因此，你应该使用`\.`和`\*`。当然，要查找`\`本身，你也得用`\\`.

## 字符类

> 很简单，你只需要在**方括号里列出它们**就行了，像`[aeiou]`就匹配任何一个英文元音字母，`[.?!]`匹配标点符号(`.`或`?`或`!`)。

| 代码/语法 | 说明                       |
| --------- | -------------------------- |
| [abc]     | 查找方括号之间的任何字符。 |
| [0-9]     | 查找任何从 0 至 9 的数字。 |
| (x\|y)    | 查找任何以 \| 分隔的选项。 |

## 分枝条件

> 分枝情况是指，某种情况有多种规则与其相匹配，如果满足其中任意一种规则则认为匹配成功
>  如匹配两种格式的电话号（010）12345678   010-12345678
>  具体方法是使用`|`符号将其分隔开

符号： `|`   （也就是`或` ）

| 代码/语法 | 说明                       |
| --------- | -------------------------- |
| (x\|y)    | 查找任何以 \| 分隔的选项。 |

分枝条件匹配时会**从左到右**的匹配每一个条件，如果找到合适的条件则不继续向下匹配

例子：

**待匹配字符串：**

电话1：(010)12345678

电话2：010-12345678

电话3：(010)1234

**正则表达式：**`(0\d{2})\d{8}|0\d{2}-\d{8}`

**匹配结果：**共找到 2 处匹配：

(010)12345678

 010-12345678

## 分组

> 就是**重复多个字符**

**用法：**

用小括号来指定**子表达式**(也叫做**分组**)，然后你就可以指定这个子表达式的重复次数

**例子：**

`\d{1,3}`匹配**1到3位的数字** , 这就是前面的**重复**

`(\d{1,3}){3}` 这是将上面的给重复三次，小括号`()`里面的就是分组

## 反义

> 除某某之外的都行

> **比如**想查找**除了数字以外**，**其它任意字符都行**的情况，这时需要用到反义：`\D`

**常用的反义代码**

| 代码/语法 | 说明                                              |
| --------- | ------------------------------------------------- |
| \W        | 匹配任意**不是**字母，数字，下划线，汉字的字符    |
| \S        | 匹配任意**不是**空白符的字符                      |
| \D        | 匹配任意**非**数字的字符                          |
| \B        | 匹配**不是**单词开头或结束的位置                  |
| [^x]      | 匹配**除了**`x`**以外**的任意字符                 |
| [^aeiou]  | 匹配**除了**  `aeiou`这几个字母**以外**的任意字符 |

## 贪婪与懒惰

> 比如对于字符串`aabab`

**贪婪**

> 匹配**尽可能多**的字符

`a.*b` 将匹配上述的尽可能多的字符   `aabab`

**懒惰**

> 匹配**尽可能少**的字符

`a.*?b`  ,其中的`?` 代表尽可能少地匹配字符。那么将匹配到`aab`  和   `ab`

| 代码/语法 | 说明                               |
| --------- | ---------------------------------- |
| *？       | 重复0次或者更多次，但尽可能少重复  |
| +？       | 重复一次或者更多次，但尽可能少重复 |
| ？？      | 重复0次或者1次，但尽可能少重复     |
| {n}？     | 重复n次，但尽可能少重复            |
| {n,}？    | 重复n次或更多次，但尽可能少重复    |
| {n,m}？   | 重复n到m次，但尽可能少重复         |

## 常见的正则表达式

| 正则表达式                                                   | 说明                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `^\w+$`   或者  `^\w{3,20}$`                                 | 数字、26个英文字母或者下划线组成的字符串                     |
| `[\u4e00-\u9fa5]`                                            | 中文字符的正则表达式                                         |
| `/^1[34578]\d{9}$/`                                          | 手机号                                                       |
| `^[a-zA-Z][a-zA-Z0-9_]{4,15}$`                               | 帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)     |
| `^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$`              | Email地址                                                    |
| `[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(/.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+/.?` | 域名                                                         |
| `[1-9][0-9]{4,}`                                             | QQ号                                                         |
| `(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$) `                  | 身份证                                                       |
| `^[a-zA-Z]\w{5,17}$`                                         | 密码(以字母开头，长度在6~18之间，只能包含字母、数字和下划线) |
| `^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9]{8,10}$`          | 强密码(必须包含大小写字母和数字的组合，不能使用特殊字符，长度在 8-10 之间) |
| `^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,10}$`                    | 强密码(必须包含大小写字母和数字的组合，可以使用特殊字符，长度在8-10之间) |

# Java应用

## 简介

java.util.regex 包主要包括以下三个类：

> Pattern 类：
>
> pattern 对象是一个正则表达式的编译表示。Pattern 类没有公共构造方法。要创建一个 Pattern 对象，你必须首先调用其公共静态编译方法`Pattern p = Pattern.compile(regexStr)`，它返回一个 Pattern 对象。该方法接受一个正则表达式作为它的第一个参数。
>
> Matcher 类：
>
> Matcher 对象是对输入字符串进行解释和匹配操作的引擎。与Pattern 类一样，Matcher 也没有公共构造方法。你需要调用 Pattern 对象的 matcher 方法来获得一个 Matcher 对象`p.matcher(Str)`。
>
> PatternSyntaxException：
>
> PatternSyntaxException 是一个非强制异常类，它表示一个正则表达式模式中的语法错误。

## 快速使用

**查找字符串**

使用了正则表达式 **.\*runoob.\*** 用于查找字符串中是否包了 **runoob** 子串：

```java
import java.util.regex.*;
 
class RegexExample1{
   public static void main(String args[]){
      String content = "I am noob " +
        "from runoob.com.";
 
      String pattern = ".*runoob.*";
 
      boolean isMatch = Pattern.matches(pattern, content);
      System.out.println("字符串中是否包含了 'runoob' 子字符串? " + isMatch);//true
   }
}
```

**捕获组**

通过调用 matcher 对象的 groupCount 方法来查看表达式有多少个分组。groupCount 方法返回一个 int 值，表示matcher对象当前有多个捕获组。

还有一个特殊的组（group(0)），它总是代表整个表达式。该组不包括在 groupCount 的返回值中

```java
import java.util.regex.Matcher;
import java.util.regex.Pattern;
public class RegexMatches
{
    public static void main( String args[] ){
      // 按指定模式在字符串查找
      String line = "This order was placed for QT3000! OK?";
      String pattern = "(\\D*)(\\d+)(.*)"; 
      // 创建 Pattern 对象
      Pattern r = Pattern.compile(pattern); 
      // 现在创建 matcher 对象
      Matcher m = r.matcher(line);
      if (m.find( )) {
         System.out.println("Found value: " + m.group(0) );
         System.out.println("Found value: " + m.group(1) );
         System.out.println("Found value: " + m.group(2) );
         System.out.println("Found value: " + m.group(3) ); 
      } else {
         System.out.println("NO MATCH"); } } }
```

```java
以上示例编译运行结果如下：
Found value: This order was placed for QT3000! OK?
Found value: This order was placed for QT
Found value: 3000
Found value: ! OK?
```



## 语法

### 与其他语言区别

其他语言中，`\\ `表示：**在正则表达式中插入一个普通的（字面上的）反斜杠，不要给它任何特殊的意义。**

在 Java 中，`\\ `表示：**我要插入一个正则表达式的反斜线，所以其后的字符具有特殊的意义。**

也可以简单的理解在 Java 的正则表达式中，两个 `\\` 代表其他语言中的一个 \，这也就是为什么表示一位数字的正则表达式是 `\\d`，而表示一个普通的反斜杠是`\\\`。

### Pattern 类的方法

| **序号** | **方法及说明**                                               |
| :------- | :----------------------------------------------------------- |
| 1        | **Pattern.complie(String regex)**  简单工厂方法返回一个Pattern对象，创建一个正则表达式 |
| 2        | **Pattern有一个split(CharSequence input)**  用于分隔字符串,并返回一个String[],我猜String.split(String regex)就是通过Pattern.split(CharSequence input)来实现的. |
| 3        | **Pattern.matcher(String regex,CharSequence input)**  是一个静态方法,用于快速匹配字符串,该方法适合用于只匹配一次,且匹配全部字符串. |
| 4        | **Pattern.matcher(CharSequence input)**  返回一个Matcher对象；Pattern类只能做一些简单的匹配操作,要想得到更强更便捷的正则匹配操作,需要将Pattern与Matcher合作.Matcher类提供了对正则表达式的分组支持,以及对正则表达式的多次匹配支持. |

```java
示例：

Pattern p=Pattern.compile("\\w+"); 
p.pattern();//返回 \w+ 

Pattern p=Pattern.compile("\\d+"); 
String[] str=p.split("我的QQ是:456456我的电话是:0532214我的邮箱是:aaa@aaa.com"); 
结果:str[0]="我的QQ是:" str[1]="我的电话是:" str[2]="我的邮箱是:aaa@aaa.com" 

Pattern.matches("\\d+","2223");//返回true 
Pattern.matches("\\d+","2223aa");//返回false,需要匹配到所有字符串才能返回true,这里aa不能匹配到 
Pattern.matches("\\d+","22bb23");//返回false,需要匹配到所有字符串才能返回true,这里bb不能匹配到 

Pattern p=Pattern.compile("\\d+"); 
Matcher m=p.matcher("22bb23"); 
m.pattern();//返回p 也就是返回该Matcher对象是由哪个Pattern对象的创建的 
```

### Matcher 类的方法

#### 索引方法

索引方法提供了有用的索引值，精确表明输入字符串中在哪能找到匹配：

| **序号** | **方法及说明**                                               |
| :------- | :----------------------------------------------------------- |
| 1        | **public int start()** 返回以前匹配的初始索引。              |
| 2        | **public int start(int group)**  返回在以前的匹配操作期间，由给定组所捕获的子序列的初始索引 |
| 3        | **public int end()** 返回最后匹配字符之后的偏移量。          |
| 4        | **public int end(int group)** 返回在以前的匹配操作期间，由给定组所捕获子序列的最后字符之后的偏移量。 |

#### 查找方法

查找方法用来检查输入字符串并返回一个布尔值，表示是否找到该模式：

| **序号** | **方法及说明**                                               |
| :------- | :----------------------------------------------------------- |
| 1        | **public boolean lookingAt()**  尝试将从区域开头开始的输入序列与该模式匹配。 |
| 2        | **public boolean find()** 尝试查找与该模式匹配的输入序列的下一个子序列。 |
| 3        | **public boolean find(int start****）** 重置此匹配器，然后尝试查找匹配该模式、从指定索引开始的输入序列的下一个子序列。 |
| 4        | **public boolean matches()** 尝试将整个区域与模式匹配。      |

#### 替换方法

替换方法是替换输入字符串里文本的方法：

| **序号** | **方法及说明**                                               |
| :------- | :----------------------------------------------------------- |
| 1        | **public Matcher appendReplacement(StringBuffer sb, String replacement)** 实现非终端添加和替换步骤。 |
| 2        | **public StringBuffer appendTail(StringBuffer sb)** 实现终端添加和替换步骤。 |
| 3        | **public String replaceAll(String replacement)**  替换模式与给定替换字符串相匹配的输入序列的每个子序列。 |
| 4        | **public String replaceFirst(String replacement)**  替换模式与给定替换字符串匹配的输入序列的第一个子序列。 |
| 5        | **public static String quoteReplacement(String s)** 返回指定字符串的字面替换字符串。这个方法返回一个字符串，就像传递给Matcher类的appendReplacement 方法一个字面字符串一样工作。 |

### PatternSyntaxException 类的方法

PatternSyntaxException 是一个非强制异常类，它指示一个正则表达式模式中的语法错误。

PatternSyntaxException 类提供了下面的方法来帮助我们查看发生了什么错误。

| **序号** | **方法及说明**                                               |
| :------- | :----------------------------------------------------------- |
| 1        | **public String getDescription()** 获取错误的描述。          |
| 2        | **public int getIndex()**  获取错误的索引。                  |
| 3        | **public String getPattern()** 获取错误的正则表达式模式。    |
| 4        | **public String getMessage()** 返回多行字符串，包含语法错误及其索引的描述、错误的正则表达式模式和模式中错误索引的可视化指示。 |



# JS应用

## 语法

```js
/正则表达式主体/修饰符(可选)
```

> var patt = /runoob/i
>
> 示例解析：
>
> **/runoob/i** 是一个正则表达式。
>
> **runoob** 是一个**正则表达式主体** (用于检索)。
>
> **i** 是一个**修饰符** (搜索不区分大小写)。

---

**正则表达式修饰符**

| 修饰符 | 描述                                                     |
| :----- | :------------------------------------------------------- |
| i      | 执行对大小写不敏感的匹配。                               |
| g      | 执行全局匹配（查找所有匹配而非在找到第一个匹配后停止）。 |
| m      | 执行多行匹配。                                           |

## 应用

### JS字符串方法的使用

在 JavaScript 中，正则表达式通常用于两个字符串方法 : search() 和 replace()。

**1. search() 方法** 用于检索字符串中指定的子字符串，或检索与正则表达式相匹配的子字符串，并返回子串的起始位置。

**2. replace() 方法** 用于在字符串中用一些字符替换另一些字符，或替换一个与正则表达式匹配的子串。

```js
--search() 方法
    
使用正则表达式搜索 "Runoob" 字符串，且不区分大小写：
var str = "Visit Runoob!"; 
var n = str.search(/Runoob/i);//返回：6

使用字符串作为参数。字符串参数会转换为正则表达式：
var str = "Visit Runoob!"; 
var n = str.search("Runoob");//返回：6

--replace() 方法
使用正则表达式且不区分大小写将字符串中的 Microsoft 替换为 Runoob :
var str = document.getElementById("demo").innerHTML; 
var txt = str.replace(/microsoft/i,"Runoob");//结果输出为:Visit Runoob!

使用字符串作为参数。字符串参数会转换为正则表达式：
var str = document.getElementById("demo").innerHTML; 
var txt = str.replace("Microsoft","Runoob");

注意：正则表达式参数可用在以上方法中 (替代字符串参数)。
	 正则表达式使得搜索功能更加强大(如实例中不区分大小写)。
```

### 使用 RegExp 对象

在 JavaScript 中，RegExp 对象是一个预定义了属性和方法的正则表达式对象。

**1. test() 方法**是一个正则表达式方法。

test() 方法用于检测一个字符串是否匹配某个模式，如果字符串中含有匹配的文本，则返回 true，否则返回 false。

```js
var patt1=new RegExp("e");
document.write(patt1.test("The best things in life are free"));//输出：true
/*
这样写也可以：var patt = /e/; 
document.write(/e/.test("The best things in life are free!"));
*/
```

**2. exec() 方法**是一个正则表达式方法。

exec() 方法用于检索字符串中的正则表达式的匹配。

该函数返回一个数组，其中存放匹配的结果。如果未找到匹配，则返回值为 null。

```js
var patt1=new RegExp("e");
document.write(patt1.exec("The best things in life are free"));//输出：e
/*
这样写也可以：var patt = /e/; 
document.write(/e/.exec("The best things in life are free!"));
*/
```

