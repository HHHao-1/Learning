# CSS

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

## 