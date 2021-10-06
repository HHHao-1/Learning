[j2EE](https://link.zhihu.com/?target=https%3A//www.baidu.com/s%3Fwd%3Dj2EE%26tn%3DSE_PcZhidaonwhc_ngpagmjz%26rsv_dl%3Dgh_pc_zhidao)是java的[企业级开发](https://link.zhihu.com/?target=https%3A//www.baidu.com/s%3Fwd%3D%E4%BC%81%E4%B8%9A%E7%BA%A7%E5%BC%80%E5%8F%91%26tn%3DSE_PcZhidaonwhc_ngpagmjz%26rsv_dl%3Dgh_pc_zhidao)版本，其实换句话说就是用来做[web开发](https://link.zhihu.com/?target=https%3A//www.baidu.com/s%3Fwd%3Dweb%E5%BC%80%E5%8F%91%26tn%3DSE_PcZhidaonwhc_ngpagmjz%26rsv_dl%3Dgh_pc_zhidao)的[java框架](https://link.zhihu.com/?target=https%3A//www.baidu.com/s%3Fwd%3Djava%E6%A1%86%E6%9E%B6%26tn%3DSE_PcZhidaonwhc_ngpagmjz%26rsv_dl%3Dgh_pc_zhidao)。javaEE通过设定统一的标准来解决[web开发](https://link.zhihu.com/?target=https%3A//www.baidu.com/s%3Fwd%3Dweb%E5%BC%80%E5%8F%91%26tn%3DSE_PcZhidaonwhc_ngpagmjz%26rsv_dl%3Dgh_pc_zhidao)的问题，javaEE的接口，抽象类，规定了[web开发](https://link.zhihu.com/?target=https%3A//www.baidu.com/s%3Fwd%3Dweb%E5%BC%80%E5%8F%91%26tn%3DSE_PcZhidaonwhc_ngpagmjz%26rsv_dl%3Dgh_pc_zhidao)所需要实现的流程。整个web的开发，有2层，第1层是服务器容器，比如tomcat，weblogic。他们在javaEE的规范下，实现套接字的连接，封装消息等等，第2层是业务，而这一层是你要做的，通过tomcat封装的消息，进行相应的业务处理。服务器容器的开发由大型的产商开发，而我们通常做的开发是在服务器容器上的业务开发，正是sun的javaEE统一了规范(比如用servlet)我们的业务代码，能和comcat进行很好的通讯。

Java EE是为开发企业级应用程序提供的解决方案。包括Servlet、JSP、Java Bean、EJB、Web Service等技术。

# reSTfUL?

![image-20210927115149850](https://tva1.sinaimg.cn/large/008i3skNgy1guv1mzzez5j60hp07imxj02.jpg)

![image-20210927115315216](https://tva1.sinaimg.cn/large/008i3skNgy1guv1ohdw6pj60ix03274902.jpg)



![image-20210927115421350](https://tva1.sinaimg.cn/large/008i3skNgy1guv1pmg4u3j60lx0aq75d02.jpg)

![image-20210927115457238](https://tva1.sinaimg.cn/large/008i3skNgy1guv1q8qpnoj60iy068aa502.jpg)

![image-20210927115529719](https://tva1.sinaimg.cn/large/008i3skNgy1guv1qsx134j60ko05yjrr02.jpg)

![image-20210927115848760](https://tva1.sinaimg.cn/large/008i3skNgy1guv1u9sv7fj60lm0buq4202.jpg)

![image-20210927120450376](https://tva1.sinaimg.cn/large/008i3skNgy1guv20jgebmj60ik0asaaq02.jpg)

DL：依赖查找，一倍弃用，需要用户自己查找资源、组成对象，具有侵入性

DI：是ioc的主流实现

依赖倒置原则：高层模块不应该依赖于底层模块，两者都应该依赖其抽象

![image-20210927120854212](https://tva1.sinaimg.cn/large/008i3skNgy1guv24rq096j60ia0alaaq02.jpg)

ico容器：管理bean的生命周期；控制着bean的依赖注入

![image-20210927121023608](https://tva1.sinaimg.cn/large/008i3skNgy1guv26b7lwxj6063053dfw02.jpg)

对luggage类进行初始化的地方，就是控制反转容器锁做的事情

因为采用了依赖注入，在初始化的过程中不可避免的写大量的new

![image-20210927121310564](https://tva1.sinaimg.cn/large/008i3skNgy1guv297t9pij60ip07pwes02.jpg)

![image-20210927121845865](https://tva1.sinaimg.cn/large/008i3skNgy1guv2f0zwyej60mf0aa0th02.jpg)

![image-20210927121918155](https://tva1.sinaimg.cn/large/008i3skNgy1guv2fl27rmj60mc0b0gmc02.jpg)

![image-20210927122138011](https://tva1.sinaimg.cn/large/008i3skNgy1guv2i09xnpj60gh0camxx02.jpg)

配置描述bean及bean之间的依赖关系

利用反射实例化bean并建立bean之间的依赖关系

![image-20210927122439490](https://tva1.sinaimg.cn/large/008i3skNgy1guv2l5o1suj60hr0c80t502.jpg)

![image-20210927122513547](https://tva1.sinaimg.cn/large/008i3skNgy1guv2lqje6bj60it07074h02.jpg)

两个核心接口用于表示容器

![image-20210927122543760](https://tva1.sinaimg.cn/large/008i3skNgy1guv2m9qakaj60j20bomxz02.jpg)

![image-20210927122653117](https://tva1.sinaimg.cn/large/008i3skNgy1guv2ngx4c8j60jt03et8p02.jpg)

![image-20210927122825511](https://tva1.sinaimg.cn/large/008i3skNgy1guv2p2k9e3j60iy09u0ta02.jpg)

提供：IOC基础，依赖注入，bean的装载等功能

多个get方法：从容器中获取bean；多个重载方法，支持根据名称/类型，获取bean

默认单例bean

![image-20210927123542497](https://tva1.sinaimg.cn/large/008i3skNgy1guv2wnjjt8j60fv02i74e02.jpg)

![image-20210927123652687](https://tva1.sinaimg.cn/large/008i3skNgy1guv2xvqtv3j60gs07aaai02.jpg)

我们使用spring容器时，用的大部分都是applicationContext的实现类

![image-20210927123934760](https://tva1.sinaimg.cn/large/008i3skNgy1guv30ouqy5j60js0a675102.jpg)

![image-20210927124233145](https://tva1.sinaimg.cn/large/008i3skNgy1guv33s1cukj60bo06n0t302.jpg)

![image-20210927124345214](https://tva1.sinaimg.cn/large/008i3skNgy1guv35129kej60ji06w3z402.jpg)

![image-20210927124534941](https://tva1.sinaimg.cn/large/008i3skNgy1guv36xjo5yj60lg074aao02.jpg)

## @SpringBootConfiguration、@EnableAutoConfiguration、@ComponentScan

@SpringBootApplication相当于是这三个注解的组合

![image-20210927125238099](https://tva1.sinaimg.cn/large/008i3skNgy1guv3e9m52aj60bc0bewf902.jpg)

Dog类是pet的一种实现，SpringIoc容器会将Dog实例注入person；

如果Pet有两个实现，spring不能选择；需要手动指定

![image-20210927125526477](https://tva1.sinaimg.cn/large/008i3skNgy1guv3h6ukxpj60k703zaae02.jpg)

![image-20210927125542206](https://tva1.sinaimg.cn/large/008i3skNgy1guv3hghfb4j60e105aaaa02.jpg)


　　@Resource的作用相当于@Autowired，只不过@Autowired按byType自动注入，而@Resource默认按 byName自动注入罢了。@Resource有两个属性是比较重要的，分是name和type，Spring将@Resource注解的name属性解析为bean的名字，而type属性则解析为bean的类型。所以如果使用name属性，则使用byName的自动注入策略，而使用type属性时则使用byType自动注入策略。如果既不指定name也不指定type属性，这时将通过反射机制使用byName自动注入策略。
　　@Resource装配顺序
　　1. 如果同时指定了name和type，则从Spring上下文中找到唯一匹配的bean进行装配，找不到则抛出异常
　　2. 如果指定了name，则从上下文中查找名称（id）匹配的bean进行装配，找不到则抛出异常
　　3. 如果指定了type，则从上下文中找到类型匹配的唯一bean进行装配，找不到或者找到多个，都会抛出异常
　　4. 如果既没有指定name，又没有指定type，则自动按照byName方式进行装配；如果没有匹配，则回退为一个原始类型进行匹配，如果匹配则自动装配；

@Autowired 与@Resource的区别：

1、 @Autowired与@Resource都可以用来装配bean. 都可以写在字段上,或写在setter方法上。

2、 @Autowired默认按类型装配（这个注解是属业spring的），默认情况下必须要求依赖对象必须存在，如果要允许null值，可以设置它的required属性为false，如：@Autowired(required=false) ，如果我们想使用名称装配可以结合@Qualifier注解进行使用，如下：

```
@Autowired` `()` `@Qualifier` `(` `"baseDao"` `)``private` `BaseDao baseDao;
```

3、@Resource（这个注解属于J2EE的），默认按照名称进行装配，名称可以通过name属性进行指定，如果没有指定name属性，当注解写在字段上时，默认取字段名进行安装名称查找，如果注解写在setter方法上默认取属性名进行装配。当找不到与名称匹配的bean时才按照类型进行装配。但是需要注意的是，如果name属性一旦指定，就只会按照名称进行装配。

```
@Resource` `(name=` `"baseDao"` `)``private` `BaseDao baseDao;
```

软件工程基本原则：关注点分离

![image-20210927130132455](https://tva1.sinaimg.cn/large/008i3skNgy1guv3nj92qqj60jg09i3zg02.jpg)

![image-20210927130452936](https://tva1.sinaimg.cn/large/008i3skNgy1guv3r0isbgj60kf085gm902.jpg)

![image-20210927131011227](https://tva1.sinaimg.cn/large/008i3skNgy1guv3wj31x6j60f807k3z902.jpg)

动态代理会有系统上的开销，但不需要特殊的编译器或类加载器

aop我们只需要解决三个问题即可3w

what where when

what指定切面：如请求日志功能分离出来做成一个切面

where前面的植入发生在哪里：

when什么时候进行织入：方法执行前、后、执行时

![image-20210927132143724](https://tva1.sinaimg.cn/large/008i3skNgy1guv48jpbz6j60k00bemy302.jpg)

![image-20210927132213776](https://tva1.sinaimg.cn/large/008i3skNgy1guv4925qywj60ga0axgm002.jpg)

![image-20210927132311749](https://tva1.sinaimg.cn/large/008i3skNgy1guv4a2beysj60jv08umxy02.jpg)

 ASM能够操作字节码的框架

![image-20210927132453044](https://tva1.sinaimg.cn/large/008i3skNgy1guv4btmormj60j004cglq02.jpg)

如：支付宝，用户只管支付，不用管钱如何出来，再如何给用户，这些都是委托给支付宝实现的

![image-20210927132657021](https://tva1.sinaimg.cn/large/008i3skNgy1guv4dyv3hwj60g204t3yn02.jpg)

![image-20210927132724215](https://tva1.sinaimg.cn/large/008i3skNgy1guv4eflycsj60dx048t8w02.jpg)

![image-20210927132835565](https://tva1.sinaimg.cn/large/008i3skNgy1guv4fp3hjmj60ds0abgml02.jpg)

![image-20210927132926128](https://tva1.sinaimg.cn/large/008i3skNgy1guv4gjurkbj60eg038aa702.jpg)

![image-20210927133019811](https://tva1.sinaimg.cn/large/008i3skNgy1guv4hhu119j60jy085dge02.jpg)