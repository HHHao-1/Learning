# --- 布局 ---

# Float

> 脱离文档流，浮动不会重叠
>
> 使元素向左或向右移动，其周围的元素也会重新排列。
>
> 一个浮动元素会尽量向左或向右移动，直到它的外边缘碰到页面框或另一个浮动框的边框为止。
>
> 浮动元素之后的元素将围绕它；浮动元素之前的元素将不会受到影响。

场景：

1. 环绕：如果元素是右浮动，下面的文档流元素将环绕在它左边，反之则反。

2. 排列：如果把几个浮动的元素放到一起，如果有空间的话，它们将彼此相邻，空间不够则换行。

3. 清除浮动：浮动元素之后的元素，为保持其正常文档流位置(既在浮动元素下一行)，使用 clear 属性。

```css
.img
{
	float:left;
}
.text
{
	clear:both;
}
```

# Position

- static：正常文档流
- relative：移动后，正常文档流的位置仍然保留
- fixed：脱离文档流，因此不占据空间
- absolute：脱离文档流，因此不占据空间
- sticky：脱离文档流，因此不占据空间

*使用定位后（除static），元素可以使用偏移量：top，bottom，left，right属性定位*

> 重叠元素：(定位会重叠)
>
> 元素的定位与文档流无关，所以它们可以覆盖页面上的其它元素
>
> z-index属性指定了一个元素的堆叠顺序
>
> **注意：** 如果两个定位元素重叠，没有指定z - index，最后定位在HTML中的元素显示在最前面。

## static 定位

HTML 元素的默认值，既没有定位，遵循正常的文档流。

## relative 定位

元素位置是相对其正常文档流位置。

但它原本所占的空间不会改变。

相对定位元素经常被用来作为绝对定位元素的容器块。

## fixed 定位

元素的位置相对于浏览器窗口是固定位置。

即使窗口是滚动的它也不会移动。

**注意：** Fixed 定位在 IE7 和 IE8 下需要描述 !DOCTYPE 才能支持。

## absolute 定位

元素位置相对于最近的已定位父元素。

如果元素没有已定位的父元素，那么它的位置相对于\<html>。

## sticky 定位

基于用户的滚动位置来定位。

页面滚动时，在 **position:relative** 与 **position:fixed** 定位之间切换。

元素定位表现为在跨越特定阈值前为相对定位，之后为固定定位。

这个特定阈值指的是 top, right, bottom,left 之一，必须指定四个阈值其中之一，才可使粘性定位生效。否则其行为与相对定位相同。

**注意:** Internet Explorer, Edge 15 及更早 IE 版本不支持 sticky 定位。 Safari 需要使用`position: -webkit-sticky; `。

# 居中布局

## 水平居中

*垂直居中布局就是指当前元素在父级元素容器中,水平方向是居中显示的*

- inline-block + text-algin

- table + margin

- absolute +transform

```css
第一种：
优点:
浏览器兼容性比较好，CSS2的语法,浏览器兼容性主要指老版本IE浏览器
缺点:
text-algin属性具有继承性,导致子级元素的文本也是居中显示的
解决：
可在子元素中再设置text-align解决

.parent { 
  /* 
  text-align属性:是为文本内容设置对齐方式
  * left:左对齐
  * center:居中对齐
  * right:右对齐
  */
  text-align: center; 
} 
.child { 
  /* 
  display属性:
  * block:块级元素
  * inline:内联元素(text-align属性有效)
  * width和height属性是无效的
  * inline-block:行内块级元素(块级+内联)
  * width和height属性是有效的
  */
  display: inline-block; 
}
```

```css
第二种：
优点:
只需要对子级元素进行设置就可以实现水平方向居中布局效果
缺点:
如果子级元素脱离文档流,导致margin属性的值无效
解释：
脱离文档流：元素设置为浮动，绝对定位，固定定位(fixed)【只有相对定位不脱离文档流】

.child { 
  /* display的值为table或block */
  display: table;
  /* 
  margin属性:外边距
  * 一个值 - 上右下左
  * 二个值 - 第一个表示上下，第二个表示左右
  * auto - 表示根据浏览器自动分配
  * 三个值 - 第一个表示上，第二个表示左右，第三个表示下
  * 四个值 - 上右下左
  */
  margin: 0 auto;
}
```

```css
第三种：
优点：
父级元素是否脱离文档流,不影响子级元素水平居中效果
缺点：
transform属性是CSS3中新增属性,浏览器支持情况不好

.parent { 
  /* 开启定位 */
  position: relative; 
} 
.child {
  /* 
  当把当前元素设置为绝对定位之后:
  * 如果父级元素没有开启定位的话，当前元素是相对于页面定位的
  * 如果父级元素开启了定位的话，当前元素是相对于父级元素定位的
  */
  position: absolute;
  left: 50%;
  transform: trans latex(-50%);
}
```

## 垂直居中

*垂直居中布局就是指当前元素在父级元素容器中,垂直方向是居中显示的*

- table-cell + vertical-algin

- absolute + transform

```css
第一种：
优点：
浏览器兼容性比较好
缺点：
vertical-algin属性具有继承性,导致父级元素的文本也是居中显示的

.parent { 
  /* 
  display属性:
  * table:设置当前元素为<table>元素
  * table-cell:设置当前元素为<td>元素(单元格)
  */
  display: table-cell;
  /* 
  vertical-align属性:用于设置文本内容的垂直方向对齐方式
  * top:顶部对齐
  * middle:居中对齐
  * bottom:底部对齐
  */
  vertical-align: middle;
}
```

```css
第二种：
优点:
父级元素是否脱离文档流,不影响子级元素垂直居中效果
缺点:
transform属性是CSS3中新增属性,浏览器支持情况不好

.parent { 
  position: relative; 
} 
.child {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
}
```

## 居中

是既要水平方向居中，也要直向居中

- table + margin实现水平方向居中, table-cell + vertical-algin实现垂直方向居中

- absolute + transform实现水平方向和垂直方向居中

```css
.parent { 
  display: table-cell;
  vertical-align: middle;
} 
.child {
  display: block;
  margin: 0 auto;
}
```

```css
.parent { 
  position: relative; 
} 
.child {
  position: absolute;
  Left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
}
```

# 多列布局

所谓多列布局就是几个元素呈现水平方式排列的效果

## 两列布局

两列布局一般情况下是指定宽与自适应布局

两列中左列是确定的宽度,右列是自动填满剩余所有空间的一种布局效果

- float + margin
- float + overflow
- display属性的table相关值使用

```css
第一种：
优点:
实现方式简单
缺点:
- 自适应元素margin属性值与定宽元素的width属性值保持一致，高耦合
- 定宽元素浮动与自适应元素不浮动导致浏览器兼容性不好

.left { 
  width: 100px;
  float: left;
}
.right { 
  margin-left: 100px;/*向右移动*/
}

优化版：

<div class="left">左:定宽</div>
<!-- 为自适应元素定位父级元素 -->
<div class="right-fix">
		<div class="right">右:自适应</div>
</div>

/* 定宽 */
.left {
  width: 400px;
  /* 当前元素脱离文档流 */
  float: left;
  /* 设置显示层级更高，定位显示层级高于浮动 */
  position: relative;
}
/* 自适应 */
.right-fix {
  /* 设置为浮动，导致默认宽度值为 0 */
  float: right;
  width: 100%;
  margin-left: -400px;
}
```

```css
第二种：
优点:
第一种解决方案中的问题在此解决方案中都没有
缺点:
overflow属性不仅解决了两列布局问题,同时设置了内容溢出的情况

.left { 
  width: 100px;
  float: left;
}
.right { 
  overflow: hidden; 
}
```

```css
第三种：
优点：
浏览器兼容性比较好
缺点：
将所有元素的display属性设置为table相关值,受到相应制约

<div class="parent">
<div class="left">左:定宽</div>
<div class="right">右:自适应</div>
</div>
.parent {
  /* 表格的单元格的宽度会自动分配 
  不写宽度就是50%和50%，一个有宽度，那另一个就充满剩下*/
  display: table;
  /*设置表格的布局算法
  automatic	默认。列宽度由单元格内容设定。
  fixed	列宽由表格宽度和列宽度设定。
  inherit	规定应该从父元素继承 table-layout 属性的值*/
  table-layout: fixed;
}
.left, .right { 
  display: table-cell; 
} 
.left {
  width: 100px; 
}
```

## 三列布局

三列布局一般情况下是指三列由左边两列是确定的宽度,右边一列是自动填满剩余所有空间的一种布局效果

- float + margin
- float + overflow
- display属性的table相关值的使用

> 与两列布局用法相同，多列+自适应都是这样

重要：定宽+自适应+定宽

```css
缺点：
center放在最后面，不利于搜索引擎抓取

<div id="left"></div>
<div id="right"></div>
<div id="center"></div>

#left,
#center,
#right {
  height: 300px;
}

#left,
#right {
  width: 300px;
}

#left {
  float: left;
}

#center {
  margin-left: 300px;
  margin-right: 300px;
}

#right {
  float: right;
}
```

## 圣杯布局

三行三列布局

三行：三个div

三列：左右定宽+中间自适应的布局效果（使用第二种）

![image-20201104142611263](https://tva1.sinaimg.cn/large/0081Kckwly1gkd4glymdjj316u0ky0w9.jpg)

```css
<div id="parent">
    <div id="center"></div>
    <div id="left"></div>
    <div id="right"></div>
</div>

#parent {
  height: 300px;
  /* 对应的是left元素的宽度 */
  margin-left: 300px;
  /* 对应的是right元素的宽度 */
  margin-right: 300px;
}

#left,
#center,
#right {
  height: 300px;
  float: left;
}

#left,
#right {
  width: 300px;
}

#left {
  /* 将当前元素从当前行，移动上一行同一个位置 */
  margin-left: -100%;
  position: relative;
  /* 将当前元素移动到理想位置 */
  left: -300px;
}

#center {
  /* 为父级元素宽度的100% */
  width: 100%;
}

#right {
  margin-left: -300px;
  position: relative;
  right: -300px;
}
```

## 双飞翼布局

双飞翼布局最早是淘宝团队提出,是针对圣杯局部的优化解决方案。

主要是优化了圣杯布局中开启定位的问题

```css
<div id="parent">
  <div id="center">
    <div id="inner"></div>
  </div>
  <div id="left"></div>
  <div id="right"></div>
</div>

#parent {
  height: 300px;
}

#left,
#center,
#right {
  height: 300px;
  float: left;
}

#left,
#right {
  width: 300px;
}

#left {
  /* 将当前元素从当前行，移动上一行同一个位置 */
  margin-left: -100%;
}

#center {
  /* 为父级元素宽度的100% */
  width: 100%;
}

#right {
  margin-left: -300px;
}

/*原center的内容写在这里*/
#inner {
  height: 300px;
  /* 对应的是left元素的宽度 */
  margin-left: 300px;
  /* 对应的是right元素的宽度 */
  margin-right: 300px;
}
```

## 等分布局

等分布局就是指一行被分为若干列,每一列的宽度是相同的值

- float
- display属性的table相关值的使用

```css
第一种：
<div id="parent">
<div class="col"></div>
<div class="col"></div>
<div class="col"></div>
<div class="col"></div>
</div>

.col {
  height: 300px;
  width: 25%;
  float: left;
  box-sizing: border-box;
  /*  box-sizing- 指定元素宽高设置
  content-box：默认值，其让元素维持W3C的标准盒模型，width/height = border + padding + content width / height
  border-box：元素的宽度或高度等于元素内容的宽度或高度
  inherit：继承自父元素 */
}
```

```css
第二种：
.parent { 
  /* <table> */
  display: table;
  table-layout: fixed;
}
.column { 
  /* <td> */
  display: table-cell;
}
```

> 带间隙布局

![image-20201104162602100](https://tva1.sinaimg.cn/large/0081Kckwly1gkd7x9fypkj31nk0u0tns.jpg)

用margin或padding统一设置会多出一列间隙，超过父级容器宽度，导致不能在一行中显示

```css
改造第一种：
<div id="parent-fix">
    <!-- 作为父级容器 -->
    <div id="parent">
      <div class="col">
        <div class="inner"></div>
      </div>
      <div class="col">
        <div class="inner"></div>
      </div>
      <div class="col">
        <div class="inner"></div>
      </div>
      <div class="col">
        <div class="inner"></div>
      </div>
    </div>
 </div>

#parent-fix {
  /*子容器宽度超出父容器宽度，溢出隐藏*/
  /*解决高度塌陷*/
  overflow: hidden;
}
#parent {
  height: 300px;
  /*左边多出一个间隙处理*/
  margin-left: -10px;
}
.col {
  height: 300px;
  width: 25%;
  float: left;
  /*解决加间隙超过父级容器宽度问题*/
  box-sizing: border-box;
  padding-left: 10px;
}
.inner {
  height: 300px;
}
```

```css
改造第二种：
#parent-fix {
  /*子容器宽度超出父容器宽度*/
  overflow: hidden;
}
#parent {
  /*此容器宽度要比父容器宽度(屏幕宽度)多出10px*/
  width: 1434px;
  display: table;
  /*左边多出一个间隙处理*/
  margin-left: -10px;
}
.col {
  height: 300px;
  display: table-cell;
  /*解决加间隙超过父级容器宽度问题*/
  box-sizing: border-box;
  padding-left: 10px;
}
.inner {
  height: 300px;
}
```

## 等高布局

等高布局就是一行被划分成若干列,每一列的高度是相同的值

- display属性的table相关值的使用
- padding + margin

```css
第一种：
<div class="parent">
  <div class="left">test</div> 
  <div class="right">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Suscipit amet eaque assumenda neque
      repudiandae ad ratione nulla quae quod soluta, debitis tempore aliquid recusandae cupiditate, in maiores
      distinctio obcaecati a?</div>
</div>

.parent { 
  display: table;
  table-layout: fixed;
}
.Left, .right { 
  /* 表格的单元格默认是等高的 */
  display: table-cell; 
} 
.left {
  width: 100px; 
}
```

```css
第二种：伪等高布局（视觉上等高）
.parent { 
  overflow: hidden;
}
.left, .right { 
  width: 300px;
  float: left;
  padding-bottom: 9999px;
  margin-bottom:-9999px;
}
```

## CSS3多列布局

*浏览器兼容不好，包括新版浏览器*

columns：列的属性

> - column-count属性:定义列的数量或者允许的最大列数
>   - auto :默认值,用于表示列的数量由其他CSS属性决定
>   - number :必须是正整数,用于表示定义列的数量
> - column-width属性:定义列的宽度或者列的最小宽度
>   - auto:默认值,用于表示列的宽度由其他CSS属性决定
>   - length :必须是正整数,用于表示定义列的宽度

column-gap：列的间隙

> 用于设置列与列之间的间距,该属性需要为多列显示时的元素设置
>
> - normal :用于表示使用浏览器定义列的默认间距,默认值为1em
> - length :必须是正整数,用于表示定义列之间的间距

column-rule：列的边框，只是间隙的边框，不是围绕的

> 用于定义列与列之间的边框,其中包括边框宽度、边框颜色以及边框样式
>
> - column-rule-width属性:用于表示列与列之间的边框宽度
> - column-rule-color属性:用于表示列与列之间的边框颜色
> - column-rule-style属性:用于表示列与列之间的边框样式

column-span：横跨多列

> 属性用于定义一个列元素是否跨列
>
> - none :用于表示元素不跨列
> - all :用于表示元素跨所有列

column-fill：列的填充，Chrome现在还不能完全支持

> 属性用于定义列的高度是由内容决定,还是统一高度
>
> - auto :默认值,用于表示列的高度由内容决定
> - balance :用于表示列的高度根据内容最多的一列高度为准，既等高布局

```css
#parent,
#parent2,
#parent3 {
  /* column-count: 4;
  column-width: 300px; */
  columns: 4 300px;

  column-gap: 20px;

  /* column-rule-width: 5px;
  column-rule-color: tomato;
  column-rule-style: double; */
  column-rule: 5px tomato double;
}

.col1,
.col2,
.col3,
.col4,
.col5 {
  height: 300px;
}

.col1,
.col6 {
  background-color: hotpink;
}

.col2,
.col7 {
  background-color: lightblue;
}

.col3.col8 {
  background-color: green;
}

.col4,
.col9 {
  background-color: yellow;
}

.col5 {
  background-color: tomato;
  column-span: all;
}

.col6,
.col7,
.col8,
.col9 {
  column-fill: balance;
}

<div id="parent">
  <div class="col1"></div>
  <div class="col2"></div>
  <div class="col3"></div>
  <div class="col4"></div>
</div>
<div id="parent2">
	<div class="col5"></div>
</div>
<div id="parent3">
  <div class="col6">Lorem ipsum dolor sit amet consectetur adipisicing elit. Cum possimus aliquid nostrum provident
  est esse necessitatibus mollitia error, tempore voluptate nobis odio alias, ab animi reprehenderit repellat
  perferendis voluptas rerum!</div>
  <div class="col7">Lorem ipsum dolor sit, amet consectetur adipisicing elit. A, quibusdam vel! Provident consequatur
  voluptates quibusdam consectetur architecto! Ut eaque aspernatur quibusdam incidunt nobis ipsam quidem, quod
  ullam, velit officia necessitatibus!
  </div>
  <div class="col8">Lorem ipsum dolor sit amet consectetur adipisicing elit. Facilis dicta officia porro error
  suscipit. Nostrum, deleniti laborum. Sed odit, nemo, ducimus dolores rem reprehenderit soluta ipsam nesciunt id
  unde accusamus.</div>
  <div class="col9">imooc</div>
</div>
```

![image-20201104173412731](/Users/chenghao/Library/Application Support/typora-user-images/image-20201104173412731.png)

# 全屏布局

全屏布局就是指HTML页面铺满整个浏览器窗口,并且没有滚动条。而且还可以跟随浏览器的大小变化而变化

![image-20201104173558303](https://tva1.sinaimg.cn/large/0081Kckwly1gkd9y11rekj31920jgtbu.jpg)

```css
<body>
    <header></header>
    <div class="content">
      <div class="left"></div>
      <div class="right"></div>
    </div>
    <footer></footer>
  </body>

html,
body {
  /* 浏览器默认body外边距8px */
  margin: 0;
  /* 保持全屏布局、不会出现滚动条，页面中有任何一个元素溢出都隐藏 */
  overflow: hidden;
}

header {
  height: 100px;
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  background-color: lightgray;
}

.content {
  position: fixed;
  left: 0;
  right: 0;
  top: 100px;
  bottom: 100px;
  /* 处理子元素的内容溢出，auto：不溢出不处理，溢出加滚动条 
  hidden：超出部分会隐藏
  scroll：任何情况都加滚动条*/
  overflow: auto;
  background-color: lightblue;
}

.content .left {
  width: 300px;
  height: 100%;
  position: fixed;
  left: 0;
  top: 100px;
  bottom: 100px;
  background-color: lightcoral;
}

.content .right {
  height: 1000px;
  margin-left: 300px;
  background-color: greenyellow;
}

footer {
  height: 100px;
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: lightslategray;
}
```

# --- 补充 ---

# 宽/高

- 默认高度
  - 为0
  - 脱离文档流，默认为0，宽度可被子元素之和撑起来
- 默认宽度
  - 为父级元素的100%
  - 脱离文档流，默认为0，宽度可被子元素之和撑起来
- 设置宽/高
  - 100%表示父级元素的100%

# --- 记录 ---

# 图片缩放失真

```css
img {
  /* 会失真 */
  width: 100%;

  /* 解决方法一 */
  image-rendering: -moz-crisp-edges;
  /* Firefox */
  image-rendering: -o-crisp-edges;
  /* Opera */
  image-rendering: -webkit-optimize-contrast;
  /*Webkit (non-standard naming) */
  image-rendering: crisp-edges;
  -ms-interpolation-mode: nearest-neighbor;
  /* IE (non-standard property) */

  /* 解决方法二 */
  object-fit: fill;
  object-fit: contain;
  object-fit: scale-down;
}
```

**object-fit**（css3）

> - fill { object-fit: fill; }: 中文释义“填充”。**默认值**。替换内容拉伸填满整个content box, 不保证保持原有的比例。
> - contain: 中文释义“包含”。保持原有尺寸比例。保证替换内容尺寸一定可以在容器里面放得下。因此，此参数可能会在容器内留下空白。
> - cover: 中文释义“覆盖”。保持原有尺寸比例。保证替换内容尺寸一定大于容器尺寸，宽度和高度至少有一个和容器一致。因此，此参数可能会让替换内容（如图片）部分区域不可见。
> - none: 中文释义“无”。保持原有尺寸比例。同时保持替换内容原始尺寸大小。
> - scale-down: 中文释义“降低”。就好像依次设置了none或contain, 最终呈现的是尺寸比较小的那个。
>

属性测试：上述顺序 （宽高200px,100p'x）![image-20201106104201076](https://tva1.sinaimg.cn/large/0081Kckwly1gkf97vgh7vj31jm06gna9.jpg)

