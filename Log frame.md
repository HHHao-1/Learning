# 简介

## 日志级别

> 可输出指定级别及以上级别信息； 常用：**ERROR、WARN、INFO、DEBUG**
>
> A：off 最高等级，用于关闭所有日志记录。
>
> B：fatal 指出每个严重的错误事件将会导致应用程序的退出。
>
> C：error 指出虽然发生错误事件，但仍然不影响系统的继续运行。
>
> D：warn 表明会出现潜在的错误情形。
>
> E：info 一般和在粗粒度级别上，强调应用程序的运行全程。
>
> F：debug 一般用于细粒度级别上，对调试应用程序非常有帮助。
>
> G：trace: 程序运行的跟踪信息，很低的日志级别，一般不会使用。
>
> H：all 最低等级，用于打开所有日志记录。

## SLF4J

> **SLF4J是一个接口，一个日志标准，logback、log4j等是它的具体实现**
>
> 系统使用了多种日志框架，我们的系统就不得不同时支持并维护如：logback、log4j、slf4j-simple等多种日志框架，非常不便。
>
> 为了解决这个问题的方式就是引入一个适配层，由适配层决定使用哪一种日志系统，而调用端只需要做的事情就是打印日志而不需要关心如何打印日志，slf4j或者commons-logging就是这种适配层。
>
> ```java
> //SLF4J标准的使用
> Logger logger = LoggerFactory.getLogger(Object.class);
> ogger.error("123");
> ```

# 应用

```java
//用户流量拦截器
//使用slf4j日志标准
public class AccessHistoryInterceptor implements HandlerInterceptor {
    private Logger logger = LoggerFactory.getLogger(AccessHistoryInterceptor.class);
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        StringBuilder log = new StringBuilder();
        log.append(request.getRemoteAddr());//用户远程客户端IP地址
        log.append("|");
        log.append(request.getRequestURL());//用户访问的URL
        log.append("|");
        log.append(request.getHeader("user-agent"));//客户端环境以及使用的什么浏览器
        logger.info(log.toString());
        return true;}
//根据日志分析：此用户上班时间用pc端访问某商品，以后可就此进行推送
```

# LogBack

## 配置 

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <appender name="console" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <!--线程 日期 日志级别 产生日志的类[10代表包名最大允许长度] 日志信息-->
            <pattern>[%thread] %d %level %logger{10} - %msg%n</pattern>
        </encoder>
    </appender>
    <!--RollingFileAppender日滚动文件 -->
    <appender name="accessHistoryLog" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <!--rollingPolicy滚动策略； TimeBasedRollingPolicy按照时间进行滚动-->
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <fileNamePattern>/Users/hao/programming/log/history.%d.log</fileNamePattern>
        </rollingPolicy>
        <encoder>
            <pattern>[%thread] %d %level %logger{10} - %msg%n</pattern>
<!--<pattern>[%thread] %d{HH:mm:ss.SSS} %-5level %logger{36} - %msg%n</pattern>-->
        </encoder>
    </appender>
    <!--引用上面"console"的appender配置-->
    <root level="debug">
        <appender-ref ref="console"/>
    </root>
     <!--设定false指定类的日志不会在控制台输出，只会输出到指定文件-->
    <logger name="com.imooc.restful.interceptor.AccessHistoryInterceptor"
            level="INFO" additivity="false">
        <appender-ref ref="accessHistoryLog"/>
    </logger>
</configuration>
```

# Log4j

## 配置

```properties
#配置日志信息的格式（布局）及格式布局选项 
log4j.appender.console=org.apache.log4j.ConsoleAppender
log4j.appender.console.Target=System.err
log4j.appender.console.layout=org.apache.log4j.PatternLayout
log4j.appender.console.layout.ConversionPattern=[%-5p] %d{yyyy-MM-dd HH:mm:ss,SSS} method:%l%n%m%n

### 配置输出到文件，并且每天都创建一个文件 ###
log4j.appender.dailyRollingFile = org.apache.log4j.DailyRollingFileAppender
log4j.appender.dailyRollingFile.File = logs/log.log
log4j.appender.dailyRollingFile.Append = true
log4j.appender.dailyRollingFile.Threshold = DEBUG
log4j.appender.dailyRollingFile.layout = org.apache.log4j.PatternLayout
log4j.appender.dailyRollingFile.layout.ConversionPattern = %-d{yyyy-MM-dd HH:mm:ss}  [ %t:%r ] - [ %p ]  %m%n

#配置根Logger
#log4j.rootLogger  =   [ level ]   ,  appenderName ,  appenderName1 ,  …
log4j.rootLogger=debug,console,dailyRollingFile
```

```properties
Log4j配置文件的基本格式如下：

复制代码
#配置根Logger
log4j.rootLogger  =   [ level ]   ,  appenderName ,  appenderName1 ,  …

#配置日志信息输出目的地Appender及Appender选项
log4j.appender.appenderName = fully.qualified.name.of.appender.class 　　
log4j.appender.appenderName.option = value1
　　　　… 　　
log4j.appender.appenderName.optionN = valueN 

#配置日志信息的格式（布局）及格式布局选项 
appender.appenderName.layout = fully.log4j.qualified.name.of.layout.class
log4j.appender.appenderName.layout.option1 = value1
 　　　　… 　　
log4j.appender.appenderName.layout.optionN = valueN
```

```properties
ConversionPattern 日志信息，符号所代表的含义：

 -X号: X信息输出时左对齐；
 %p: 输出日志信息优先级，即DEBUG，INFO，WARN，ERROR，FATAL,
 %d: 输出日志时间点的日期或时间，默认格式为ISO8601，也可以在其后指定格式，比如：%d{yyy MMM dd HH:mm:ss,SSS}，输出类似：2002年10月18日 22：10：28，921
 %r: 输出自应用启动到输出该log信息耗费的毫秒数
 %c: 输出日志信息所属的类目，通常就是所在类的全名
 %t: 输出产生该日志事件的线程名
 %l: 输出日志事件的发生位置，相当于%C.%M(%F:%L)的组合,包括类目名、发生的线程，以及在代码中的行数。举例：Testlog4.main (TestLog4.java:10)
 %x: 输出和当前线程相关联的NDC(嵌套诊断环境),尤其用到像java servlets这样的多客户多线程的应用中。
 %%: 输出一个"%"字符
 %F: 输出日志消息产生时所在的文件名称
 %L: 输出代码中的行号
 %m: 输出代码中指定的消息,产生的日志具体信息
 %n: 输出一个回车换行符，Windows平台为"\r\n"，Unix平台为"\n"输出日志信息换行
 
 可以在%与模式字符之间加上修饰符来控制其最小宽度、最大宽度、和文本的对齐方式。如：
 1)%20c:指定输出category的名称，最小的宽度是20，如果category的名称小于20的话，默认的情况下右对齐。
 2)%-20c:指定输出category的名称，最小的宽度是20，如果category的名称小于20的话，"-"号指定左对齐。
 3)%.30c:指定输出category的名称，最大的宽度是30，如果category的名称大于30的话，就会将左边多出的字符截掉，但小于30的话也不会有空格。
 4)%20.30c:如果category的名称小于20就补空格，并且右对齐，如果其名称长于30字符，就从左边较远输出的字符截掉。
```

```properties
appenderName是日志输出位置的配置的命名
log4j.appender.appenderName = fully.qualified.name.of.appender.class中fully.qualified.name.of.appender.class应换上以下信息输出的目的地：
org.apache.log4j.ConsoleAppender（控制台）
org.apache.log4j.FileAppender（文件）
org.apache.log4j.DailyRollingFileAppender（每天产生一个日志文件）
org.apache.log4j.RollingFileAppender（文件大小到达指定尺寸的时候产生一个新的文件）
org.apache.log4j.WriterAppender（将日志信息以流格式发送到任意指定的地方）
 

log4j.appender.appenderName.layout = fully.log4j.qualified.name.of.layout.class中fully.qualified.name.of.layout.class格式布局应换上以下信息：
org.apache.log4j.HTMLLayout（以HTML表格形式布局）
org.apache.log4j.PatternLayout（可以灵活地指定布局模式）
org.apache.log4j.SimpleLayout（包含日志信息的级别和信息字符串）
org.apache.log4j.TTCCLayout（包含日志产生的时间、线程、类别等等信息）

log4j.appender.appenderName.option中option应替换的属性/选项
　　1.ConsoleAppender控制台选项
　　　　Threshold=DEBUG:指定日志消息的输出最低层次。
　　　　ImmediateFlush=true:默认值是true,意味着所有的消息都会被立即输出。
　　　　Target=System.err：默认情况下是：System.out,指定输出控制台
　　2.FileAppender 文件选项
　　　　Threshold=DEBUF:指定日志消息的输出最低层次。
　　　　ImmediateFlush=true:默认值是true,意谓着所有的消息都会被立即输出。
　　　　File=mylog.txt:指定消息输出到mylog.txt文件。
　　　　Append=false:默认值是true,即将消息增加到指定文件中，false指将消息覆盖指定的文件内容。
　　3.RollingFileAppender 每天生成一个文件选项
　　　　Threshold=DEBUG:指定日志消息的输出最低层次。
　　　　ImmediateFlush=true:默认值是true,意谓着所有的消息都会被立即输出。
　　　　File=mylog.txt:指定消息输出到mylog.txt文件。
　　　　Append=false:默认值是true,即将消息增加到指定文件中，false指将消息覆盖指定的文件内容。
　　　　MaxFileSize=100KB: 后缀可以是KB, MB 或者是 GB. 在日志文件到达该大小时，将会自动滚动，即将原来的内容移到mylog.log.1文件。
　　　　MaxBackupIndex=2:指定可以产生的滚动文件的最大数。
```