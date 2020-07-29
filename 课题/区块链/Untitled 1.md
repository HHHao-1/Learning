# 以太坊

## 简介

> 去中心化应用平台
>
> 区块链2.0
>
> 是一个全新开放的区块链平台，允许任何人在平台中建立和使用通过区块链技术运行的去中心化应用。就像比特币一样，以太坊不受任何人控制，也不归任何人所有——它是一个开放源代码项目。和比特币协议有所不同的是，以太坊的设计十分灵活，极具适应性，在以太坊平台上创立新的应用十分简便。

## 详述

> 以太坊是可编程的区块链。它并不是给用户一系列预先设定好的操作（例如比特币交易），而是允许用户按照自己的意愿创建复杂的操作。这样一来，它就可以作为多种类型去中心化区块链应用的平台，包括加密货币在内但并不仅限于此。
>
> 以太坊狭义上是指一系列定义去中心化应用平台的协议，它的核心是**以太坊虚拟机（“EVM”）**，可以执行任意复杂算法的编码。在计算机科学术语中，以太坊是“图灵完备的”。开发者能够使用现有的JavaScript和Python等语言为模型的其他友好的编程语言，创建出在以太坊模拟机上运行的应用。
>
> 和其他区块链一样，以太坊也有一个点对点网络协议。以太坊区块链数据库由众多连接到网络的节点来维护和更新。每个网络节点都运行着以太坊模拟机并执行相同的指令。因此，人们有时形象地称以太坊为“世界电脑”。
>
> 这个贯穿整个以太坊网络的大规模并行运算并不是为了使运算更高效。实际上，这个过程使得在以太坊上的运算比在传统“电脑”上更慢更昂贵。然而，每个以太坊节点都运行着以太坊虚拟机是为了保持整个区块链的一致性。去中心化的一致使以太坊有极高的故障容错性，保证零停机，而且可以使存储在区块链上的数据保持永远不变且抗审查。
>
> 以太坊平台本身没有特点，没有价值性。和编程语言相似，它由企业家和开发者决定其用途。不过很明显，某些应用类型较之其他更能从以太坊的功能中获益。以太坊尤其适合那些在点与点之间自动进行直接交互或者跨网络促进小组协调活动的应用。例如，协调点对点市场的应用，或是复杂财务合约的自动化。比特币使个体能够不借助金融机构、银行或政府等其他中介来进行货币交换。以太坊的影响可能更为深远。理论上，任何复杂的金融活动或交易都能在以太坊上用编码自动且可靠地进行。除金融类应用外，任何对信任、安全和持久性要求较高的应用场景——比如资产注册、投票、管理和物联网——都会大规模地受到以太坊平台影响。

## 区块链

> 区块链技术是比特币的底层技术，一个区块链是一个分布式计算架构，里面的每个网络节点执行并记录相同的交易，交易被分组为区块。一次只能增加一个区块，每个区块有一个数学证明来保证新的区块与之前的区块保持先后顺序。这样一来，区块链的“分布式数据库”就能和整个网络保持一致。个体用户与总账的互动（交易）受到安全的密码保护。由数学执行并编码到协议中的经济激励因素刺激着维持和验证网络的节点。
>
> 在比特币中，分布式数据库被设想为一个账户余额表，一个总账，交易就是通过比特币的转移以实现个体之间无需信任基础的金融活动。但是随着比特币吸引了越来越多开发者和技术专家的注意，新的项目开始将比特币网络用于有价代币转移之外的其他用途。其中很多都采用了“代币”的形式——以原始比特币协议为基础，增加了新的特征或功能，采用各自加密货币的独立区块链。

## 工作流程

> 以太坊合并了很多对比特币用户来说十分熟悉的特征和技术，同时自己也进行了很多修正和创新。比特币区块链纯粹是一个关于交易的列表，而以太坊的基础单元是账户。以太坊区块链跟踪每个账户的状态，所有以太坊区块链上的状态转换都是账户之间价值和信息的转移。账户分为两类：外部账户(EOA) 和 合约账户
>
> 外部账户（EOA），由私人密码控制合约账户，由它们的合约编码控制，只能由外部账户“激活” 对于大部分用户来说，两者基本的区别在于外部账户是由人类用户掌控——因为他们能够控制私钥，进而控制外部账户。而合约账户则是由内部编码管控。如果他们是被人类用户“控制”的，那也是因为程序设定它们被具有特定地址的外部账户控制，进而被持有私钥控制外部账户的人控制着。“智能合约”这个流行的术语指的是在合约账户中编码——交易被发送给该账户时所运行的程序。用户可以通过在区块链中部署编码来创建新的合约。
>
> 只有当外部账户发出指令时，合约账户才会执行相应的操作。所以合约账户不可能自发地执行诸如任意数码生成或应用程序界面调用等操作—只有受外部账户提示时，它才会做这些事。这是因为以太坊要求节点能够与运算结果保持一致，这就要求保证严格确定执行。
>
> 和比特币一样，以太坊用户必须向网络支付少量交易费用。这可以使以太坊区块链免受无关紧要或恶意的运算任务干扰，比如分布式拒绝服务（DDoS）攻击或无限循环 。交易的发送者必须在激活的“程序”每一步付款，包括运算和记忆储存。费用通过以太坊自有的有价代币，以太币的形式支付。
>
> 交易费用由节点收集，节点使网络生效。这些“矿工”就是以太坊网络中收集、传播、确认和执行交易的节点。矿工们将交易分组——包括许多以太坊区块链中账户“状态”的更新——分成的组被称为“区块”，矿工们会互相竞争，以使他们的区块可以添加到下一个区块链上。矿工们每挖到一个成功的区块就会得到以太币奖励。这就为人们带来了经济激励，促使人们为以太坊网络贡献硬件和电力。
>
> 和比特币网络一样，矿工们有解决复杂数学问题的任务以便成功地“挖”到区块。这被称为“工作量证明”。一个运算问题，如果在算法上解决，比验证解决方法需要更多数量级的资源，那么它就是工作证明的极佳选择。为防止比特币网络中已经发生的，专门硬件（例如特定用途集成电路）造成的中心化现象，以太坊选择了难以存储的运算问题。如果问题需要存储器和CPU，事实上理想的硬件是普通的电脑。这就使以太坊的工作量证明具有抗特定用途集成电路性，和比特币这种由专门硬件控制挖矿的区块链相比，能够带来更加去中心化的安全分布。

## 智能合约

> 将合约条款代码化
>
> 以太坊上的程序,是代码和数据(状态)的集合
>
> 典型应用：代币: EOS ，游戏：迷恋猫

你愿意和从未谋面的人签合约吗？你会同意把钱借给埃塞俄比亚的农民吗？你愿意投资一个战乱地区由少数人管理的报纸吗？你会不嫌麻烦为了网上一次5美元的购买签一个有法律效力的合约吗？

大多数的答案都是否定的，原因是合约需要的基础太多了：有时需要双方之间互相信任的工作关系，有时要依靠合法的工作体系、警察和律师费用。

在以太坊这些都不需要：**如果合约所必需的要求都能放在区块链中，那么就会放在区块链中，这是一个无需信任基础也几乎不用任何成本的环境**。

 不要想将你现有的合约转移到区块链中会麻烦，想一想那些因为经济上不可行或是没有足够法律保护而被你拒绝的成千上万的小合约吧。

## DAO

> Decentralized Autonomous Organization，简称DAO，一般翻译为去中心化的自治组织。

这里简单地举个例子：想象一下你和朋友有个小生意。律师和会计很贵，完全信任让一个单独的合伙人来看管账簿可能让你精神很紧张（这甚至可能是个诈骗的机会）。你可以尝试一下多个合伙人共同看管账簿，但只要协议没有被严格遵守，就可能导致诈骗发生。

使用智能合约，公司的所有权和基金分配的条款可以在一开始就详细规定。智能合约签署的方式是，只有大部分拥有者批准，合约才可以变更。 这样的智能合约可以像开源软件一样获取，你甚至都不必雇佣自己的程序员来代替会计和律师。

这样的智能合约可以立即按比例决定分配。几个年轻人分配柠檬水站收入，可以像主权基金给拥有基金的亿万公民分配收益一样透明。在这两个案例中，这种透明性带来的花费可能每美元连一美分都不到。

## 客户端

进入到Homestead阶段以后，Go客户端占据了主导地位，但情况并不一直是这样，将来也并不必然如此。除了EthereumH，其他客户端都有Homestead兼容的版本。

| 客户端         | 语言       | 开发者       | 最新版本                        |
| -------------- | ---------- | ------------ | ------------------------------- |
| go-ethereum    | Go         | 以太坊基金会 | go-ethereum-v1.4.9              |
| Parity         | Rust       | Ethcore      | Parity-v1.2.1                   |
| cpp-ethereum   | C++        | 以太坊基金会 | cpp-ethereum-v1.2.9             |
| pyethapp       | Python     | 以太坊基金会 | pyethapp-v1.2.3                 |
| ethereumjs-lib | Javascript | 以太坊基金会 | ethereumjs-lib-v3.0.0           |
| Ethereum(J)    | Java       |              | ethereumJ-v1.3.0-RC3-daoRescue2 |
| ruby-ethereum  | Ruby       | Jan Xie      | ruby-ethereum-v0.9.3            |
| ethereumH      | Haskell    | BlockApps    | 尚无Homestead 版本              |

# Solidity

## 简介

以太坊Solidity是一种面向智能合约的高级语言，其语法与JavaScript类似。solidity是用于生成在EVM上执行的机器级代码的工具。solidity编译器获取高级代码并将其分解为更简单的指令。Solidity代码封装在Contracts中。

合约是以太坊去中心化应用程序的基本构建模块。所有变量和函数都是合约的一部分，这是所有项目的起点。一个名为MyFirst的空合约看起来像这样：

```css
version pragma ^0.4.19;
contract MyFirst{
}
```

## 布局

源文件可以包含任意数量的合约定义，包括指令和pragma指令。

### 编译器版本

Version Pragma是定义代码使用的Solidity编译器版本的声明。

```css
version pragma ^0.4.00;
```

注意：上面显示的源文件不会使用早于版本0.4.0的编译器进行编译，也不能在从版本0.5.0开始的编译器上运行。

### 导入

Ethereum Solidity支持与JavaScript中可用的导入语句非常相似的导入语句，尽管Solidity不知道`default export`的概念。在全局级别，可以使用以下形式的import语句：

```cpp
import "filename";
```

```jsx
import * as symbolName from "filename";
```

### 注释

```cpp
// This is a single-line comment.
/*
This is a
multi-line comment
*/
```

## 存储区域

### 变量存储区域

存储Storage：

```css
永久存储在区块链

storage 存储结构是在合约创建的时候就确定好了的，它取决于合约所声明状态变量。但内容可以被(交易)调用改变。
Solidity 称这个为状态改变，这也是合约级变量称为状态变量的原因。也可以更好的理解为什么状态变量都是storage存储。

storage 在区块链中是用key/value的形式存储
```

内存Memory：

```css
存储在内存，临时存储，当外部函数对某合约调用完成时，内存型变量即被移除

memory 只能用于函数内部，memory 声明用来告知EVM在运行时创建一块（固定大小）内存区域给变量使用。

memory 表现为字节数组
```

memory位置还包含2种类型的存储数据位置，一种是calldata，一种是栈（stack）

> （1）calldata
>
> ```css
> 这是一块只读的，且不会永久存储的位置，用来存储函数参数。 外部函数的参数（非返回参数）的数据位置被强制指定为 calldata ，效果跟 memory 差不多。
> ```
>
> （2） 栈（stack）
>
> ```css
> 保存小的局部变量，但只能保存有限数量的值。
> 
> EVM是一个基于栈的语言，栈实际是在内存(memory)的一个数据结构，每个栈元素占为256位，栈最大长度为1024。 值类型的局部变量是存储在栈上。
> ```

### gas消耗

storage 会永久保存合约状态变量，开销最大；

memory 仅保存临时变量，函数调用之后释放，开销很小；

stack 保存很小的局部变量，免费使用，但有数量限制(16个变量)；

calldata 的数据包含消息体的数据，其计算需要增加n*68的gas费用；

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