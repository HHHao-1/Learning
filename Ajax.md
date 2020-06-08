# 简介

Asynchronous JavaScript And XML(异步的JavaScript和XML)

Ajax可以在不刷新页面的前提下,进行页面局部更新

Ajax不是新的技术, Ajax并不是W3C的标准

AJAX 的核心是 XMLHttpRequest 对象

### 优点

提高 Web 程序的性能

减轻服务器和带宽的负担

### 缺点

破坏浏览器前进、“后退”按钮的正常功能

对搜索引擎的支持的不足

# JS Ajax

### 创建 XMLHttpRequest 对象

```js
var xhr;
if (window.XMLHttpRequest){
	// IE7+, Firefox, Chrome, Opera, Safari浏览器执行代码
	xhr=new XMLHttpRequest();
}else{
	// IE6, IE5浏览器执行代码
	xhr=new ActiveXObject("Microsoft.XMLHTTP");
}	
```

### 发送请求

| 方法                   | 描述                                                         |
| ---------------------- | ------------------------------------------------------------ |
| open(method,url,async) | 规定请求的类型、URL 以及是否异步处理请求。 method: 请求的类型，http 的请求类型，如 GET、POST。 url: 请求的服务端路径 async: Boolean 类型，true (异步处理)，false(同步处理) |
| send(string)           | 将请求发送到服务端。 string：仅用于 post 请求。              |

```js
//get请求
xhr.open("GET","http://helloworld.com?id=1","true");
xhr.send();

//post请求
xhr.open("POST","index.php",true);
//如果我们想像 HTML 表单那样 POST 数据，则需要使用 setRequestHeader() 来添加 HTTP 头，然后在 send 中规定要发送的数据。
xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xhr.send("name=syl&id=2");

异步（true）和同步（false）的区别：
async 设为 true，当发送了 AJAX 请求后，js 无需等待服务端的响应，而是会去处理其它的脚本，等到服务端响应就绪的时候，js 会返回对 AJAX 中的剩余部分作响应处理，这个响应处理需要通过 onreadystatechange 来实现。
 
如果async设为 false（一般不推荐使用），如果你这么使用了，不要编写 onreadystatechange 函数，否则 js 会挂起在这个函数的地方，等待服务端响应，如果服务端瘫痪了，那么你的脚本就会无法运行。所以如果使用了 async = false，把处理代码放到 send() 后面即可。
xhr.open("GET","index.text",false);
xhr.send();
console.log(xhr.responseText);
```

### 服务端响应

**XMLHttpRequest 的三个重要的属性**

| 属性               | 描述                                                         |
| ------------------ | ------------------------------------------------------------ |
| onreadystatechange | 存储函数，每当 readyState 属性改变时，就会调用这个函数。     |
| readyState         | 这个变量储存了 XMLHttpRequest 的状态，有 0-4 并且分别对应不同的含义。  <br />0：请求未初始化 <br />1:服务器连接已建立 <br />2:请求已接受 <br />3:请求处理中 <br />4:请求已完成，且响应已就绪 |
| status             | 200："OK"  <br />404：未找到页面                             |

```js
一般需要处理的就是 readyState == 4 && status == 200 的情况
```

**获取服务端响应**

XMLHttpRequest 提供了两种方式

| 属性         | 描述                     |
| ------------ | ------------------------ |
| responseText | 获得字符串形式的响应数据 |
| responseXML  | 获得 XML 形式的相应数据  |

```js
xhr.onreadystatechange = function(){
    if(xhr.readyState == 4 && xhr.status == 200){
        console.log(xhr.responseText);
    }
}
```

### 完整示例

```html
<script>
    $(document).ready(function(){
        var xhr = null;
        //创建对象
        if(window.ActiveXObject)
            xhr = new ActiveXObject("Microsoft.XMLHTTP");
        else if(window.XMLHttpRequest)
            xhr = new XMLHttpRequest();
        //发送请求
        xhr.open("GET","https://042bc5dd9bf0.simplelab.cn/xhrtest",true);
        xhr.send();
        //处理响应
        xhr.onreadystatechange = function(){
            if(xhr.readyState == 4 && xhr.status == 200){
                alert(xhr.responseText);
            }
        }
        //如果是同步则直接编写对响应的使用（ajax请求响应到达之前，页面会卡住）
        //alert(xhr.responseText);
    })
</script>
```

# jquery Ajax

### load()

jQuery load()方法作用是从服务器加载数据，是一个简单但强大的AJAX方法。

```js
语法为：load(url,[data],[callback])
```

| 参数           | 类型     | 描述                                                         |
| -------------- | -------- | ------------------------------------------------------------ |
| url            | String   | 请求的 url 地址                                              |
| data(可选)     | Object   | 发送到服务器的数据                                           |
| callback(可选) | Function | 请求完成时的回调函数，无论成功失败  function 有三个额外参数  <br />response ：包含来自请求的结果数据 <br />status ：包含请求的状态 <br />xhr ：包含 XMLHttpRequest 对象 |

**用法：**

```js
一.在load的url里加上空格后面就可以跟选择器了

示例：我需要load  test.html的内容，并只要取id为a的内容。

$("body").load("test.html #a");

示例：用ajax方法
$.ajax({
    url: "hotelQuery!queryHotelByCity.action",
    type: "post",
    dataType: "html",
    data: "queryHotel.city="+cityobj.value+"&queryHotel.wbcid="+wbcid,
    success: function(data){
        $("#hotellists").html($(data).filter("#list").html());
    }
});
```

```js
二.使用data

1.加载一个php文件，该php文件不含传递参数
 
$("#myID").load("test.php");
//在id为#myID的元素里导入test.php运行后的结果

2. 加载一个php文件，该php文件含有一个传递参数

$("#myID").load("test.php",{"name" : "Adam"});
//导入的php文件含有一个传递参数，类似于：test.php?name=Adam

3. 加载一个php文件，该php文件含有多个传递参数。注：参数间用逗号分隔 

$("#myID").load("test.php",{"name" : "Adam" ，"site":"61dh.com"});
//导入的php文件含有一个传递参数，类似于：test.php?name=Adam&site=61dh.com

4. 加载一个php文件，该php文件以数组作为传递参数

$("#myID").load("test.jsp",{'arr[]': ["aa", "bb"]});
//导入的jsp文件含有一个数组传递参数。
$("#myID").load("test.jsp",{'arr1[]': ["aa", "bb"],'arr2[]':["cc","dd"]});
//传递多个数组
注意：使用load，这些参数是以POST的方式传递的，因此在test.php里，不能用GET来获取参数。
```

```js
三：使用callback

比如我们要在`load方法`得到服务器响应后，慢慢地显示加载的内容，就可以使用`callback`函数

$("#go").click(function(){
  $("#myID").load("welcome.php", {"lname" : "Cai", "fname" : "Adam", function(){
    $("#myID").fadeIn('slow');}
  );
});
```

### $.ajax 

$.ajax 是ajax方面 jQuery 最底层的方法

```js
语法为：$.ajax(options)
```

options 是一个 {} ，里面包含了 ajax 请求的参数：

| 参数        | 类型             | 描述                                                         |
| ----------- | ---------------- | ------------------------------------------------------------ |
| url         | String           | 发送请求的地址                                               |
| type        | String           | 请求的方式，例如我们之前使用过的 GET、POST，除此之外，还有其他的 HTTP 方法 |
| timeout     | Number           | 设置请求超时时间(毫秒)                                       |
| data        | Object 或 String | 发送到服务器的数据                                           |
| dataType    | String           | 预期服务器返回的数据类型，如果不指定，jQuery 将自动根据 HTTP 包 MIME 信息返回 responseXML 或 responseText，并作为回调函数参数传递，有如下这些常用类型：xml、html、script、json、jsonp（跨域通信）、text 等。 |
| beforeSend  | Function         | 发送请求前可以修改 XMLHttpRequest 对象的函数，比如可以添加自定义的 HTTP 请求头，判读是否发送本次 Ajax 请求等，XMLHttpRequest 对象是唯一的参数 |
| complete    | Function         | 请求完成后调用的回调函数(请求成功或失败都要调用该函数) ，参数：XMLHttpRequest 对象和描述成功请求类型的字符串 textStatus |
| success     | Function         | 请求成功后调用的回调函数，参数：由服务器返回，并根据 dataType 处理后的数据，还有一个是 textStatus |
| error       | Function         | 请求失败时被调用的函数，参数：XMLHttpRequest 对象、错误信息、捕获的错误对象(可选) |
| contentType | String           | 发送信息至服务器时内容的编码，默认为 `application/x-www-form-urlencoded` |

```html
示例：

<script>
    $(document).ready(function(){
        $("#btn").click(function(){
            $.ajax({
                type:"POST",
                url:"https://042bc5dd9bf0.simplelab.cn/ajaxtest",
                data:{
                    value:$("#content").val()
                },
                //var deleteIds = new Array();
                //data:{ids : deleteIds},
		   		//traditional: true,//使用数组传递参数，必须加上，否则后台取值为空
                dataType:"text",
                beforeSend:function(xhr){
                    var reg = /^((?!0)\d{1,2}|100)$/
                    if(!reg.test(parseInt($("#content").val()))){
                        xhr.abort();
                        alert("请输入 0 - 100 的正整数！");
                    }
                },
                success:function(result){//result:响应返回的结果
                    alert(result);
                },
                error:function(xhr,e){//xhr:xmlhttprequest对象；e：响应返回的错误
                    console.log(e);
                }
            })
        })
    })
</script>
```

### 全局 AJAX 事件

想象这样一个应用场景，用户点击了一个按钮，而这个请求需要相当长的时间才能返回，如果页面上没有提示信息，用户很容易就失去耐心，所以我们需要对 ajax 请求有一个全局的监控。

jQuery 中 AJAX 的全局事件有：

| 方法                   | 描述                                                         |
| ---------------------- | ------------------------------------------------------------ |
| ajaxStart(callback)    | Ajax 请求开始时执行的函数                                    |
| ajaxComplete(callback) | Ajax 请求完成时执行的函数                                    |
| ajaxError(callback)    | Ajax 请求发生错误时执行的函数，捕捉到的错误可以作为最后一个参数传递 |
| ajaxSend(callback)     | Ajax 请求发送前执行的函数                                    |
| ajaxSuccess(callback)  | Ajax 请求成功时执行的函数                                    |
| ajaxStop(callback)     | Ajax 请求结束时执行的函数                                    |

```js
示例：

$("$test").ajaxStart(function(){
    $(this).show();
})
$("$test").ajaxStop(function(){
    $(this).hide();
})
```

如果想要某个 ajax 请求不受全局事件监听影响，那么可以在使用 $.ajax 时，把参数中的 global 设置为 false（global: false）。

### 简化方法

#### $.get()

get() 通过远程 HTTP GET 请求载入信息。

```js
语法：$(selector).get(url,data,success(response,status,xhr),dataType)
```

| 参数                         | 描述                                                         |
| ---------------------------- | ------------------------------------------------------------ |
| url                          | 必须，请求的 url                                             |
| data                         | 可选，发送到服务器的数据                                     |
| success(response,status,xhr) | 可选，当请求成功时运行该方法 <br />response--包含来自请求的结果数据 <br />status--包含请求的状态 <br />xhr--XMLHttpRequest 对象 |
| dataType                     | 可选，规定预计接收服务端的响应的数据；<br />可能的类型有 xml、html、text、script、json |

```js
$.get(
    "https://042bc5dd9bf0.simplelab.cn/gettest",
    function(result){
        alert(result);
    }
```

#### $.post()

post() 方法通过 HTTP POST 请求从服务器载入数据：

- get 请求会将参数跟在 url 后面进行传递，而 post 请求的参数则是作为 HTTP 的消息的实体内容，在 AJAX 请求中，这种区别对用户是不可见的。
- get 请求对传输的数据有大小限制，一般是小于 2KB 的，而 post 理论上没有限制。
- get 请求的数据会被浏览器缓存起来，一些敏感数据同样会被缓存，而 post 则可以避免这个问题。

```js
语法:jQuery.post(url,data,success(data, textStatus, jqXHR),dataType)
```

| 参数                         | 描述                                                         |
| ---------------------------- | ------------------------------------------------------------ |
| url                          | 必须，请求的 url                                             |
| data                         | 可选，发送到服务器的数据                                     |
| success(response,status,xhr) | 可选，当请求成功时运行该方法 <br />data--包含来自请求的结果数据 <br />status--包含请求的状态<br />xhr--XMLHttpRequest 对象 |
| dataType                     | 可选，规定预计接收服务端的响应的数据；<br />可能的类型有 xml、html、text、script、json |

```js
var data = {
    name : "syl",
    id : 1
}
$("#btn").click(function(){
    $.post(
        "https://042bc5dd9bf0.simplelab.cn/posttest",
        data,
        function(result){
            alert(result);
        }
    )
})
```

#### $.ajaxSetup()

ajaxSetup() 设置全局ajax参数 (全局方法需要global参数不为false，不适用于jsonp方式)

ajaxSetup() 方法为将来的ajax请求设置默认值或为将来的ajax请求设置特定的全局方法

ajaxSetup()其使用方法与ajax()并无区别，只是在其之后的ajax()不用再重复添加相同参数，节省了代码量。

```js
语法：$.ajaxSetup({name:value, name:value, ... })
                
该参数为带有一个或多个名称/值对的 AJAX 请求规定设置。
```

下面的表格中列出了可能的名称/值：

| 名称                         | 值/描述                                                      |
| :--------------------------- | :----------------------------------------------------------- |
| async                        | 布尔值，表示请求是否异步处理。默认是 true。                  |
| beforeSend(*xhr*)            | 发送请求前运行的函数。                                       |
| cache                        | 布尔值，表示浏览器是否缓存被请求页面。默认是 true。          |
| complete(*xhr,status*)       | 请求完成时运行的函数（在请求成功或失败之后均调用，即在 success 和 error 函数之后）。 |
| contentType                  | 发送数据到服务器时所使用的内容类型。默认是："application/x-www-form-urlencoded"。 |
| context                      | 为所有 AJAX 相关的回调函数规定 "this" 值。                   |
| data                         | 规定要发送到服务器的数据。                                   |
| dataFilter(*data*,*type*)    | 用于处理 XMLHttpRequest 原始响应数据的函数。                 |
| dataType                     | 预期的服务器响应的数据类型。                                 |
| error(*xhr,status,error*)    | 如果请求失败要运行的函数。                                   |
| global                       | 布尔值，规定是否为请求触发全局 AJAX 事件处理程序。默认是 true。 |
| ifModified                   | 布尔值，规定是否仅在最后一次请求以来响应发生改变时才请求成功。默认是 false。 |
| jsonp                        | 在一个 jsonp 中重写回调函数的字符串。                        |
| jsonpCallback                | 在一个 jsonp 中规定回调函数的名称。                          |
| password                     | 规定在 HTTP 访问认证请求中使用的密码。                       |
| processData                  | 布尔值，规定通过请求发送的数据是否转换为查询字符串。默认是 true。 |
| scriptCharset                | 规定请求的字符集。                                           |
| success(*result,status,xhr*) | 当请求成功时运行的函数。                                     |
| timeout                      | 设置本地的请求超时时间（以毫秒计）。                         |
| traditional                  | 布尔值，规定是否使用参数序列化的传统样式。                   |
| type                         | 规定请求的类型（GET 或 POST）。                              |
| url                          | 规定发送请求的 URL。默认是当前页面。                         |
| username                     | 规定在 HTTP 访问认证请求中使用的用户名。                     |
| xhr                          | 用于创建 XMLHttpRequest 对象的函数。                         |

```js
示例：

设置 AJAX 请求默认地址为 “/xmlhttp/”，禁止触发全局 AJAX 事件，用 POST 代替默认 GET 方法。其后的 AJAX 请求不再设置这些选项参数。

$.ajaxSetup({
  url: "/xmlhttp/",
  global: false,
  type: "POST"
});
$.ajax({ data: myData });
```

#### $.getScript()

有时，在页面第一次加载时就获取所需的全部的 JavaScript 文件并没有必要，虽然可以在需要哪个 JS 文件时动态的创建 script 标签，但是这种动态创建的方法并不理想，为此 jQuery 提供了 $.getScript() 方法来直接加载 js 文件，加载的 js 文件会自动执行。getScript 通过 HTTP GET 请求载入并执行 JavaScript 文件，语法：

```js
jQuery.getScript(url,success(response,status))
```

| 参数                     | 描述                                                         |
| ------------------------ | ------------------------------------------------------------ |
| url                      | 请求的 url 地址                                              |
| success(response,status) | 可选，请求成功后执行的回调函数。  response--包含来自请求的结果数据 status--包含请求的状态 |

```js
$.getScript(
    "https://042bc5dd9bf0.simplelab.cn/getscripttest"
)

等价于

$.ajax({
    type:"GET",
    url:url,
    dataType:"script",
    success:success
})
```

####  $.getJSON()

getJson() 用于加载 JSON 文件，与getJson() 用于加载Json() 文件，与getScript() 的用法相同。语法：

```js
jQuery.getJSON(url,data,success(data,status,xhr))
```

| 参数                         | 描述                                                         |
| ---------------------------- | ------------------------------------------------------------ |
| url                          | 请求的 url 地址                                              |
| data                         | 可选，发送到服务端的数据                                     |
| success(response,status,xhr) | 可选，请求成功后执行的回调函数。  response-包含来自请求的结果数据<br />status-包含请求的状态 <br />xhr-XMLHttpRequest 对象 |

```js
$.getJSON(
    "https://042bc5dd9bf0.simplelab.cn/getjsontest",
    function(data){
        alert(
            typeof(data)+"\n"
            +data[0].id+" "+data[0].name+"\n"
            +data[1].id+" "+data[1].name+"\n"
            +data[2].id+" "+data[2].name+"\n"
        );
    }
    
等价于
    
$.ajax({
    type:"GET",
    url: url,
    data: data,
    success: callback,
    dataType: json
});
```

