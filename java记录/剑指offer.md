谈谈你对ava的理解
平台无关性
◆面向对象
◆GC
◆类库
◆语言特性
◆异常处理

平台无关性的实现

![image-20210115183518155](https://tva1.sinaimg.cn/large/008eGmZEly1gmoka9yl9sj3140068n0g.jpg)

![image-20210115183808423](https://tva1.sinaimg.cn/large/008eGmZEly1gmokd66g0tj31cw0ieakg.jpg)

在非静态方法中， aload_0 表示对this的操作，在static 方法中，aload_0表示对方法的第一参数的操作。

![image-20210115185133901](/Users/chenghao/Library/Application Support/typora-user-images/image-20210115185133901.png)

![image-20210115190213373](https://tva1.sinaimg.cn/large/008eGmZEly1gmol2821cxj31ao0han5v.jpg)

jvm内存结构模型与GC

jvm：内存中的虚拟机

jvm由以下四个部分组成

Execution Engine：对class中的指令进行解析后提交到操作系统运行

java执行性能没c，c++ 高

主流jvm基于c++实现

在需要较高执行性能的操作时可在java里调用c/c++程序

Native Interface：本地接口--->加载本地接口 

以下是个native方法

![image-20210115193115647](https://tva1.sinaimg.cn/large/008eGmZEly1gmolwg36o1j30zm0aqteu.jpg)

![image-20210115193202390](https://tva1.sinaimg.cn/large/008eGmZEly1gmolx9c0g9j31dx0u07wh.jpg)