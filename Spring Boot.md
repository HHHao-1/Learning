
[TOC]

# Spring Boot :monkey:

---
## Dependency
---
#### Spring Web
集成了Tomcat、SpringMVC、RESTful
#### DevTools
代码修改热更新，无需重启
监控程序的变化，然后进行自动重新启动
#### Lombok
消除模板代码
getter、setter、构造器、toString()、equals()等
在运行过程中，自动生成，注解后便可直接调用
  - 注解介绍
    ```properties
    @NonNull : 让你不在担忧并且爱上NullPointerException

    @CleanUp : 自动资源管理：不用再在finally中添加资源的close方法

    @Setter/@Getter : 自动生成set和get方法

    @ToString : 自动生成toString方法

    @EqualsAndHashcode : 从对象的字段中生成hashCode和equals的实现

    @NoArgsConstructor/@RequiredArgsConstructor/@AllArgsConstructor:自动生成构造方法

    @Data : 自动生成set/get方法，toString方法，equals方法，hashCode方法，不带参数的构造方法

    @Value : 用于注解final类

    @Builder : 产生复杂的构建器api类

    @SneakyThrows : 异常处理（谨慎使用）

    @Synchronized : 同步方法安全的转化

    @Getter(lazy=true) :
        （1）该标注用于生成一个 lazy 版的 getter，它会在第一次调用这个 getter 时计算一次值，然后从那里开始缓存它。如果计算该值需要大量 CPU，或者该值占用大量内存，这可能很有用。
        注意：Lombok 会自动去管理线程安全的问题，所以不会存在重复赋值的问题。
        （2）要使用此功能，需要创建一个 private final 变量，并且使用运行成本高的表达式对其进行初始化，同时使用 @Getter(lazy=true) 注解进行标注。
        示例

    @Log : 支持各种logger对象，使用时用对应的注解，如：@Log4j

    使用技巧:
        在 Bean / Entity 类上使用 @Data 注解。
        需要使用 Log 对象的地方使用 @Log4j（依项目日志框架决定）。
        注意：lombok 的注解不能被继承。
    ```
#### Spring Configuration Processor
让配置文件有提示
使用其他配置文件xml或properties
  - 示例
使用 @EnableConfigurationProperties开启 @ConfigurationProperties注解
    ```java
    @Data
    @Component
    @ConfigurationProperties(prefix = "author")
    @PropertySource(value = {"classpath:demo.properties" }, ignoreResourceNotFound = false, encoding = "UTF-8", name = "demo.properties")
    public class Demo {
      private String name;
      private int age;
    }
    ```
    ```java
    @RestController
    @EnableConfigurationProperties
    public class DemoController {
        @Autowired
        Demo demo;
        @RequestMapping("/")
        public String index(){
            return "author's name is " + demo.getName() + ",ahtuor's age is " + demo.getAge();
        }
    }
    ```
    使用 @Value 需要注入的值较多时，代码就会显得冗余，于是 @ConfigurationProperties登场了
    ```java
    @Data
    @Component
    @PropertySource(value = {"classpath:static/config/demo.properties" }, ignoreResourceNotFound = false, encoding = "UTF-8", name = "demo.properties")
    public class AuthorTest {
        @Value ("${author.name}") 
        private String name;
        @value ("${author. age}"
        private int age;
    }
    ```
#### Spring Session
- 为什么使用
布式应用和集群应用中，用户的请求可能被负载分发至不同的服务器，此时传统的web容器管理用户会话session的方式即行不通。除非集群或者分布式web应用能够共享session，尽管tomcat等支持这样做。但是这样存在以下两点问题：
  - 需要侵入web容器，提高问题的复杂
  - web容器之间共享session，集群机器之间势必要交互耦合
- session容器
  - 使用第三方仓储来实现集群session管理，也就是常说的分布式session容器，替换应用容器（如tomcat的session容器）。仓储的实现，Spring Session提供了三个实现（redis，mongodb，jdbc），其中redis使我们最常用的。
  - 可以非常方便的扩展Cookie和自定义Session相关的Listener，Filter。
  - 可以很方便的与Spring Security集成，增加诸如findSessionsByUserName，rememberMe，限制同一个账号可以同时在线的Session数（如设置成1，即可达到把前一次登录顶掉的效果）等等

- Spring Reactive Web
  - Spring 的reactive web框架：webflux
  - spring-webflux
    - spring-webflux与spring-webmvc平级
    - webmvc是servlet stack  based,而webflux是reactive stack based。
    - webflux是一个完全的reactive并且非阻塞的web框架。
    - flux：“流”的意思（stream, flux, rate, class, blast, grade）
作用：就是webflux可以让你在web应用下也可以体验tcp长连接传输流数据的快感了。这在过去我们都是通过一些奇技淫巧才能实现的能力。

---
## File Introduce
---
#### mvnw
- 作用:
mvnw是一个maven wrapper script,它可以让你在没有安装maven或者maven版本不兼容的条件下运行maven的命令.
**注意，需要与mvnw软件区分开，spring项目中的mvnw仅仅是个脚本，并非软件。**
- 原理:
  1. 首先寻找maven在你电脑环境变量path中的路径
  2. 如果没有找到这个路径它就会自动下载maven到一个默认的路径下,之后你就可以运行maven命令
  3. 如果碰到一些项目的peoject和你本地的maven不兼容,它会帮你下载合适的maven版本,然后运行
####mvnw.cmd
- 执行mvnw脚本的cmd入口
####.gitignore
- 分布式版本控制系统git的配置文件，意为忽略提交
- 在.gitingore 文件中，遵循相应的语法，在每一行指定一个忽略规则

---
## application.properties
---
#### Spring MVC
```properties
# 异步请求处理超时之前的时间量（以毫秒为单位）
spring.mvc.async.request-timeout=
# 要使用的日期格式 例如`dd / MM / yyyy`
spring.mvc.date-format=
# 发送TRACE请求到FrameworkServlet doService方法
spring.mvc.dispatch-trace-request= false
# 发送OPTIONS请求到FrameworkServlet doService方法
spring.mvc.dispatch-options-request= false
# 启用favicon.ico的解析
spring.mvc.favicon.enabled= true
# 如果在重定向方案期间应该忽略“默认”模型的内容
spring.mvc.ignore-default-model-on-redirect= true
# 要使用的区域设置
spring.mvc.locale=
# 将文件扩展名映射到内容协商的媒体类型
spring.mvc.media-types.*=
# 消息代码格式策略 例如`PREFIX_ERROR_CODE`
spring.mvc.message-codes-resolver-format=
# 用于静态资源的路径模式
spring.mvc.static-path-pattern= /**
# 如果没有发现处理程序来处理请求，则应抛出“NoHandlerFoundException”
spring.mvc.throw-exception-if-no-handler-found= false
# Spring MVC视图前缀
spring.mvc.view.prefix=
# Spring MVC视图后缀
spring.mvc.view.suffix=
```
#### FreeMarker
```properties
spring.freemarker.allow-request-override=false
设置是否允许HttpServletRequest属性覆盖(隐藏)控制器生成的同名模型属性。
spring.freemarker.allow-session-override=false
设置是否允许HttpSession属性覆盖(隐藏)控制器生成的同名模型属性。
spring.freemarker.cache=false
启用模板缓存
spring.freemarker.charset=UTF-8
设置编码格式
spring.freemarker.check-template-location=true
检查模板位置是否存在。
spring.freemarker.content-type=text/html
内容类型值
spring.freemarker.enabled=true
为这种技术启用MVC视图解决方案。
spring.freemarker.expose-request-attributes=false
设置是否应该在与模板合并之前将所有请求属性添加到模型中。
spring.freemarker.expose-session-attributes=false
设置是否在与模板合并之前将所有HttpSession属性添加到模型中。
spring.freemarker.expose-spring-macro-helpers=true
设置是否公开RequestContext供Spring宏库使用，名称为“SpringMacroRequestContext”。
spring.freemarker.prefer-file-system-access=true
更喜欢文件系统访问模板加载。文件系统访问允许对模板更改进行热检测。
spring.freemarker.prefix=
前缀，用于在构建URL时查看名称
spring.freemarker.request-context-attribute=
所有视图的RequestContext属性的名称。
spring.freemarker.settings.*=
众所周知的FreeMarker密钥将传递给FreeMarker的配置。
spring.freemarker.suffix=
后缀，该后缀用于在构建URL时查看名称。
spring.freemarker.template-loader-path=classpath:/templates/
以逗号分隔的模板路径列表。
spring.freemarker.view-names=
可以解析的视图名称的白列表。
```
#### Thymeleaf
```properties
spring.thymeleaf.cache = true #启用模板缓存
spring.thymeleaf.check-template-location = true #检查模板位置是否存在
spring.thymeleaf.content-type = text / html #Content-Type值
spring.thymeleaf.enabled = true #启用MVC Thymeleaf视图分辨率
spring.thymeleaf.encoding = UTF-8 #模板编码
spring.thymeleaf.excluded-view-names = #应该从解决方案中排除的视图名称的逗号分隔列表
spring.thymeleaf.mode = HTML5 #应用于模板的模板模式另请参见

StandardTemplateModeHandlers
spring.thymeleaf.prefix = classpath：/ templates / #在构建URL时预先查看名称的前缀
spring.thymeleaf.suffix = .html #构建URL时附加查看名称的后缀
spring.thymeleaf.template-resolver-order = #链中模板解析器的顺序
spring.thymeleaf.view-names = #可以解析的视图名称的逗号分隔列表
```
#### DataSource
```properties
spring.datasource.continue-on-error = false #初始化数据库时发生错误时不要停止
spring.datasource.data = #Data（DML）脚本资源引用
spring.datasource.driver-class-name = #JDBC驱动程序的完全限定名称默认情况下，根据URL自动检测
spring.datasource.initialize = true #使用'data.sql'填充数据库
spring.datasource.jmx-enabled = false #启用JMX支持（如果由底层池提供）
spring.datasource.jndi-name = #数据源的JNDI位置设置时，类，网址，用户名和密码将被忽略
spring.datasource.max-active = #例如100
spring.datasource.max-idle = #例如8
spring.datasource.max等待=
spring.datasource.min-evictable空闲时间-米利斯=
spring.datasource.min-idle = 8
spring.datasource.name = testdb #数据源的名称
spring.datasource.password = #登录数据库的密码
spring.datasource.platform = all #在资源模式（schema - $ {platform} .sql）中使用的平台
spring.datasource.schema = #Schema（DDL）脚本资源引用
spring.datasource.separator =;  #语句分隔符在SQL初始化脚本中
spring.datasource.sql-script-encoding = #SQL脚本编码
spring.datasource.test-on-borrow = #例如`false`
spring.datasource.test-on-return = #例如`false`
spring.datasource.test-while-idle = #
spring.datasource.time-between-eviction-runs-millis = 1
spring.datasource.type = #要使用的连接池实现的完全限定名称默认情况下，它是从类路径自动检测的
spring.datasource.url = #数据库的JDBC url
spring.datasource.username=
spring.datasource.validation-query=
```
#### Redis
```properties
# 连接工厂使用的数据库索引
spring.redis.database= 0
# Redis服务器主机
spring.redis.host= localhost
# 登录redis服务器的密码
spring.redis.password=
# 给定时间池可以分配的最大连接数 使用负值为无限制
spring.redis.pool.max-active= 8
# 池中“空闲”连接的最大数量 使用负值来表示无限数量的空闲连接
spring.redis.pool.max-idle= 8
# 连接分配在池耗尽之前在抛出异常之前应阻止的最大时间量（以毫秒为单位） 使用负值无限期地阻止
spring.redis.pool.max-wait= -1
# 定义池中维护的最小空闲连接数 此设置只有在正值时才有效果
spring.redis.pool.min-idle= 0
# redis服务器端口
spring.redis.port= 6379
# redis服务器名称
spring.redis.sentinel.master=
#
spring.redis.sentinel.nodes=
# 连接超时（毫秒）
spring.redis.timeout= 0
```
#### JMS
```properties
# 连接工厂JNDI名称 设置时，优先于其他连接工厂自动配置
spring.jms.jndi-name=
# 容器的确认模式 默认情况下，监听器被自动确认处理
spring.jms.listener.acknowledge-mode=
# 启动时自动启动容器
spring.jms.listener.auto-startup= true
# 最小并发消费者数
spring.jms.listener.concurrency=
# 最大并发消费者数
spring.jms.listener.max-concurrency=
# 指定默认的目的地类型是否为主题
spring.jms.pub-sub-domain= false
```
#### DEVTools
```properties
# DEVTOOLS（开发工具属性）
# 启用一个livereload.com兼容的服务器
spring.devtools.livereload.enabled= true
#  # Server port.
spring.devtools.livereload.port= 35729
# 应该排除的触发完全重新启动的其他模式
spring.devtools.restart.additional-exclude=
# 观看更改的附加路径
spring.devtools.restart.additional-paths=
# 启用自动重启功能
spring.devtools.restart.enabled= true
# 应该排除的模式触发完全重新启动
spring.devtools.restart.exclude= META-INF/maven/**,META-INF/resources/**,resources/**,static/**,public/**,templates/**,**/*Test.class,**/*Tests.class,git.properties
# 轮询类路径更改之间等待的时间量（以毫秒为单位）
spring.devtools.restart.poll-interval= 1000
# 触发重新启动之前没有任何类路径更改所需的安静时间量（以毫秒为单位）
spring.devtools.restart.quiet-period= 400
# 更改后的特定文件的名称将触发重新启动检查 如果未指定任何类路径文件更改将触发重新启动
spring.devtools.restart.trigger-file=
Spring batch
spring.batch.initializer.enabled = true #如果需要，在启动时创建所需的批处理表
spring.batch.job.enabled = true #在启动时执行上下文中的所有Spring批处理作业
spring.batch.job.names = #在启动时执行的作业名称的逗号分隔列表（例如`job1，job2`） 默认情况下，执行在上下文中找到的所有作业
spring.batch.schema = classpath：org / springframework / batch / core / schema - @@ platform @@sql #用于初始化数据库模式的SQL文件的路径
spring.batch.table-prefix = #所有批次元数据表的表前缀
```
#### 远程开发工具
```properties
# 用于处理远程连接的上下文路径
spring.devtools.remote.context-path= /.~~spring-boot!~
# 启用远程调试支持
spring.devtools.remote.debug.enabled= true
# 本地远程调试服务器端口
spring.devtools.remote.debug.local-port= 8000
# 用于连接到远程应用程序的代理主机
spring.devtools.remote.proxy.host=
# 用于连接到远程应用程序的代理端口
spring.devtools.remote.proxy.port=
# 启用远程重启
spring.devtools.remote.restart.enabled= true
# 建立连接所需的共享密钥（需要启用远程支持）
spring.devtools.remote.secret=
# HTTP头用于传输共享密钥</ span>
spring.devtools.remote.secret-header-name= X-AUTH-TOKEN
```