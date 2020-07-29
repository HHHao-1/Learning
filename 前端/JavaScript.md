# 简介

**概述**

> JavaScript，通常缩写为 JS，是一种高级的，解释执行的编程语言。JavaScript 是一门基于原型、函数先行的语言，是一门多范式的语言，它支持面向对象编程，命令式编程，以及函数式编程。它提供语法来操控文本、数组、日期以及正则表达式等，不支持 I/O，比如网络、存储和图形等，但这些都可以由它的宿主环境提供支持。
>

**JavaScript 的组成**

> - ECMAScript：JavaScript 的语法标准。
> - DOM：JavaScript 操作网页上的元素的 API。
> - BOM：JavaScript 操作浏览器的部分功能的 API。
>

**JavaScript 的特点**

> - 可以使用任何文本编辑工具编写，然后使用浏览器就可以执行程序。
> - 是一种解释型脚本语言：代码不进行预编译，从上往下逐行执行，不需要进行严格的变量声明。
> - 主要用来向 HTML 页面添加交互行为。
>

# 原理

## JS运行机制

### JavaScript单线程

既同一个时间只能做一件事。

> 作为浏览器脚本语言，JavaScript的主要用途是与用户互动，以及操作DOM。这决定了它只能是单线程，否则会带来很复杂的同步问题。比如，假定JavaScript同时有两个线程，一个线程在某个DOM节点上添加内容，另一个线程删除了这个节点，这时浏览器应该以哪个线程为准？
>
> 为了利用多核CPU的计算能力，HTML5提出Web Worker标准，允许JavaScript脚本创建多个线程，但是子线程完全受主线程控制，且不得操作DOM。所以，这个新标准并没有改变JavaScript单线程的本质。

### 任务队列

只要主线程空了，就会去读取"任务队列"。

> 任务可以分成两种，一种是同步任务（synchronous），另一种是异步任务（asynchronous）。
>
> 同步任务指的是，在主线程上排队执行的任务，只有前一个任务执行完毕，才能执行后一个任务；
>
> 异步任务指的是，不进入主线程、而进入"任务队列"（task queue）的任务，只有"任务队列"通知主线程，某个异步任务可以执行了，该任务才会进入主线程执行。

异步执行的运行机制如下（同步执行也是如此，因为它可以被视为没有异步任务的异步执行）

> （1）所有同步任务都在主线程上执行，形成一个执行栈（execution context stack）。
>
> （2）主线程之外，还存在一个"任务队列"（taskqueue）。只要异步任务有了运行结果，就在"任务队列"之中放置一个事件。
>
> （3）一旦"执行栈"中的所有同步任务执行完毕，系统就会读取"任务队列"，看看里面有哪些事件。对应的异步任务，结束等待状态，进入执行栈，开始执行。
>
> （4）主线程不断重复上面的第三步。

**异步任务**

```css
1. setTimeout和setInterval
2. DOM事件
3. Promise
4. process.nextTick
5. fs.readFile
6. http.get
```

任务队列又分为macro-task（宏任务）与micro-task（微任务），它们被分别称为task与job。

宏任务

```css
1. I/O
2. setTimeout
3. setInterval
4. setImmdiate
5. requestAnimationFrame
```

微任务

```css
1. process.nextTick
2. Promise
3. Promise.then
4. MutationObserver
```

宏任务和微任务的执行顺序

> 一次事件循环中，先执行宏任务队列里的一个任务，再把微任务队列里的所有任务执行完毕，再去宏任务队列取下一个宏任务执行。
>
> 注：在当前的微任务没有执行完成时，是不会执行下一个宏任务的。

### 事件和回调函数

> "任务队列"是一个事件的队列（也可以理解成消息的队列），IO设备完成一项任务，就在"任务队列"中添加一个事件，表示相关的异步任务可以进入"执行栈"了。主线程读取"任务队列"，就是读取里面有哪些事件。
>
> "任务队列"中的事件，除了IO设备的事件以外，还包括一些用户产生的事件（比如鼠标点击、页面滚动等等）。只要指定过回调函数，这些事件发生时就会进入"任务队列"，等待主线程读取。
>
> 所谓"回调函数"（callback），就是那些会被主线程挂起来的代码。异步任务必须指定回调函数，当主线程开始执行异步任务，就是执行对应的回调函数。
>
> "任务队列"是一个先进先出的数据结构，排在前面的事件，优先被主线程读取。主线程的读取过程基本上是自动的，只要执行栈一清空，"任务队列"上第一位的事件就自动进入主线程。但是，由于存在后文提到的"定时器"功能，主线程首先要检查一下执行时间，某些事件只有到了规定的时间，才能返回主线程。

### Event Loop

> 主线程从"任务队列"中读取事件，这个过程是循环不断的，所以整个的这种运行机制又称为Event Loop（事件循环）。
>
> 主线程运行的时候，产生堆（heap）和栈（stack），栈中的代码调用各种外部API，它们在"任务队列"中加入各种事件（click，load，done）。只要栈中的代码执行完毕，主线程就会去读取"任务队列"，依次执行那些事件所对应的回调函数。
>
> 执行栈中的代码（同步任务），总是在读取"任务队列"（异步任务）之前执行。

### 定时器

除了放置异步任务的事件，"任务队列"还可以放置定时事件。

> setTimeout()接受两个参数，第一个是回调函数，第二个是推迟执行的毫秒数。
>
> setTimeout(fn,0)的含义是，指定某个任务在主线程最早可得的空闲时间执行，也就是说，尽可能早得执行。它在"任务队列"的尾部添加一个事件，因此要等到同步任务和"任务队列"现有的事件都处理完，才会得到执行。
>
> setTimeout()只是将事件插入了"任务队列"，必须等到当前代码（执行栈）执行完，主线程才会去执行它指定的回调函数。要是当前代码耗时很长，有可能要等很久，所以并没有办法保证，回调函数一定会在setTimeout()指定的时间执行。

##  回调函数

<img src="https://tva1.sinaimg.cn/large/007S8ZIlly1gfm1pbodt9j30m309mn02.jpg" alt="06796D9C-01C1-4DB4-975F-5C36861D03E0" style="zoom: 80%;" />

> 回调机制的优势：
> 可以把回调函数像参数一样传入中间函数。在传入一个回调函数之前，中间函数是不完整的，程序可以在运行时，通过登记不同的回调函数，来决定、改变中间函数的行为。这就比简单的函数调用要灵活太多，既用函数行为做函数的参数。
>
> 在JavaScript中，回调函数具体的定义为：函数A作为参数(函数引用)传递到另一个函数B中，并且这个函数B执行函数A。我们就说函数A叫做回调函数。如果没有名称(函数表达式)，就叫做匿名回调函数。
>
> 示例说明：
> 你到一个商店买东西，刚好你要的东西没有货，于是你在店员那里留下了你的电话，过了几天店里有货了，店员就打了你的电话，然后你接到电话后就到店里去取了货。在这个例子里，你的电话号码就叫回调函数，你把电话留给店员就叫登记回调函数，店里后来有货了叫做触发了回调关联的事件，店员给你打电话叫做调用回调函数，你到店里去取货叫做响应回调事件。



# 语法标准

## 快速使用

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

引用类型:对象（内置对象、自定义对象）,数组,函数
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

## 详细使用

- 变量

``` js
var
变量与其他程序设计语言相同,是用来临时存储信息

var x1 = 10;
x2 = 5.23;//变量可不作声明，变量 x 为整数
var n = prompt("请输入一个正整数");//js的input
```

```js
const定义的变量不可以修改，而且必须初始化。

1 const b = 2;//正确
2 // const b;//错误，必须初始化 
3 console.log('函数外const定义b：' + b);//有输出值
4 // b = 5;
5 // console.log('函数外修改const定义b：' + b);//无法输出 
```

```js
let
它的用法类似于var，但是所声明的变量，只在let命令所在的代码块内有效，而且有暂时性死区的约束。

用法

1.用let定义块级作用域变量；由于JS只有函数作用域和全局作用域，没有块级作用域，所以{}限定不了var声明变量的访问范围
{var i = 9;}
console.log(i);//9
{let i = 9;}
console.log(i);//i is not defined

2.let 配合for循环的独特应用
for (var i = 0; i < 10; i++) {
    setTimeout(function () {
        console.log(i);
    }, 1)
};//输出 10个 10
for (let i = 0; i < 10; i++) {
    setTimeout(function () {
       console.log(i);
    }, 0)
};//输出：0 1 2 3 4 5 6 7 8 9
```

```js
注意：

1.let和const没有变量提升

2.暂时性死区：
如果区块中存在let和const命令，这个区块对这些命令声明的变量，从一开始就形成了封闭作用域。凡是在声明之前就使用这些变量，就会报错。
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
0.所有对象继承了两个转换方法：
//直接转换为字符串形式
第一个是toString(),它的作用是返回一个反映这个对象的字符串
//每个JavaScript固有对象的 valueOf 方法定义不同
第二个是valueOf(),它的作用是返回它相应的原始值

1. toString() 方法
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

## js对象

- Object

```js
是所有JavaScript对象的基类
```

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
// 以上代码在html页面输出为 l08

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

- 操作对象

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

# Web API

## 简介

```css
浏览器是一个封装的较为完善的软件，它给我们提供了操作浏览器功能和页面元素的接口。

API（Application Programming Interface，应用程序编程接口）："计算机操作系统"（Operating system）或"程序库"提供给应用程序调用使用的代码。

API 本身是抽象的，它仅定义了一个接口，而不涉及应用程序在实际实现过程中的具体操作。

Web API 是浏览器提供的一套操作浏览器功能和页面元素的 API（BOM 和 DOM）。
```

## BOM

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

## DOM

**概述：操作网页上的元素的 API**

```css
文档对象模型（Document Object Model，简称 DOM），是 W3C 组织推荐的处理可扩展标志语言的标准编程接口。DOM 定义了访问 HTML 和 XML 文档的标准。DOM 可以把 HTML 看做是文档树，通过 DOM 提供的 API 可以对树上的节点进行操作。
```

**HTML内容操作**

```js
js获取text、html、属性值、value的方法：
document.getElementById("test").innerText；
document.getElementById("test").innerHTML；
document.getElementById("test").id；
document.getElementById("test1").value;

innerText-获取或设置元素的纯文本
innerHTML-获取或设置元素内部的HTML
id-获取或设置元素的属性
value-获取或设置输入项的值
```

```html
1.DOM 能够操作 HTML 的内容。

--改变 HTML 输出流
使用 document.write() 可用于直接向 HTML 输出流写内容。
document.write("新设置的内容<p>标签也可以生成</p>");

--改变 HTML 内容
使用 innerHTML 属性改变 HTML 内容。比如修改 p 标签中的内容：
<p id="p1">Hello World!</p>
<script>
   var a = document.getElementById("p1").innerHTML;//获取
   document.getElementById("p1").innerHTML = "Hello 实验楼";//改写
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
- 获取节点（选择器）

```js
getElementById() 通过元素的 ID 而选取元素；//id：指定标签的唯一标识

getElementsByTagName() 通过标签名找到 HTML 元素；//所有同标签名元素
如果有多个同类型标签，可以通过下标来确认：
document.getElementsByTagName("input")[0].value = "hello";

getElementsByClassName() 通过类名来找到 HTML 元素；//所有同类名元素
document.getElementsByClassName("name"); // 返回包含 class = "name" 的所有元素的一个列表。

getElementsByName()通过name属性来找到 HTML 元素;//所有同名元素

element = document.querySelector(CSS selectors)//回文档中匹配指定 CSS 选择器的一个元素
elementList = document.querySelectorAll(selectors);//返回文档中匹配指定 CSS 选择器的所有元素
elementList 是一个静态的 NodeList 类型的对象。
selectors 是一个由逗号连接的包含一个或多个 CSS 选择器的字符串。
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

# 面向对象

JavaScript 是一门脚本语言。它支持多种编程方式，面向对象编程就是其中一种。

## 快速使用

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

<!--如getEle的写法：对象字面量-->
```

## 原型：prototype

```js
在 js 中，每一个函数都有一个 prototype 属性，指向另一个对象。
这个对象的所有属性和方法，都会被构造函数的实例继承。
//构造函数创建实例，会多次创建sayHi()方法，浪费内存。
function Student(name, age, gender) {
  this.name = name;
  this.age = age;
  this.gender = gender;
}
Student.prototype.sayHi = function () {
  console.log("hi");
};
var s1 = new Student("zhangsan", 18, "male");
s1.sayHi(); // 打印 hi
var s2 = new Student("lisi", 18, "male");
s2.sayHi(); // 打印 hi
console.log(s1.sayHi == s2.sayHi); // 结果为 true,若构造函数结果为false
```

## 构造函数、实例、原型三者之间的关系

```js
每一个函数都有一个 prototype 属性，指向另一个对象。
<script type="text/javascript">
  function F() {}
  console.log(F.prototype);
</script>
打印结果为 Object，验证了我们所说的 prototype 属性，指向另一个对象。

构造函数的 prototype 对象默认都有一个 constructor 属性，指向 prototype 对象所在函数。
function F() {}
console.log(F.prototype.constructor === F); // 结果为 ture

通过构造函数得到的实例对象内部会包含一个指向构造函数的 prototype 对象的指针 __proto__
function F() {}
var a = new F();
console.log(a.__proto__ === F.prototype); // 结果为 true

实例对象可以直接访问原型对象成员，所有实例都直接或间接继承了原型对象的成员。

总结：每个构造函数都有一个原型对象，原型对象包含一个指向构造函数的指针 constructor，而实例都包含一个指向原型对象的内部指针__proto__。
```

## 原型链

```js
--所有的对象都有原型，而原型也是对象，也就是说原型也有原型，那么如此下去，也就组成了我们的原型链。

--属性搜索原则：

属性搜索原则，也就是属性的查找顺序，在访问对象的成员的时候，会遵循以下原则：
1.首先从对象实例本身开始找，如果找到了这个属性或者方法，则返回。
2.如果对象实例本身没有找到，就从它的原型中去找，如果找到了，则返回。
3.如果对象实例的原型中也没找到，则从它的原型的原型中去找，如果找到了，则返回。
4.一直按着原型链查找下去，找到就返回，如果在原型链的末端还没有找到的话，那么如果查找的是属性则返回 undefined，如果查找的是方法则返回 xxx is not a function。

--更简单的原型语法:

在前面的例子中，我们是使用 xxx.prototype. 然后加上属性名或者方法名来写原型，但是每添加一个属性或者方法就写一次显得有点麻烦，因此我们可以用一个包含所有属性和方法的对象字面量来重写整个原型对象：
function Student(name, age, gender) {
  this.name = name;
  this.age = age;
  this.gender = gender;
}
Student.prototype = {
  //手动将 constructor 指向正确的构造函数
  //若不写原型对象会丢失constructor 成员没最后一行结果为false
  constructor: Student, 
  hobby: "study",
  sayHi: function () {
    console.log("hi");
  },
};
var s1 = new Student("wangwu", 18, "male");
console.log(Student.prototype.constructor === Student); // 结果为 true

--原型链继承(原型对象可以继承)
在 JavaScript 中也有继承，接下来我们会学习原型链继承。原型链继承的主要思想是利用原型让一个引用类型继承另外一个引用类型的属性和方法。
s1.sayHi();// 打印 hi
//s1继承了 sayHi() 方法。
```

## Object.prototype

在浏览器控制台输入：Object.prototype可以查看原型

| 成员                              | 描述                                                         |
| --------------------------------- | ------------------------------------------------------------ |
| Object.prototype._proto           | 指向当对象被实例化的时候,用作原型的对象。                    |
| Object.prototype.hasOwnProperty() | 返回一个布尔值,用来判断一个属性是定义在对象本身而不是继承自原型链。 |
| Object.prototype.isPrototypeof()  | 返回一个布尔值,表示指定的对象是否在本对象的原型链中。        |
| Object.prototype.tostring()       | 返回一个表示该对象的字符串。                                 |
| Object.prototype.valueof ()       | 返回指定对象的原始值。                                       |



# 其他

## 调试

```js
设置断点：在调试界面在 Sources 中行号处设置

添加变量到Watch：选取变量右键 Add selected text to watches

刷新、单步调试
```

## 异常处理

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

## call()、apply()、bind()

```js
示例：
var name ='小王',age=17;
var obj={
    name:'小张'
    myFun: function(){
    console. log( this.name +"年龄"+this. age );}
}
obj.myFun()  // 小张年龄 undefined

var fav='盲僧';
function shows(){ console. log(this. fav);
shows () //盲僧               
```

```js
call()、apply()、bind() 都是用来重定义 this 这个对象的！

var name = '小王', age = 17;
var obj = {
    name: '小张',
    objAge: this.age,
    myFun: function (fm,t) {
    console.log(this.name + "年龄" + this.age, "来自" + fm + "去往" + t);}
}
var db ={
    name: "德玛",
    age: 99
}

obj.myFun.call(db,'成都','上海')；　　　　 // 德玛 年龄 99  来自 成都去往上海
obj.myFun.call( '成都', '上海') ;　　　　 // undefined年龄undefined 来自上海去往undefined
obj.myFun.call() ;　　　　 // 小王年龄17 来自undefined去往undefined
obj.myFun.apply(db,['成都','上海']);      // 德玛 年龄 99  来自 成都去往上海  
obj.myFun.bind(db,'成都','上海')();       // 德玛 年龄 99  来自 成都去往上海
obj.myFun.bind(db,['成都','上海'])();　　 // 德玛 年龄 99  来自 成都, 上海去往 undefined
```

```js
call 、bind 、 apply 这三个函数的第一个参数都是 this 的指向对象。

第二个参数差别就来了：
call 的参数是直接放进去的，第二第三第 n 个参数全都用逗号分隔;
apply 的所有参数都必须放在一个数组里面传进去;
bind 除了返回是函数以外，它的参数和 call 一样。

三者的参数都可选，也不限定是 string 类型，允许是各种类型，包括函数、object 等等！
```

## 递归

```js
例子：计算 1 到 10 之间的整数相加的和：

function foo(n) {
  if (n == 0) {
    return 0;
  } // 临界条件
  else {
    return n + foo(n - 1);
  }
}
var a = foo(10);
a; // 55

注：一定要写临界条件，不然程序无法结束并且会报错。
```

## 作用域

```css
块级作用域

在 JavaScript 中是没有块级作用域的。比如：
{
  var num = 123;
  {
    console.log(num);
  }
}
console.log(num);

上面的例子不会报错，而是打印两次 123，但是在其他编程语言中（C#、C、JAVA）会报错，这是因为在 JavaScript 中是没有块级作用域。也就是说，使用 {} 标记出来的代码块中声明的变量 num，是可以被 {} 外面访问到的。
```

```js
函数作用域
JavaScript 的函数作用域是指在函数内声明的所有变量在函数体内始终是可见的，函数外不可见。来看个例子：

function test() {
  var num = 123;
  console.log(num);
  if (2 == 3) {
    var k = 5;
    for (var i = 0; i < 10; i++) {}
    console.log(i);
  }
  // 不会报错，而是显示 undefined
  // 若干2==2，返回5 ；如果在函数外会报错：k is not defined  
  console.log(k); 
}
test();
```

```
全局作用域

全局作用域也就是说什么地方都能够访问到。不用 var 关键字，直接声明变量的话，那这个变量就是全局变量，它的作用域就是全局作用域。使用 window 全局对象来声明，全局对象的属性也是全局变量。另外在所有的函数外部用 var 声明的变量也是全局变量，这是因为内层作用域可以访问外层作用域。
```

## 程序运行顺序

JavaScript 是解释型的语言，但是它并不是真的在运行的时候完完全全的逐句的往下解析执行。

```js
实际运行顺序相当于：

var a;
var b;
.....
function a(){};
function b(){};
......
a()；
b();
......
a=1;
b=2;
......

//声明（变量、函数），会被按顺序提升到最前面
```

## 闭包

闭包是指函数可以使用函数之外定义的变量。

```js
简单的闭包
var num = 3;
function foo() {
  console.log(num);
}
foo(); //打印 3

复杂的闭包
function f1() {
  var num1 = 6;
  function f2() {
    var num2 = 7;
  }
  console.log(num1 + num2);
}
f1();
//f2 能够访问到它外层的变量 num1，但是 f1 是不能访问 f2 中的变量num2，所以报错。应修改：
function f1() {
  var num1 = 6;
  function f2() {
    var num2 = 7;
    return num2;
  }
  return f2();
  console.log(num1 + num2);
}
f1();
```

## arguments 对象

```js
function foo() {
  console.log(arguments[0]);
  console.log(arguments[1]);
}
foo(2, 3); // 打印 2 3
```

```js
function add() {
  var sum = 0;
  for (var i = 0; i < arguments.length; i++) {
    sum += arguments[i];
  }
  return sum;
}
add(); // 0
add(1, 2, 3); // 6
```

## Function 对象

```js
var function_name = new Function(arg1, arg2, ..., argN, function_body)
//注：每个参数都必须是字符串，function_body 是函数主体，也就是要执行的代码。

var add = new Function("a", "b", "console.log(a+b);");
add(2, 5); // 打印 7
```

```js
Function 对象的 length 属性

var add = new Function("a", "b", "console.log(a+b);");
console.log(add.length); // 打印 2，参数个数

Function 对象的方法

Function() 对象也有与所有对象共享的 valueOf() 方法和 toString() 方法。这两个方法返回的都是函数的源代码。
var add = new Function("a", "b", "console.log(a+b);");
console.log(add.valueOf());
console.log(add.toString());
```

# 问题记录

## export&import

### 1.Export

模块是独立的文件，该文件内部的所有的变量外部都无法获取。如果希望获取某个变量，必须通过export输出：

```js
// profile.js
export var firstName = 'Michael';
export var lastName = 'Jackson';
export var year = 1958;
```

```js
// profile.js
var firstName = 'Michael';
var lastName = 'Jackson';
var year = 1958;

export {firstName, lastName, year};
```

除了输出变量，还可以输出函数或者类（class），

```js
export function multiply(x, y) {
  return x * y;
};
```

还可以批量输出，同样是要包含在大括号里，也可以用as重命名：

```js
function v1() { ... }
function v2() { ... }

export {
  v1 as streamV1,
  v2 as streamV2,
  v2 as streamLatestVersion
};
```

**Attention:**

export 命令规定的是对外接口，必须与模块内部变量建立一一对应的关系

```js
// 写法一
export var m = 1;

// 写法二
var m = 1;
export {m};

// 写法三
var n = 1;
export {n as m};


// 报错
export 1;

// 报错
var m = 1;
export m;
```

报错的写法原因是：没有提供对外的接口，第一种直接输出1，第二种虽然有变量m，但还是直接输出1，导致无法解构。

同样的，`function`和`class`的输出，也必须遵守这样的写法。

```js
// 报错
function f() {}
export f;

// 正确
export function f() {};

// 正确
function f() {}
export {f};
```

And：export语句输出的接口，都是和其对应的值是动态绑定的关系，即通过该接口取到的都是模块内部实时的值。

位置：export模块可以位于模块中的任何位置，但是必须是在模块顶层，如果在其他作用域内，会报错。

```js
function foo() {
  export default 'bar' // SyntaxError
}
foo()
```

### 2.Import命令

export定义了模块的对外接口后，其他JS文件就可以通过import来加载这个模块：

```js
// main.js
import {firstName, lastName, year} from './profile';

function setName(element) {
  element.textContent = firstName + ' ' + lastName;
}
```

import命令接受一对大括号，里面指定要从其他模块导入的变量名，**必须与被导入模块（`profile.js`）对外接口的名称相同**。

如果想重新给导入的变量一个名字，可以用as关键字，

```js
import { lastName as surname } from './profile';
```

import后的from 可以指定需要导入模块的路径名，可以是绝对路径，也可以是相对路径， .js路径可以省略，如果只有模块名，不带有路径，需要有配置文件指定。

注意，`import`命令具有**提升效果**，会提升到整个模块的头部，首先执行。（是在编译阶段执行的）

因为import是静态执行的，不能使用表达式和变量，即在运行时才能拿到结果的语法结构（e.g. if...else...）

### 3.module的整体加载

除了指定加载某个输出值，还可以用（*）指定一个对象，所有的变量都会加载在这个对象上。

```js
// circle.js 输出两个函数
export function area(radius) {
  return Math.PI * radius * radius;
}
export function circumference(radius) {
  return 2 * Math.PI * radius;
}


// main.js 加载这个模块
import { area, circumference } from './circle';
console.log('圆面积：' + area(4));
console.log('圆周长：' + circumference(14));

//上面写法是逐一指定要加载的方法，整体加载的写法如下。
import * as circle from './circle';
console.log('圆面积：' + circle.area(4));
console.log('圆周长：' + circle.circumference(14));
```

注意，模块整体加载所在的那个对象（上例是`circle`），应该是可以**静态分析的**，所以不允许运行时改变。

```js
import * as circle from './circle';

// 下面两行都是不允许的
circle.foo = 'hello';
circle.area = function () {};
```

### 4.export default

之前的例子中，使用import导入时，都需要知道模块中所要加载的变量名或函数名，用户可能不想阅读源码，只想直接使用接口，就可以用export default命令，为模块指定输出

```js
// export-default.js
export default function () {
  console.log('foo');
}
```

其他模块加载该模块时，`import`命令可以为该匿名函数指定任意名字。

```js
// import-default.js
import customName from './export-default';
customName(); // 'foo'
```

export default也可以用于非匿名函数前。

下面比较一下默认输出和正常输出。

```js
// 第一组
export default function crc32() { // 输出
  // ...
}
import crc32 from 'crc32'; // 输入

// 第二组
export function crc32() { // 输出
  // ...
};
import {crc32} from 'crc32'; // 输入
```

可以看出，使用export default时，import语句不用使用大括号。

### import() 

**简介**

`import`和`export`命令只能在模块的顶层，不能在代码块之中。否则会语法报错。

这样的设计，可以提高编译器效率，但是没有办法实现运行时加载。

因为require是运行时加载，所以import命令没有办法代替require的动态加载功能。

所以引入了**import()函数**。完成动态加载。

```js
import(specifier)
```

specifier用来指定所要加载的模块的位置。import能接受什么参数，import()可以接受同样的参数。

import()返回一个Promise对象。

```js
const main = document.querySelector('main');

import(`./section-modules/${someVariable}.js`)
  .then(module => {
    module.loadPageInto(main);
  })
  .catch(err => {
    main.textContent = err.message;
  })
```

**import()适用场合**

 1）按需加载：

```js
button.addEventListener('click', event => {
  import('./dialogBox.js')
  .then(dialogBox => {
    dialogBox.open();
  })
  .catch(error => {
    /* Error handling */
  })
});
```

以上：import模块在事件监听函数中，只有用户点击了按钮，才会加载这个模块。

 2）条件加载：

import()可以放在if...else语句中，实现条件加载。

```js
if (condition) {
  import('moduleA').then(...);
} else {
  import('moduleB').then(...);
}
```

 