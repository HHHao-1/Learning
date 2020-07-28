

# solidity教程：solidity语言入门

### 什么是Solidity？

以太坊Solidity是一种面向智能合约的高级语言，其语法与JavaScript类似。solidity是用于生成在EVM上执行的机器级代码的工具。solidity编译器获取高级代码并将其分解为更简单的指令。Solidity代码封装在Contracts中。

### 以太坊合约中的solidity

合约是以太坊去中心化应用程序的基本构建模块。所有变量和函数都是合约的一部分，这是所有项目的起点。一个名为MyFirst的空合约看起来像这样：



```css
version pragma ^0.4.19;
contract MyFirst{
}
```

![img](https://upload-images.jianshu.io/upload_images/11831773-5210aaa8a79bc143.jpg?imageMogr2/auto-orient/strip|imageView2/2/w/280/format/webp)

image

盯紧你的屏幕因为接下来在我们的Solidity教程中我们将开始编码......

### Solidity文件的布局

源文件可以包含任意数量的合约定义，包括指令和pragma指令。

### Version Pragma

Version Pragma是定义代码使用的Solidity编译器版本的声明。



```css
version pragma ^0.4.00;
```

注意：上面显示的源文件不会使用早于版本0.4.0的编译器进行编译，也不能在从版本0.5.0开始的编译器上运行。

### 导入其他源文件

Ethereum Solidity支持与JavaScript中可用的导入语句非常相似的导入语句，尽管Solidity不知道`default export`的概念。

在全局级别，可以使用以下形式的import语句：



```cpp
import "filename";
```

上述语句将所有全局符号从`filename`导入当前全局范围。



```jsx
import * as symbolName from "filename";
```

### 注释

就像任何其他语言一样，Solidity可以使用单行和多行注释。



```cpp
// This is a single-line comment.
/*
This is a
multi-line comment
*/
```

现在，在我们进一步深入了解Solidity教程之前，应该知道以太坊有三个可以存储项目的区域。

- 存储Storage：所有合约状态变量所在的位置。每个合约都有自己的存储，并且在函数调用之间是持久的。
- 内存Memory：保存临时值并在（外部）函数调用之间擦除，并且使用起来更便宜。
- 堆栈Stack：保存小的局部变量并且几乎可以免费使用，但只能保存有限数量的值。

对于几乎所有类型，都无法指定它们应存储的位置，因为它们在每次使用时都会被复制。

好了，既然你已经知道以太坊Solidity中的存储位置，那么让我告诉你一般的值类型。

### solidity中的值类型

以下类型也称为值类型，因为这些类型的变量将始终按值传递。

![img](https://upload-images.jianshu.io/upload_images/11831773-db337755867d1e66.png?imageMogr2/auto-orient/strip|imageView2/2/w/768/format/webp)

image

#### 布尔

关键词：bool

值是常数，即true或false。

#### 整型

关键字：int/uint（uint8到uint256，步长为8（无符号，最多为256位），int8为int256）

各种大小的有符号和无符号整数。

例：



```csharp
contract MySample{
uint UnsignedInt =50;
}
```

在上面的语句中，我们创建了一个名为InsignedInt的uint并将其设置为50。

#### 地址

关键字：address

保存一个20字节的值（以太坊地址的大小）。地址类型也有`members`，并作为所有合约的基础。

#### 地址成员：balance与transfer

可以使用属性balance查询地址的余额，并使用transfer函数将以太网发送到地址。



```kotlin
address x = 0x123;
address myAddress = this;
if  (x.balance < 10 && myAddress.balance > = 10)
x.transfer(10);
```

#### 字符串

String：字符串文字用双引号或单引号如“foo”或'bar'编写。

用于任意长度的UTF数据。



```cpp
string language ="Solidity";
```

这些值类型可以在包含运算符的表达式中相互交互。接下来，在我们的Solidity教程中，让我告诉你各种运算符。

### 运算符

solidity的运算符与JavaScript相同。Solidity有四种类型的运算符：

![img](https://upload-images.jianshu.io/upload_images/11831773-9dc8c733c3bc5b76.png?imageMogr2/auto-orient/strip|imageView2/2/w/768/format/webp)

image

#### 算术运算符

Solidity具有非常简单的数学运算。以下与大多数编程语言类似：

- 增加：x + y
- 减法：x - y
- 乘法：x * y
- 除法：x / y
- 取整/求余：x％y

Solidity还提供了使用指数运算符的选项，具体如下：



```csharp
uint x = 10 **  3; // equal to 10^3 = 1000
```

#### 增量运算符

增量运算符的稳定性：a++，a- ，++a，-a，a+=1，a=a+1

适用于其他编程语言的规则也是类似的。

#### 按位运算符

以下是运算符:(按位OR）'|'，（按位异或），（按位求反）'~'，（按位右移）'>>'，（按位左移）'<<'

#### 逻辑运算符

Solidity中的逻辑运算符：!（逻辑否定），&&（逻辑和），||（逻辑或），==（相等），!=（不相等）

例：



```jsx
contract operators {
// Arithmetic Operators
// +,-,*,/, %, **
// Incremental Operators
// a++, a--, a+=1, a=a+1,++a,--a;
a=10;
a= a++; //here, output will be 10, because the value is first returned and then then increment is done
a=++a;
//Logical Operators
!, &&, ||, ==, !=
isOwner = true && false;
var orValue= 0x02 | 0x01; // output would be 0x03
//Bitwise Operators~,>>, <<;
function Operators() {
// Initialize state variables here}}
```

现在有时需要更复杂的数据类型。为此，Solidity提供结构。

### solidity数据结构

Solidity提供三种类型的数据结构：

![img](https://upload-images.jianshu.io/upload_images/11831773-01cea2a550393737.png?imageMogr2/auto-orient/strip|imageView2/2/w/768/format/webp)

image

#### 结构Structs

Solidity提供了一种以Structs形式定义新类型的方法。Structs是自定义类型，可以对多个变量进行分组。



```csharp
pragma solidity ^0.4.0;
contract Ballot {
struct Voter { // Struct
uint weight1, weight2, weight3;
bool voted;
address delegate1, delegate2, delegate3, delegate4;
string name;
uint vote1, vote2, vote3, vote4, vote5;
uint height1, height2, height3   } }
```

注意：结构只能有16个成员，超过该成员可能会发生以下错误：**Stack too Deep 堆栈太深。**

结构允许创建具有多个属性的更复杂的数据类型。

现在，如果你需要一些集合，比如说地址，那该怎么办？好吧，就像大多数语言一样，Solidity也有数组。

#### 数组Arrays

Solidity中的数组可以具有编译时固定大小，也可以是动态的。



```csharp
uint[3] fixed;  //array of fixed length 3
uint[] dynamic; //a dynamic array has no fixed size, it can keep growing
```

还可以创建一个结构数组。使用以前创建的Voter结构：



```css
Voter[] voting;
```

注意：将数组声明为public将自动为其创建getter方法。



```cpp
Voter[] public voting;
```

#### 映射mappings

映射可以看作是哈希表，它们被虚拟地初始化，使得每个可能的键都存在并被映射到其字节表示全为零的值：类型的默认值。

映射声明为：



```jsx
Mapping(_Keytype => _ValueType )
```

注意：_Keytype几乎可以是任何类型，除了动态大小的数组，合约，枚举和结构。

例：



```jsx
contract MappingExample {
mapping(address => uint) public balances;
function update(uint newBalance) {
balances[msg.sender] = newBalance;  }}
contract MappingUser {
function f() returns (uint) {
MappingExample m = new MappingExample();
m.update(100);
return m.balances(this);
}}
```

### 控制结构

除了switch和goto之外，JavaScript中的大多数控制结构都在Solidity中可用。

所以有：if，else，while，do，for，break，continue，return，？ ：，使用从C或JavaScript中已知的通常语义。

注意：没有像C和JavaScript那样从非布尔类型到布尔类型的类型转换。

现在让我们看看这些控制结构如何在Solidity中使用。



```csharp
contract ControlStructure {
address public a;
function ControlStructure>){
// if-else can be used like this
if(input1==2)
a=1;
else
a=0;
// while can be used like this
while(input1>=0){
if(input1==5)
continue;
input1=input1-1;
a++;}
// for loop can be used like this
for(uint i=0;i<=50;i++) { a++; if(a==4) break; } //do while can be used like this do { a--; } (while a>0);
// Conditional Operator can be used like this
bool IsTrue = (a == 1)?true: false;
/*will show an error because
there is no type conversion from non-boolean to boolean
*/
if(1)
{
}
```

继续我们的Solidity教程博客，让我们谈谈合约中可执行的代码单元。这些被称为函数。

### 函数

以下是在Solidity中声明函数的方式。



```csharp
function sampleFunc(string name, uint amount) {
}
```

上面声明的是一个空体函数，它有两个参数：一个字符串和一个uint。

可以这样调用此函数：



```bash
sampleFunc("Shashank", 10000);
```

谈到函数，Solidity还提供函数修饰符。

#### 函数修饰符

它用于轻松更改函数的行为。甚至在进行函数调用之前也可以检查这些条件，因为它们已在智能合约的函数定义中声明。

示例：如果要仅通过函数的所有者或创建者调用kill contract函数。



```php
contract FunctionModifiers{
address public creator;
function FunctionModifiers() {
creator = msg.sender;}
Modifier onlyCreator() {
if(msg.sender!=creator){
throw; }
_; //resumes the function wherever the access modifier is used
}
function killContract() onlyCreator{ //function will not execute if an exception occurs
self-destruct(creator); }}
```

### 继承

Solidity通过复制包含多态的代码来支持多重继承。



```php
contract Owned {
address Owner ;
function owned() {
owner = msg.sender;
}}
contract Mortal is Owned {  // 'is' keyword is used for inheritance
function kill(){
self-destruct(owner);   }}
contract User is Owned, Mortal //Multiple inheritance
{
string public UserName;
function User(string _name){
UserName = _name;
}}
```

好吧，我觉得上面讨论的概念足以让你开始使用Solidity编程。

去写代码吧!!

有了这个，我结束了这个Solidity Tutorial博客。我希望你喜欢阅读这篇博客并发现它内容丰富。到目前为止，必须对Solidity Programming Language的理解有所了解。现在去练习吧。

如果希望快速进行以太坊开发，那请看我们精心打造的教程：

[以太坊入门教程](http://xc.hubwiz.com/course/5a952991adb3847553d205d1?affid=928jianshu)，主要介绍智能合约与dapp应用开发，适合入门。

其他区块链教程如下：

> - [以太坊开发进阶教程](http://xc.hubwiz.com/course/5abbb7acc02e6b6a59171dd6?affid=928jianshu)，主要是介绍使用node.js、mongodb、区块链、ipfs实现去中心化电商DApp实战，适合进阶。
> - [java以太坊开发教程](http://xc.hubwiz.com/course/5b2b6e82c02e6b6a59171de2?affid=928jianshu)，主要是针对java和android程序员进行区块链以太坊开发的web3j详解。
> - [python以太坊](http://xc.hubwiz.com/course/5b40462cc02e6b6a59171de4?affid=928jianshu)，主要是针对python工程师使用web3.py进行区块链以太坊开发的详解。
> - [php以太坊](http://xc.hubwiz.com/course/5b36629bc02e6b6a59171de3?affid=928jianshu)，主要是介绍使用php进行智能合约开发交互，进行账号创建、交易、转账、代币开发以及过滤器和事件等内容。
> - [C#以太坊](http://xc.hubwiz.com/course/5b6048c3c02e6b6a59171dee?affid=928jianshu)，主要讲解如何使用C#开发基于.Net的以太坊应用，包括账户管理、状态与交易、智能合约开发与交互、过滤器和事件等。
> - [php比特币开发教程](http://xc.hubwiz.com/course/5b9e779ac02e6b6a59171def?affid=928jianshu)，本课程面向初学者，内容即涵盖比特币的核心概念，例如区块链存储、去中心化共识机制、密钥与脚本、交易与UTXO等，同时也详细讲解如何在Php代码中集成比特币支持功能，例如创建地址、管理钱包、构造裸交易等，是Php工程师不可多得的比特币开发学习课程。
> - [EOS入门教程](http://xc.hubwiz.com/course/5b52c0a2c02e6b6a59171ded?affid=928jianshu)，本课程帮助你快速入门EOS区块链去中心化应用的开发，内容涵盖EOS工具链、账户与钱包、发行代币、智能合约开发与部署、使用代码与智能合约交互等核心知识点，最后综合运用各知识点完成一个便签DApp的开发。

汇智网原创翻译，转载请标明出处。这里是[原文](http://blog.hubwiz.com/2018/09/27/ethereum-solidity/)