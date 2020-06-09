# CSS

## css选择器

| 选择器                                                       | 示例                  | 示例说明                                                  | CSS  |
| :----------------------------------------------------------- | :-------------------- | :-------------------------------------------------------- | :--- |
| [.*class*](https://www.runoob.com/cssref/sel-class.html)     | .intro                | 选择所有class="intro"的元素                               | 1    |
| [#*id*](https://www.runoob.com/cssref/sel-id.html)           | #firstname            | 选择所有id="firstname"的元素                              | 1    |
| [*](https://www.runoob.com/cssref/sel-all.html)              | *                     | 选择所有元素                                              | 2    |
| *[element](https://www.runoob.com/cssref/sel-element.html)*  | p                     | 选择所有<p>元素                                           | 1    |
| *[element,element](https://www.runoob.com/cssref/sel-element-comma.html)* | div,p                 | 选择所有<div>元素和<p>元素                                | 1    |
| [*element* *element*](https://www.runoob.com/cssref/sel-element-element.html) | div p                 | 选择<div>元素内的所有<p>元素                              | 1    |
| [*element*>*element*](https://www.runoob.com/cssref/sel-element-gt.html) | div>p                 | 选择所有父级是 <div> 元素的 <p> 元素                      | 2    |
| [*element*+*element*](https://www.runoob.com/cssref/sel-element-pluss.html) | div+p                 | 选择所有紧接着<div>元素之后的<p>元素                      | 2    |
| [[*attribute*\]](https://www.runoob.com/cssref/sel-attribute.html) | [target]              | 选择所有带有target属性元素                                | 2    |
| [[*attribute*=*value*\]](https://www.runoob.com/cssref/sel-attribute-value.html) | [target=-blank]       | 选择所有使用target="-blank"的元素                         | 2    |
| [[*attribute*~=*value*\]](https://www.runoob.com/cssref/sel-attribute-value-contains.html) | [title~=flower]       | 选择标题属性包含单词"flower"的所有元素                    | 2    |
| [[*attribute*\|=*language*\]](https://www.runoob.com/cssref/sel-attribute-value-lang.html) | [lang\|=en]           | 选择 lang 属性以 en 为开头的所有元素                      | 2    |
| [:link](https://www.runoob.com/cssref/sel-link.html)         | a:link                | 选择所有未访问链接                                        | 1    |
| [:visited](https://www.runoob.com/cssref/sel-visited.html)   | a:visited             | 选择所有访问过的链接                                      | 1    |
| [:active](https://www.runoob.com/cssref/sel-active.html)     | a:active              | 选择活动链接                                              | 1    |
| [:hover](https://www.runoob.com/cssref/sel-hover.html)       | a:hover               | 选择鼠标在链接上面时                                      | 1    |
| [:focus](https://www.runoob.com/cssref/sel-focus.html)       | input:focus           | 选择具有焦点的输入元素                                    | 2    |
| [:first-letter](https://www.runoob.com/cssref/sel-firstletter.html) | p:first-letter        | 选择每一个<p>元素的第一个字母                             | 1    |
| [:first-line](https://www.runoob.com/cssref/sel-firstline.html) | p:first-line          | 选择每一个<p>元素的第一行                                 | 1    |
| [:first-child](https://www.runoob.com/cssref/sel-firstchild.html) | p:first-child         | 指定只有当<p>元素是其父级的第一个子级的样式。             | 2    |
| [:before](https://www.runoob.com/cssref/sel-before.html)     | p:before              | 在每个<p>元素之前插入内容                                 | 2    |
| [:after](https://www.runoob.com/cssref/sel-after.html)       | p:after               | 在每个<p>元素之后插入内容                                 | 2    |
| [:lang(*language*)](https://www.runoob.com/cssref/sel-lang.html) | p:lang(it)            | 选择一个lang属性的起始值="it"的所有<p>元素                | 2    |
| [*element1*~*element2*](https://www.runoob.com/cssref/sel-gen-sibling.html) | p~ul                  | 选择p元素之后的每一个ul元素                               | 3    |
| [[*attribute*^=*value*\]](https://www.runoob.com/cssref/sel-attr-begin.html) | a[src^="https"]       | 选择每一个src属性的值以"https"开头的元素                  | 3    |
| [[*attribute*$=*value*\]](https://www.runoob.com/cssref/sel-attr-end.html) | a[src$=".pdf"]        | 选择每一个src属性的值以".pdf"结尾的元素                   | 3    |
| [[*attribute**=*value*\]](https://www.runoob.com/cssref/sel-attr-contain.html) | a[src*="runoob"]      | 选择每一个src属性的值包含子字符串"runoob"的元素           | 3    |
| [:first-of-type](https://www.runoob.com/cssref/sel-first-of-type.html) | p:first-of-type       | 选择每个p元素是其父级的第一个p元素                        | 3    |
| [:last-of-type](https://www.runoob.com/cssref/sel-last-of-type.html) | p:last-of-type        | 选择每个p元素是其父级的最后一个p元素                      | 3    |
| [:only-of-type](https://www.runoob.com/cssref/sel-only-of-type.html) | p:only-of-type        | 选择每个p元素是其父级的唯一p元素                          | 3    |
| [:only-child](https://www.runoob.com/cssref/sel-only-child.html) | p:only-child          | 选择每个p元素是其父级的唯一子元素                         | 3    |
| [:nth-child(*n*)](https://www.runoob.com/cssref/sel-nth-child.html) | p:nth-child(2)        | 选择每个p元素是其父级的第二个子元素                       | 3    |
| [:nth-last-child(*n*)](https://www.runoob.com/cssref/sel-nth-last-child.html) | p:nth-last-child(2)   | 选择每个p元素的是其父级的第二个子元素，从最后一个子项计数 | 3    |
| [:nth-of-type(*n*)](https://www.runoob.com/cssref/sel-nth-of-type.html) | p:nth-of-type(2)      | 选择每个p元素是其父级的第二个p元素                        | 3    |
| [:nth-last-of-type(*n*)](https://www.runoob.com/cssref/sel-nth-last-of-type.html) | p:nth-last-of-type(2) | 选择每个p元素的是其父级的第二个p元素，从最后一个子项计数  | 3    |
| [:last-child](https://www.runoob.com/cssref/sel-last-child.html) | p:last-child          | 选择每个p元素是其父级的最后一个子级。                     | 3    |
| [:root](https://www.runoob.com/cssref/sel-root.html)         | :root                 | 选择文档的根元素                                          | 3    |
| [:empty](https://www.runoob.com/cssref/sel-empty.html)       | p:empty               | 选择每个没有任何子级的p元素（包括文本节点）               | 3    |
| [:target](https://www.runoob.com/cssref/sel-target.html)     | #news:target          | 选择当前活动的#news元素（包含该锚名称的点击的URL）        | 3    |
| [:enabled](https://www.runoob.com/cssref/sel-enabled.html)   | input:enabled         | 选择每一个已启用的输入元素                                | 3    |
| [:disabled](https://www.runoob.com/cssref/sel-disabled.html) | input:disabled        | 选择每一个禁用的输入元素                                  | 3    |
| [:checked](https://www.runoob.com/cssref/sel-checked.html)   | input:checked         | 选择每个选中的输入元素                                    | 3    |
| [:not(*selector*)](https://www.runoob.com/cssref/sel-not.html) | :not(p)               | 选择每个并非p元素的元素                                   | 3    |
| [::selection](https://www.runoob.com/cssref/sel-selection.html) | ::selection           | 匹配元素中被用户选中或处于高亮状态的部分                  | 3    |
| [:out-of-range](https://www.runoob.com/cssref/sel-out-of-range.html) | :out-of-range         | 匹配值在指定区间之外的input元素                           | 3    |
| [:in-range](https://www.runoob.com/cssref/sel-in-range.html) | :in-range             | 匹配值在指定区间之内的input元素                           | 3    |
| [:read-write](https://www.runoob.com/cssref/sel-read-write.html) | :read-write           | 用于匹配可读及可写的元素                                  | 3    |
| [:read-only](https://www.runoob.com/cssref/sel-read-only.html) | :read-only            | 用于匹配设置 "readonly"（只读） 属性的元素                | 3    |
| [:optional](https://www.runoob.com/cssref/sel-optional.html) | :optional             | 用于匹配可选的输入元素                                    | 3    |
| [:required](https://www.runoob.com/cssref/sel-required.html) | :required             | 用于匹配设置了 "required" 属性的元素                      | 3    |
| [:valid](https://www.runoob.com/cssref/sel-valid.html)       | :valid                | 用于匹配输入值为合法的元素                                | 3    |
| [:invalid](https://www.runoob.com/cssref/sel-invalid.html)   | :invalid              | 用于匹配输入值为非法的元素                                | 3    |

**优先级别**
```css
元素选择器 ---> 类选择器、属性选择器 ---> ID选择器

内联样 > 外部样式表

!important声明将覆盖任何其他声明（IE6及以下浏览器不识别!important）
```
**伪类、伪元素**

作用：添加一些选择器的特殊效果，弥补了CSS选择器的不足

```css
伪类：为了通过选择器，格式化DOM树以外的信息以及不能被常规CSS选择器获取到的信息。
通过上面的概念我们知道了伪类的功能有两种：
1.格式化DOM树以外的信息。比如： <a> 标签的:link、:visited 等。这些信息不存在于DOM树中。
2.不能被常规CSS选择器获取到的信息。比如：要获取第一个子元素，我们无法用常规的CSS选择器获取，但可以通过 :first-child 来获取到。

伪元素：可以创建一些文档语言无法创建的虚拟元素。比如：
文档语言没有机制可以描述元素内容的第一个字母或第一行，但伪元素可以(::first-letter、::first-line)。
同时，伪元素还可以创建源文档不存在的内容，比如使用 ::before 或 ::after。
```

|     伪类Selector     | Meaning                                        | CSS  |
| :------------------: | :--------------------------------------------- | :--: |
|       :active        | 选择正在被激活的元素                           |  1   |
|        :hover        | 选择被鼠标悬浮着元素                           |  1   |
|        :link         | 选择未被访问的元素                             |  1   |
|       :visited       | 选择已被访问的元素                             |  1   |
|     :first-child     | 选择满足是其父元素的第一个子元素的元素         |  2   |
|        :lang         | 选择带有指定 lang 属性的元素                   |  2   |
|        :focus        | 选择拥有键盘输入焦点的元素                     |  2   |
|       :enable        | 选择每个已启动的元素                           |  3   |
|       :disable       | 选择每个已禁止的元素                           |  3   |
|       :checked       | 选择每个被选中的元素                           |  3   |
|       :target        | 选择当前的锚点元素                             |  3   |
|    :first-of-type    | 选择满足是其父元素的第一个某类型子元素的元素   |  3   |
|    :last-of-type     | 选择满足是其父元素的最后一个某类型子元素的元素 |  3   |
|    :only-of-type     | 选择满足是其父元素的唯一一个某类型子元素的元素 |  3   |
|   :nth-of-type(n)    | 选择满足是其父元素的第n个某类型子元素的元素    |  3   |
| :nth-last-of-type(n) | 选择满足是其父元素的倒数第n个某类型的元素      |  3   |
|     :only-child      | 选择满足是其父元素的唯一一个子元素的元素       |  3   |
|     :last-child      | 选择满足是其父元素的最后一个元素的元素         |  3   |
|    :nth-child(n)     | 选择满足是其父元素的第n个子元素的元素          |  3   |
|  :nth-last-child(n)  | 选择满足是其父元素的倒数第n个子元素的元素      |  3   |
|        :empty        | 选择满足没有子元素的元素                       |  3   |
|      :in-range       | 选择满足值在指定范围内的元素                   |  3   |
|    :out-of-range     | 选择值不在指定范围内的元素                     |  3   |
|       :invalid       | 选择满足值为无效值的元素                       |  3   |
|        :valid        | 选择满足值为有效值的元素                       |  3   |
|    :not(selector)    | 选择不满足selector的元素                       |  3   |
|      :optional       | 选择为可选项的表单元素，即没有“required”属性   |  3   |
|      :read-only      | 选择有"readonly"的表单元素                     |  3   |
|     :read-write      | 选择没有"readonly"的表单元素                   |  3   |
|        :root         | 选择根元素                                     |  3   |

| 伪元素Selector | Meaning                        | CSS  |
| :------------: | :----------------------------- | :--: |
| ::first-letter | 选择指定元素的第一个单词       |  1   |
|  ::first-line  | 选择指定元素的第一行           |  1   |
|    ::after     | 在指定元素的内容前面插入内容   |  2   |
|    ::before    | 在指定元素的内容后面插入内容   |  2   |
|  ::selection   | 选择指定元素中被用户选中的内容 |  3   |

## css定位

```CSS
position 属性的五个值：
static（无定位）、fixed（固定）、absolute（绝对）、relative（相对）、sticky（粘性）

重叠的元素：z-index
```

**示例**

```css
img {    
    /*HTML 元素的默认值，即没有定位，遵循正常的文档流对象;
    静态定位的元素不会受到 top, bottom, left, right影响。*/
    position:static; 
    
    /*元素的位置相对于浏览器窗口是固定位置；
	即使窗口是滚动的它也不会移动；
    Fixed定位使元素的位置与文档流无关，因此不占据空间。*/
    position:fixed; 
    
    /*绝对定位的元素的位置相对于最近的已定位父元素,
    如果元素没有已定位的父元素，那么它的位置相对于<html>;
    absolute 定位使元素的位置与文档流无关，因此不占据空间。*/
    position:absolute;
    
    /*相对定位元素的定位是相对其正常位置；
    移动相对定位元素，但它原本所占的空间不会改变；
    相对定位元素经常被用来作为绝对定位元素的容器块。*/
    position:relative;
    
    /*元素定位表现为在跨越特定阈值前为相对定位，之后为固定定位。
	既指定 top, right, bottom 或 left 四个阈值其中之一，才可使粘性定位生效，
    否则其行为与相对定位相同。*/
    /*滚动超出屏幕窗口，元素贴在边缘*/
    position:sticky;
    top: 0;
    
    /*元素的定位与文档流无关，所以它们可以覆盖页面上的其它元素
	z-index属性指定了一个元素的堆叠顺序（哪个元素应该放在前面，或后面）
	一个元素可以有正数或负数的堆叠顺序*/
    z-index:-1; }
```

## @media

**@media 可以针对不同的屏幕尺寸设置不同的样式**

在使用Media的时候需要先设置下面这段代码，来兼容移动设备的展示效果：

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

width = device-width：宽度等于当前设备的宽度
height = device-height：高度等于当前设备的高度
initial-scale：初始的缩放比例（默认设置为1.0）  
minimum-scale：允许用户缩放到的最小比例（默认设置为1.0）    
maximum-scale：允许用户缩放到的最大比例（默认设置为1.0）   
user-scalable：用户是否可以手动缩放（默认设置为no，因为我们不希望用户放大缩小页面） 
```

**CSS 语法**

```css
@media *mediatype* and|not|only *(media feature)* {*
  CSS-Code;
*}
```

也可以针对不同的媒体使用不同 *stylesheets* :

```css
<link rel="stylesheet" media="*mediatype* and|not|only (*media feature*)" href="*mystylesheet.css*">
```

| mediatyp | 用于所有设备                         |
| -------- | ------------------------------------ |
| all      | 用于所有设备                         |
| print    | 用于打印机和打印预览                 |
| screen   | 用于电脑屏幕，平板电脑，智能手机等。 |
| speech   | 应用于屏幕阅读器等发声设备           |

| media feature           | 描述                                                         |
| :---------------------- | :----------------------------------------------------------- |
| aspect-ratio            | 定义输出设备中的页面可见区域宽度与高度的比率                 |
| color                   | 定义输出设备每一组彩色原件的个数。如果不是彩色设备，则值等于0 |
| color-index             | 定义在输出设备的彩色查询表中的条目数。如果没有使用彩色查询表，则值等于0 |
| device-aspect-ratio     | 定义输出设备的屏幕可见宽度与高度的比率。                     |
| device-height           | 定义输出设备的屏幕可见高度。                                 |
| device-width            | 定义输出设备的屏幕可见宽度。                                 |
| grid                    | 用来查询输出设备是否使用栅格或点阵。                         |
| height                  | 定义输出设备中的页面可见区域高度。                           |
| max-aspect-ratio        | 定义输出设备的屏幕可见宽度与高度的最大比率。                 |
| max-color               | 定义输出设备每一组彩色原件的最大个数。                       |
| max-color-index         | 定义在输出设备的彩色查询表中的最大条目数。                   |
| max-device-aspect-ratio | 定义输出设备的屏幕可见宽度与高度的最大比率。                 |
| max-device-height       | 定义输出设备的屏幕可见的最大高度。                           |
| max-device-width        | 定义输出设备的屏幕最大可见宽度。                             |
| max-height              | 定义输出设备中的页面最大可见区域高度。                       |
| max-monochrome          | 定义在一个单色框架缓冲区中每像素包含的最大单色原件个数。     |
| max-resolution          | 定义设备的最大分辨率。                                       |
| max-width               | 定义输出设备中的页面最大可见区域宽度。                       |
| min-aspect-ratio        | 定义输出设备中的页面可见区域宽度与高度的最小比率。           |
| min-color               | 定义输出设备每一组彩色原件的最小个数。                       |
| min-color-index         | 定义在输出设备的彩色查询表中的最小条目数。                   |
| min-device-aspect-ratio | 定义输出设备的屏幕可见宽度与高度的最小比率。                 |
| min-device-width        | 定义输出设备的屏幕最小可见宽度。                             |
| min-device-height       | 定义输出设备的屏幕的最小可见高度。                           |
| min-height              | 定义输出设备中的页面最小可见区域高度。                       |
| min-monochrome          | 定义在一个单色框架缓冲区中每像素包含的最小单色原件个数       |
| min-resolution          | 定义设备的最小分辨率。                                       |
| min-width               | 定义输出设备中的页面最小可见区域宽度。                       |
| monochrome              | 定义在一个单色框架缓冲区中每像素包含的单色原件个数。如果不是单色设备，则值等于0 |
| orientation             | 定义输出设备中的页面可见区域高度是否大于或等于宽度。         |
| resolution              | 定义设备的分辨率。如：96dpi, 300dpi, 118dpcm                 |
| scan                    | 定义电视类设备的扫描工序。                                   |
| width                   | 定义输出设备中的页面可见区域宽度。                           |

**示例**

```css
/*max-width: 500px为页面可见区域最大宽度，可在浏览器开发模式中查询各设备匹配值*/
@media only screen and (max-width: 500px) {
    .gridmenu {
        width:100%;
    }
    .gridmain {
        width:100%;
    }
    .gridright {
        width:100%;
    }
}

/*横屏*/
@media all and (orientation : landscape) { 
h2{color:red;}
} 

/*竖屏*/
@media all and (orientation : portrait){ 
h2{color:green;}
} 
```



# HTML

## 问题记录

### 1. html内嵌

前端内嵌

```html
< iframe name="XXX" width=X height=X frameborder=0 src="XXX.htm" >< /iframe >

--不出现滚动条：在外部文件< body >标签中加入“scroll=no”或者在宿主页面< iframe >标签中加入“scrolling=no”即可。

--背景颜色不同：标签< iframe >内设置属性allowTransparency="true"(即框架背景透明)。
```

```html
<object style="border: 0px" type="text/x-scriptlet" data="XXX.htm" width=X Height=X >
</object>

--类似于ifram，它有自己的不透明方形区域，并覆盖在宿主页面上。
```

```html
<script>
  $("#test").load("qian.html #qian",function(data){
    console.log($("#qian").text());//返回选择器选取元素文本
    console.log(data);//返回整个html源码
  });
  console.log($("#test").html());//返回选择器选取元素内部html
</script>

等价于
<script>
$.ajax({
    url: "qian.html",
    dataType: "html",
    success: function (data) {
      $("#test").html($(data).filter("#qian").html());
    }
  });
</script>

--使用脚本，这种方法的特点是外部页面不具有自己的方形区域，和宿主页面浑然一体，但由于外部页面内容全部写在脚本中，无法做到所见即所得，必须等到脚本运行时才能看到实际效果，这样就为修改调试增加了困难。
```

后端内嵌

SSI （server side include）服务器端包含，如：<#include>类似jsp的 include 标签

服务器将内容发送到浏览器之前，可以使用“服务器端包含 (SSI)”指令将文本、图形或应用程序信息包含到网页中。Web 服务器在处理网页的同时处理 SSI 指令。当 Web 服务器遇到 SSI 指令时，直接将包含文件的内容插入 HTML 网页。ssi的可定义扩展名为：*.stm、* *.shtm、* *.shtml*

```css
SSI指令使用

显示服务器端环境变量<#echo>

1、获取本文档名称：
<!–#echo var="DOCUMENT_NAME"–>
2、获取当前时间：
<!–#echo var="DATE_LOCAL"–>
3、获取当前IP：
<! #echo var="REMOTE_ADDR"–>
　　

将文本内容直接插入到文档中<#include>

注：file包含文件可以在同一级目录或其子目录中，但不能在上一级目录中，virtual包含文件可以是Web站点上的虚拟目录的完整路径

<! #include file="文件名称"–>
如：<!--#include virtual="index.html" -->
 
<! #include virtual="文件名称"–>
如：<!--#include virtual="/www/footer.html" -->
　　
显示WEB文档相关信息<#flastmod><#fsize>(如文件制作日期/大小等)

1、获取文件最近更新日期：
<! #flastmod file="文件名称"–>
2、获取文件的长度：
<!–#fsize file="文件名称"–>
　　

直接执行服务器上的各种程序<#exec>(如CGI或其他可执行程序)

1、<!–#exec cmd="文件名称"–>
<!--#exec cmd="cat /etc/passwd"-->
2、<!–#exec cgi="文件名称"–>
<!--#exec cgi="/cgi-bin/access_log.cgi"–>
```

```css
配置服务器：

1. nginx配置：nginx.conf
server {
    listen       80;
    server_name  localhost;
    # 开启 ssi
    ssi on;
    # ssi 出错是不会打印日志
    ssi_silent_errors on;
    # 默认的静态页面后缀为 html，如果想自定义，比如使用shtml则开启下方注释
    # ssi_types text/shtml;
    location / {
        # 指定静态文件所在位置
        root        ssi;
        # 默认首页，如果你的后缀在上方修改为 *.shtml，则下方也需要跟着修改
        index       index.html index.htm;
    }
}

2. apache配置：httpd.conf

加载ssi模块
取消注释：
LoadModule ssl_module modules/mod_ssl.so

添加需要的文件类型,ssi技术的默认文件名为.shtml
取消注释：可添加.html文件类型
AddType text/html .shtml .html .htm
AddOutputFilter INCLUDES .shtml .html .htm

取消注释：Options Indexes FollowSymLinks在后面加上INCLUDES
ssi可以利用shell来执行命令,因此这个功能是有危险的,它会执行任何包含在exec标记中的命令
关闭exec功能，改为: Options Indexes FollowSymLinks INCLUDES IncludesNOEXEC

重启apache,即可使用ssi指令。对于个别apache环境还不能使用.html的情况,可在配置中添加以下代码:
AddType text/html .ssi
Options Includes
AddOutputFilterByType INCLUDES;DEFLATE text/html
```

