 ![image-20210403163004211](https://tva1.sinaimg.cn/large/008eGmZEgy1gp6n04s835j31230k3dvm.jpg)

![image-20210403163013953](https://tva1.sinaimg.cn/large/008eGmZEgy1gp6n09z1tbj310o0j545q.jpg)

![image-20210403163032914](https://tva1.sinaimg.cn/large/008eGmZEgy1gp6n0kibx7j30z40fhwkj.jpg)

![image-20210403163122165](https://tva1.sinaimg.cn/large/008eGmZEgy1gp6n1ct7bcj311r0kfn8s.jpg)

![image-20210403163131667](https://tva1.sinaimg.cn/large/008eGmZEgy1gp6n1iy630j30u80lsgu0.jpg)

![image-20210403163144236](https://tva1.sinaimg.cn/large/008eGmZEgy1gp6n1s3d1lj30y40iyk17.jpg)

![image-20210403163209341](https://tva1.sinaimg.cn/large/008eGmZEgy1gp6n24uzuej30o10k4tei.jpg)

![image-20210403163323590](https://tva1.sinaimg.cn/large/008eGmZEgy1gp6n3f5aaxj30z50jjai3.jpg)

![image-20210403163306540](/Users/hao/Library/Application Support/typora-user-images/image-20210403163306540.png)

# 一

![image-20210403163810431](https://tva1.sinaimg.cn/large/008eGmZEgy1gp6n8dytkhj30f6032gn4.jpg)

![image-20210403163802805](https://tva1.sinaimg.cn/large/008eGmZEgy1gp6n89hjvwj30n60eotd0.jpg)

http：在网页之间传递html的一种规则

万维网（www、web、3w）：一种B/S架构的信息服务系统，每一个万维网站点通过url访问、超链接跳转，进而形成一个覆盖全球范围的网络系统。

万维网的基础技术：http（超文本传输协议）、html（超文本标记语言），超文本由html写好、以http为约束传输、再加放入万维网系统便可被获取

http协议现在使用较广的版本仍然是http1.1

![image-20210403174951364](https://tva1.sinaimg.cn/large/008eGmZEgy1gp6payxd0hj31260ggagw.jpg)

![image-20210403175033381](https://tva1.sinaimg.cn/large/008eGmZEgy1gp6pbp51fhj310c0dz104.jpg)

![image-20210403182926025](https://tva1.sinaimg.cn/large/008eGmZEgy1gp6qg62me3j30z70evjve.jpg)

![image-20210404173355172](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7ugpee35j310u0fajwo.jpg)

![image-20210404173428692](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7uhacconj311g0gs79n.jpg)

tcp面向连接、可靠性高

udp无连接、效率高

![image-20210404173541823](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7uik91icj30z70fatem.jpg)

选择一条传输路径

![image-20210404173610860](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7uj1tcdsj30zj0etn3b.jpg)

![image-20210404173649021](/Users/hao/Library/Application Support/typora-user-images/image-20210404173649021.png)

![image-20210404173719305](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7uk8hc2zj30o80fpq61.jpg)

![image-20210404173742629](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7ukn2kxsj312l0k3qdq.jpg)

![image-20210404173814137](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7ul7561oj30jy0gowji.jpg)

![image-20210404173938724](/Users/hao/Library/Application Support/typora-user-images/image-20210404173938724.png)

![image-20210404174420901](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7urjzf3aj312d0jp7h9.jpg)

![image-20210404174434017](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7urs6vpjj312k0jowpx.jpg)

![image-20210404174717606](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7uumdmpvj30z10i114l.jpg)

tcp/ip协议使用的是ip地址进行访问

![image-20210404174850456](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7uw8kyd7j30vf0jrajz.jpg)

DNS服务的解析是有层次的，就近原则，本地电脑会将我们经常使用的域名和其ip建立一个映射关系并保存在系统文件中个，在进行dns解析时，系统会优先从host文件里面去寻找对应的ip地址，如果找到就直接使用它，如果没有，再到本地的dns服务器，本地主机使用一个dns服务的，如果本地没有找到，那本地的dns服务器会一层一层的向上一层发送请求，  知道dns根服务器，如果找到就会传，最终把找到的ip地址返回给服务器；一直没有的话就是域名错误，或没有对应的服务器

如果本地dns服务器缓存没有，就会去找tcp/ip参数里设置的首选dns服务器，就是我们常设置的8.8.8.8，114.114.114.114；本地dns服务器如果没有设置转发模式，就直接把请求发到13台艮dns服务器一一查找；如果有设置，就会一层一层向上查找。 

dns解系顺序：host->本地dns服务器缓存->设置的首选DNS服务器——>若本地dns服务器配置了转发功能就一级一级向上转发直到13台根服务器，否则直接转发至13台dns根服务器

114.114.114.114是国内移动、电信和联通通用的DNS；8.8.8.8是GOOGLE公司提供的DNS，该地址是全球通用的

![image-20210404184019030](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7wdsq2q6j312e0jsqdm.jpg)

![image-20210404184031466](/Users/hao/Library/Application Support/typora-user-images/image-20210404184031466.png)

输入一个url发生了什么？![image-20210404195113187](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7yfkdqrhj30tt09atc7.jpg)

![image-20210404195124957](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7yfr7v6fj30kk04z3zk.jpg)

![image-20210404195229148](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7ygvo988j30y60h2af9.jpg)

![image-20210404195417933](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7yiri159j30xv0ha0y4.jpg)

![image-20210404195445328](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7yj8pkscj30yj0dsjul.jpg)

![image-20210404200050805](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7ypkwg5sj30x00hf42c.jpg)

![image-20210404200249305](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7yrmzdk5j30ye0hd441.jpg)

两种用于保持http连接状态的技术 coockies session  承前启后 记忆

性格特征：乖巧听话、因为家族都是客户端服务器的模式所以它也继承了，单纯 任劳任怨、人非常灵活什么都能做，还做得特别快，非常专一不会劈腿不记仇，缺点就是记性不好、需要家里贴满便签纸

![image-20210404200909646](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7yy8byejj30vx0epgpr.jpg)

![image-20210404201041587](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7yzu0ykaj310v0hi79t.jpg)

![image-20210404202157715](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7zbjmle6j30u90ekn11.jpg)

- URI（Uniform Resource Identifier）：统一资源标识符
  - 用于唯一标识一个资源的符号，如：身份证号，以任意可唯一标识资源的方式寻找
  - URL和URN是URI的子集

- URL（Uniform Resource Locator）：统一资源定位符
  - 用于唯一标识一个资源的地址，如：家庭地址，以地址寻找

- URN（Uniform Resource Name）：统一资源名称
  - 用于唯一标识一个资源的名称，如：唯一的人名，以名称寻找

![image-20210404204246666](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7zx82zxfj30yt0kraq9.jpg)

![image-20210404204455663](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7zzg08wlj30x70ev43r.jpg)

![image-20210404204509539](https://tva1.sinaimg.cn/large/008eGmZEgy1gp7zzot1o0j30rp0de0yt.jpg)

![image-20210404204605764](https://tva1.sinaimg.cn/large/008eGmZEgy1gp800ph1pfj30ph0hpwnz.jpg)

![image-20210404204706843](https://tva1.sinaimg.cn/large/008eGmZEgy1gp801qyjgcj30rm0c3gst.jpg)

![image-20210404204720007](https://tva1.sinaimg.cn/large/008eGmZEgy1gp801yb8x1j30t00e9n5a.jpg)

![image-20210404204807298](https://tva1.sinaimg.cn/large/008eGmZEgy1gp802ryho1j311d0j2q9d.jpg)

![image-20210404204838476](https://tva1.sinaimg.cn/large/008eGmZEgy1gp803bnryqj31150grq9d.jpg)



![image-20210404205221384](https://tva1.sinaimg.cn/large/008eGmZEgy1gp80762sn1j30z30d842o.jpg)

gzip是一种数据格式，默认且目前仅使用deflate算法压缩data部分；
**deflate是一种压缩算法,是huffman编码的一种加强**

![image-20210404205250619](https://tva1.sinaimg.cn/large/008eGmZEgy1gp807ouhq5j30wx0hxafc.jpg)

![image-20210404205443759](https://tva1.sinaimg.cn/large/008eGmZEgy1gp809obhecj310k0hnjyz.jpg)

![image-20210404205555499](https://tva1.sinaimg.cn/large/008eGmZEgy1gp80aw47wpj310p0hu79j.jpg)

![image-20210404205645609](https://tva1.sinaimg.cn/large/008eGmZEgy1gp80brm6jaj30yg0cvn0r.jpg)

![image-20210404205718669](https://tva1.sinaimg.cn/large/008eGmZEgy1gp80cbyc0sj311o0fogpw.jpg)

比如要解决ie8的一些兼容问题

![image-20210404212759199](https://tva1.sinaimg.cn/large/008eGmZEgy1gp81893n7kj30qv0jqn1y.jpg)

![image-20210404212815792](https://tva1.sinaimg.cn/large/008eGmZEgy1gp818ja9vtj30zl0ih7cc.jpg)

Request Headers下的Content-Type是客户端对服务器约定的编码格式，服务器要按照对应格式解码；

反之，Response Headers下的Content-Type是服务器对客户端约定的编码格式，客户端要按照对应格式解码。

![image-20210404212840600](https://tva1.sinaimg.cn/large/008eGmZEgy1gp818yo7b8j30vr0l7gz3.jpg)

第一行：响应行 

![image-20210404215216996](https://tva1.sinaimg.cn/large/008eGmZEgy1gp81xj09aej30t20j2tcj.jpg)

get 浏览器默认请求方法 

![image-20210404215428993](https://tva1.sinaimg.cn/large/008eGmZEgy1gp81ztev9oj311s0jewp8.jpg)

url在浏览器中长度有限制，ie 2803 firefox 65536

![image-20210404215732603](https://tva1.sinaimg.cn/large/008eGmZEgy1gp823003lhj310e0eytdl.jpg)

![image-20210404215758111](https://tva1.sinaimg.cn/large/008eGmZEgy1gp823fxyv4j30yw0kpdqn.jpg)

![image-20210404220338604](https://tva1.sinaimg.cn/large/008eGmZEgy1gp829cil2ij311q0gxwio.jpg)

Http1.1 put方法不带有验证机制 自身存在一定的安全性问题 一般的web网站不适用put方法 post请求后台逻辑更新对象

幂等：不管进行多少次的重复操作，都是实现相同的结果；不过修改多少次，都是修改同一个地方

![image-20210404221344737](https://tva1.sinaimg.cn/large/008eGmZEgy1gp82jurw17j31000eon13.jpg)

head方法，测试连接是否可用、是否更新

delete方法和put方法一样，没有验证机制，一般web网站不用，使用post做逻辑删除

![image-20210404221440455](https://tva1.sinaimg.cn/large/008eGmZEgy1gp82ktsi30j30zj0fu7bu.jpg)

![image-20210404222010666](https://tva1.sinaimg.cn/large/008eGmZEgy1gp82qk0t2gj30yt0g3dkz.jpg)

trace：客户端通过trace方法查询发送出的请求是怎么样被加工修改或篡改的

请求想要连接到源目标服务器时可能会产生代理中转，trace方法就是确认连接过程中一系列的操作，看看中转的过程

也是有安全隐患，会引发xst攻击，所以不会用   [跨站跟踪*攻击*(CST/*XST*)

connect，也不会用到；使用场景：使用代理服务器来访问互联网的时候（代理）

如：通过代理访问Facebook，首先浏览器向代理服务器发送connect请求，服务器返回200，然后浏览器和要访问的服务器握手建立连接，代理服务器在中间只负责传输彼此的数据包，并不能读取具体的数据内容

![image-20210404222927414](https://tva1.sinaimg.cn/large/008eGmZEgy1gp8309p7s5j30zf0jwth1.jpg)

状态码表示响应状态

1几乎不用

![image-20210404223105457](https://tva1.sinaimg.cn/large/008eGmZEgy1gp831x44elj30yz0ktato.jpg)

![image-20210404223129556](/Users/hao/Library/Application Support/typora-user-images/image-20210404223129556.png)

206只想请求部分资源时，请求加上range-source头，指明要请求哪部分；这里涉及到断点续传、既下载到一半暂停后继续下载而不是重新开始，

![image-20210404223726144](https://tva1.sinaimg.cn/large/008eGmZEgy1gp838ia9pgj30yw0ilgvp.jpg)

![image-20210404223906665](https://tva1.sinaimg.cn/large/008eGmZEgy1gp83a9ejtqj30xi0j7ti9.jpg)

4 服务器接收到、也处理完成了，但结果跟客户端预想的不一样

403一般是没有权限

![image-20210404224148823](https://tva1.sinaimg.cn/large/008eGmZEgy1gp83d3d5v6j30xz0evgqp.jpg)

  502 网关或代理服务器错误

![image-20210404225214556](https://tva1.sinaimg.cn/large/008eGmZEgy1gp83nx0z50j30y905xadh.jpg) ![image-20210404225414503](https://tva1.sinaimg.cn/large/008eGmZEgy1gp83pzx9aej30v40aogpl.jpg)

![image-20210404225430868](https://tva1.sinaimg.cn/large/008eGmZEgy1gp83qa8lm1j30c904lmxq.jpg)

回车两次返回响应报文

 *Telnet*协议是TCP/IP协议族中的一员,是Internet远程登陆服务的标准协议和主要方式。

这个命令可用来测试端口连通性、发送请求

![image-20210404225911777](https://tva1.sinaimg.cn/large/008eGmZEgy1gp83v5ejsij30y309gadh.jpg)

响应体第一行，密码正确并下发一个cookie给客户端

![image-20210404230215558](https://tva1.sinaimg.cn/large/008eGmZEgy1gp83ybwdx4j30bw01fjro.jpg)

head请求

![image-20210404230334811](https://tva1.sinaimg.cn/large/008eGmZEgy1gp83zpksfyj307c021weo.jpg)

![image-20210404230500293](https://tva1.sinaimg.cn/large/008eGmZEgy1gp8417bu54j30tf04zwgw.jpg)

无连接、无状态，导致不会记忆之前的信息，每次都需要重新传输，导致传输信息增大

优点：解放服务器；缺点：每次都要传输大量重复信息；

两种用于记录http连接状态的技术

![image-20210404232325274](https://tva1.sinaimg.cn/large/008eGmZEgy1gp84kd2rq0j30y90foagn.jpg)

![image-20210404232422273](https://tva1.sinaimg.cn/large/008eGmZEgy1gp84lcaj1fj30ot0hu0wu.jpg)

![image-20210404232549710](https://tva1.sinaimg.cn/large/008eGmZEgy1gp84mv1md8j3083012aa8.jpg)

输入一个url：查找域名对应的本地cookie信息，并随请求发送至服务器， 服务器收到数据就会在数据库中检索你的id，查询到你的历史记录（如：购物信息，喜好等），并且记录下这次新的内容增加到数据库和cookie文件里面去；如果没有cookie信息，或你的cookie信息与数据库信息不匹配，说明是第一次浏览这个网战，服务器就会给你创建一个新的id，并保存到数据库里面去，并给客户端下发一个cookie

![image-20210404234152311](https://tva1.sinaimg.cn/large/008eGmZEgy1gp853jz9wnj311l0e0thp.jpg)

set-cookie 响应头（第一次访问网站）

![image-20210404234246994](https://tva1.sinaimg.cn/large/008eGmZEgy1gp854i4hp2j30xz0dgjwn.jpg)

![image-20210404234356213](https://tva1.sinaimg.cn/large/008eGmZEgy1gp855pgatbj310d0dyq6j.jpg)

![image-20210404234647532](https://tva1.sinaimg.cn/large/008eGmZEgy1gp858odgvoj31060bxgpk.jpg)

![image-20210404234713553](https://tva1.sinaimg.cn/large/008eGmZEgy1gp8594uvzbj30zl0b7win.jpg)

![image-20210404234751232](https://tva1.sinaimg.cn/large/008eGmZEgy1gp859s8ov0j30ws0dumzu.jpg)

隐藏表单：服务器自动修改表单，添加一个隐藏字段，以便表单提交时能够传递sessionid

cookie时间长（可永久），session时间短、由于会有大量访问、所以会自动超时清除或主动清除（如退出、注销操作）

session在内存

![image-20210404235252827](https://tva1.sinaimg.cn/large/008eGmZEgy1gp85f0h7k6j30uy0bon0f.jpg)

![image-20210404235417676](https://tva1.sinaimg.cn/large/008eGmZEgy1gp85ghcomaj30q00cqmzw.jpg)

安全性：cookie可能被修改，可以对cookie进行加密，在服务端再进行解密；

cookie如果每次请求之后可能都会被修改，就不能重现上次的请求状态

cookie seesionid失效时间 默许-1 关闭浏览器 session失效

**一、Cookie的过期和Session的超时有什么区别？**

会话的超时由服务器来维护，它不同于Cookie的失效日期。首先，会话一般基于驻留内存的cookie
不是持续性的cookie，因而也就没有截至日期。即使截取到JSESSIONID cookie，并为它设定一个失效日期发送出去。浏览器会话和服务器会话也会截然不同。

**二、session cookie和session对象的生命周期是一样的吗？**

当用户关闭了浏览器虽然session cookie已经消失，但session对象仍然保存在服务器端

**三、是否只要关闭浏览器，session就消失了？**

程序一般都是在用户做log off的时候发个指令去删除session，然而浏览器从来不会主动在关闭之前通知服务器它将要被关闭，因此服务器根本不会有机会知道浏览器已经关闭。

服务器会一直保留这个会话对象直到它处于非活动状态超过设定的间隔为止。
之所以会有这种错误的认识，是因为大部分session机制都使用会话cookie来保存session id，而关闭浏览器后这个session id就消失了，再次连接到服务器时也就无法找到原来的session。

如果服务器设置的cookie被保存到硬盘上，或者使用某种手段改写浏览器发出的HTTP请求报头，把原来的session id发送到服务器，则再次打开浏览器仍然能够找到原来的session。

恰恰是由于关闭浏览器不会导致session被删除，迫使服务器为session设置了一个失效时间，当距离客户上一次使用session的时间超过了这个失效时间时，服务器就可以认为客户端已经停止了活动，才会把session删除以节省存储空间。

如果不设置cookie过期时间，则表示这个cookie的生命期为浏览器会话期间，只要关闭浏览器窗口，cookie就消失了。这种生命期为浏览器会话期的 cookie被称为会话cookie。会话cookie一般不存储在硬盘上而是保存在内存里，当然这种行为并不是规范规定的。如果设置了过期时间，浏览器就会把cookie保存到硬盘上，关闭后再次打开浏览器，这些cookie仍然有效直到超过设定的过期时间。

存储在硬盘上的 cookie可以在不同的浏览器进程间共享，比如两个IE窗口。而对于保存在内存里的cookie，不同的浏览器有不同的处理方式。对于IE，在一个打开的窗口上按Ctrl-N（或者从文件菜单）打开的窗口可以与原窗口共享，而使用其他方式新开的IE进程则不能共享已经打开的窗口的内存cookie；对于 Mozilla Firefox、chrome、IE8，所有的进程和标签页都可以共享同样的cookie。一般来说是用javascript的window.open打开的窗口会与原窗口共享内存cookie。

今天收到了一个需求，居然是后端给我传过来一个JS代码，然后前端去执行。

因为后端传过来的JS代码是一个字符串，所以刚开始有点懵，以前也没有做过这样的东西所以刚开始没有方法。

这个项目是使用了前后端分离的格式，所以代码在服务器渲染是不可能了，所以只能在浏览器端想方法。

再网上扎到了几个方法，

一、使用Function方法，代码为如下

 

var str = 'alert(1)';
(new Function(str))();

二、使用eval方法

 

var str = 'alert(1)';
eval(str)

三、如果你的项目是后端渲染的页面可以接在<script></script>中渲染出来，这样的话就不需要前端去处理了。

![image-20210405150453348](https://tva1.sinaimg.cn/large/008eGmZEgy1gp8vrxyr10j310705c42b.jpg)

http协议的编码与解码

![image-20210405150506093](https://tva1.sinaimg.cn/large/008eGmZEgy1gp8vs6fa59j30e403fq43.jpg)

![image-20210405150713852](https://tva1.sinaimg.cn/large/008eGmZEgy1gp8vuen9nnj30l80gc0x3.jpg)

对于计算机而言 数据都是以二进制进行存储和传输的

不同的编码方式节约的空间不同

一个较短的二进制数通过一种编码方式转换为编码字符集中对应的地址，然后在字库表里找到一个对应的字符，最终显示给用户。

![image-20210405151017198](https://tva1.sinaimg.cn/large/008eGmZEgy1gp8vxkk0kcj30nn0j6tef.jpg)

编码规范：字符集

我们在计算机屏幕上看到的是实体化的文字，而在计算机存储介质中存放的实际是二进制的比特流。那么在这两者之间的转换规则就需要一个统一的标准

ascii使用一个字节编码  0000 0000 ~ 0111 1111 一共可表示128个字符 收录阿拉伯数字 大小写英文字符 标点符号控制字符（不可显示字符，回车CR、换行LF等）**通信专用字符（其余为可显示字符），**如控制符：LF（换行）、CR（[回车](https://baike.baidu.com/item/回车)）、FF（换页）、DEL（[删除](https://baike.baidu.com/item/删除/13020275)）、BS（退格)、BEL（响铃）等；通信专用字符：SOH（文头）、EOT（文尾）、ACK（确认）等；ASCII值为8、9、10 和13 分别转换为[退格](https://baike.baidu.com/item/退格)、制表、换行和回车字符。它们并没有特定的图形显示，但会依不同的应用程序，而对[文本](https://baike.baidu.com/item/文本)显示有不同的影响 [1] 。

因为标准ASCII码是七位,一个字节是八位,所以用八位表示一个ASCII码,最高位为‘0’

编码方式就是字节位一一对应，既ascii编码方式

gbk 收录中日韩汉字 所有字符都占两个字节 兼容ascii码（gbk utf-8 iso-88 unicode）

 gbk编码方式

iso 使用单字节内的所有空间 扩展了ascii 包含部分欧洲语言字符 和一些其他国家语言字符 不支持中文

iso8859-1编码方式 一一对应

对于Mysql而言，默认编码是ISO8859-1，java没有设置编码方式时，默认使用本地电脑系统的编码方式

tomcat8以后默认编码格式是utf-8；7之前的都是iso8859-1

unicode 世界通用编码规范 包含世界所有字符 最多可以保存四个字节容量的字符

**UTF8、UTF16、UTF32**都是unicode字符集的字符编码。

三种编码方式 

UTF8：存在单字节编码，兼容ASCII；当编码为一个字节，则设最高比特位为0；当编码超过一个字节，则需要几个字节，就在第一个字节从最高位开始令连续的几个比特位为1，之后的字节最高位为10。变长度字符编码

是针对Unicode的一种可变长度字符编码。它可以用来表示Unicode标准中的任何字符，而且其编码中的第一个字节仍与[ASCII](https://baike.baidu.com/item/ASCII/309296)相容；优点：节省空间

UTF-8使用1~4字节为每个字符编码：

英文一个字节 汉字3或4个 一般3个

UTF32：用固定长度的字节存储字符编码，不管Unicode字符编号需要几个字节，全部都用4个字节存储，直接存储Unicode编号。无需经过字符编号向字符编码的转换步骤，提高效率，用空间换时间。

UTF16：使用2或4个字节进行存储。对于Unicode编号范围在0~FFFF之间的字符，统一用两个字节存储，无需字符转换，直接存储Unicode编号。对于Unicode字符编号在10000-10FFFF之间的字符，UTF16用四个字节存储，简单说就是：将Unicode字符编号(3字节)分为两部分，高位部分（Unicode字符编号中占1.5个字节）用一个值介于 D800-DBFF （110110yy yyyyyyyy，y为0/1）之间的双字节存储，低位部分用一个值介于 DC00-DFFF （110111xx xxxxxxxx，x为0/1）的双字节存储。而介于D800-DFFF之间的编码在Unicode中是预留的，不安排字符，如果Unicode中有字符的编号是这之间的值，会引发冲突和歧义，很有可能一个不常见字符（存储为四个字节）最后被读成两个常见字符（存储为两个字节）。

**字符编码是定义在编码字符集上的映射规则。**

**编码字符集Unicode，有UTF-8、UTF-16、UTF-32等多种字符编码**

**编码字符集ASCII,本身就是编码字符集，又是字符编码**

**ASCII直接将字符在编码字符集中的序号作为字符在计算机中存储从数值，**

**例如：在ASCII中`A`在表中排第65位，序号是65，而编码后`A`的数值是`0100 0001，`也即十进制 的65的二进制转换结果**

字库表：：：：

字库表（character repertoire）

相当于所有可读或者可显示字符的数据库，字库表决定了整个字符集能够展现表示的所有字符的范围。

例如：在`ASCII`中A在表中排第65位，而编码后A的数值是`0100 0001`，也就是十进制的65的二进制转换结果。编码字符集就是用来存储这些二进制数的。而这个二进制数就是编码字符集中的一个元素，同时它也是字库表中字母A的地址。我们根据这个地址就可以显示出字母A。

原因很简单：统一字库表的目的是为了能够涵盖世界上所有的字符，但实际使用过程中会发现真正用的上的字符相对整个字库表来说比例非常低。例如中文地区的程序几乎不会需要日语字符，而一些英语国家甚至简单的`ASCII`字库表就能满足基本需求。而如果把每个字符都用字库表中的序号来存储的话，每个字符就需要3个字节（这里以`Unicode`字库为例），这样对于原本用仅占一个字符的`ASCII`编码的英语地区国家显然是一个额外成本（存储体积是原来的三倍）。这就导致一个可以用1G保存的文件，现在需要3G才能保存，这是极其浪费的做法。

所以制定了字符编码来处理这种问题。每种不同的算法被称为一种编码方式。一套编码规范可以有不同的编码方式，不同的编码方式有不同的适应场景。

例如：`UTF-8`这样的变长编码。在`UTF-8`编码中原本只需要一个字节的`ASCII`字符，仍然只占一个字节。而像中文及日语这样的复杂字符就需要2个到3个字节来存储。



字符集只是文字的集合，不一定适合网络传送、处理。计算机要准确的处理各种字符集文字， 有时须经编码（ENCODING）后才能应用。所谓字符编码是规定每个“字符”分别用一个字节还是多个字节存储，用哪些字节来存储，这个规定就叫做“编 码”。各个国家和地区在制定编码标准的时候，“字符集”和“编码”一般都是同时制定的。因此，平常我们所说的“字符集”，比如GB2312、GBK等，除 了有“字符的集合”这层含义外，同时也包含了“编码”的含义。对UNICODE字符集的编码称为UTF。目前通用的编码标准有UTF-16小尾序 （LITTLE ENDIAN）、UTF-16大尾序（BIG ENDIAN）和UTF-8变长编码。 

字库就是字型库（FONT LIBRARY），其实计算机上显示的每个字符（不管它是哪种语言的），都是一个小的图案。字库就是把这些小的图案以图片的某种形式保存起来，需要显示的 时候还原出来就可以了。在WINDOWS操作系统里的字库存放在系统盘windows/fonts文件夹下，在linux操作系统中字库存放在这/usr /share/fonts/文件夹下。

字库与字符集有什么区别？
一直不是很明白字库与字符集他们有什么区别。麻烦各位告诉一下。
------解决方案--------------------
字符集定义的是什么样的二进制字节对应哪个文字.
字库是某个文字如何显示在屏幕上.
------解决方案--------------------
字符集是定义，字库是实现
------解决方案--------------------
比如“啊”：GBK字符集中是0xB0A1，Unicode字符集中是0x554A，BIG5字符集中是0xXXXX，Shift-JIS字符集中是0xXXXX，……
在16x16点阵字库中是
0x00 0x04
0x2f 0x7e
0xf9 0x04
0xa9 0x04
0xaa 0x14
0xaa 0x7c
0xac 0x54
0xaa 0x54
0xaa 0x54
0xa9 0x54
0xe9 0x74
0xad 0x54
0x0a 0x04
0x08 0x04
0x08 0x14
0x08 0x0c
在24x24点阵字库中是
……
在TrueType宋体字库中是
……
------解决方案--------------------
字符集是编码集，是机器里对字符个体描述的集合，而字库是对字符视觉形态描述的集合。

字符集和字库还是有关系的，至少要指出字库中某个字符在指定字符集中的对应代码。
------解决方案--------------------
不应该说是位置，理解成编号更合适些。字库需要由字符集来访问。

乱码：iso-8859字库表中不包含中文，就算讲中文用iso进行编码，再用iso解码，也无法显示出正确的中文字符

编码解码方式不一致，或者编码方式的字库表里不包含相应的字符

![image-20210405170552544](https://tva1.sinaimg.cn/large/008eGmZEgy1gp8z9uhsdoj30y20f6tfn.jpg)

![image-20210405170725357](https://tva1.sinaimg.cn/large/008eGmZEgy1gp8zbgu03yj30vx0e9wm7.jpg)

内码：十六进制编码

 在使用url进行参数传递时，经常会传递一些中文名（或含有特殊字符）的参数或URL地址，在后台处理时会发生转换错误。这些特殊符号在URL中是不能直接传递的，如果要在URL中传递这些特殊符号，那么就要使用他们的编码了。编码的格式为：%加字符的ASCII码，即一个百分号%，后面跟对应字符的ASCII（16进制）码值。例如空格的编码值是"%20"。下表中列出了一些URL特殊符号及编码。

 

| 序号 | 特殊字符 | 含义                         | 十六进制值 |
| ---- | -------- | ---------------------------- | ---------- |
| 1.   | +        | URL 中+号表示空格            | %2B        |
| 2.   | 空格     | URL中的空格可以用+号或者编码 | %20        |
| 3.   | /        | 分隔目录和子目录             | %2F        |
| 4.   | ?        | 分隔实际的 URL 和参数        | %3F        |
| 5.   | %        | 指定特殊字符                 | %25        |
| 6.   | #        | 表示书签                     | %23        |
| 7.   | &        | URL 中指定的参数间的分隔符   | %26        |
| 8.   | =        | URL 中指定参数的值           | %3D        |

 

　　下面就让我们看看，“URL编码”到底有多混乱。我会依次分析四种不同的情况，在每一种情况中，浏览器的URL编码方法都不一样。把它们的差异解释清楚之后，我再说如何用Javascript找到一个统一的编码方法。

二、情况1：网址路径中包含汉字

　　打开IE（我用的是8.0版），输入网址“http://zh.wikipedia.org/wiki/春节”。注意，“春节”这两个字此时是网址路径的一部分。

![img](https://img-blog.csdn.net/20160704143843894?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

　　查看HTTP请求的头信息，会发现IE实际查询的网址是“http://zh.wikipedia.org/wiki/%E6%98%A5%E8%8A%82”。也就是说，IE自动将“春节”编码成了“%E6%98%A5%E8%8A%82”。

![img](https://img-blog.csdn.net/20160704143855430?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

　　我们知道，“春”和“节”的utf-8编码分别是“E6 98 A5”和“E8 8A 82”，因此，“%E6%98%A5%E8%8A%82”就是按照顺序，在每个字节前加上%而得到的。

　　在Firefox中测试，也得到了同样的结果。所以，结论1就是，网址路径的编码，用的是utf-8编码。

Javascript函数：encodeURI()

　　encodeURI()是Javascript中真正用来对URL编码的函数。

　　它着眼于对整个URL进行编码，因此除了常见的符号以外，对其他一些在网址中有特殊含义的符号“; / ? : @ & = + $ , #”，也不进行编码。编码后，它输出符号的utf-8形式，并且在每个字节前加上%。

![img](https://img-blog.csdn.net/20160704164752321?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

　　它对应的解码函数是decodeURI()。

![image-20210405174706197](https://tva1.sinaimg.cn/large/008eGmZEgy1gp90gqj7rij30pm0i844q.jpg)

![image-20210405174721429](https://tva1.sinaimg.cn/large/008eGmZEgy1gp90h09ji2j30uv0h5gp3.jpg)

![image-20210405174858220](https://tva1.sinaimg.cn/large/008eGmZEgy1gp90io47jhj30tk0bijvq.jpg)

ba http1.0 明文字符串认证base64编码 安全等级不够

di http 1.1 请求响应加密 不能放置用户伪装 达不到一般web网站安全等级

前两个：缺点：安全等级不够

![image-20210405174919829](/Users/hao/Library/Application Support/typora-user-images/image-20210405174919829.png)

![image-20210405175304467](https://tva1.sinaimg.cn/large/008eGmZEgy1gp90mxn5m4j30xo0dxgpj.jpg)

缺点：具有一定的成本 

服务器接收到要认证资源的请求->返回响应要求客户端提供客户端证书->用户选择要发送的证书发送给服务器-> 服务器验证证书->验证成功后领取客户端证书内的公开秘钥->然后开始https的加密通信

一般和表单共同认证还是比较多的，先让你输入用户名密码，再去进行证书认证 ；一般银行 金融才会使用

![image-20210405175945902](https://tva1.sinaimg.cn/large/008eGmZEgy1gp90txmhp8j30sh0dh78r.jpg)

![image-20210405180030901](https://tva1.sinaimg.cn/large/008eGmZEgy1gp90uoj70rj30n603lwgl.jpg)

![image-20210405182100712](https://tva1.sinaimg.cn/large/008eGmZEgy1gp91g0dx8oj30x50cxdl5.jpg)

![image-20210405182804706](https://tva1.sinaimg.cn/large/008eGmZEgy1gp91ndrl4xj30xa0csn23.jpg)

http结合自身优点的优化：http资源消耗的优化---长连接

http是应用层协议 它的传输层使用tcp协议（如何在网络层之上可靠的传输数据包） 网络层适应ip协议（网络物流、寻址）

长连接短连接指的事tcp连接  而不是tcp本身

长连接：响应头：connection：keep-alive

使用长连接的情况下，当一个网页打开完成以后 客户端和服务器之间用于传输http数据的tcp连接不会关闭 客户端再次访问服务器上的这个网页资源会利用已建立的这条连接 ；但也不会用就保持连接，有保持时间 可以在服务器软件（如：apache）去设置这个时间；短连接：每一次如图片，css等资源获取都会建立一次tcp连接  

