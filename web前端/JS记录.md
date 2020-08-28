# Callback Hell

**回调是啥？**

其实就是在执行某些操作（吃饭）后，得到特定数据（盘子），再去调用的一个方法（洗盘子）。

```js
do('eat', (dishes) => {
    //吃完饭,拿到盘子，去洗盘子
    washDishes(dishes)
})

//上面的代码，包括ajax、各种模块的方法等等，他们都是回调函数。
//js中Lambda表达式用 =>
```

**为什么叫回调地狱？**

```js
$.ajax1(url, () => {
    $.ajax2(url, () => {
        $.ajax3(url, () => {
            doSomething()
        })
    })
})
```

如果在写业务代码时，有几个接口需要使用，接口A需要接口B的回调res参数去请求数据， 所以就会写成三四个回调函数嵌套。

若果很多的话，这个类似场景就爆炸了！

**这样写的缺点：**

- 代码耦合，一旦修改，原地爆炸。
- 无法使用try catch，就无法排错，也是原地爆炸。

**什么是回调地狱？答案：**

> 1. 因为javascript是单线程的，所以有些需要等待的地方，需要使用回调函数。
> 2. 由于某些业务的问题，在代码中会一次性写会多层的回调嵌套，回调嵌套后的代码的维护难度，和无法排除bug。这个就被称作回调地狱。
> 3. 我在工作中，一般处理的方式是使用promise或者async函数。

# Promise

## 简介

**Promise为何出现？**

为了解决callback Hell

```js
let eat = () => {
    return new Promise((resolve, reject) => {
        resolve('俺吃好啦,给你盘子')
    })
}

eat.then( res => {
    //拿到盘子开始洗
    let washResult = washDishes(res);
    return washResult;
}).then(res => {
    //洗完盘子后，你妈妈甚至还奖励你吃冰淇淋！
    eatIceCream(res)
})
```

**Promise就像追求女孩**

它有三种状态：等待中（pending） 完成了 （resolved） 拒绝了（rejected）。

>   1. 你给阿珍送了跟项链，阿珍在想，到底要不要接受呢？这个就是pending 等待中。
>   2. 阿珍觉得你挺不错，接受你了！这个就是resovled 完成了。
>  3. 阿珍不想接受你，拒绝你了，整个流程碰到错误了有问题了。这就是reject 拒绝了
>

## Promise的状态

promise有三种状态:

1. pending （初始化状态：等待）
2. resolved（成功）
3. rejected （失败）

Promise对象的状态改变，只有两种可能：从pending变为resolved、从pending变为rejected，之后状态不会再改变且状态不可逆。

## 用法

1. new Promise 实例 要return
2. 传入函数 要有resolve，reject 俩参数
3. 成功执行resolve 失败 reject
4. then 监听结果并且接收结果

### 1. 基本使用

不使用Promise，模拟一个callback Hell

```javascript
function loadImg(src, callback, fail){
  var img = document.createElement('img')
  img.onload = function () {
    callback(img)
  }
  img.onerror = function () {
    fail()
  }
  img.src = src
}
var src = 'www.s.com/index/logo.png'

loadImg(src, function (img) {
  console.log(img.width)// callback Hell 我们还要做好多事情 这样看的就很不友好
}, function () {
  console.log('failed')
})
```

使用Promise

```javascript
function loadImg(src) {
  const promise = new Promise(function(resolve,reject){
    img.onload = function () {
      resolve(img)
    }
    img.onerror = function () {
      reject()
    }
    img.src = src
  })
  return promise
}
var src = 'www.s.com/index/logo.png'

loadImg(src).result.then().then()
```

### 2. catch捕获

catch通常用于最后统一捕获,如我们try catch一样

Error和reject都可以捕获

```javascript
result.then(function(img){
    // dosomthing
}).then(function(){
    // dosomthing
}).catch(function(error){
    console.log(error)
})
```

### 3. 多个串联

如果我们希望我们的需求按顺序加载（例如，先加载用户信息，然后再通过用户信息渲染好友列表之类的）

我们需要在.then之后return 另外一个Promise 就可以了

```javascript
var src1 = 'www.xxx.com/1.jpg'
var src2 = 'www.xxx.com/2.jpg'
var img1 = loadImg(src1)
var img2 = loadImg(src2)

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

### 4. Promise.all

Promise.all 接收一个Promose对象数组 **待全部完成之后** 一起执行success。（有点像JS中短路操作的 且&&）

.then方法接收的datas是一个数组,依次包含多个Promise返回值

```javascript
Promise.all([result1,result2]).then(datas => {
  console.log(datas[0])
  console.log(datas[1])
})
```

### 5. Promise.race

和all不一样的是 **数组中只要有一个完成** 就执行success。 (参考JS短路操作的 或||)

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

这个东西呢，其实就是一层语法糖，加上async命令的函数，会return出一个promise。

