# 简介

**概述**

JavaScript，通常缩写为 JS，是一种高级的，解释执行的编程语言。JavaScript 是一门基于原型、函数先行的语言，是一门多范式的语言，它支持面向对象编程，命令式编程，以及函数式编程。它提供语法来操控文本、数组、日期以及正则表达式等，不支持 I/O，比如网络、存储和图形等，但这些都可以由它的宿主环境提供支持。

**JavaScript 的组成**

- ECMAScript：JavaScript 的语法标准。
- DOM：JavaScript 操作网页上的元素的 API。
- BOM：JavaScript 操作浏览器的部分功能的 API。

**JavaScript 的特点**

- 可以使用任何文本编辑工具编写，然后使用浏览器就可以执行程序。
- 是一种解释型脚本语言：代码不进行预编译，从上往下逐行执行，不需要进行严格的变量声明。
- 主要用来向 HTML 页面添加交互行为。

# 语法

## 语法标准

### 快速使用

- 数据类型

|      | 类型      | 作用                                         |
| ---- | --------- | -------------------------------------------- |
| 1    | number    | 数字类型,整型浮点型都包括                    |
| 2    | string    | 字符串类型,必须放在单引号或者双引号中        |
| 3    | boolean   | 布尔类型,只有true和false两种值               |
| 4    | underfine | 未定义,一般指的是已经声明,但是没有赋值的变量 |
| 5    | null      | 空对象类型, var a=null,和var a=""有区别;     |

- 特殊类型

|      | 类型   | 作用                                                         |
| ---- | ------ | ------------------------------------------------------------ |
| 1    | object | 对象类型,在js常见的有window,document, array等                |
| 2    | NaN    | Number的一种特殊类型(not a number), isNaN() ,如果是数字返回false,不是返回true |

- 值类型和引用类型

```js
值类型:数值类型,布尔类型,undefined,null,字符串
值类型存储在栈（stack）中，它们的值直接存储在变量访问的位置。

引用类型:对象,数组,函数
引用类型存储在堆中，也就是说存储在变量处的值是一个指针，指向存储对象的内存处。
```



- 运算符优先级

| 顺序 | 符号       | 描述         | 顺序 | 符号   | 描述         |
| ---- | ---------- | ------------ | ---- | ------ | ------------ |
| 1    | ( )        | 小括号       | 6    | ==、!= | 等于、不等于 |
| 2    | ++、--     | 自加、自减   | 7    | &&     | 逻辑与       |
| 3    | *   /   %  | 乘、除、取模 | 8    | \|\|   | 逻辑或       |
| 4    | +   -      | 加、减       | 9    | ?  :   | 三目运算符   |
| 5    | < <=  > >= | 比较运算     | 10   | =      | 赋值Ω        |

- 调试

```js
alert弹框调试、console.log控制台输出调试
```

- 自定义函数

完成某一功能的代码段,可重复执行,方便管理和维护


```js
1.函数声明创建函数；可以先使用后定义
function fun1 (){
    代码片段;
	return***;
};

2.函数表达式创建函数；必须先定义后使用
var fun1=function(x){
    代码片段;
    return x+1;
};

3.返回值
var f = function (a, b) {
  a + b;
};
console.log(f(2, 3)); // 结果为 undefined
var f = function (a, b) {
  return a + b;
};
console.log(f(2, 3)); // 结果为 5

4.匿名函数
//匿名函数就是没有命名的函数，一般用在绑定事件的时候
function(){
     执行的代码
};
var myButton = document.querySelector("button");
myButton.onclick = function () {
  alert("hello");
};

5. 自调用函数
//匿名函数不能通过直接调用来执行，因此可以通过匿名函数的自调用的方式来执行。
(function () {
  alert("hello");
})();

6.重点：
创建功能，我们使用函数声明来创建函数。
使用匿名函数来运行负载的代码以响应事件触发（如点击按钮），使用事件处理程序。
```

### 详细使用

- 变量

```js
//变量与其他程序设计语言相同,是用来临时存储信息
var x1 = 10;
x2 = 5.23;//变量可不作声明，变量 x 为整数
var n = prompt("请输入一个正整数");//js的input
```

- Null 和 Undefined

```css
1. == 是相等操作符，比较值是否相等，如果相等输出为 true，否则为 false。
2. === 是全等操作符，比较值和类型是否都相等，如果都相等输出为 true，否则为 false。
3. null 和 undefined 的值不等于 0，它们的值相等，但是类型不相等。undefined 表示所有没有赋值变量的默认值，而 null 则表示一个变量不再指向任何对象地址。
```

- 字符串

```js
--字符串长度
var myString = "hello world ";
myString.length;
myString[0];//查找这个字符串的第一个字符

--查找子字符串并提取它

1. str.indexOf(searchValue, fromIndex);
/*  searchValue 表示我们指定的较小的字符串，fromIndex 表示调用该方法的字符串中开始查找的位置，可选的任意整数值，默认是 0 表示从头开始查。
	fromIndex < 0 和 fromIndex = 0 是一样的效果，表示从头开始查找整个字符串。如果 fromIndex >= str.length，则该方法的返回值为 -1。
	特殊情况：就是如果被查找的字符串是一个空字符串，当 fromIndex <= 0 时返回 0，0 < fromIndex <= str.length 时返回 fromIndex，fromIndex > str.length 时返回 str.length。*/
注：返回值指的是指定值第一次出现的索引，如果没有找到返回 -1。
	indexOf() 方法区分大小写	
"Blue Sky".indexOf("Blue"); // returns  0
"Blue Sky".indexOf("Ble"); // returns -1
"Blue Sky".indexOf("", 0); // returns  0
"Blue Sky".indexOf("", 5); // returns 5
"Blue Sky".indexOf("", 9); // returns 8

2. str.slice(strat，end);
   str.substring(strat，end);
/*提取不包括end，右边开区间。end可以不写，代表某个字符之后提取字符串中的所有剩余字符。
  两者参数有负数是返回值不同：
    str.slice(2,-5))//实际上是slice(2,3)，负数加上字符串长度转换成正3，(若第一位 >= 第二位, 则返回空字符串);
	str.substring(2,-5));//实际上是substring(2,0),负数都转换为0,substring总是把较小的数作为起始位置。*/
"Blue Sky".slice(0, 3); // returns "Blu"
"Blue Sky".slice(2); // returns "ue Sky"

--转换大小写
var string = "I like study";
string.toLowerCase(); // returns "i like study"
string.toUpperCase(); // returns "I LIKE STUDY"

--替换字符串的某部分
var string = "I like study";
string.replace("study", "sleep"); // returns "I like sleep"
```

- 数据转换

```js
--转换成字符串

1. 几乎每个值都有 toString() 方法
var myNum = 123;
var myString = myNum.toString();
typeof myString;//获取变量或表达式类型

2. String() 函数
var result = true;
var result1 = String(result);
//注：因为有的值没有 toString() 方法，所以需要用 String()，比如 null 和 undefined

3. 使用拼接字符串
var num1 = 16;
var num2 = num1 + "";
num2; // returns "16"

--转换成数值类型

1. Number() 可以把任意值转换成数值;
   如果要转换的字符串中有一个不是数值的字符，返回 NaN（not a number）
var num1 = Number(true);
num1; // true 返回 1，false 返回 0
var num2 = Number(undefined);
num2; // 返回 NaN
var num3 = Number(null);
num3; // 返回 0
var num4 = Number("syl");
num4; // 返回 NaN
var num5 = Number("   ");
num5; // 如果是空字符串返回 0
var num6 = Number(123);
num6; // 返回123，如果是数字型的字符，返回数字
var num7 = Number("123abc");
num7; // 返回 NaN

2.parseInt() 把字符串转换成整数
var num1 = parseInt("12.3abc");
num1; // 返回 12，如果第一个字符是数字会解析知道遇到非数字结束，只取整，不是约等于
var num2 = parseInt("abc123");
num2; // 返回 NaN，如果第一个字符不是数字或者符号就返回 NaN
var num3 = parseInt("");
num3; // 空字符串返回 NaN，但是 Number("")返回 0
var num4 = parseInt("520");
num4; // 返回 520
var num5 = parseInt("0xA");
num5; // 返回 10
//注：parseInt() 可以传递两个参数，第一个参数是要转换的字符串，第二个参数是要转换的进制。

3.parseFloat() 把字符串转换成浮点数。
/*写法和 parseInt() 相似，主要有以下几个不同点：
  parseFloat 不支持第二个参数，只能解析 10 进制数。
  如果解析的内容里只有整数，解析成整数。*/
parseFloat("10"); // returns 10
parseFloat("10.000"); // returns 10
parseFloat("10.01"); // returns 10.01
parseFloat("10"); // returns 10
parseFloat("10 hours"); // returns 10
parseFloat("aaa 10"); // returns NaN

4.执行减 0 操作。
var n = "10";
var m = n - 0;
m; // returns 10

如果该字符串不是纯粹的数字字符串，那么它执行减 0 操作后，虽然变成了一个数字类型，但是返回值为 NaN。
var n = "abc";
var m = n - 0;
m; // returns NaN
typeof m; // returns "number"

--转换成布尔类型

1.使用 Boolean() 函数
Boolean(123); // returns true
Boolean("abc"); // returns true
Boolean(null); // returns false
Boolean(undefined); // returns false
Boolean(NaN); // returns false
Boolean(0); // returns false
Boolean(""); // returns false
Boolean(false); // returns false
Boolean("false"); // returns true
Boolean(-1); // returns true

2.流程控制语句会把后面的值隐式转换为布尔类型
var message;
if (message) {
  //会自动把 message 转换成 false，最后打印结果为：我很好
  console.log("你好啊");
} else {
  console.log("我很好");
}
```

### js对象

- json
- Array

```js
--数组定义
var myarray = new Array(1, 2, 3, 4, 5); // 创建数组同时赋值
var myarray = [1, 2, 3, 4, 5]; // 直接输入一个数组（称“字面量数组”）
myarray[0]; // returns "1"
var student = [["张三", "男", "18"],["李四", "女", "20"],];
student[0][2]; // returns "18"

--数组应用
var color = ["red", "green", "blue", "yellow"];
color[0] = "black";
color; // returns ["black", "green", "blue", "yellow"]

--Array 对象的常用属性：length，获取数组的长度。

--Array 对象的常用方法：

1. concat() 方法用于连接两个或多个数组，并返回结果。语法为：
arrayObject.concat(arrayX, arrayX, ..., arrayX);
var a = [1, 2, 3];
var b = [4, 5, 6];
var c = ["one", "two", "three"];

2. join() 方法，将数组转换成字符串。

3.. toString() 方法，把数组转换为字符串，并返回结果。

4. pop() 方法，删除并返回数组的最后一个元素。
//数组长度减 1，并且返回它删除的元素的值。
//如果数组已经为空，则 pop() 不改变数组，然后返回 undefined 值。

5. push() 方法，向数组的末尾添加一个或更多元素，并返回新的长度。

6. shift() 方法，删除并返回数组的第一个元素。
//数组长度减 1，并且返回数组当前第一个值。
//如果数组已经为空，则 pop() 不改变数组，然后返回 undefined 值。

7. unshift() 方法，向数组的开头添加一个或更多元素，并返回新的长度。

8. reverse() 方法，颠倒数组的顺序。

9. slice() 方法，从某个已有的数组返回选定的元素。语法为：

10. arrayObject.slice(start, end);
// strat 值是必需的，规定从何处开始选取
// end 值可选，规定从何处结束选取，如果没有设置，默认为从 start 开始选取到数组后面的所有元素
var a = [1, 2, 3, 4, 5, 6];
a.slice(2, 5); // 结果为[3, 4, 5]，另外需要注意的是该方法不会修改数组，只是返回一个子数组，a 数组还是 [1, 2, 3, 4, 5, 6]

11. splice() 方法，删除或替换当前数组的某些项目。语法为：
arrayObject.splice(start, deleteCount, options);
// start 值是必需的，规定删除或替换项目的位置
// deleteCount 值是必需的，规定要删除的项目数量，如果设置为 0，则不会删除项目
// options 值是可选的，规定要替换的新项目
// 和 slice() 方法不同的是 splice() 方法会修改数组
var a = [1, 2, 3, 4, 5, 6];
a.splice(2, 2, "abc");
a; // 最终 a 数组变成了[1, 2, "abc", 5, 6]

11. sort() 方法，将数组进行排序。语法为：
arrayObject.sort(sortby);
// sortby 是可选的，规定排序顺序，必需是函数。如果没有参数的话，将会按照字母顺序进行排序，更准确的说是按照字符编码的顺序进行排序。如果想按照其他标准进行排序，则需要提供比较函数
function sortNum1(a, b){
    return a - b; // 从小到大排序
}
var arr4 = [1,22,44,6,55,5,2,4,66];
document.write(arr4 + "<br />");
document.write(arr4.sort(sortNum1) + "<br />" + "<br />");

function sortNum2(a,b){
    return b - a; // 从大到小排序
}
var arr4 = [1,22,44,6,55,5,2,4,66];
document.write(arr4 + "<br />");
document.write(arr4.sort(sortNum2) + "<br />" + "<br />");
运行结果为：
1,22,44,6,55,5,2,4,66
1,2,4,5,6,22,44,55,66
1,22,44,6,55,5,2,4,66
66,55,44,22,6,5,4,2,1

12.字符串转数组
"1:2:3:4".split(":"); // returns ["1", "2", "3", "4"]
"|a|b|c".split("|"); // returns ["", "a", "b", "c"]
```

- String

```js
--String 对象的常用属性：length，获取字符串的长度。

--String 对象的常用方法：

1. charAt() 方法，获取指定位置处字符。语法为：
stringObject.charAt(index);
// 字符串中第一个字符的下标是 0。如果参数 index 不在 0 与 string.length 之间，该方法将返回一个空字符串
var str = "Hello world!";
document.write(str.charAt(2));

2. charCodeAt() 方法，获取指定位置处字符的 Unicode 编码。语法为：
stringObject.charCodeAt(index);
// 字符串中第一个字符的下标是 0。如果 index 是负数，或大于等于字符串的长度，则 charCodeAt() 返回 NaN
var str = "Hello world!";
document.write(str.charCodeAt(2));
// 以上代码输出为 l08

3. concat() 方法，连接字符串，等效于 “+”，“+” 更常用。与数组中的concat() 方法相似。

4. slice() 方法，提取字符串的片断，并在新的字符串中返回被提取的部分。

5. indexOf() 方法，检索字符串。

6. toString() 方法，返回字符串。

7. toLowerCase() 方法，把字符串转换为小写。

8. toUpperCase() 方法，把字符串转换为大写。

9. replace() 方法，替换字符串中的某部分。

10. split() 方法，把字符串分割为字符串数组。
```

- Date

```js
--Date 对象方法：

1. Date()：返回当日的日期和时间（输出的是中国标准时间）。

2. getDate()：从 Date 对象返回一个月中的某一天 (1 ~ 31)。

3. getDay()：从 Date 对象返回一周中的某一天 (0 ~ 6)。

4. getMonth()：从 Date 对象返回月份 (0 ~ 11)。

5. getFullYear()：从 Date 对象以四位数字返回年份。

6. getHours()：返回 Date 对象的小时 (0 ~ 23)。

7. getMinutes()：返回 Date 对象的分钟 (0 ~ 59)。

8. getSeconds()：返回 Date 对象的秒数 (0 ~ 59)。

9. getMilliseconds()：返回 Date 对象的毫秒(0 ~ 999)。

10. 日期格式转换

new Date().toLocaleString('chinese', { hour12: false });// 2020/6/5 13:43:04
new Date().to***String;
```

- Math

```js
--Math 对象的常用属性：

1. E ：返回常数 e (2.718281828...)。

2. LN2 ：返回 2 的自然对数 (ln 2)。

3. LN10 ：返回 10 的自然对数 (ln 10)。

4. LOG2E ：返回以 2 为底的 e 的对数 (log2e)。

5. LOG10E ：返回以 10 为底的 e 的对数 (log10e)。

6. PI ：返回 π（3.1415926535...)。

7. SQRT1_2 ：返回 1/2 的平方根。

8. SQRT2 ：返回 2 的平方根。

--Math 对象的常用方法：

1. abs(x) ：返回 x 的绝对值。

2. round(x) ：返回 x 四舍五入后的值。

3. sqrt(x) ：返回 x 的平方根。

4. ceil(x) ：返回大于等于 x 的最小整数。

5. floor(x) ：返回小于等于 x 的最大整数。

6. sin(x) ：返回 x 的正弦。

7. cos(x) ：返回 x 的余弦。

8. tan(x) ：返回 x 的正切。

9. acos(x) ：返回 x 的反余弦值（余弦值等于 x 的角度），用弧度表示。

10. asin(x) ：返回 x 的反正弦值。

11. atan(x) ：返回 x 的反正切值。

12. exp(x) ：返回 e 的 x 次幂 (e^x)。

13. pow(n, m) ：返回 n 的 m 次幂 (nm)。

14. log(x) ：返回 x 的自然对数 (ln x)。

15. max(a, b) ：返回 a, b 中较大的数。

16. min(a, b) ：返回 a, b 中较小的数。

17. random() ：返回大于 0 小于 1 的一个随机数。
```

- 创建对象

```js
--通过对象字面量来创建

var student = {
    name: "zhangsan",
    age: 18,
    gender: "male",
    sayHi: function () {
    console.log("hi,my name is " + this.name);
  },
};

--通过 new Object() 创建对象

var student = new Object();
	(student.name = "zhangsan"),
    (student.age = 18),
    (student.gender = "male"),
    (student.sayHi = function () {
    console.log("hi,my name is " + this.name);
});

--通过工厂函数创建对象

function createStudent(name, age, gender) {
  var student = new Object();
  student.name = name;
  student.age = age;
  student.gender = gender;
  student.sayHi = function () {
    console.log("hi,my name is " + this.name);
  };
  return student;
}
var s1 = createStudent("zhangsan", 18, "male");

--自定义构造函数

function Student(name, age, gender) {
  this.name = name;
  this.age = age;
  this.gender = gender;
  this.sayHi = function () {
    console.log("hi,my name is " + this.name);
  };
}
var s1 = new Student("zhangsan", 18, "male");

--来看看构造函数与工厂函数的区别：

首先在构造函数内没有创建对象，而是使用 this 关键字，将属性和方法赋给了 this 对象。
构造函数内没有 return 语句，this 属性默认下是构造函数的返回值。
函数名使用的是大写的 Student。
用 new 运算符和类名 Student 创建对象。

--new 关键字

构造函数，是一种特殊的函数。主要用来在创建对象时初始化对象，即为对象成员变量赋初始值，总与 new 运算符一起使用在创建对象的语句中。这里有需要特别注意的几点：
    构造函数用于创建一类对象，首字母要大写。
    内部使用 this 关键字给对象添加成员。
    使用 new 关键字调用对象构造函数。

--this 详解

在 JavaScript 中，我们经常会使用到 this 关键字，那么 this 到底指向什么呢？这里有一个口诀：谁调用 this，它就是谁。

函数在定义的时候 this 是不确定的，只有在调用的时候才可以确定。
一般函数直接执行，内部 this 指向全局 window。比如：
function test() {
  console.log(this);
}
test(); // window.test();

函数作为一个对象的方法，被该对象所调用，那么 this 指向的是该对象。
构造函数中的 this，始终是 new 的当前对象。
```

- 访问对象

```js
--遍历对象的属性
for...in 语句用于遍历数组或者对象的属性，对数组或者对象的属性进行循环操作。

var student = {
    name: "zhangsan",
    age: 18,
    gender: "male",
};
for (var key in student) {
    console.log(key);
    console.log(student[key]);
}

--删除对象的属性
使用 delete 删除对象的属性。

student["name"];// zhangsan
student.name; // zhangsan
delete student.name;
student.name; // undefined

--添加、修改
 student["key3"] = "value3"; //添加时无该key值则添加,有则修改value
 student.key4 = "value4";

```

## Web API

### 简介

```css
浏览器是一个封装的较为完善的软件，它给我们提供了操作浏览器功能和页面元素的接口。

API（Application Programming Interface，应用程序编程接口）："计算机操作系统"（Operating system）或"程序库"提供给应用程序调用使用的代码。

API 本身是抽象的，它仅定义了一个接口，而不涉及应用程序在实际实现过程中的具体操作。

Web API 是浏览器提供的一套操作浏览器功能和页面元素的 API（BOM 和 DOM）。
```

### BOM

**概述：操作浏览器的部分功能的 API**

```css
浏览器对象模型（Browser Object Model (BOM)）指的是由 Web 浏览器暴露的所有对象组成的表示模型。

作为显示文档的窗口，浏览器程序将其视为对象的分层集合。当浏览器分析文档时，它将创建一个对象的集合以定义文档，并详细说明它应如何显示。浏览器对象集合统称为浏览器对象模型或 BOM。

BOM 层次结构的顶层是窗口对象，它包含有关显示文档的窗口的信息。某些窗口对象本身就是描述文档和相关信息的对象。
```

**对象**

- 顶级对象 window

```javascript
当调用 window 下的属性和方法时，可以省略 window。

1. 对话框
alert()：显示带有一段消息和一个确认按钮的警告框。
prompt()：显示可提示用户输入的对话框。
confirm()：显示带有一段消息以及确认按钮和取消按钮的对话框。

2. 页面加载事件
onload
window.onload = function () {
  // 当页面完全加载所有内容（包括图像、脚本文件、CSS 文件等）执行
};
onunload
window.onunload = function () {
  // 当用户退出页面时执行
};

3. 浏览器尺寸
//可以获取所有浏览器的宽高（不包括工具栏/滚动条）
var width = window.innerWidth;
document.documentElement.clientWidth;
document.body.clientWidth;

var height = window.innerHeight;
document.documentElement.clientHeight;
document.body.clientHeight;

4. 定时器

setTimeout() 方法在指定的毫秒数到达之后执行指定的函数，只执行一次。
clearTimeout() 方法取消由 setTimeout() 方法设置的 timeout。
// 创建一个定时器，2000毫秒后执行，返回定时器的标示
var timerId = setTimeout(function () {
  console.log("Hello shiyanlou");
}, 2000);
// 取消定时器的执行
clearTimeout(timerId);
//setTimeout()方法的返回值是一个唯一的数值。
//调用clearTimeout()时，用这个数值来确定结束哪个setTimeout()方法。

setInterval() 方法设置定时调用的函数也就是可以按照给定的时间（单位毫秒）周期调用函数。
clearInterval() 方法取消由 setInterval() 方法设置的 timeout。
// 创建一个定时器，每隔 2 秒调用一次
var timerId = setInterval(function () {
  var date = new Date();
  console.log(date.toLocaleTimeString());
}, 2000);
// 取消定时器的执行
clearInterval(timerId);
```

### DOM

**概述：操作网页上的元素的 API**

```css
文档对象模型（Document Object Model，简称 DOM），是 W3C 组织推荐的处理可扩展标志语言的标准编程接口。DOM 定义了访问 HTML 和 XML 文档的标准。DOM 可以把 HTML 看做是文档树，通过 DOM 提供的 API 可以对树上的节点进行操作。
```

**应用**

```html
1.DOM 能够操作 HTML 的内容。

--改变 HTML 输出流
使用 document.write() 可用于直接向 HTML 输出流写内容。
document.write("新设置的内容<p>标签也可以生成</p>");

--改变 HTML 内容
使用 innerHTML 属性改变 HTML 内容。比如修改 p 标签中的内容：
<p id="p1">Hello World!</p>
<script>
   document.getElementById("p1").innerHTML = "Hello 实验楼";
</script>

--改变 HTML 属性
语法：document.getElementById(id).attribute = new value();
<img id="image" src="https://www.baidu.com/img/bd_logo1.png" />
<script>
	document.getElementById("image").src = "https://static.shiyanlou.com/img/shiyanlou_logo.svg";
</script

--够改变 HTML 元素的样式
语法为：document.getElementById(id).style.property = new style();
<p id="syl" style="color: red;">实验楼</p>
<script>
    document.getElementById("syl").style.color = "green";
</script>
```

**DOM 节点**

```css
根据 W3C 的 HTML DOM 标准，HTML 文档中的所有内容都是节点：整个文档就是一个文档节点，而每一个 HMTL 标签都是一个元素节点。HTML 标签中的文本则是文本节点，HTML 标签的属性是属性节点，一切都是节点。
```

| 节点             | 名称         | 含义                              |
| ---------------- | ------------ | --------------------------------- |
| Document         | 文档节点     | 整个文档(window.document)         |
| DocumentType     | 文档类型节点 | 文档的类型                        |
| Element          | 元素节点     | HTML元素(比如<head>, <body>等)    |
| Attribute        | 属性节点     | HTML元素的属性(比如class="right") |
| Text             | 文本节点     | HTML文档中出现的文本              |
| DocumentFragment | 文档碎片节点 | 文档的片段                        |

```css
DocumentFragment在文档中没有对应的标记。DOM规定文档片段 ( document fragment)是一种"轻量级"的文档，可以包含和控制节点，但不会像完整的文档那样占用额外的资源。

虽然不能把文档片段直接添加到文档中，但可以将它作为一个"仓库"来使用，即可以在里面保存将来可能会添加到文档中的节点。要创建文档片段，可以使用document .createDocumentFragment()。
var fragment=document .createDocumentFragment();
```

**DOM 节点操作**

- 节点之间的关系

| 父节点     | 兄弟节点               | 子节点            | 所有子节点 |
| ---------- | ---------------------- | ----------------- | ---------- |
| parentNode | nextSibling            | firstChild        | childNodes |
|            | nextElementSibling     | firstElementChild | children   |
|            | previousSibling        | lastChild         |            |
|            | previousElementSibling | lastElementChild  |            |

```css
childNodes：它是标准属性，它返回指定元素的子元素集合，包括 HTML 节点，所有属性，文本节点。
children：非标准属性，它返回指定元素的子元素集合。但它只返回 HTML 节点，甚至不返回文本节点。
nextSibling 和 previousSibling 获取的是节点，获取元素对应的属性是 nextElementSibling 和 previousElementSibling。
nextElementSibling 和 previousElementSibling 有兼容性问题，IE9 以后才支持。
```
- 获取节点

```js
getElementById() 通过元素的 ID 而选取元素；//id：指定标签的唯一标识

getElementsByTagName() 通过标签名找到 HTML 元素；//所有同标签名元素
如果有多个同类型标签，可以通过下标来确认：
document.getElementsByTagName("input")[0].value = "hello";

getElementsByClassName() 通过类名来找到 HTML 元素；//所有同类名元素
document.getElementsByClassName("name"); // 返回包含 class = "name" 的所有元素的一个列表。

getElementsByName()通过name属性来找到 HTML 元素;//所有同名元素
```

- 节点操作

```js
创建节点：使用 createElement() 方法：
var par = document.createElement("p");

创建属性节点：使用 createAttribute() 方法。
创建文本节点：使用 createTextNode() 方法。

插入子节点：
appendChild () 方法向节点添加最后一个子节点。
insertBefore (插入的新的子节点，指定的子节点) 方法在指定的子节点前面插入新的子节点。如果第二个参数没写或者为 null，则默认插入到后面。

删除节点：使用 removeChild() 方法。语法为：
父节点.removeChild(子节点);
node.parentNode.removeChild(node); // 如果不知道父节点是什么，可以这样写

替换子节点：使用 replaceChild() 方法。语法为：
node.replaceChild(newnode, oldnode);

设置节点的属性：
获取：getAttribute(name)
设置：setAttribute(name, value)
删除：removeAttribute(name)
```

**DOM 事件**

```js
事件的定义:在什么时候执行什么事。在js中都以on开头

事件三要素:
事件由：事件源 + 事件类型 + 事件处理程序组成。

事件源：触发事件的元素。

事件类型：事件的触发方式（比如鼠标点击或键盘点击）。

事件处理程序：事件触发后要执行的代码（函数形式，匿名函数）。
```

| 常用事件    | 说明                                 |
| ----------- | ------------------------------------ |
| onclick     | 鼠标单击                             |
| ondblclick  | 鼠标双击                             |
| onkeyup     | 按下并释放键盘上的一个键时触发       |
| onchange    | 文本内容或下拉菜单中的选项发生改变   |
| onfocus     | 获得焦点，表示文本框等获得鼠标光标。 |
| onblur      | 失去焦点，表示文本框等失去鼠标光标。 |
| onmouseover | 鼠标悬停，即鼠标停留在图片等的上方   |
| onmouseout  | 鼠标移出，即离开图片等所在的区域     |
| onload      | 网页文档加载事件                     |
| onunload    | 关闭网页时                           |
| onsubmit    | 表单提交事件                         |
| onreset     | 重置表单时                           |

```html
例子 1 ：鼠标单击事件：
<p onclick="this.innerHTML = '我爱学习，身体好好!'">请点击该文本</p>

例子 2 ：鼠标双击事件：
<h1 ondblclick="changetext(this)">请点击该文本</h1>
<script>
    function changetext(id) {
    id.innerHTML = "我爱学习，身体棒棒!";}
</script>

例子 3 ：鼠标移除悬停：
<div  onmouseover="mOver(this)"  onmouseout="mOut(this)"
      style="background-color:deepskyblue;width:200px;height:100px;">
      把鼠标移到上面
</div>
<script>
    function mOver(obj) {
    	obj.innerHTML = "你把鼠标移到了上面 ";}
    function mOut(obj) {
   		obj.innerHTML = "你把鼠标移开了";}
</script>

例子 3 ：点击换颜色：
<style>
    #list li {
    list-style-type: none;
    width: 100px;
    height: 50px;
    line-height: 50px;
    background-color: beige;
    text-align: center;
    float: left;}
    #list li.current {
    background-color: red;}
    #list li a {
    text-decoration: none;}
</style>

<div id="menu">
    <ul id="list">
        <li class="current">
            <a href="javascript:void(0)">首页</a>
        </li>
        <li>
            <a href="javascript:void(0)">HTML</a>
        </li>
    </ul>
</div>
<script>
    // 获取所有的 li 标签
    var liObjs = document.getElementById("list").getElementsByTagName("li");
    // 循环遍历，找到每个 li 中的 a，注册点击事件
    for (var i = 0; i < liObjs.length; i++) {
        // 每个 li 中的 a
        var aObj = liObjs[i].firstElementChild;
        aObj.onclick = function () {
            // 把这个 a 所在的 li 的所有的兄弟元素的类样式全部移除
            for (var j = 0; j < liObjs.length; j++) {
                liObjs[j].removeAttribute("class");}
            //当前点击的 a 的父级元素 li(点击的这个 a 所在的父级元素 li)，设置背景颜色
            this.parentNode.className = "current";};
    }
</script>
```

### 面向对象

JavaScript 是一门脚本语言。它支持多种编程方式，面向对象编程就是其中一种。

**快速使用**

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title></title>
    <style type="text/css">
      div,
      p {
        width: 200px;
        height: 100px;}
    </style>
  </head>
  <body>
    <div>你好吗？</div>
    <p>我很好</p>
    <div>测试一下嘛</div>
    <p>好的啊</p>
    <script>
      var test = {
          getEle: {
              tag: function(tagName){
                  return document.getElementsByTagName(tagName);
              },
              id: function(idName){
                  return document.getElementById(idName);
              },
              class: function(className){
                  return document.getElementsByClassName(className);
              }
          },
          setCss: {
              setStyle: function(arr){
                  for(var i = 0; i < arr.length; i++) {
                      arr[i].style.backgroundColor = "red";
                  }
              },
              updateCss: function(){},
              deleteCss: function(){}
              // ...
          }；
      }
      var divs = test.getEle.tag("div");
      test.setCss.setStyle(divs);
      var ps = test.getEle.tag("p");
      test.setCss.setStyle(ps);
    </script>
  </body>
</html>
```



### 其他

**调试**

```js
设置断点：在调试界面在 Sources 中行号处设置

添加变量到Watch：选取变量右键 Add selected text to watches

刷新、单步调试
```

**异常处理**

```js
--异常捕获

try {
  // 这里写可能出现异常的代码
} catch (err) {
  // 在这里写，出现异常后的处理代码
}
示例：
<input type="button" value="点击一下" onclick="message()" />
<script>
var txt = "";
function message() {
    try {
        alertt("我爱学习，身体好好"); // 故意写错 alert
        alert("我爱学习，身体好好");
    } catch (err) {
        txt = "There was an error on this page.\n\n";
        txt += "Error description: " + err.message + "\n\n";
        txt += "Click OK to continue.\n\n";
        alert(txt);}
}
</script>

--throw 语句

通过 throw 语句，我们可以创建自定义错误。throw 语句常常和 try catch 语句一起使用。
示例：
<p>请输入 0 到 100 之间的数字：</p>
<input id="demo" type="text" />
    <button type="button" onclick="myFunction()">测试输入值</button>
<p id="throwText"></p>
<script>
    function myFunction() {
    try {
        var x = document.getElementById("demo").value;
        if (x == "") throw "您输入的值为空";
        if (isNaN(x)) throw "您输入的不是数字";
        if (x > 100) throw "您输入的值太大";
        if (x < 0) throw "您输入的值太小";
    } catch (err) {
        var y = document.getElementById("throwText");
        y.innerHTML = "错误提示：" + err + "。";
    }
}
</script>
```

