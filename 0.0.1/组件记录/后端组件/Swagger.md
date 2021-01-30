# 简介

> Swagger 是一个用于生成、描述、调用和可视化 RESTful 风格 API的 Web 服务
>
> 作用：1.接口的文档在线自动生成；2.功能测试

# 快速使用

## 1. 打开文档

> Swagger-ui：http://localhost:8088/swagger-ui/index.html
>
> Bootstrap-ui：http://localhost:8080/doc.html（knife4j启动器）
>
> knife4文档：https://doc.xiaominfo.com/guide/

**注意：**3.0更新

> - 移除了2.x版本的冲突版本，移除了guava等
> - 移除了@EnableSwagger2
> - 新增了springfox-boot-starter

## 2. 导入依赖

```xml
<!--启动器-->
<dependency>
  <groupId>io.springfox</groupId>
  <artifactId>springfox-boot-starter</artifactId>
  <version>3.0.0</version>
</dependency>

<!--knife4j启动器,继承类swagger2，需要swagger-ui再可添加-->
<!--使用knife4j对swagger的增强功能，需在配置类上添加@EnableKnife4j-->
<dependency>
  <groupId>com.github.xiaoymin</groupId>
  <artifactId>knife4j-spring-boot-starter</artifactId>
  <version>2.0.3</version>
</dependency>
```

```xml
<!--用来管理依赖版本-->
<properties>
    ...
    <swagger.version>2.2.2</swagger.version>
    ...
</properties>
```

```css
3.0版本:
添加依赖后再应用主类增加注解@EnableOpenApi，删除之前版本的SwaggerConfig.java，启动项目，访问地址：http://localhost:8080/swagger-ui/index.html，注意2.x版本中访问的地址的为http://localhost:8080/swagger-ui.html
```

## 3.配置类

**拦截配置**

```java
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.
                addResourceHandler("/swagger-ui/**")
                .addResourceLocations("classpath:/META-INF/resources/webjars/springfox-swagger-ui/")
                .resourceChain(false);
    }

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/swagger-ui/")
                .setViewName("forward:/swagger-ui/index.html");
    }
}
```

**可选配置**

```java
//3.0配置
@Configuration
public class Swagger3Config {
    @Bean
    public Docket createRestApi() {
        return new Docket(DocumentationType.OAS_30)
                .apiInfo(apiInfo())
                .select()
                .apis(RequestHandlerSelectors.withMethodAnnotation(ApiOperation.class))
                .paths(PathSelectors.any())
                .build();
    }

    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("Swagger3接口文档")
                .description("文档描述")
                .contact(new Contact("fanl", "#", "862844083@qq.com"))
                .version("1.0")
                .build();
    }
}

```

```java
//3.0以下配置
@Configuration
@EnableSwagger2
public class Swagger2 { 
    //是否开启swagger，正式环境一般是需要关闭的，可根据springboot的多环境配置进行设置
    @Value(value = "${swagger.enabled}")
    Boolean swaggerEnabled;
    
    // swagger2核心配置：docket
    @Bean
    public Docket createRestApi() {
        return new Docket(DocumentationType.SWAGGER_2)  // 指定api类型为swagger2
            .apiInfo(apiInfo())
            .enable(swaggerEnabled)						// 是否开启
            .select()
            .apis(RequestHandlerSelectors
                  .basePackage("com.imooc.controller")) // 指定controller包
            .paths(PathSelectors.any())                 // 所有controller
            .build();
            //.pathMapping("/");
            //最终调用接口后会和paths拼接在一起,可不写,如：/demo，会url错误而导致测试失败
    }
	//设置api信息
    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
            .title("电商平台接口api")                     // 文档页标题
            .contact(new Contact("zxw",
                                 "https://www.zxw.com",
                                 "abc@imooc.com"))     // 联系人信息
            .description("专为天天吃货提供的api文档")      // 详细信息
            .version("1.0.1")                          // 文档版本号
            .termsOfServiceUrl("NO terms of service")  // 服务条款URL
            .license("The Apache License, Version 2.0")//许可证（授权名称，例如Apache 2.0）
            .licenseUrl("http://www.apache.org/licenses/LICENSE-2.0.html")//许可证URL
            .build();
    }

}
```

```properties
# application.properties
swagger.enabled=true
```

**SpringSecurity 拦截**

```java
    private static final String[] AUTH_WHITELIST = {
            // -- swagger ui
            "/swagger-ui.html",
            "/swagger-ui/*",
            "/swagger-resources/**",
            "/v2/api-docs",
            "/v3/api-docs",
            "/webjars/**"
    };
//追加
 .antMatchers(AUTH_WHITELIST).permitAll()
```

## 4.注解的使用

| 注解               | 注解说明                         | 示例                                                         |
| :----------------- | :------------------------------- | :----------------------------------------------------------- |
| @Api               | 用在类上标注类为 swagger 资源    | @Api(value = "用户接口")                                     |
| @ApiOperation      | 用在方法上，说明方法的作用       | @ApiOperation(value ="获取用户全部信息",tags = "查询用户",notes = "注意这里没有分页") |
| @ApiParam          | 用在请求参数前，请求属性         | 同上第二条                                                   |
| @ApiImplicitParam  | 用在方法上，在方法上独立表示参数 | @ApiImplicitParam(name = "userId", value = "用户标识", required = true, paramType = "query", dataType = "String") |
| @ApiImplicitParams | 用在方法上，多个参数             | 多个 @ApiImplicitParam 集合                                  |
| @ApiResponse       | 用方法上，响应配置               | @ApiResponse(code = 200, message = "成功返回用户信息") 对返回状态备注 |
| @ApiResponses      | 用方法上，响应集配置             | 用于多个 ApiResponse 配置                                    |
| @ResponseHeader    | 用方法上，响应头设置             | 相应投配置                                                   |
| @ApiModel          | 用在实体对象的类上               | 在 UserDO 上加入 @ApiModel(value="user对象",description="用户对象user") |
| @ApiModelProperty  | 用在实体对象属性上               | 在 @ApiModelProperty(value="用户名",name="username",example="fishpro") |
| @ApiIgnore         | 用在类上或方法上                 |                                                              |



# 完整示例

```java
@RestController
@Api(tags = "用户管理相关接口")
@RequestMapping("/user")
public class UserController {

    @PostMapping("/")
    @ApiOperation("添加用户的接口")
    @ApiImplicitParams({ 
        @ApiImplicitParam(name = "username", value = "用户名", defaultValue = "李四"),
        @ApiImplicitParam(name = "address", value = "用户地址", defaultValue = "深圳", required = true) })
    public RespBean addUser(String username, @RequestParam(required = true) String address) {
        return new RespBean();
    }

    @GetMapping("/query/{id}")
    @ApiOperation("根据id查询用户的接口")
    @ApiImplicitParam(name = "id", value = "用户id", defaultValue = "99", required = true)
    public User getUserById(@PathVariable Integer id) {
        User user = new User();
        user.setId(id);
        user.setUsername("小明");
        return user;
    }

    @PutMapping("/{id}")
    @ApiOperation("根据id更新用户的接口")
    public User updateUserById(@RequestBody User user) {
        return user;
    }
}
```

```java
@Data
@ApiModel
public class User {
    @ApiModelProperty(value = "用户id")
    private Integer id;
    @ApiModelProperty(value = "用户名",required = false, hidden = true)
    private String username;
    @ApiModelProperty(value = "用户地址", hidden = true)
    private String address;
}
```

```java
@Data//有@Data注解可以不用@ApiModel
public class RespBean {
    private String username;
    private String address;
}
```



# 注解详述

## 1. api标记

> Api 用在类上，说明该类的作用。可以标记一个Controller类做为swagger 文档资源，使用方式：

```css
@Api(value = "/user", description = "Operations about user")
```

属性配置：

| 属性名称       |                                             备注 |
| :------------- | -----------------------------------------------: |
| value          |                                      url的路径值 |
| tags           |                如果设置这个值、value的值会被覆盖 |
| description    |                                  对api资源的描述 |
| basePath       |                               基本路径可以不配置 |
| position       |             如果配置多个Api 想改变显示的顺序位置 |
| produces       | For example, "application/json, application/xml" |
| consumes       | For example, "application/json, application/xml" |
| protocols      |           Possible values: http, https, ws, wss. |
| authorizations |                               高级特性认证时配置 |
| hidden         |                        配置为true 将在文档中隐藏 |

## 2. ApiOperation标记

> ApiOperation：用在方法上，说明方法的作用，每一个url资源的定义,使用方式：

```kotlin
@ApiOperation(
          value = "Find purchase order by ID",
          notes = "For valid response try integer IDs with value <= 5 or > 10. Other values will generated exceptions",
          response = Order,
          tags = {"Pet Store"})
```

属性配置：

| 属性名称          |                                                         备注 |
| :---------------- | -----------------------------------------------------------: |
| value             |                                                  url的路径值 |
| tags              |                            如果设置这个值、value的值会被覆盖 |
| description       |                                              对api资源的描述 |
| basePath          |                                           基本路径可以不配置 |
| position          |                         如果配置多个Api 想改变显示的顺序位置 |
| produces          |             For example, "application/json, application/xml" |
| consumes          |             For example, "application/json, application/xml" |
| protocols         |                       Possible values: http, https, ws, wss. |
| authorizations    |                                           高级特性认证时配置 |
| hidden            |                                    配置为true 将在文档中隐藏 |
| response          |                                                   返回的对象 |
| responseContainer |           这些对象是有效的 "List", "Set" or "Map".，其他无效 |
| httpMethod        | "GET", "HEAD", "POST", "PUT", "DELETE", "OPTIONS" and "PATCH" |
| code              |                                        http的状态码 默认 200 |
| extensions        |                                                     扩展属性 |

## 3. ApiParam标记

> ApiParam请求属性,使用方式：

```kotlin
public ResponseEntity<User> createUser(@RequestBody @ApiParam(value = "Created user object", required = true)  User user)
```

属性配置：

| 属性名称        |         备注 |
| :-------------- | -----------: |
| name            |     属性名称 |
| value           |       属性值 |
| defaultValue    |   默认属性值 |
| allowableValues |   可以不配置 |
| required        | 是否属性必填 |
| access          |   不过多描述 |
| allowMultiple   |  默认为false |
| hidden          |   隐藏该属性 |
| example         |       举例子 |

## 4. ApiResponse

> ApiResponse：响应配置，使用方式：

```css
@ApiResponse(code = 400, message = "Invalid user supplied")
```

属性配置：

| 属性名称          |                             备注 |
| :---------------- | -------------------------------: |
| code              |                     http的状态码 |
| message           |                             描述 |
| response          |                  默认响应类 Void |
| reference         |           参考ApiOperation中配置 |
| responseHeaders   | 参考 ResponseHeader 属性配置说明 |
| responseContainer |           参考ApiOperation中配置 |

## 5. ApiResponses

> ApiResponses：响应集配置，使用方式：

```css
 @ApiResponses({ @ApiResponse(code = 400, message = "Invalid Order") })
```

属性配置：

| 属性名称 |                备注 |
| :------- | ------------------: |
| value    | 多个ApiResponse配置 |

## 6. ResponseHeader

> 响应头设置，使用方法

```kotlin
@ResponseHeader(name="head1",description="response head conf")
```

属性配置：

| 属性名称          |                   备注 |
| :---------------- | ---------------------: |
| name              |             响应头名称 |
| description       |                 头描述 |
| response          |        默认响应类 Void |
| responseContainer | 参考ApiOperation中配置 |

## 7. 其他

> @ApiImplicitParams：用在方法上包含一组参数说明；
>
> @ApiImplicitParam：用在@ApiImplicitParams注解中，指定一个请求参数的各个方面
>
> - paramType：参数放在哪个地方
> - name：参数代表的含义
> - value：参数名称
> - dataType： 参数类型，有String/int，无用
> - required ： 是否必要
> - defaultValue：参数的默认值
>
> @ApiResponses：用于表示一组响应；
>
> @ApiResponse：用在@ApiResponses中，一般用于表达一个错误的响应信息；
>
> - code： 响应码(int型)，可自定义
> - message：状态码对应的响应信息
>
> @ApiModel：描述一个Model的信息（这种一般用在post创建的时候，使用@RequestBody这样的场景，请求参数无法使用@ApiImplicitParam注解进行描述的时候；
>
> @ApiModelProperty：描述一个model的属性。



# Swagger Edit

## 简介

Swagger Edit是用来编辑接口文档的小程序。Swagger是通过YAML来定义接口规范，可以通过接口文档帮你生成不同框架的服务端和客户端（可直接生成可运行的API源代码）

在线编辑器

> http://editor.swagger.io/#/

本地编辑器

> 官网下载、然后解压，在swagger-editor文件夹上一层开启http-server，即可使用editor web服务

## 用法

> - File
>
> 这个用来导出/引入接口文件在swagger edit里面进行编辑，也可以输出YAML/JSON格式。这个如果你是非在线版，编辑一半想下次在编辑，建议先导出备份，避免数据丢失。
>
> - convert to YAML
>
> 把编辑区转换成YAML格式。
>
> - Generate Server
>
> 生成可直接运行、已配置好、可以部署的程序源码，如：spring boot 源码
>
> 把接口文档生成服务器文件，导出一个压缩包，接口文档生成java、js等服务器文件。很实用工具，让你写少很多代码。
>
> - Generate Client
>
> 1. 生成为配置的程序源码，如：java 源码（gradle构建）
>
> 2. 生成查看接口文档，如：html。编写好下一步就是展示，这里可以选择导出什么格式的接口文档




# 问题记录

1. swagger API文档导入postman

> - `http://localhost:8080/v2/api-docs`,在文档中找到此类地址，postman中import导入Link
>
> - localhost无法导入问题：上述地址用迅雷下载，postman中import导入File



2. 在Security中的配置

>
> 如果我们的Spring Boot项目中集成了Spring Security，那么如果不做额外配置，Swagger2文档可能会被拦截，此时只需要在Spring Security的配置类中重写configure方法，添加如下过滤即可：

```java
@Override
public void configure(WebSecurity web) throws Exception {
    web.ignoring()
            .antMatchers("/swagger-ui.html")
            .antMatchers("/v2/**")
            .antMatchers("/swagger-resources/**");

//如此之后，Swagger2文件就不需要认证就能访问了
```



如此之后，Swagger2文件就不需要认证就能访问了。



