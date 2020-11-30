# 操作符

1. 扩展运算符:

```js
Const a = [1,2,3]
const b = [...a]

const odd = [1,3,5]
const nums = [2,4,6,...odd]
const nums = [2,...odd,4,6]

const {a,b,...z} = {a:1,b:2,c:3,d:4}
console.log(z) // {c:3,d:4}
```

2. 双非按位取反：

位运算中操作数会先转为整数

对于正数，它向下取整；对于负数，向上取整；非数字取值为0

```js
~~null;      // => 0
~~undefined; // => 0
~~false;     // => 0
~~true;      // => 1
~~1.9;       // => 1
~~-1.9;      // => -1

Math.floor(1.2)  // => 1
Math.floor(-1.2) // => -2
```

3. 用 | 取整

```js
1.2 | 0  // 1
-1.2 | 0 // -1
```

4. rest参数

```js
function test (...args){
    console.log(args)
}
test(1,2,3)
// [1, 2, 3]
```

# 简写总结

1. 短路求值

```js
if(a !== null || a !== undefined || a !== '' || a !== false) {
  let b = a;
}

==>  const b = a || 'new'
```

2. 三元操作符

```js
const x = 20;
let answer;
if(x > 10) {
  answer = 'is greater';
} else {
  answer = 'is lesser';
}

==> const answer = x > 10 ? 'is greater' : 'is lesser'
```

3. 数字指数

```js
10000000 === 1e7
for(let i = 0; i < 1e7; i++) {}
```

4. 对象属性

```js
const obj = { x:x, y:y }

==> const obj = { x, y }
```

5. 参数默认值

```js
function volume(l, w, k) {
  if(w === undefined) 
    w = 3;
  if(h === undefined)
    k = 4;
  return l * w * k
}

==> volume = (l, w = 3, k = 4) => (l * w * h);
==> volume(2) // 输出: 24
```

6. 模板字符串

```js
const welcome = 'You have logged in as' + first + ' ' + last + '.'
const lorem = 'Lorem ipsum dolor sit amet, consectetur\n\t'
    + 'adipisicing elit, sed do eiusmod tempor incididunt\n\t'

//使用反引号和${}
==> const welcome = `You have logged in as ${first} ${last}`
==> const lorem = `Lorem ipsum dolor sit amet, consectetur
	   adipisicing elit, sed do eiusmod tempor incididunt`
```

# 解构赋值

```js
//数组
const test = [101,102,103]
const [a,b,c] = test

const sum = ([a, b, c]) =>{ 
  console. log(a + b + c);
};
sum([1, 2, 3]);

//异步
axios.get('./data.json').then(({data})=>{
  console.log(data)
})
axios.get('./data.json').then(({data:{name,type}})=>{
  console.log(name-----type)
})

//变量互换
let a=1;
let b=2;
[a,b]=[b,a];

//Json
const json = '{"name":"es","price":"500"}';
const {name, price} = Json.parse(json)
console.log(name-----price)

//对象
const foo = ({name, age, school='XX学校'})=>{
  console.log(name, age, school)
};
foo({
  name: '张三',
  age: 20,
  school: 'imooc'
});

const {
  name: courseName, //别名
  price,
  teacher: {
    name, age
  }
} = course;
console.log(courseName, price, name, age);
```

# 箭头函数

箭头函数没有this，箭头函数的this是**继承父执行上下文里面的this** ，这里箭头函数的执行上下文是函数fun()，所以它就继承了fun()的this（这里this是定义函数时的对象---既实例）。

> 注意：
>
> 简单对象（非函数）是没有执行上下文的！
>
> 箭头函数没有 this、super、arguments 、 new.target 的绑定。

```js
var Person = {
    'age': 18,
    'sayHello': ()=>{
        console.log(this.age);
      }
};
var age = 20;
Person.sayHello();  // 20
// 此时 this 指向的是全局对象
 
var Person1 = {
    'age': 18,
    'sayHello': function () {
        console.log(this.age);
    }
};
var age = 20;
Person1.sayHello();   // 18
// 此时的 this 指向 Person1 对象
```

当箭头函数要返回对象的时候，为了区分于代码块，要用 **()** 将对象包裹起来

```js
var f = (id,name) => ({id: id, name: name}); 
f(6,2);  // {id: 6, name: 2}
```

# 迭代

1. for循环

```js
for(let i = 0; i < allImgs.length; i++)
  
----------------------------------------------------------------
for (let index in allImgs)

----------------------------------------------------------------
[2, 5, 9].forEach((value,index)=>console.log(value+'---'+index)); 

myMap.forEach(function(value, key) {
  console.log(key + " = " + value);
})
  
function logArrayElements(element, index) {
  console.log(`${index},${element}`);
}
[2, 5, 9].forEach(logArrayElements);
// 0,2
// 1,5
// 2,9

----------------------------------------------------------------
for (var [key, value] of myMap) {
  console.log(key + " = " + value);
}

/* 这个 entries 方法返回一个新的 Iterator 对象，它按插入顺序包含了 Map 对象中每个元素的 [key, value] 数组。 */
for (var [key, value] of myMap.entries()) {
  console.log(key + " = " + value);
}

for (var key of myMap.keys()) {
  console.log(key);
}

for (var value of myMap.values()) {
  console.log(value);

```

2. 迭代器

```js
const items = ["zero", "one", "two"];
const it = items[Symbol.iterator]();
 
it.next();
>{value: "zero", done: false}
it.next();
>{value: "one", done: false}
it.next();
>{value: "two", done: false}
it.next();
>{value: undefined, done: true}
```

# 模块化

1. 特点

ES6 的模块自动开启严格模式，不管你有没有在模块头部加上 **use strict;**（既变量必须声明）。

模块中可以导入和导出各种类型的变量，如函数，对象，字符串，数字，布尔值，类等。

每个模块都有自己的上下文，每一个模块内声明的变量都是局部变量，不会污染全局作用域。

每一个模块只加载一次（是单例的）， 若再去加载同目录下同文件，直接从内存中读取。

2. export default 

在一个文件或模块中，export、import 可以有多个，export default 仅有一个。

通过 export 方式导出，在导入时要加{ }，export default 则不需要。

export default 向外暴露的成员，可以使用任意变量来接收。

```js
var a = "My name is Tom!";
export default a; // 仅有一个
import b from "./xxx.js"; // 不需要加{}， 使用任意变量接收
```

3. 用法

```js
import { a } from "./xxx.js";
import { b } from "./xxx.js";
// 相当于 import { a, b } from "./xxx.js";

------------------------------------------------------------------
import {a} from "./xxx.js"
a = {}; // error
 
import {a} from "./xxx.js"
a.foo = "hello"; // a = { foo : 'hello' }

------------------------------------------------------------------
/*-----export [test.js]-----*/
let myName = "Tom";
let myAge = 20;
let myfn = function(){
    return "My name is" + myName + "! I'm '" + myAge + "years old."
}
let myClass =  class myClass {
    static a = "yeah!";
}
export { myName, myAge, myfn, myClass }
 
/*-----import [xxx.js]-----*/
import { myName, myAge, myfn, myClass } from "./test.js";
console.log(myfn());// My name is Tom! I'm 20 years old.
console.log(myAge);// 20
console.log(myName);// Tom
console.log(myClass.a );// yeah!

------------------------------------------------------------------
let myName = "Tom";
export { myName }
import { myName as name1 } from "./test1.js";
export { myName as exportName }
import { exportName } from "./test.js";

------------------------------------------------------------------
```

4. 复合使用

```js
export { foo, bar } from "methods";
 
// 约等于下面两段语句，不过上面导入导出方式该模块没有导入 foo 与 bar
import { foo, bar } from "methods";
export { foo, bar };
 
/* ------- 特点 1 --------*/
// 普通改名
export { foo as bar } from "methods";
// 将 foo 转导成 default
export { foo as default } from "methods";
// 将 default 转导成 foo
export { default as foo } from "methods";
 
/* ------- 特点 2 --------*/
export * from "methods";
```

5. import()函数

`import`命令会被 JavaScript 引擎静态分析，先于模块内的其他模块执行。

`import()`函数，完成动态加载。异步加载

`require`是运行时加载模块，只有运行时才知道。同步加载

- import() 返回一个 Promise 对象

应用场景：

```js
（1）按需加载。
button.addEventListener('click', event => {
  import('./dialogBox.js')
    .then(dialogBox => {
    dialogBox.open();
  })
});

（2）条件加载
if (condition) {
  import('moduleA').then(...);} 
else {
  import('moduleB').then(...);}

（3）动态的模块路径
//根据函数f的返回结果，加载不同的模块。
import(f()).then(...);
        

注意:
                 
（1）import()加载模块成功以后，这个模块会作为一个对象，当作then方法的参数。因此，可以使用对象解构赋值的语法，获取输出接口。
import('./myModule.js')
  .then(({export1, export2}) => {
  // ...·
});
import('./myModule.js')
  .then(myModule => {
  console.log(myModule.default);
});
import('./myModule.js')
  .then(({default: theDefault}) => {
  console.log(theDefault);
});

（2）如果想同时加载多个模块，可以采用下面的写法。
Promise.all([
  import('./module1.js'),
  import('./module2.js'),
  import('./module3.js'),
])
.then(([module1, module2, module3]) => {
  ···
});

（3）import()也可以用在 async 函数之中。
async function main() {
  const myModule = await import('./myModule.js');
  const {export1, export2} = await import('./myModule.js');
  const [module1, module2, module3] =
        await Promise.all([
          import('./module1.js'),
          import('./module2.js'),
          import('./module3.js'),
        ]);
}
```

# Symbol

表示独一无二的值，最大的用法是用来定义对象的唯一属性名。

ES6 原始数据类型类型除 Number 、 String 、 Boolean 、 Object、 null 和 undefined ，新增了 Symbol 。

```js
let sy = Symbol("KK");
console.log(sy);   // Symbol(KK)
typeof(sy);        // "symbol"
 
// 相同参数 Symbol() 返回的值不相等
let sy1 = Symbol("kk"); 
sy === sy1;       // false
```

使用场景：

```js
// 作为属性名
let sy = Symbol("key1");
let syObject = {
  [sy]: "kk"
};
console.log(syObject);    // {Symbol(key1): "kk"}
syObject[sy];  // "kk"
syObject.sy;   // undefined

//定义常量
const COLOR_RED = Symbol("red");
const COLOR_YELLOW = Symbol("yellow");
const COLOR_BLUE = Symbol("blue");

//Symbol.for()
/*首先会在全局搜索被登记的 Symbol 中是否有该字符串参数作为名称的 Symbol 值，如果有即返回该 Symbol 值，若没有则新建并返回一个以该字符串参数为名称的 Symbol 值，并登记在全局环境中供搜索。*/
let yellow = Symbol("Yellow");
let yellow1 = Symbol.for("Yellow");
yellow === yellow1;      // false
let yellow2 = Symbol.for("Yellow");
yellow1 === yellow2;     // true

//Symbol.keyFor()
/*Symbol.keyFor() 返回一个已登记的 Symbol 类型值的 key ，用来检测该字符串参数作为名称的 Symbol 值是否已被登记。*/
let yellow1 = Symbol.for("Yellow");
Symbol.keyFor(yellow1);    // "Yellow"
```

# new.target

函数调用中的 new.target

```js
//判断是否使用new方法调用
function Foo() {
  if (!new.target) throw "Foo() must be called with new";
  console.log("Foo instantiated with new");
}

Foo(); // throws "Foo() must be called with new"
new Foo(); // logs "Foo instantiated with new"
```

构造方法中的 new.target

```js
//new.target指向new的类
class A {
  constructor() {
    console.log(new.target.name);
  }
}

class B extends A { constructor() { super(); } }

var a = new A(); // A
var b = new B(); // B
```

# Map

**Map 与 Array的转换**

```js
var kvArray = [["key1", "value1"], ["key2", "value2"]];
 
// Map 构造函数可以将一个 二维 键值对数组转换成一个 Map 对象
var myMap = new Map(kvArray);
 
// 使用 Array.from 函数可以将一个 Map 对象转换成一个二维键值对数组
var outArray = Array.from(myMap);
```

**Map 的克隆**

```js
var myMap1 = new Map([["key1", "value1"], ["key2", "value2"]]);
var myMap2 = new Map(myMap1);
 
console.log(original === clone); 
// 打印 false。 Map 对象构造函数生成实例，迭代出新的对象。
```

**Map 的合并**

```js
var first = new Map([[1, 'one'], [2, 'two'], [3, 'three'],]);
var second = new Map([[1, 'uno'], [2, 'dos']]);
 
// 合并两个 Map 对象时，如果有重复的键值，则后面的会覆盖前面的，对应值即 uno，dos， three
var merged = new Map([...first, ...second]);
```

# Set

> Set 对象允许你存储任何类型的唯一值，无论是原始值或者是对象引用。
>
> Set 对象存储的值总是唯一的，所以需要判断两个值是否恒等。有几个特殊值需要特殊对待：
>
> - +0 与 -0 在存储判断唯一性的时候是恒等的，所以不能重复；
> - undefined 与 undefined 是恒等的，所以不能重复；
> - NaN 与 NaN 是不恒等的，但是在 Set 中只能存一个，不能重复。

**Set 与 Array的转换**

```js
// Array 转 Set
var mySet = new Set(["value1", "value2", "value3"]);
//  Set 转 Array
var myArray = [...mySet];
String
// String 转 Set
var mySet = new Set('hello');  // Set(4) {"h", "e", "l", "o"}
// 注：Set 中 toString 方法是不能将 Set 转换成 String
```

**Set 对象的作用**

1. **数组去重**

```js
var mySet = new Set([1, 2, 3, 4, 4]); 
[...mySet]; // [1, 2, 3, 4]
```

2. **并集**

```js
var a = new Set([1, 2, 3]); 
var b = new Set([4, 3, 2]); 
var union = new Set([...a, ...b]); // {1, 2, 3, 4}
```

3. **交集**

```js
var a = new Set([1, 2, 3]); 
var b = new Set([4, 3, 2]); 
var intersect = new Set([...a].filter(x => b.has(x))); // {2, 3}
```

4. **差集**

```js
var a = new Set([1, 2, 3]); 
var b = new Set([4, 3, 2]); 
var difference = new Set([...a].filter(x => !b.has(x))); // {1}
```

# 字符串

> - **includes()**：返回布尔值，判断是否找到参数字符串。
>
> - **startsWith()**：返回布尔值，判断参数字符串是否在原字符串的头部。
>
> - **endsWith()**：返回布尔值，判断参数字符串是否在原字符串的尾部。
>
>   如果需要知道子串的位置，还是得用 indexOf 和 lastIndexOf 。
>
>   这三个方法如果传入了正则表达式而不是字符串，会抛出错误。而 indexOf 和 lastIndexOf 这两个方法，它们会将正则表达式转换为字符串并搜索它。
>
> - **repeat()**：返回新的字符串，表示将字符串重复指定次数返回。
> - **padStart**：返回新的字符串，表示用参数字符串从头部（左侧）补全原字符串。
> - **padEnd**：返回新的字符串，表示用参数字符串从尾部（右侧）补全原字符串。

```js
//这三个方法都可以接受两个参数，需要搜索的字符串，和可选的搜索起始位置索引。
let string = "apple,banana,orange";
string.includes("banana");     // true
string.startsWith("apple");    // true
string.endsWith("apple");      // false
string.startsWith("banana",6)  // true

console.log("Hello,".repeat(2));  // "Hello,Hello,"

console.log("h".padStart(5,"o"));  // "ooooh"
console.log("h".padEnd(5,"o"));    // "hoooo"
```

# let 与 const

let 声明的变量只在 let 命令所在的代码块内有效

const 声明一个只读的常量，一旦声明，常量的值就不能改变

let 和 const 声明的变量不存在变量提升，其作用域都是块级作用域，凡是在声明变量之前使用变量就会报错

暂时性死区：在代码块内，使用`let`命令声明变量之前，该变量都是不可用的。这在语法上，称为“暂时性死区”（temporal dead zone，简称 TDZ）。

```js
if (true) {
  // 死区开始
  lzp = 'lut'; //  ReferenceError
  console.log(lzp); //  ReferenceError
 
  // 开始声明变量，死区结束
  let lzp; 
  console.log(lzp); // undefined
 
  lzp = 520;
  console.log(lzp); // 520
```

# Promise

- **回调地狱**

```js
$.ajax1(url, () => {
    $.ajax2(url, () => {
        $.ajax3(url, () => {
            doSomething()
        })
    })
})
```

- **简介**

promise有三种状态:

1. pending （初始化状态：等待）
2. fulfilled（已成功）
3.  rejected（已失败）

Promise对象的状态改变，只有两种可能：从pending变为fulfilled、从pending变为rejected，之后状态不会再改变且状态不可逆。

- **用法**

1. 传入函数 要有resolve，reject 俩参数
2. 成功执行resolve 失败 reject
3. then 监听结果并且接收结果

```javascript
//在 JavaScript 事件队列的当前运行完成之前，回调函数永远不会被调用。
const p = new Promise(function(resolve,reject){
  resolve('success');
});
 
p.then(function(value){
  console.log(value);
})

//Error和reject都可以捕获
p.catch(function(error){
    console.log(error)
});
 
console.log('first');
// first
// success

------------------------------------------------------------------
//链式操作
img1.then(function(img){
  console.log('图片一加载完成', img)
  return img2 //接下来就是对img2进行异步操作了
}).then(function(img){
  console.log('图片二加载完成', img)
}).catch(function(e){
  console.log(e)
})
```

- **Promise.all**

Promise.all 接收一个Promose对象数组 **待全部完成之后** 一起执行success。

.then方法接收的datas是一个数组,依次包含多个Promise返回值

```javascript
Promise.all([result1,result2]).then(datas => {
  console.log(datas[0])
  console.log(datas[1])
})
```

- **Promise.race**

和all不一样的是 **数组中只要有一个完成** 就执行success。

```javascript
Promise.race([result1,result2]).then(data => {
  console.log(data)
})
```

# async/await

```js
async function eat () {
    let washResult = await washDishes();
    let eatIceCream = await buyIceCream(washResult);
    let eatCake = await buyCake(eatIceCream);
    //你妈妈看你吃的多，再奖励大胖儿子一个cake！
}
```

加上async命令的函数，会return出一个promise，可再.then去添加回调。

await 操作符用于等待一个 Promise 对象, 它只能在异步函数 async function 内部使用。

await针对所跟不同表达式的处理方式：

- Promise 对象：await 暂停执行，等 Promise 对象 resolve，然后恢复 async 函数的执行并返回解析值。
- 非 Promise 对象：直接返回对应的值。

# Generator 函数

- 语法

其中yield的作用就是暂停，没有别的作用。

Generator函数是一个状态机,封装了多个内部状态。

执行Generator函数会返回一个遍历器对象。

也就是说, Generator函数除了状态机,还是一个遍历器对象生成函数。返回的遍历器对象,可以依次遍历Generator函数内部的每一个状态。

- 形式

一是, function关键字与函数名之间有一个星号。

二是，函数体内部使用yield表达式,定义不同的内部状态 。

- 示例

```js
// next方法
function* g() {
    var o = 1;
    var a = yield o++;
    console.log('a = ' + a);
    var b = yield o++;
}
var gen = g();
console.log(gen.next());
console.log('------');
console.log(gen.next(11));
// {value: 1, done: false}
// a = 11
// {value: 2, done: false}
---------------------------------------------------------------
// 遍历
function* foo() {
  yield 1;
  yield 2;
  yield 3;
}
let a = foo();
for (let v of a) {
  console.log(v);
}// 1 2 3
---------------------------------------------------------------
// return方法
function* gen() {
  yield 1;
  yield 2;
  yield 3;
}
var g = gen();
console.log(g.next());        // { value: 1, done: false }
console.log(g.return('foo')); // { value: "foo", done: true }
console.log(g.next());        // {value: undefined, done: true}
---------------------------------------------------------------
// yield*语句
function* bar() {
  yield 'x';
  yield* foo();
  yield 'y';
}
// ---上个函数等同于
function* bar() {
  yield 'x';
  yield 'a';
  yield 'b';
  yield 'y';
}
// ---也等同于
function* bar() {
  yield 'x';
  for (let v of foo()) {
    yield v;
  }
  yield 'y';
}
for (let v of bar()){
  console.log(v);
}
// "x"
// "a"
// "b"
// "y"
```

- 应用场景

化异步为同步

```js
function asy() {
    $.ajax({
        url: 'test.txt',
        dataType: 'text',
        success() {
            console.log("我是异步代码");
        }
    })
}
 
function* gener() {
    let asy = yield asy();
    yield console.log("我是同步代码");
}
let it = gener().next();
it.then(function() {
    it.next();
})
// 我是异步代码
// 我是同步代码
```

```js
// 浏览器编译之后
function gener() {
    // let asy = yield asy(); 替换为
    $.ajax({
        url: 'test.txt',
        dataType: 'text',
        success() {
            console.log("我是异步代码");
            // next 之后执行以下
            console.log("我是同步代码");
        }
    })
    // yield console.log("我是同步代码");
}
```

# Class 类

> class 的本质是 function。
>
> 它可以看作一个语法糖，让对象原型的写法更加清晰、更像面向对象编程的语法。

```js
// 匿名类
let Example = class {
    constructor(a) {
        this.a = a;
    }
}
// 命名类
let Example = class Example {
    constructor(a) {
        this.a = a;
    }
}
```

## 属性

静态属性

静态属性：class 本身的属性，即直接定义在类内部的属性（ Class.propname ），不需要实例化。 ES6 中规定，Class 内部只有静态方法，没有静态属性。

```js
class Example {
// 新提案
    static a = 2;
}
// 目前可行写法
Example.b = 2;
```

原型属性

```js
class Example{} 
Example.prototype.a = 2;
```

实例属性

实例属性：定义在实例对象（ this ）上的属性。

```js
class Example {
    a = 2;
    constructor () {
        console.log(this.a);
    }
}
```

## 方法

  对象方法

```js
function People(name)
{
  this.name=name;
  this.Introduce=function(){
    alert("My name is "+this.name);
  }
}

var p1=new People("Windking");
p1.Introduce();
```

类方法

```js
class Example{
    static sum(a, b) {
        console.log(a+b);
    }
}
Example.sum(1, 2); // 3

People.Run=function(){
  alert("I can run");
}
```

原型方法

```js
class Example {
    sum(a, b) {
        console.log(a + b);
    }
}
let exam = new Example();
exam.sum(1, 2); // 3

People.prototype.IntroduceChinese=function(){
  alert("我的名字是"+this.name);
}
```

构造方法

```js
class Example {
    constructor(a,b) {
        this.sum = a+b;
        }
    }
}
```

## 原型属性\方法

- 实例对象可直接访问，可以在new实例之后添加，也可添加到实例上

- 写在原型中的方法可以被所有的实例共享， 实例化的时候不会在实例内存中再复制一份，占有的内存消耗少。

- js中每个函数(类的本质是函数)都有一个prototype属性，这个属性指向一个对象（所有属性的集合（除静态属性外））

- 默认constructor的值指向这个函数(类)本身。

- 每个原型对象都属于对象，所以它也有自己的原型，而它自己的原型对象又有自己的原型，所以就形成了原型链。

- js的继承也就是通过原型链来实现的，当访问一个对象的属性，如果这个属性不存在，则沿着__proto__依次往上查找，如果有则返回值，没有则一直到查到Object.prototype的__proto__的值为null.

  - ```js
    console.log(Cat.__proto__.__proto__.__proto__)//null
    Cat.__proto__等于Animal.prototype ,
    Animal.prototype.__proto__等于Object.prototype.
    ```

  - 这里ch是在new出aaa实例后添加的原型属性

    ![image-20201130101953194](https://tva1.sinaimg.cn/large/0081Kckwly1gl6zgbt3z3j30j20eymyu.jpg)

  - \__proto__是Chrome的标准，不通用

    ```js
    // 通用获取原型对象
    Object.getPrototypeOf(aaa)// =aaa.__proto__,推荐
    aaa.constructor.prototype// =aaa.__proto__，不推荐，间接获取，aaa.constructor是获取原始函数,可调用静态属性、方法
    ```

- 示例

```js
function Animal() {
  //实例属性
  this.name = name || 'Animal';
  //实例方法
  this.sleep = function () {
    console.log(this.name + "正在睡觉")
  }
  this.play=function(play){
    console.log(this.name+'正在玩'+ play)
  }
}
// 原型属性
Animal.prototype.play1 = 1;
// 原型方法
Animal.prototype.play2 = function (play2) {
  console.log(play2)
}
```

## 私有属性\方法

- 私有属性\方法只能在函数内部，用this. 调用

```js
// ES6可用
function Animal() {
  this.name = name || 'Animal'; //公有
  var/let/const a = 1;
  var/let/const b = () => {
    console.log(123);
  }

// ES11
class Person {
  name;   // 公有
  #age;   // 私有
  #a=()=>{ //私有
  console.log(123)
}
}
```



## 实例化

```js
class Example {}
new Example(); 
```

## 继承

```js
class Father {
  constructor() {}//有默认构造函数，其中return this
}
class Child extends Father {
  constructor() {
    //子类 constructor 方法中必须有 super ，且必须出现在 this 之前。
    super();
  }
}
let test = new Child();
```

# 对象

## 对象字面量

- 属性的简洁表示法

```js
const age = 12;
const name = "Amy";
const person = {age, name};
person   //{age: 12, name: "Amy"}
//等同于
const person = {age: age, name: name}
```

- 方法名简写

```js
const person = {
  sayHi(){
    console.log("Hi");
  }
}
person.sayHi();  //"Hi"
//等同于
const person = {
  sayHi:function(){
    console.log("Hi");
  }
}
person.sayHi();//"Hi"

//如果是Generator 函数，则要在前面加一个星号:
const obj = {
  * myGenerator() {
    yield 'hello world';
  }
};
//等同于
const obj = {
  myGenerator: function* () {
    yield 'hello world';
  }
};
```

- 属性名表达式

```js
const obj = {
 ["he"+"llo"](){
   return "Hi";
  }
}
obj.hello();  //"Hi"
```

## 对象的新方法

- Object.assign(target, source_1, ···)

用于将源对象的所有可枚举属性复制到目标对象中。

```js
let target = {a: 1};
let object2 = {b: 2};
let object3 = {c: 3};
Object.assign(target,object2,object3);  
// 第一个参数是目标对象，后面的参数是源对象
target;  // {a: 1, b: 2, c: 3}
```

**注意：**

1. assign 的属性拷贝是浅拷贝

```js
let sourceObj = { a: { b: 1}}; 

let targetObj = {c: 3}; 

Object.assign(targetObj, sourceObj); 

targetObj.a.b = 2; sourceObj.a.b;  // 2
```

2. 同名属性替换

```js
targetObj = { a: { b: 1, c:2}}; 

sourceObj = { a: { b: "hh"}}; 

Object.assign(targetObj, sourceObj); 

targetObj;  // {a: {b: "hh"}}
```

3. 数组的处理

```js
Object.assign([2,3], [5]);  // [5,3]
//会将数组处理成对象，所以先将 [2,3] 转为 {0:2,1:3} ，然后再进行属性复制，所以源对象的 0 号属性覆盖了目标对象的 0。
```

- Object.is(value1, value2)

用来比较两个值是否严格相等，与（===）基本类似

```js
Object.is("q","q");      // true
Object.is(1,1);          // true
Object.is([1],[1]);      // false
Object.is({q:1},{q:1});  // false
```

与（===）的区别

```js
//一是+0不等于-0
Object.is(+0,-0);  //false
+0 === -0  //true

//二是NaN等于本身
Object.is(NaN,NaN); //true
NaN === NaN  //false
```

# 数组

## 创建

- Array.of()

将参数中所有值作为元素形成数组。

```js
// 参数值可为不同类型
console.log(Array.of(1, '2', true)); // [1, '2', true]
 
// 参数为空时返回空数组
console.log(Array.of()); // []
```

- Array.from()

将类数组对象或可迭代对象转化为数组。

类数组对象：一个类数组对象必须有 length 属性，且元素属性名必须是数值或者可转换为数值的字符。

```js
// 参数为数组,返回与原数组一样的数组
console.log(Array.from([1, 2])); // [1, 2]
 
// 参数含空位
console.log(Array.from([1, , 3])); // [1, undefined, 3]
```

参数

`Array.from(arrayLike[, mapFn[, thisArg]])`

返回值为转换后的数组。

```js
arrayLike
想要转换的类数组对象或可迭代对象。
console.log(Array.from([1, 2, 3])); // [1, 2, 3]

mapFn
可选，map 函数，用于对每个元素进行处理，放入数组的是处理后的元素。
console.log(Array.from([1, 2, 3], (n) => n * 2)); // [2, 4, 6]

thisArg
可选，用于指定 map 函数执行时的 this 对象。
let map = {
    do: function(n) {
        return n * 2;
    }
}
let arrayLike = [1, 2, 3];
console.log(Array.from(arrayLike, function (n){
    return this.do(n);
}, map)); // [2, 4, 6]
```

## 操作

### 增删

```js
1.splice(index,howmany,[item1,...]):从数组中添加/删除元素,返回被删除项，注意：此操作会改变原始数组。
index	必需。整数，规定添加/删除项目的位置，使用负数可从数组结尾处规定位置。
howmany	必需。要删除的项目数量。如果设置为 0，则不会删除项目。
item1, ..., itemX	可选。向数组添加的新项目。
                        
2.slice(start,[end])：从已有数组中返回选定元素,此操作不会修改原始数组。

3.shift()：删除数组第一个元素，返回删除项，改变原始数组，不产生新数组。

4.unshift(newelement1,[...]):在数组开头添加一或多个元素，并返回新的长度。改变原数组，不产生新数组。

5.pop():删除数组最后一个元素，并返回删除的值，若是操作空数组，返回undefined。改变原数组。

6.push(element1，[......]):向数组末尾添加一个或多个元素，返回数组长度。直接修改原数组。
```

###  拼接

```
concat(arrayX,......):连接两个或多个数组，返回被连接数组的副本，不会改变原始数组。
```

### 倒序

```
reverse():颠倒数组元素顺序，改变原始数组，不会创建新数组。
```

### 排序

```
sort():对现有数组进行排序，改变原始数组。此方法会在排序之前首先对数组的每一项调用toString()方法，再进行排序
```

### 分割为字符串

```
join([separator]):对数组元素以指定的分隔符进行分隔，参数为空，默认以“，”进行分隔。返回值是分隔后形成的字符串
```

### 查找

**find()**

查找数组中符合条件的元素,若有多个符合条件的元素，则返回第一个元素。

```js
let arr = Array.of(1, 2, 3, 4); 
console.log(arr.find(item => item > 2)); // 3  
// 数组空位处理为 undefined 
console.log([, 1].find(n => true)); // undefined
```

**findIndex()**

查找数组中符合条件的元素索引，若有多个符合条件的元素，则返回第一个元素索引。

```js
let arr = Array.of(1, 2, 1, 3); // 参数1：回调函数 
// 参数2(可选)：指定回调函数中的 this 值 
console.log(arr.findIndex(item => item = 1)); // 0  
// 数组空位处理为 undefined 
console.log([, 1].findIndex(n => true)); //0
```

### 填充

**fill()**

将一定范围索引的数组元素内容填充为单个指定的值。

```js
let arr = Array.of(1, 2, 3, 4); 
// 参数1：用来填充的值 
// 参数2：被填充的起始索引 
// 参数3(可选)：被填充的结束索引，默认为数组末尾 
console.log(arr.fill(0,1,2)); // [1, 0, 3, 4]
```

**copyWithin()**

将一定范围索引的数组元素修改为此数组另一指定范围索引的元素。

```js
// 参数1：被修改的起始索引 
// 参数2：被用来覆盖的数据的起始索引 
// 参数3(可选)：被用来覆盖的数据的结束索引，默认为数组末尾 
console.log([1, 2, 3, 4].copyWithin(0,2,4)); // [3, 4, 3, 4]  
// 参数1为负数表示倒数 
console.log([1, 2, 3, 4].copyWithin(-2, 0)); // [1, 2, 1, 2]  
console.log([1, 2, ,4].copyWithin(0, 2, 4)); // [, 4, , 4]
```

### 遍历

**entries()**

遍历键值对。

```js
for(let [key, value] of ['a', 'b'].entries()){
    console.log(key, value);
}
// 0 "a"
// 1 "b"
 
// 不使用 for... of 循环
let entries = ['a', 'b'].entries();
console.log(entries.next().value); // [0, "a"]
console.log(entries.next().value); // [1, "b"]
 
// 数组含空位
console.log([...[,'a'].entries()]); // [[0, undefined], [1, "a"]]
```

**keys()**

遍历键名。

```js
for(let key of ['a', 'b'].keys()){
    console.log(key);
}
// 0
// 1
 
// 数组含空位
console.log([...[,'a'].keys()]); // [0, 1]
```

**values()**

遍历键值。

```js
for(let value of ['a', 'b'].values()){
    console.log(value);
}
// "a"
// "b"
 
// 数组含空位
console.log([...[,'a'].values()]); // [undefined, "a"]
```

### 包含

**includes()**

数组是否包含指定值。

注意：与 Set 和 Map 的 has 方法区分；Set 的 has 方法用于查找值；Map 的 has 方法用于查找键名。

```js
// 参数1：包含的指定值
[1, 2, 3].includes(1);    // true
 
// 参数2：可选，搜索的起始索引，默认为0
[1, 2, 3].includes(1, 2); // false
 
// NaN 的包含判断
[1, NaN, 3].includes(NaN); // true
```

### 嵌套数组转一维数组

**flat()**

```js
console.log([1 ,[2, 3]].flat()); // [1, 2, 3]
 
// 指定转换的嵌套层数
console.log([1, [2, [3, [4, 5]]]].flat(2)); // [1, 2, 3, [4, 5]]
 
// 不管嵌套多少层
console.log([1, [2, [3, [4, 5]]]].flat(Infinity)); // [1, 2, 3, 4, 5]
 
// 自动跳过空位
console.log([1, [2, , 3]].flat());<p> // [1, 2, 3]
```

**flatMap()**

先对数组中每个元素进行了的处理，再对数组执行 flat() 方法。

```js
// 参数1：遍历函数，该遍历函数可接受3个参数：当前元素、当前元素索引、原数组
// 参数2：指定遍历函数中 this 的指向
console.log([1, 2, 3].flatMap(n => [n * 2])); // [2, 4, 6]
```

# Proxy和Reflect

## Proxy

Proxy用于修改某些操作的默认行为，Proxy意思为“代理”，即在访问对象之前建立一道“拦截”，任何访问该对象的操作之前都会通过这道“拦截”，即执行Proxy里面定义的方法。

```jsx
//Proxy的基本用法
let pro = new Proxy(target,handler);
```

其中 new Proxy相当于创建了一个Proxy实例，target为所要拦截的目标对象，handler也是一个对象，里面定义的是对拦截对象所要进行的拦截方法。

```js
let target = {
    name: 'Tom',
    age: 24
}
let handler = {
    get: function(target, key) {
        console.log('getting '+key);
        return target[key]; // 不是target.key
    },
    set: function(target, key, value) {
        console.log('setting '+key);
        target[key] = value;
    }
}
let proxy = new Proxy(target, handler)
proxy.name     // 实际执行 handler.get
proxy.age = 25 // 实际执行 handler.set
// getting name
// setting age
// 25

------------------------------------------------------------------
let exam ={
    name: "Tom",
    age: 24
}
let proxy = new Proxy(exam, {
  get(target, propKey, receiver) {
    console.log('Getting ' + propKey);
    return target[propKey];
  }
})
proxy.name 
// Getting name
// "Tom"
```

实例方法

```js
1. 拦截对对象属性的访问
// receiver 表示原始操作行为所在对象，一般是 Proxy 实例本身
get(target, propKey, receiver)
set(target, propKey, value, receiver)
has(target, propKey)//此方法不拦截 for ... in 循环
construct(target, args)//用于拦截 new 命令，返回值必须为对象
deleteProperty(target, propKey)
defineProperty(target, propKey, propDesc)

2.拦截函数的调用
//target 表示目标对象，ctx 表示目标对象上下文，args 表示目标对象的参数数组。
apply(target, ctx, args)

function sub(a, b){
    return a - b;
}
let handler = {
    apply: function(target, ctx, args){
        console.log('handle apply');
        return Reflect.apply(...arguments);
    }
}
let proxy = new Proxy(sub, handler)
proxy(2, 1) 
// handle apply
// 1
```

## Reflect

将Object对象的属于语言内部的方法放到Reflect对象上，即从Reflect对象上拿Object对象内部方法。

将用 老Object方法 报错的情况，改为返回false

**静态方法**

```js
//Reflect 对象的方法与 Proxy 对象的方法是一一对应的
Reflect.get(target, name, receiver)
Reflect.set(target, name, value, receiver)
Reflect.has(obj, name)
Reflect.deleteProperty(obj, property)
Reflect.construct(obj, args)
```

## 结合使用

Reflect 静态方法与 Proxy 对象的方法是一一对应的。所以 Proxy 对象的方法可以通过调用 Reflect 对象的方法获取默认行为，然后进行额外操作。

```js
let exam = {
    name: "Tom",
    age: 24
}
let handler = {
    get: function(target, key){
        console.log("getting "+key);
        return Reflect.get(target,key);
    },
    set: function(target, key, value){
        console.log("setting "+key+" to "+value)
        Reflect.set(target, key, value);
    }
}
let proxy = new Proxy(exam, handler)
proxy.name = "Jerry"
proxy.name
// setting name to Jerry
// getting name
// "Jerry"
```

# -------- 补充 --------

# NaN

NaN 和任何值甚至和自己都不相等(NaN !== NaN 返回true)

# 数值

二进制表示法: 前缀 0b 或 0B 。

八进制表示法: 前缀 0o 或 0O 。

八进制表示法: 前缀 0x 或 0X 。

# arguments

已被ES6的rest参数代替

 是一个对应于传递给函数参数的**类数组对象**。

```js
//实现可变参数，既方法重载
function add() {
    let sum = 0;
    for(let i in arguments){
    sum+=arguments[i]
    }
    return sum 
}
add(1,2) //3
```

# apply、call、bind

```js
Color.apply(Box, [outcol, incol]);//列表传参
Shape.call(this, length, width, height);//数组传参
Test.bind(this,a,b)();//返回一个函数
Test.bind(this)(a,b));//函数传参
```

1. 借用别人的方法实现自己的功能

```js
function a(b,c){
  return c-b
}

function ab(b,c){}

a.apply(ab,[1,2])
// 1
```

2. 改变this指向

```JS
function Color(outcol, incol) {
  this.outcol = outcol;
  this.incol = incol;
}
function Shape(length, width, height) {
  this.length = length;
  this.width = width;
  this.height = height;
}
function Test(a, b) {
  this.a1 = a;
  this.b1 = b;
}
function Box(outcol, incol, length, width, height,a,b) {
  // 借助已有的实现自己的
  Color.apply(Box, [outcol, incol]);
  Shape.call(this, length, width, height);//this指向Box实例对象
  //Test.bind(this,a,b)();返回一个函数
  //Test.bind(this)(a,b));
}
var box2 = new Box("red", "blue", 200, 150, 140,'a','b');
```

# 函数参数

```js
function fn(name,age=17){
 console.log(name+","+age);
}
fn("Amy",18);  // Amy,18
fn("Amy","");  // Amy,
fn("Amy");     // Amy,17
```



# 函数三种定义方式

函数关键字(function)语句：

`function fnMethodName(x){alert(x);}`

函数字面量(Function Literals)：

`var fnMethodName = function(x){alert(x);}`

Function()构造函数：

`var fnMethodName = new Function(‘x','alert(x);') `// 由Function构造函数的参数个数可变。最后一个参数写函数体，前面的参数写入参。

# 原型&原型链

## 概念

> `prototype`是函数才有的属性，这个属性指向函数的原型。
>
> `__proto__`是每个对象都有的属性，这个属性会指向该对象的原型。
>
> 作用：
>
> 原型链无处不在，==**类的概念由原型链模拟**==，如果没有原型链，也就没有父类。 像`toString`等方法，没有原型链，难道都定义一遍？ 当访问a.b的时候，首先会查找a对象的b属性，如果没有，然后依次按照`prototype`往上找直到找到`Object.prototype`为止，没有则返回`undefined`，所以说无处不在。

![img](https://tva1.sinaimg.cn/large/0081Kckwly1gkc91inelmj30ge0elmxz.jpg)

![image-20201017134441511](https://tva1.sinaimg.cn/large/007S8ZIlgy1gjsa4cuwgvj313r0m2gou.jpg)

```js
let a ='123'
String.prototype === a.__proto__
//true
String.prototype.__proto__
//{constructor: ƒ, __defineGetter__: ƒ, __defineSetter__: ƒ, hasOwnProperty: ƒ, __lookupGetter__: ƒ, …}
String.prototype.__proto__.__proto__
//null
String.prototype.__proto__ === Object.prototype
//true
String.prototype.__proto__.constructor === Object
//true
```

## 函数对象与字面量对象

*这里对象的原型值Object的原型*

![图片描述](https://image-static.segmentfault.com/401/383/4013836435-5a7e7228d765b_articlex)

- 原型继承

1、使用函数对象

```js
// 原型链为(以对象b为例)：对象b-->函数原型对象-->Object原型对象-->null

var a=function(name){
    this.name=name;
};
a.prototype.sex="nan";
var b= new a("nihao");
console.log(b);
console.log(b.name);
console.log(b.sex);
 
var c=new a("test");
console.log(c);
console.log(c.name);
console.log(c.sex);

//a {name: "nihao"}
//nihao
//nan
//a {name: "test"}
//test
//nan
```

2、使用字面量对象

```js
var a={"name":"nihao"};
a.__proto__.sex="nan";
console.log(a);
console.log(a.name);
console.log(a.sex);

var b={};
console.log(b);
console.log(b.name);
console.log(b.sex);

// {name: "nihao"} 
// nihao 
// nan 
// {} 
// undefined 
// nan

b对象明明设置的为空啊？这是因为在执行a.__proto__.sex="nan";时候，程序向对象的原型上添加了一个属性sex，上图可解释。
```

