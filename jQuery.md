# 简介

为了简化JavaScript开发,第三方厂商开发了JavaScript库。主流JavaScript库：jQuery、Vuejs、AngularJS、React…

jQuery是一个轻量级JS库,使用十分简单，jQuery的核心是选择器,用于获取页面元素。

CDN：https://cdn.bootcdn.net/ajax/libs/jquery/3.5.1/jquery.min.js

# 语法

```js
语法1：jQuery(选择器表达式)
语法2：$(选择器表达式)
```

## 选择器

### 基本选择器

```js
$("#id") ID选择器,指定1d元素的对象
$("标签") 元素选择器选择指定标签名的选择器
$(".class") 类选择器,选中拥有指定css类的元素
$("S1, S2, SN") 组合选择器,对元素进行组合
$("*")选择页面所有元素，包括 body
//警告： 除非被它自己使用，否则 * 选择器或通用选择器，其速度是极其慢的。
```

### 层叠选择器

```js
层叠选择器是根据元素的位置关系来获取元素的选择器表达式

$("ancestor descendant")  后代选择器
$("ancestor>descendant")  子选择器
$("prev~siblings")  兄弟选择器(prev后面的所有siblings元素)
$("prev+siblings")  兄弟选择器(prev后一个siblings元素)
```
```
可以使用 next() 方法来代替 $('prev+next') 选择器。比如 $(".one + div); 和 $(".one").next("div");
                                         
用 nextAll() 方法来代替 $('prev~siblings') 选择器。比如 `$("#prev~div");和$("#prev").nextAll("div");

siblings() 方法，$("#prev~div"); 选择器只能选择 “prev” 元素后面的同辈 div 元素，而 siblings() 方法与前后位置无关，只要是同辈节点都能匹配。
```
```js
示例：
//选取#prev之后的所有同辈div元素
$("#prev~div").css("background", "#bbffaa");
//同上
$("#prev").nextAll("div").css("background", "#bbffaa");
//选取#prev所有的同辈div元素，无论前后位置
$("#prev").siblings("div").css({
    "width": "100px",
    "height": "100px",
    "border": "1px solid red"
})
```

### 属性选择器

```js
属性选择器是根据元素的属性值来选择元素的选择器表达式

$("selector[attribute=value]")  选中属性值等于具体值的组件
$("selector[attribute^=value]")  选中属性值以某值开头的组件
$("selector[attribute$=value]")  选中属性值以某值结尾的组件
$("selector[attribute*=valuel")  选中属性值包含某值的组件
```

### 位置选择器

```js
位置选择器是指通过位置获取指定的元素

$("selector:first")获取第一个元素
$("selector:last")获取最后一个元素
$("selector:even")获取偶位置的元素(从0开始)
$("selector:odd")获取奇数位置的元素(从0开始)
$("selector:eq(n)")获取指定位置的元素(从0开始)
```

### 表单选择器

```js
表单选择器是获取表单元素的简化形式

:input 选取所有的 <input> 、<textarea>、<select>和 <button>元素。

:text 选取所有的单行文本框。

:password 选取所有的密码框

:radio 选取所有的单选框

:checkbox 选取所有的多选框

:submit 选取所有的提交按钮

:image 选取所有的图像

:reset 选取所有的重置按钮

:button 选取所有的按钮

:file 选取所有的上传域

:hidden 选取所有不可见元素

示例：选取所有的 input 元素，并设置高度。
$(":input").css({
    "height": "300px"
});
//form1 :input返回id为form 中所有input, textarea, select 和 button 元素
//form1 input 返回id为form 中所有input
```

### 过滤选择器

过滤选择器主要是通过特定的过滤规则来筛选出所需要的 DOM 元素，过滤规则与 CSS 中的伪类选择器语法相同，即选择器都以一个冒号 : 开头，按照不同的过滤规则，过滤选择器可以分为：

**（1）基本过滤选择器**

```js
:animated Selector 选择所有正在执行动画效果的元素.

:eq() Selector 在匹配的集合中选择索引值为 index 的元素。

:even Selector 选择索引值为偶数的元素，从 0 开始计数。 也可以查看 odd.

:first Selector 选择第一个匹配的元素。

:focus Selector 选择当前获取焦点的元素。

:gt() Selector 选择匹配集合中所有大于给定 index（索引值）的元素。

:header Selector 选择所有标题元素，像 h1, h2, h3 等.

:lang() Selector 选择指定语言的所有元素。

:last Selector 选择最后一个匹配的元素。

:lt() Selector 选择匹配集合中所有索引值小于给定 index 参数的元素。

:not() Selector 选择所有元素去除不匹配给定的选择器的元素。

:odd Selector 选择索引值为奇数元素，从 0 开始计数。同样查看偶数 even.

:root Selector 选择该文档的根元素。

:target Selector 选择由文档 URI 的格式化识别码表示的目标元素

选取所有的 input 元素中的第一个 input 元素，并设置高度。

$("input:first").css({
"height": "300px"
});
```

**（2）内容过滤选择器**

```js 
内容过滤选择器的过滤规则主要体现在它所包含的子元素或文本内容上。

:contains() Selector 选择所有包含指定文本的元素。

:empty Selector 选择所有没有子元素的元素（包括文本节点）。

:has() Selector 选择元素其中至少包含指定选择器匹配的一个种元素。

:parent Selector 选择所有含有子元素或者文本的父级元素。

示例：选取包含文本“shiyanlou”的 div 元素，并设置字体大小。
$(document).ready(function() {
$("div:contains('shiyanlou')").css({
"font-size": "30px"
});
});
```

**（3）可见性过滤选择器**

```js
可见性过滤选择器是根据元素的可见和不可见状态来选择相应的元素。

:hidden Selector 选择所有隐藏的元素。

:visible Selector 选择所有可见的元素。

示例：选取所有可见的 div 元素，并设置字体大小。
$("div:visible").css({"font-size":"30px"});
```

**（5）子元素过滤选择器**

```js
:first-child Selector 选择所有父级元素下的第一个子元素。

:first-of-type Selector 选择所有相同的元素名称的第一个兄弟元素。

:last-child Selector 选择所有父级元素下的最后一个子元素。

:last-of-type Selector 选择的所有元素之间具有相同元素名称的最后一个兄弟元素。

:nth-child() Selector 选择的他们所有父元素的第 n 个子元素。

:nth-last-child() Selector 选择所有他们父元素的第 n 个子元素。计数从最后一个元素开始到第一个。

:nth-last-of-type() Selector 选择的所有他们的父级元素的第 n 个子元素，计数从最后一个元素到第一个。

:nth-of-type() Selector 选择同属于一个父元素之下，并且标签名相同的子元素中的第 n 个。

:only-child Selector 如果某个元素是其父元素的唯一子元素，那么它就会被选中。

:only-of-type Selector 选择所有没有兄弟元素，且具有相同的元素名称的元素。

示例：选取类名为 demo 的元素的第一个子 div 元素，并设置字体大小。
$(".demo div:first-child").css({
"font-size": "30px"
});
```

**（6）表单对象属性过滤选择器**

```js
:enabled Selector 选择所有可用的（注：未被禁用的元素）元素。

:disabled Selector 选择所有被禁用的元素。

:checked Selector 匹配所有勾选的元素。

:selected Selector 获取 select 元素中所有被选中的元素。

示例：选择被选中元素，并设置宽度。
$("input:checked").css({
"width": "300px"
});
```

## DOM节点操作

### 查找节点

```
使用选择器
```

### 创建节点

```js
（1）创建元素节点
$(html) 方法会根据传入的 HTML 标记字符串，创建一个 DOM 对象，并将这个 DOM 对象包装成一个 jQuery 对象后返回。
var $li = $("<li></li>"); //创建一个<li>元素

（2）创建文本节点
var $li = $("<li>syl</li>"); 
（3）创建属性节点
var $li = $("<li title='syl'>syl</li>"); 

示例：将新建的 li 元素插入到 ul 中
$(document).ready(function() {
    var li_obj = $("<li>黄色</li>");
    $('ul').append(li_obj);
});
```

### 插入节点

```js
(1) DOM 插入现有元素内:

.append() 在每个匹配元素里面的末尾处插入参数内容。

.appendTo() 将匹配的元素插入到目标元素的最后面。

.html() 获取集合中第一个匹配元素的 HTML 内容 设置每一个匹配元素的 html 内容。

.prepend() 将参数内容插入到每个匹配元素的前面（元素内部）。

.prependTo() 将所有元素插入到目标前面（元素内）。

.text() 得到匹配元素集合中每个元素的合并文本，包括他们的后代设置匹配元素集合中每个元素的文本内容为指定的文本内容。

(2) DOM 插入现有元素外:

.after() 在匹配元素集合中的每个元素后面插入参数所指定的内容，作为其兄弟节点。

.before() 根据参数设定，在匹配元素的前面插入内容。

.insertAfter() 在目标元素后面插入集合中每个匹配的元素(注：插入的元素作为目标元素的兄弟元素)。

.insertBefore() 在目标元素前面插入集合中每个匹配的元素(注：插入的元素作为目标元素的兄弟元素)。

//注：这些插入节点的方法不仅能将新创建的 DOM 元素插入到文档中，也能对原有的 DOM 元素进行移动。
```

```js
示例：将新建的 li 元素插入到 ul 中
 $(document).ready(function() {
 $("<li>yellow</li>").appendTo("ul");
 });

示例：移动节点
$(document).ready(function() {
    var $li = $("ul li:eq(1)");//获取<ul>节点中的第2个<li>元素节点
    var $h1 = $("h1");//获取<h1>节点
    $h1.insertBefore($li);//移动节点

});
```

### 删除节点

```js
remove(),detach() 和 empty() 方法删除节点

1.empty()同时移除元素上的事件及 jQuery 数据。无参。

2.remove()同时移除元素上的事件及 jQuery 数据。有参

3.detach() 保存所有 jQuery 数据而且和被移走的元素相关联。有参数

$(document).ready(function() {
    $("ul li").click(function(){
        alert($(this).html());
    })
    var $li = $("ul li:eq(1)").detach();//删除元素
    $li.appendTo("ul");//重新追加此元素,发现它之前绑定的事件还在,如果使用remove()方法删除元素的话,那么它之前绑定的事件将失效
});
```

### 复制节点

```js
复制节点可以通过 clone() 方法来实现；
clone() 中传递了参数 true 时，代表复制元素的同时复制其所绑定的元素。
```

```html
示例：点击 li 元素即可复制其本身到 ul 中

<ul>
    <li>blue</li>
    <li title="syl">white</li>
    <li>red</li>
</ul>
<script type="text/javascript">
    $(document).ready(function() {
        $("ul li").on('click', function() {
            $(this).clone().appendTo('ul');
        });

    });
</script>
```

 ### 替换节点

```js
.replaceAll()
$("p").replaceWith("<p>SHIYANLOU</p>");

.replaceWith()
$("<p>SHIYANLOU</p>").replaceAll("p")
```

###  包裹节点

```
（1）wrap() 方法：用n个内容包裹n个匹配元素节点
（2）wrapAll() 方法：用1内容包裹n匹配元素
（3）wrapInner() 方法：用n个内容包裹n个匹配元素节点的子内容（包括文本节点）
```

```html
<script type="text/javascript">
    $(document).ready(function() {
    $("p").wrapInner("<div style='border:1px red solid;'></div>");
});
</script>
```

![61B06B8A-64C9-4BE7-B6A9-C1EBEB6468F6](https://tva1.sinaimg.cn/large/007S8ZIlly1gfl0hp158sj30tb049wgd.jpg)

### 属性操作

```js
attr(name|properties|key)-获取或设置元素属性
removeAttr(name)-移除元素属性
```

```js
示例：
//获取属性
var p_class = $("p").attr("class");
$('div').append(p_class);
//添加属性
$("div").attr("class", "demo");
//删除属性
$("div").removeAttr("class");
```

### 样式操作

```js
css()-获取或设置匹配元素的样式属性//常用、重要
addClass()-为每个匹配的元素添加指定的类名
removeClass0)-从所有匹配的元素中删除全部或者指定的类
```

```js
示例：
//获取color样式属性值
$("p").css("color");
//设置样式（style属性）
<h1 style="color:blue; text-align:center">
$("p").css({
    "color":"white",
    "background-color":"#98bf21",
    "font-family":"Arial",
    "font-size":"20px",
    "padding":"5px"
});

//为 div 追加一个新样式 another
$("div").addClass("another");

//移除 div 的 another 样式
$("div").removeClass("another");

//切换样式
$("p").toggleClass("main");

//判断是否含有某个样式,如果有则返回 true，否则返回 false。
$("p").hasClass("another");
```

### 设置元素内容

```js
val()-获取或设置输入项的值
text()-获取或设置元素的纯文本
html()-获取或设置元素内部的HTML
```

```js
示例：
var div_html = $("div").html();//获取<div>元素的HTML代码
$("div").html("<span>shiyanlou</span>");//设置 div 中的 HTML 内容

var p_text = $("div").text();//获取 div 元素的文本内容
$("div").text("shiyanlou");//设置 div 中的文本内容

$("input").val()//获取输入框的值
$("input").val("shiyanlou");//设置输入框的值
```

### 遍历节点

```js
（1）.children() 方法
//获取 ul 的子元素 li 的文本值
var ul_chlildList = $('ul').children();
for (var i = 0, len = ul_chlildList.length; i < len; i++) {
    alert(ul_chlildList[i].innerHTML);
}

（2）.next() 方法
//获取 div 后面紧邻的同辈元素
var div_next = $('div').next();
alert(div_next.text());

（3）.prev() 方法
//获取 p 前面紧邻的同辈元素
var p_prev = $('p').prev();
alert(p_prev.text());

（4）.siblings() 方法
//改变p 元素前后所有的同辈元素的颜色
 $('p').siblings().css('background-color', 'red');

（5）.parent() 方法
//获取 p 元素的父级元素的 class
var p_pa = $('p').parent();
alert(p_pa.attr("class"));	

（6）closest() 方法
从元素本身开始，逐级向上级元素匹配，并返回最先匹配的祖先元素。
也就是说首先检查当前元素是否匹配，如果匹配则直接返回元素本身，如果不匹配则向上查找父级元素，逐级向上直到找到匹配选择器的元素，如果什么都没找到则返回一个空的 jQuery 对象。

（7）parents() 方法
获得集合中每个匹配元素的祖先元素。
查找方式和 parent() 方法类似，不同点在于，当它找到第一个父节点时并没有停止查找，而是继续查找，最后返回多个父节点。
```

## 事件

### 常用事件

| 键盘事件 | 鼠标事件   | 表单事件 | 文档/窗口事件 |
| -------- | ---------- | -------- | ------------- |
| keypress | click      | submit   | load          |
| keydown  | dblclick   | change   | resize        |
| keyup    | mouseenter | focus    | scroll        |
|          | mouseleave | blur     | unload        |
|          | mouseover  |          |               |

### 添加事件

**on() 向元素添加事件处理程序**

**one() 该处理程序只能被每个元素触发一次**

```css
语法为：

$(selector).on(event,childSelector,data,function)

参数说明：

event 必需。表示事件类型，由空格分隔多个事件值，也可以是数组。

childSelector 可选。规定只能添加到指定的子元素上的事件处理程序。

data 可选。规定传递到函数的额外数据。

function 可选。规定当事件发生时运行的函数。

示例：

on("click", function)-为选中的页面元素绑定单击事件
click(function)-是绑定事件的简写形式
$("ul li").click(function(){
    $(this).clone().appendTo('ul');
});
```

### 删除事件

**off() 方法用来移除事件**

```css
语法为：

$(selector).off(event,selector,function(eventObj),map)

参数说明：

event 必需。规定要从被选元素移除的一个或多个事件或命名空间。由空格分隔多个事件值。必须是有效的事件。

selector 可选。规定添加事件处理程序时最初传递给 on() 方法的选择器。

function(eventObj) 可选。规定当事件发生时运行的函数。

map 可选。规定事件映射 ({event:function, event:function, ...})，包含要添加到元素的一个或多个事件，以及当事件发生时运行的函数。

示例：

$("p").on("click", function() {
    $(this).css("background-color", "red");
});
$("button").click(function() {
    $("p").off("click");
});
```

### 合成事件

```js
hover() 方法用于模拟光标悬停事件。
当光标移动到元素上时，会触发指定的第 1 个函数，当光标移出这个元素时，会触发指定的第 2 个函数。

$(selector).hover(inFunction,outFunction)

参数说明：

inFunction 必需。规定 mouseover 事件发生时运行的函数。

outFunction 可选。规定 mouseout 事件发生时运行的函数。
```

###  事件冒泡

```css
概念：

当事件发生后，这个事件就要开始传播(从里到外或者从外向里)。为什么要传播呢？因为事件源本身（可能）并没有处理事件的能力，即处理事件的函数（方法）并未绑定在该事件源上。例如我们点击一个按钮时，就会产生一个 click 事件，但这个按钮本身可能不能处理这个事件，事件必须从这个按钮传播出去，从而到达能够处理这个事件的代码中（例如我们给按钮的 onclick 属性赋一个函数的名字，就是让这个函数去处理该按钮的 click 事件），或者按钮的父级绑定有事件函数，当该点击事件发生在按钮上，按钮本身并无处理事件函数，则传播到父级去处理。

示例：在点击 span 元素的时候，会触发 span 元素的 click 事件，会输出三条记录
<script type="text/javascript">
$(document).ready(function() {
    $('span').on("click", function() {
        alert("我是内部span元素，我被点击了");
    });
    $('#content').on("click", function() {
        alert("我是外部div元素，我被点击了");
    });
    $('body').on("click", function() {
        alert("我是body元素，我被点击了");
    });
})
</script>

停止事件冒泡：

event.stopPropagation() 方法来停止冒泡。
event.isPropagationStopped() 方法来检查指定的事件上是否调用了该方法。
如果 event.stopPropagation() 被调用则该方法返回 true，否则返回 false。

<script type="text/javascript">
$(document).ready(function() {
    $('span').on("click", function(event) {
        alert("我是内部span元素，我被点击了");
        event.stopPropagation();//停止事件冒泡
    });
    $('#content').on("click", function(event) {
        alert("我是外部div元素，我被点击了");
        event.stopPropagation();//停止事件冒泡
    });
    $('body').on("click", function() {
        alert("我是body元素，我被点击了");
    });
})
</script>

阻止默认行为：

网页中的元素都有自己默认的行为。比如单击超链接后会跳转，单击“提交”按钮后表单会提交，有时候我们需要阻止元素的默认行为。

event.preventDefault() 方法阻止元素发生默认的行为。
使用 event.isDefaultPrevented() 方法来检查指定的事件上是否调用了 preventDefault() 方法。

示例：阻止链接打开 url
<script type="text/javascript">
$(document).ready(function() {
    $("a").click(function(event) {
        event.preventDefault();
    });
})
</script>
```



### 模拟操作

 **trigger() 方法来完成模拟操作**

```html
比如 click 事件必须要用户单击才能触发，但有时候，我们需要通过模拟用户操作，来达到单击的效果

语法为：

$(selector).trigger(event,param1,param2,...)

参数说明：

event 必需。规定指定元素上要触发的事件。可以是自定义事件，或者任何标准事件。

param1,param2,... 可选。传递到事件处理程序的额外参数。额外的参数对自定义事件特别有用。
```

```html
示例：打开页面字体自动放大，形成动画效果

（1）触发事件

<p>这是一个段落 。</p>
<p>这是另外一个段落。</p>
<p>点击任意一个段落来修改段落的字体大小，每个段落只会执行一次。</p>
<script type="text/javascript">
$(document).ready(function() {
    $("p").one("click", function() {
        $(this).animate({
            fontSize: "+=6px"
        });
    });
    $("p").trigger("click");
});
</script>

（2）触发自定义事件

<script type="text/javascript">
    $(document).ready(function() {
    $("p").one("myClick", function() {
        $(this).animate({
            fontSize: "+=6px"
        });
    });
    //触发自定义事件
    $("p").trigger("myClick");
});
</script>

（3）传递数据

trigger(type,[data]) 
<script type="text/javascript">
    $(document).ready(function() {
        $('#btn').on("myClick",function(event,message1,message2){
            $('#test').append("<p>"+message1+message2+"</p>");
        });
        $('#btn').trigger("myClick",["我的自定义","事件"]);
    });
</script>

（4）执行默认操作

trigger() 方法触发事件后，会执行浏览器默认操作。例如：
$("input").trigger("focus");
以上代码不仅会触发为 input 元素绑定的 foucs 事件，也会使 input 元素本身得到焦点（浏览器的默认操作）。

triggerHandler() 不触发事件的默认行为。（比如表单提交）

trigger() 会操作 jQuery 对象匹配的所有元素，而 triggerHandler() 只影响第一个匹配元素。

由 triggerHandler() 创建的事件不会在 DOM 树中冒泡；如果目标元素不直接处理它们，则不会发生任何事情。
```

## 动画

### 显示隐藏

```css
（1）show() 方法

show() 方法显示隐藏的被选元素。另外需要注意的是 show() 适用于通过 jQuery 方法和 CSS 中 display:none隐藏的元素（不适用于通过 visibility:hidden`隐藏的元素）。

语法为：

$(selector).show(speed,easing,callback)

参数说明：

speed 可选。规定显示效果的速度。可能的值：毫秒，"slow"，"fast"。

easing 可选。规定在动画的不同点上元素的速度。默认值为 "swing"。可能的值："swing" 表示在开头/结尾移动慢，在中间移动快。"linear" 表示匀速移动。提示：扩展插件中提供更多可用的 easing 函数。

callback 可选。show() 方法执行完之后，要执行的函数。
```

```html
（2）hide() 方法

与 show() 方法相对应的 hide() 方法隐藏被选元素。与 CSS 属性 display:none 类似。隐藏的元素不会被完全显示（不再影响页面的布局）。

语法为：

$(selector).hide(speed,easing,callback)
copy
参数说明与 show() 方法一致。只不过是把显示改为了隐藏。

示例：
<p>我是测试段落</p>
<button class="btn1">隐藏</button>
<button class="btn2">显示</button>
<script type="text/javascript">
$(document).ready(function() {
    $(".btn1").click(function() {
        $("p").hide(1000, function() {
            $("p").css("background-color","yellow");
        });
    });
    $(".btn2").click(function() {
        $("p").show(1000, function() {
            $("p").css("background-color","red");
        });
    });
});
</script>
```

## 淡入淡出

```css
（1）fadeIn() 方法

fadeIn() 方法通过淡入的方式显示匹配元素。

$(selector).fadeIn(speed,easing,callback)

参数说明同上。

（2）fadeOut() 方法

fadeOut() 方法通过淡出的方式隐藏匹配元素。

$(selector).fadeOut(speed,easing,callback)
```

### 滑动隐藏显示

```css
（1）slideUp() 方法

slideUp() 方法以滑动方式隐藏被选元素。

$(selector).slideUp(speed,easing,callback)

参数说明同上。

（2）slideDown() 方法

slideDown() 方法以滑动方式显示被选元素。slideDown() 适用于通过 jQuery 方法隐藏的元素，或在 CSS 中声明 display:none 隐藏的元素（不适用于通过 visibility:hidden 隐藏的元素）。

$(selector).slideDown(speed,easing,callback)
```

### animate()方法

```html
！！！重要：animate() 方法，用来实现自定义动画。

该方法通过 CSS 样式将元素从一个状态改变为另一个状态。CSS 属性值是逐渐改变的，这样就可以创建动画效果。只有数字值可创建动画（比如 "margin:30px"）。字符串值无法创建动画（比如 "background-color:red"）。

提示：请使用 "+=" 或 "-=" 来创建相对动画。

语法：

$(selector).animate({params},speed,callback);
copy
参数说明：

params 参数，必需的，定义形成动画的 CSS 属性。

speed 参数，可选的，规定效果的时长。它可以取以下值："slow"、"fast" 或毫秒。

callback 参数，可选的，是动画完成后所执行的函数名称。

注：默认情况下，所有 HTML 元素都有一个静态位置，且无法移动。 如需对位置进行操作，比如使用 “top”，“right”，“bottom”，“left” 属性要记得首先把元素的 CSS position 属性设置为 relative、fixed 或 absolute！

示例：
<style type="text/css">
    .title {
        position: relative;
        border: 1px solid red;
        height: 100px;
        width: 200px;
    }
</style>

<body>
    <div class="title">shiyanlou</div>
    <script type="text/javascript">
        $(document).ready(function() {
            $(".title").animate({
                left: "500px"
            }, 3000);
            $(".title").animate({
                height:'+=150px'
            }, 3000);
            $(".title").animate({
                width:'+=150px'
            }, 3000);
        });
    </script>
</body>
```

### 动画回调函数

```css
如果不使用回调函数，css() 方法并不会加入到动画队列中，而是立即执行，可以使用回调函数 callback 对非动画实现排队。只要把 css() 方法写在最后一个动画的回调函数里面即可。callback 函数适用于 jQuery 中所有的动画效果。

比较：

$("button").click(function() {
    $("p").show(1000);
    $("p").css("background-color", "red");
});

$("button").click(function() {
    $("p").show(1000,function(){
        $("p").css("background-color", "red");
    });
```

### 停止动画

```css
（1）停止动画

jQuery stop() 方法用于在动画或效果完成前对它们进行停止。stop() 方法适用于所有 jQuery 效果函数，包括滑动、淡入淡出和自定义动画。

$(selector).stop( [clearQueue ] [, jumpToEnd ] )

参数说明：

clearQueue 参数，可选值，规定是否应该清除动画队列。默认是 false，即仅停止活动的动画，允许任何排入队列的动画向后执行。

jumpToEnd 参数，可选值，规定是否立即完成当前动画。默认是 false。

示例：在动画1完成前点击停止，动画2开始执行
$(document).ready(function() {
    $("#flip").click(function() {
        $("#panel").slideDown(5000);//动画1
        $("#panel").slideUp(5000);//动画2
    });
    $("#stop").click(function() {
        $("#panel").stop();
    });
});

（2）判断元素是否处于动画状态

if(! $(element).is(":animated")){//判断元素是否处于动画状态
    //如果当前没有进行动画，则添加新动画
}

（3）延迟动画

在动画执行的过程中，如果想对动画进行延迟操作，那么可以使用 delay() 方法。

语法为：

$(selector).delay(speed,queueName)
copy
参数说明：

speed 可选。规定延迟的速度。可能的值：毫秒，"slow"，"fast"。

queueName 可选。规定队列的名称。默认是 "fx"，标准效果队列。
```

### 动画间切换

```css
jQuery 中还有四个专门用于交互的动画方法。

toggle() 方法：hide() 和 show() 方法之间的切换。

slideToggle() 方法：slideUp() 和 slideDown() 方法之间的切换。

fadeToggle() 方法：在 fadeIn() 和 fadeOut() 方法之间进行切换。

fadeTo() 方法：把被选元素逐渐改变至给定的不透明度。
```



# 其他

## 页面就绪函数

```js
页面就绪函数是指在页面加载完成后执行的函数
语法1: $(document).ready(function(){})
语法2: $(function(){})

所有js  / jQuery 函数位于一个页面就绪函数中：防止文档在完全加载（就绪）之前运行 代码；如果在文档没有完全加载之前就运行函数，操作可能失败。
```

| window.onload                                          |          | $(doucment).ready()                                          |
| ------------------------------------------------------ | -------- | ------------------------------------------------------------ |
| 必须等待网页中所有的内容加载完毕后才能执行（包括图片） | 执行时机 | 网页中所有 DOM 结构绘制完毕后就执行，可能 DOM 元素关联的东西并没有加载完 |
| 只能有一个页面就虚函数。                               | 编写个数 | 能同时编写多个页面就虚函数。                                 |

```js
window.onload = function(){
    alert("test1");
};
window.onload = function(){
    alert("test2");
};
//结果只会输出 test2。

$(document).ready(function(){
    alert("test1");
})
$(document).ready(function(){
    alert("test2");
})
//结果两次都输出
```



##  链式操作

```js
$(document).ready(function() {
    $(".level1>a").click(function() {
        $(this).addClass("current")//给当前元素添加"current"样式
            .next().show()//下一个元素显示
        	//父元素的同辈元素的子元素a移除"current"样式
            .parent().siblings().children("a").removeClass("current")
            .next().hide();//它们的下一个元素隐藏
        return false;
    })
});
```

## 对象转换

```js
jQuery对象和DOM对象转换:

js和jQuery比较：

$("#syl").html();//获取id为syl的元素内的html代码，jQuery对象使用jQuery中的方法
document.getElementById("syl").innerHTML;//DOM对象使用js的innerHTML方法

jQuery 对象转换为DOM 对象 ：
var $cr = $("#cr");//jQuery 对象
var cr = $cr[0];//DOM 对象

var $cr = $("#cr");//jQuery 对象
var cr = $cr.get(0);//DOM 对象

DOM 对象转换为 jQuery 对象：
var cr = document.getElementById("cr");//DOM 对象
var $cr = $(cr);//jQuery 对象

注：这里加个$只是为了区分变量是 jQuery 对象还是 DOM 对象
```

##  和其他库的冲突

某些框架也使用 $ 符号作为简写（就像 jQuery），如果您在用的两种不同的框架正在使用相同的简写符号，有可能导致脚本停止运行。

**noConflict() 方法会释放对 $ 标识符的控制**

```js
//使用jQuery
$.noConflict();
jQuery(document).ready(function() {
    jQuery("button").click(function() {
        jQuery("p").text("jQuery 仍然在工作!");
    });
});

//使用别名
var jq = $.noConflict();
jq(document).ready(function() {
    jq("button").click(function() {
        jq("p").text("jQuery 仍然在工作!");
    });
});
```

# 插件

## 表单验证

表单验证插件 Validation

CDN：https://cdn.bootcdn.net/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js

提示信息汉化CDN：汉化包要放到验证的 js 后面
		https://cdn.bootcdn.net/ajax/libs/jquery-validate/1.19.2/localization/messages_zh.min.js

```js
应用：

（1） 引入 jQuery 和 validate。

（2） 确定哪个表单需要被验证。

 $("#commentForm").validate();

（3）针对不同的字段，进行验证规则编码，设置字段相应的属性：

class="required" 表示必须填写，minlength="2" 表示最小长度为 2。

class="required email" 表示必须填写符合 E-mail 格式的内容。

class="url" 表示为 url 格式验证。
```

```html
示例:

第一种写法：
<form class="cmxform" id="commentForm" method="get" action="">
    <fieldset>
        <legend>一个简单的带验证提示的评论例子</legend>
        <p>
            <label for="cusername">姓名</label>
            <em>*</em><input id="cusername" name="username" size="25" class="required" minlength="2" />
        </p>
        <p>
            <label for="cemail">邮箱</label>
            <em>*</em><input id="cemail" name="email" size="25" class="required email" />
        </p>
        <p>
            <label for="curl">网址</label>
            <em> </em><input id="curl" name="url" size="25" class="url" value="" />
        </p>
        <p>
            <label for="ccomment">评论</label>
            <em>*</em><textarea id="ccomment" name="comment" cols="22" class="required"></textarea>
        </p>
        <p>
            <input class="submit" type="submit" value="提交" />
        </p>
    </fieldset>
</form>

第二种写法：
<script type="text/javascript">
    $(document).ready(function() {
        $("#commentForm").validate({
            rules: {
                username: {
                    required: true,
                    minlength: 2
                },
                email: {
                    required: true,
                    email: true
                },
                url: "url",
                comment: "required"
            }
        });
    });
</script>
```

```css
默认的校验规则：

1 required:true 必须输入的字段。

2 remote:"check.php" 使用 ajax 方法调用 check.php 验证输入值。

3 email:true 必须输入正确格式的电子邮件。

4 url:true 必须输入正确格式的网址。

5 date:true 必须输入正确格式的日期。日期校验 ie6 出错，慎用。

6 dateISO:true 必须输入正确格式的日期（ISO），例如：2009-06-23，1998/01/22。只验证格式，不验证有效性。

7 number:true 必须输入合法的数字（负数，小数）。

8 digits:true 必须输入整数。

9 creditcard: 必须输入合法的信用卡号。

10 equalTo:"#field" 输入值必须和 #field 相同。

11 accept: 输入拥有合法后缀名的字符串（上传文件的后缀）。

12 maxlength:5 输入长度最多是 5 的字符串（汉字算一个字符）。

13 minlength:10 输入长度最小是 10 的字符串（汉字算一个字符）。

14 rangelength:[5,10] 输入长度必须介于 5 和 10 之间的字符串（汉字算一个字符）。

15 range:[5,10] 输入值必须介于 5 和 10 之间。

16 max:5 输入值不能大于 5。

17 min:10 输入值不能小于 10。
```

```html
自定义验证信息
<script type="text/javascript">
    $(document).ready(function() {
        $("#commentForm").validate({
            rules: {
                username: {
                    required: true,
                    minlength: 2
                },
                email: {
                    required: true,
                    email: true
                },
                url: "url",
                comment: "required"
            },
            messages: {
                username: {
                    required: "请输入用户名",
                    minlength: "用户名必需由两个字母组成"
                },
                email: {
                    required: "请输入邮箱",
                    email: "请输入正确的邮箱"
                },
                url: "请输入正确的url",
                comment: "请输入评论"
            }
        });
    });
</script>

注：messages 处，如果某个控件没有 message，将调用默认的信息。
```

```css
自定义验证信息并美化

为验证信息添加上图片来美化，也很简单。只需在 jQuery 代码中添加：

errorElement: "em", //可以用其他标签，记住把样式也对应修改
success: function(label) {
    //label指向上面那个错误提示信息标签em
    label.text(" ") //清空错误提示消息
        .addClass("success"); //加上自定义的success类
}

css 代码中添加如下代码，以便于 errorElement 相关联：
em {
    font-weight: bold;
    padding-right: 1em;
    vertical-align: top;
}

em.error {
    background: url("unchecked.gif") no-repeat 0px 0px;
    padding-left: 16px;
}

em.success {
    background: url("checked.gif") no-repeat 0px 0px;
    padding-left: 16px;
}

所需要的图片通过命令下载：
wget http://labfile.oss.aliyuncs.com/courses/22/checked.gif
wget http://labfile.oss.aliyuncs.com/courses/22/unchecked.gif
```

## Cookie 插件

Cookie 插件js-cookie

CDN：https://cdn.bootcdn.net/ajax/libs/js-cookie/2.2.1/js.cookie.min.js

```css
应用：

(1)创建一个 cookie，在整个站点中有效：
Cookies.set('name', 'value');

(2)创建一个 7 天后到期的 cookie，在整个站点上都有效：
Cookies.set('name', 'value', { expires: 7 });

(3)创建一个到期的 cookie，对当前页的路径有效：
Cookies.set('name', 'value', { expires: 7, path: '' });

(4)读取 cookie：
Cookies.get('name'); // => 'value'
Cookies.get('nothing'); // => undefined

(5)读取所有可见的 cookie：
Cookies.get(); // => { name: 'value' }

注意：不可能通过传递 cookie 属性之一来读取特定的 cookie:
Cookies.get('foo', { domain: 'sub.example.com' }); // `domain` won't have any effect...!

(6)删除 cookie：
Cookies.remove('name');

(7)删除对当前页的路径有效的 cookie：
Cookies.set('name', 'value', { path: '' });
Cookies.remove('name'); // fail!
Cookies.remove('name', { path: '' }); // removed!

注意：注意：删除 cookie 时，必须传递用于设置 cookie 的完全相同的路径，域及安全选项。删除不存在的 cookie 不会引发任何异常，也不会返回任何值。
```

```html
示例:

<p id="test"></p>
<p id="test2"></p>

<script>
    $(document).ready(function() {
        Cookies.set('name', 'syl'); // 创建 cookie
        name = Cookies.get('name'); // 读取 cookie
        $("#test").text(name);
    });
</script>
```

```css
名称空间冲突

如果有任何与命名空间冲突的危险 Cookies，noConflict 方法将允许您定义新的命名空间并保留原始名称空间。这在第三方站点上运行脚本时尤其有用，例如作为小部件或 SDK 的一部分。

var Cookies2 = Cookies.noConflict();
Cookies2.set('name', 'value');

注：.noConflict 方法在使用 AMD 或 CommonJS 时是不必要的，因此在这些环境中不公开它。
```

```js
json存储

创建 cookie 时，可以传递数组或对象文本，而不是值中的字符串。如果这样做，js-cookie 将根据以下内容存储对象的字符串表示形式：JSON.stringify:

Cookies.set('name', { foo: 'bar' });

使用默认值读取 cookie 时 Cookies.getAPI，您将接收存储在 cookie 中的字符串表示：

Cookies.get('name'); // => '{"foo":"bar"}'
Cookies.get(); // => { name: '{"foo":"bar"}' }

当使用 Cookies.getJSONAPI，您将收到存储在 cookie 中的字符串的解析表示形式。JSON.parse:

Cookies.getJSON('name'); // => { foo: 'bar' }
Cookies.getJSON(); // => { name: { foo: 'bar' } }
```

##  jQuery UI

### 简介

```css
jQuery UI 包含了许多维持状态的小部件（Widget），因此，它与典型的 jQuery 插件使用模式略有不同。所有的 jQuery UI 小部件（Widget）使用相同的模式，只要您学会使用其中一个，就知道如何使用其他的小部件。
```

CDN：https://cdn.bootcdn.net/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css

​		    https://cdn.bootcdn.net/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js
```html
<link rel="stylesheet" href="jquery-ui.css" />
<script type="text/javascript" src="jquery-3.3.1.js"></script>
<script src="jquery-ui.js"></script>
```

jQuery UI 主要分为 3 个部分：交互、微件和效果库：

```
交互（Interactions）：这里都是一些与鼠标交互相关的内容，包括缩放（Resizable） , 拖动（Draggable） , 放置（Droppable） , 选择（Selectable） , 排序（Sortable）等。

微件（Widgets）：主要是一些界面的扩展，包括折叠面板（Accordion） , 自动完成（Autocomplete） , 按钮（Button） , 日期选择器（Datepicker） , 对话框（Dialog） , 菜单（Menu） , 进度条（Progressbar） , 滑块（Slider） , 旋转器（Spinner） , 标签页（Tabs） , 工具提示框（Tooltip）等，新版本的 UI 将包含更多的微件。

效果库（Effects）：用于提供丰富的动画效果，让动画不再局限于 jQuery 的 animate()方法。包括特效（Effect） , 显示（Show） , 隐藏（Hide） , 切换（Toggle） , 添加 Class（Add Class） , 移除 Class（Remove Class） , 切换 Class（Toggle Class） , 转换 Class（Switch Class） , 颜色动画（Color Animation）等。
```
jQuery UI 默认的图标：

```shell
wget http://labfile.oss.aliyuncs.com/courses/22/images.zip 
unzip images.zip
```

### 应用

```html
日期小部件的例子：
<input type="text" name="date" id="date" />

<script>
    $(document).ready(function() {
        $("#date").datepicker();
    });
</script>
```

