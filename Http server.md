# HTTP 协议

```css
	HTTP的全称是超文本传输协议(英文：HyperText Transfer Protocol)，它是客户端与服务器请求和响应的标准。HTT`使得客户端与服务器之间可以进行通信，传输与接收数据。
```

HTTP协议请求的工作流程

> 1.终端用户在Web浏览器地址栏输入访问地址
>
> 2.Web浏览器请求DNS服务器把域名转换成Web服务器的IP地址，此处的解析过程就是DNS解析过程。
>
> 3.Web浏览器将端口号（默认是80）从访问地址（URL）中解析出来。
>
> 4.Web浏览器通过解析后的IP地址及端口号与Web服务器之间建立一条TCP连接。
>
> 5.建立TCP连接后，Web浏览器向Web服务器发送一条HTTP请求报文，请求报文内容格式及信息细节前面已经讲过，此处不再说明。
>
> 6.Web服务器响应并读取浏览器的请求信息，然后返回一条HTTP响应报文。
>
> 7.Web服务器关闭HTTP连接，关闭TCP连接，Web浏览器显示访问的网站内容到屏幕上。

# DNS解析流程

<img src="https://tva1.sinaimg.cn/large/007S8ZIlly1gfm9bmy5mij30h609574o.jpg" alt="20180611194405134 (1)" style="zoom:100%;" align="left"/>

> 第一步：查找系统本地的DNS缓存及hosts文件信息。
>
> 第二步：如果客户端本地DNS缓存及hosts文件没有记录，系统会把浏览器的解析请求发送给客户端本地设置的DNS服务器地址（Local DNS）解析，如果LDNS服务器的本地缓存有对应的解析记录就会返回给客户端，如果没有，则请求其他的DNS服务器。
>
> 第三步：LDNS从DNS系统的"."根开始请求对域名的解析，并针对各个层级的DNS服务器系统进行一系列的查找，最终查找到域名对应的授权DNS服务器，而这个授权DNS服务器是企业购买域名时用于管理域名解析的服务器。
>
> 第四步：域名的授权DNS服务器会把对应的最终IP解析记录（例如：1.2.3.4）发给LDNS。
>
> 第五步：LDNS把来自授权DNS服务器对应的IP解析记录发给客户端浏览器，并且它会把该域名和IP的对应解析缓存起来，这些缓存记录在指定的时间（DNS TTL值控制）内不会过期。
>
> 第六步：客户端浏览器获取IP地址，缓存下来，然后请求IP地址对应的网站服务器，网站服务器接收到客户的请求并响应处理（此处的处理可能是一台云主机，也可能是上百台集群的服务器系统）。
>
> 注意：第一次访问网站后，系统本地和LDNS层级都会有缓存记录，再访问会直接取本地缓存记录，这样访问过程就很快了。

# HTTP 请求

HTTP Request 分为三部分

> Request Line:请求行
>
> Header:请求头
>
> Request Body:请求体

![1](https://tva1.sinaimg.cn/large/007S8ZIlly1gfma0wp1tvj30cy04lt8p.jpg)

<img src="https://tva1.sinaimg.cn/large/007S8ZIlly1gfm9ruslk5j30ox0epqc8.jpg" alt="20191012131120405" style="zoom:67%;" align="left"/>

```CSS
①是请求方法，HTTP/1.1 定义的请求方法有8种：GET、POST、PUT、DELETE、PATCH、HEAD、OPTIONS、TRACE,最常的两种GET和POST，如果是RESTful接口的话一般会用到GET、POST、DELETE、PUT。
②为请求对应的URL地址，它和报文头的Host属性组成完整的请求URL
③是协议名称及版本号。
④是HTTP的报文头，报文头包含若干个属性，格式为“属性名:属性值”，服务端据此获取客户端的信息。
⑤是报文体，它将一个页面表单中的组件值通过param1=value1&param2=value2的键值对形式编码成一个格式化串，它承载多个请求参数的数据。不但报文体可以传递请求参数，请求URL也可以通过类似于“/chapter15/user.html? param1=value1&param2=value2”的方式传递请求参数。
```

## 请求头

| 头信息              | 描述                                                         |
| :------------------ | :----------------------------------------------------------- |
| Accept              | 这个头信息指定浏览器或其他客户端可以处理的 MIME 类型。值 **image/png** 或 **image/jpeg** 是最常见的两种可能值。 |
| Accept-Charset      | 这个头信息指定浏览器可以用来显示信息的字符集。例如 ISO-8859-1。 |
| Accept-Encoding     | 这个头信息指定浏览器知道如何处理的编码类型。值 **gzip** 或 **compress** 是最常见的两种可能值。 |
| Accept-Language     | 这个头信息指定客户端的首选语言，在这种情况下，Servlet 会产生多种语言的结果。例如，en、en-us、ru 等。 |
| Authorization       | 这个头信息用于客户端在访问受密码保护的网页时识别自己的身份。 |
| Connection          | 这个头信息指示客户端是否可以处理持久 HTTP 连接。持久连接允许客户端或其他浏览器通过单个请求来检索多个文件。值 **Keep-Alive** 意味着使用了持续连接。 |
| Content-Length      | 这个头信息只适用于 POST 请求，并给出 POST 数据的大小（以字节为单位）。 |
| Cookie              | 这个头信息把之前发送到浏览器的 cookies 返回到服务器。        |
| Host                | 这个头信息指定原始的 URL 中的主机和端口。                    |
| If-Modified-Since   | 这个头信息表示只有当页面在指定的日期后已更改时，客户端想要的页面。如果没有新的结果可以使用，服务器会发送一个 304 代码，表示 **Not Modified** 头信息。 |
| If-Unmodified-Since | 这个头信息是 If-Modified-Since 的对立面，它指定只有当文档早于指定日期时，操作才会成功。 |
| Referer             | 这个头信息指示所指向的 Web 页的 URL。例如，如果您在网页 1，点击一个链接到网页 2，当浏览器请求网页 2 时，网页 1 的 URL 就会包含在 Referer 头信息中。 |
| User-Agent          | 这个头信息识别发出请求的浏览器或其他客户端，并可以向不同类型的浏览器返回不同的内容。 |

# HTTP 响应

HTTP Response 分为三部分

> Response Line:请求行
>
> Header:请求头
>
> Response Body:请求体

![2](https://tva1.sinaimg.cn/large/007S8ZIlly1gfmac0d9xcj30iz08ht9f.jpg)

![20191012131256652](https://tva1.sinaimg.cn/large/007S8ZIlly1gfm9vdzoxwj30hh087n0w.jpg)

```JS
①报文协议及版本；
②状态码及状态描述；
③响应报文头，也是由多个属性组成；
④响应报文体，即我们真正要的“干货”。
```

## 响应状态码

| 分类 | 分类描述                                       |
| :--- | :--------------------------------------------- |
| 1**  | 信息，服务器收到请求，需要请求者继续执行操作   |
| 2**  | 成功，操作被成功接收并处理                     |
| 3**  | 重定向，需要进一步的操作以完成请求             |
| 4**  | 客户端错误，请求包含语法错误或无法完成请求     |
| 5**  | 服务器错误，服务器在处理请求的过程中发生了错误 |

常见的HTTP状态码

| 状态码及描述              | 说明                                                         |
| :------------------------ | :----------------------------------------------------------- |
| 200 OK                    | 你最希望看到的，即处理成功！                                 |
| 303 See Other             | redirect到其它的页面，目标的URL通过响应报文头的Location告诉你。 |
| 304 Not Modified          | 告诉客户端，你请求的这个资源至你上次取得后，并没有更改，你直接用你本地的缓存 |
| 404 Not Found             | 即找不到页面                                                 |
| 500 Internal Server Error | 服务器错误，服务器在处理请求的过程中发生了错误；应该查查服务端的日志了，肯定抛出了一堆异常 |

## 响应头

| 头信息              | 描述                                                         |
| :------------------ | :----------------------------------------------------------- |
| Allow               | 这个头信息指定服务器支持的请求方法（GET、POST 等）。         |
| Cache-Control       | 这个头信息指定响应文档在何种情况下可以安全地缓存。可能的值有：**public、private** 或 **no-cache** 等。Public 意味着文档是可缓存，Private 意味着文档是单个用户私用文档，且只能存储在私有（非共享）缓存中，no-cache 意味着文档不应被缓存。 |
| Connection          | 这个头信息指示浏览器是否使用持久 HTTP 连接。值 **close** 指示浏览器不使用持久 HTTP 连接，值 **keep-alive** 意味着使用持久连接。 |
| Content-Disposition | 这个头信息可以让您请求浏览器要求用户以给定名称的文件把响应保存到磁盘。 |
| Content-Encoding    | 在传输过程中，这个头信息指定页面的编码方式。                 |
| Content-Language    | 这个头信息表示文档编写所使用的语言。例如，en、en-us、ru 等。 |
| Content-Length      | 这个头信息指示响应中的字节数。只有当浏览器使用持久（keep-alive）HTTP 连接时才需要这些信息。 |
| Content-Type        | 这个头信息提供了响应文档的 MIME（Multipurpose Internet Mail Extension）类型。 |
| Expires             | 这个头信息指定内容过期的时间，在这之后内容不再被缓存。       |
| Last-Modified       | 这个头信息指示文档的最后修改时间。然后，客户端可以缓存文件，并在以后的请求中通过 **If-Modified-Since** 请求头信息提供一个日期。 |
| Location            | 这个头信息应被包含在所有的带有状态码的响应中。在 300s 内，这会通知浏览器文档的地址。浏览器会自动重新连接到这个位置，并获取新的文档。 |
| Refresh             | 这个头信息指定浏览器应该如何尽快请求更新的页面。您可以指定页面刷新的秒数。 |
| Retry-After         | 这个头信息可以与 503（Service Unavailable 服务不可用）响应配合使用，这会告诉客户端多久就可以重复它的请求。 |
| Set-Cookie          | 这个头信息指定一个与页面关联的 cookie。                      |

# HTTP 通用头

> 1. Connection
>
> 指示客户端与服务器在进行HTTP通信时如何处理TCP连接，如果Connection的值为close，则表示本次HTTP请求响应后结束TCP连接；如果Connection的值为Keep-Alive（HTTP1.1下为默认），则表示TCP连接一直有效
>
> 2. Date
>
> Date通用头域表明消息产生的日期和具体时间
>
> 3. Pragma
>
> 被用于包含特定执行指令，这些指令可能被应用于请求和响应消息传递过程中的任何接收者。最常用的为Pragmatic：no-cache，表示对请求的实体内容不予缓存
>
> 4. Transfer-Encoding
>
> 指示整个消息主体的传输编码方式，主要是为了实现在接收端和发送端之间进行安全的数据传输。比如
>
> Transfer-Encoding:chunked 表示消息主体采用块编码的方式
>
> 5. Upgrade
>
> 客户端可以通过它表示自己希望进行协议转换（比如从HTTP一个版本转换到另一个版本），如果服务器同意的话会切换到这个指定的协议，这个协议一般是指应用层协议
>
> 6. Via
>
> Via用来指明请求和响应消息在客户端和服务器之间传递时所经过的代理和网关以及相关的中间协议。比如HTTP1.0的请求消息发送到代理A，A使用HTTP1.1将消息转发给网关B，B在发送给源服务器，这是源服务器看到Via头域为Via：1.0A，1.1B
>
> 7. Warning
>
> 携带相关警告信息，比如可以被代理和网关用来警告客户端所接收内容的过期状态以及警告客户端实体内容的编辑格式发生了变化等

# HTTP content-type

Content-Type（内容类型），一般是指网页中存在的 Content-Type，用于定义网络文件的类型和网页的编码，决定浏览器将以什么形式、什么编码读取这个文件，这就是经常看到一些 PHP 网页点击的结果却是下载一个文件或一张图片的原因。

Content-Type 标头告诉客户端实际返回的内容的内容类型。

语法格式：

```
Content-Type: text/html; charset=utf-8
Content-Type: multipart/form-data; boundary=something
```

实例：

![img](https://www.runoob.com/wp-content/uploads/2014/06/F7E193D6-3C08-4B97-BAF2-FF340DAA5C6E.jpg)

**常见的媒体格式类型**

> - text/html ： HTML格式
>
> - text/plain ：纯文本格式
>
> - text/xml ： XML格式
>
> - image/gif ：gif图片格式
>
> - image/jpeg ：jpg图片格式
>
> - image/png：png图片格式
>
>   
>
> 以application开头的媒体格式类型：
>
> - application/xhtml+xml ：XHTML格式
>
> - application/xml： XML数据格式
>
> - application/atom+xml ：Atom XML聚合格式
>
> - application/json： JSON数据格式
>
> - application/pdf：pdf格式
>
> - application/msword ： Word文档格式
>
> - application/octet-stream ： 二进制流数据（如常见的文件下载）
>
> - application/x-www-form-urlencoded ： 
>
>   < form encType="">中默认的encType，encType属性规定在发送到服务器之前应该如何对表单数据进行编码；form表单数据被编码为key/value格式发送到服务器（表单默认的提交数据的格式）
>   
>   
>
> 另外一种常见的媒体格式是上传文件之时使用的：
>
> - multipart/form-data ： 需要在表单中进行文件上传时，就需要使用该格式