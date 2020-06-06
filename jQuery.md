# 简介

为了简化JavaScript开发,第三方厂商开发了JavaScript库。主流JavaScript库：jQuery、Vuejs、AngularJS、React…

jQuery是一个轻量级JS库,使用十分简单，jQuery的核心是选择器,用于获取页面元素。

CDN：https://www.bootcdn.cn/

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
位置选择器是指通过位置获取指定的元素,例如"获取第3个元素

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

## 节点操作

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

3.detach() 保存所有 jQuery 数据而且和被移走的元素相关联。有惨

$(document).ready(function() {
    $("ul li").click(function(){
        alert($(this).html());
    })
    var $li = $("ul li:eq(1)").detach();//删除元素
    $li.appendTo("ul");//重新追加此元素,发现它之前绑定的事件还在,如果使用remove()方法删除元素的话,那么它之前绑定的事件将失效
});
```



## 元素操作



### 操作元素属性

```js
attr(name|properties|key)-获取或设置元素属性
removeAttr(name)-移除元素属性
```

```js
示例：
var $li = $("ol li:eq(0)");//获取<ol>里第一个<li>节点
var li_txt = $li.text();//获取第一个<li>元素节点的文本内容
```

### 操作元素样式

```js
css()-获取或设置匹配元素的样式属性
addClass()-为每个匹配的元素添加指定的类名
removeClass0)-从所有匹配的元素中删除全部或者指定的类
```

### 设置元素内容

```js
val()-获取或设置输入项的值
text()-获取或设置元素的纯文本
html()-获取或设置元素内部的HTML
```

```js
示例：
var $li = $("ol li:eq(0)");//获取<ol>里第一个<li>节点
var li_txt = $li.text();//获取第一个<li>元素节点的文本内容
```

### 事件处理方法

```js
on("click", function)-为选中的页面元素绑定单击事件
click(function)-是绑定事件的简写形式
处理方法中提供了event参数包含了事件的相关信息
```

**jQuery常用事件**

| 鼠标事件   | 键盘事件 | 表单事件 | 文档/窗口事件 |
| ---------- | -------- | -------- | ------------- |
| click      | keypress | submit   | load          |
| dblclick   | keydown  | change   | resize        |
| mouseenter | keyup    | focus    | scroll        |
| mouseleave |          | blur     | unload        |
| mouseover  |          |          |               |

页面就绪函数

```js
页面就绪函数是指在页面加载完成后执行的函数
语法1: $(document).ready(function){}
语法2: $(function){}

所有js  / jQuery 函数位于一个页面就绪函数中：防止文档在完全加载（就绪）之前运行 代码；如果在文档没有完全加载之前就运行函数，操作可能失败。
```

|          | window.onload                                          | $(doucment).ready()                                          |
| -------- | ------------------------------------------------------ | ------------------------------------------------------------ |
| 执行时机 | 必须等待网页中所有的内容加载完毕后才能执行（包括图片） | 网页中所有 DOM 结构绘制完毕后就执行，可能 DOM 元素关联的东西并没有加载完 |
| 编写个数 | 只能有一个页面就虚函数。                               | 能同时编写多个页面就虚函数。                                 |

 jQUery 的链式操作

```
$(document).ready(function() {
    $(".level1>a").click(function() {
        $(this).addClass("current")//给当前元素添加"current"样式
        .next().show()//下一个元素显示
        .parent().siblings().children("a").removeClass("current")//父元素的同辈元素的子元素a移除"current"样式
        .next().hide();//它们的下一个元素隐藏
        return false;
    })
});
```



```
$("#syl").html();//获取id为syl的元素内的html代码，html()是jQuery中的方法
copy
这段代码等同于：

document.getElementById("syl").innerHTML;//DOM对象使用js的innerHTML方法

jQuery 对象转换为DOM 
var $cr = $("#cr");//jQuery 对象
var cr = $cr[0];//DOM 对象
通过 get(index) 方法得到相应的 DOM 对象，比如：
var $cr = $("#cr");//jQuery 对象
var cr = $cr.get(0);//DOM 对象

DOM 对象转换为 jQuery 对象
对于一个 DOM 对象，只需要用 $() 把 DOM 对象包装起来，就可以获得一个 jQuery 对象了，比如：

var cr = document.getElementById("cr");//DOM 对象
var $cr = $(cr);//jQuery 对象

注：这里加个$只是为了区分变量是 jQuery 对象还是 DOM 对象并不是说所有使用 jQuery 的代码中变量声明都需要只是为了区分变量是jQuery对象还是DOM对象并不是说所有使用jQuery的代码中变量声明都需要。
```

 jQuery 和其他库的冲突

某些框架也使用 $ 符号作为简写（就像 jQuery），如果您在用的两种不同的框架正在使用相同的简写符号，有可能导致脚本停止运行。

noConflict() 方法会释放对 $ 标识符的控制

```
 $.noConflict();
            jQuery(document).ready(function() {
                jQuery("button").click(function() {
                    jQuery("p").text("jQuery 仍然在工作!");
                });
            });
             var jq = $.noConflict();
            jq(document).ready(function() {
                jq("button").click(function() {
                    jq("p").text("jQuery 仍然在工作!");
                });
            });
```

