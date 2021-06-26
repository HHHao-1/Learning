

# Promise

- Promise 

```js
var p1 = new Promise((resolve, reject) => {
  var flag = true;
  if (flag) {
    resolve("成功数据1");
  } else {
    reject("失败数据1");
  }
});
var p2 = new Promise((resolve, reject) => {
  var flag = false;
  if (flag) {
    resolve("成功数据2");
  } else {
    reject("失败数据2");
  }
});
```

- then -- catch

```js
p1.then((res) => {
  console.log(res);
  console.log("这是成功操作");
}).catch((err) => {
  console.log(err);
  console.log("这是失败的操作");
});
```

- Promise.all
  - 接收一个Promose对象数组
  - 所有Promise执行了resolve才执行then，否则catch住reject的那一个Promise

```js
Promise.all([p1, p2])
  .then(datas => {
  console.log(datas[0]);
  console.log(datas[1]);
})
  .catch((err) => {
  console.log(err);
});
```

- Promise.race
  - 接收一个Promose对象数组
  - 只要有一个Promise执行了resolve就执行then（data为第一个成功执行的Promise的数据），否则catch住reject的那一个Promise（err为第一个失败执行的Promise数据）

```js
Promise.race([p1, p2])
.then((data) => console.log(data))
.catch((err) => console.log(err[0]));
```

# async/await

- async：声明函数是异步的
  - 返回个Promise对象

- await：等待一个表达式，只能写在async声明的函数里
  - 等到非Promise对象，返回表达式的计算结果/返回值
  - 等到Promise对象，阻塞后面的代码，等待Promise对象resolve，resolve 的值作为返回值
- Promise 对象也会 rejected
  - 此时 await 语句返回 undefined
  - 在 await 语句后添加 .catch 语句，或将 await 语句放在 try...catch 中

```js
function test1() {
  setTimeout(function () {
    console.log("非Promise对象");
  }, 1);
  return "非Promise返回值";
}

function test2() {
  return new Promise(function (resolve, reject) {
    var flag = true;
    if (flag) {
      resolve("成功数据1");
    } else {
      reject("失败数据1");
    }
  });
}

async function await() {
  const a = await 1+2;			// await对此表达式没影响
  const b = await test1();	// await对此表达式没影响
  const c = await test2().catch(err=>console.log(err));
  // const c=undefined;
  // try {
  //   c=await test2();  
  // } catch (e) {
  //   console.log(e)
  // }
  console.log(a);
  console.log(b);
  console.log(c);
  // 返回值通过 Promise.resolve()封装成Promise对象，无返回值时Promise.resolve(undefined)。
  // Promise.resolve(x) 可以看作是 new Promise(resolve => resolve(x)) 的简写
  return '返回的Promise的resolve数据'
}

await().then((res) => console.log(res));

// 3
// 非Promise返回值
// 成功数据1
// 返回的Promise的resolve数据
// 非Promise对象
```

# 回调地狱

- 原始方法
  - 可读性、可维护性降低

```js
setTimeout(function () {
  console.log('我');
  setTimeout(function () {
    console.log('爱');
    setTimeout(function () {
      console.log('米');
      setTimeout(function () {
        console.log('饭');
      }, 1000);
    }, 1000);
  }, 1000);
}, 1000);
```

- 使用Promise
  - 变为 then 链

```js
function getStr1() {
  return new Promise(function (resolve, reject) {
    setTimeout(function () {
      resolve('我');
    }, 1000);
  });
}
function getStr2() {
  return new Promise(function (resolve, reject) {
    setTimeout(function () {
      resolve('爱');
    }, 1000);
  });
}
function getStr3() {
  return new Promise(function (resolve, reject) {
    setTimeout(function () {
      resolve('米');
    }, 1000);
  });
}
function getStr4() {
  return new Promise(function (resolve, reject) {
    setTimeout(function () {
      resolve('饭');
    }, 1000);
  });
}

getStr1().then(function (data) {
  console.log(data);
  return getStr2();
}).then(function (data) {
  console.log(data);
  return getStr3();
}).then(function (data) {
  console.log(data);
  return getStr4();
}).then(function (data) {
  console.log(data);
})
```

- 使用async/await
  - 处理 Promise 的 then 链

```js
async function doIt() {
  const a = await getStr1();
  console.log(a);
  const b = await getStr2();
  console.log(b);
  const c = await getStr3();
  console.log(c);
  const d = await getStr4();
  console.log(d);
}
doIt();
```

# JSON.和qs.

- JSON.parse()：是将json字符串解析成对象的形式

- JSON.stringify()：是将对象序列化成json字符串的形式

- qs.parse()：是将URL字符串解析成对象的形式

- qs.stringify()：是将对象序列化成URL字符串的形式

# Truthy和falsy

**truthy**（真值）：指的是在布尔值上下文中，转换后的值为真的值，既除假值之外的值

**falsy**（假值）： `false`、`0`、`-0`、`0n`、`-0n`、`""`, `''`、``` `、`null`、` undefined `、`NaN`

# 严格模式

> ES6 的模块自动开启严格模式
>
> 作用：进行更严格的错误检查

- 变量必须声明
- this指向：
  - 全局作用域：Window对象
    - vue组件中：VueComponent对象
  - 全局函数：undefined
  - 对象函数：调用函数的对象实例
  - 构造函数：创建的对象的实例
  - 事件函数：触发事件的对象（如触发click的button）

# 对象创建

- 字面量式

  - ```js
    a = 1
    b = 2
    test1 = {
        a,
        b 
    }
    test2 = {
        a:1,
        b:2
    }
    ```

    

- 函数声明式
  - ```js
    // 构造函数
    function Foo(name,age,sex){
        // 不可被继承，在对象属性中
        this.name = name;
        // 不可被继承，在对象属性中
        this.age = age;
        // 不可被继承，在对象属性中
        this.sex = sex;
        // 不可被继承，在对象属性中
        this.a = function(){
            console.log(123)
        }
    }
    // 可被继承，在原型链中
    Foo.prototype.belief = function(){
        console.log('hello，world');
    }
    let f = new Foo ('zh',18,'男');
    
    // 继承 --- 使用原型链
    function Coo(){
        this.name='child'
    }
    Coo.prototype=new Foo()
    let c = new Coo()
    c.belief()
    typeof c  //"object"
    // 检测有没有继承成功
    c instanceof Foo  //true
    ```

  - 每个对象都有一个原型对象，包含构造器对象

    - ![image-20210625173354568](https://tva1.sinaimg.cn/large/008i3skNly1gruna03158j30a70im76e.jpg)