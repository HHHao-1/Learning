# 跨域访问

**允许访问第一种方式：**

```java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

@Configuration
public class CorsConfig {
    private CorsConfiguration buildConfig() {
        CorsConfiguration corsConfiguration = new CorsConfiguration();
        corsConfiguration.addAllowedOrigin("*"); // 允许任何域名使用
        corsConfiguration.addAllowedHeader("*"); // 允许任何头
        corsConfiguration.addAllowedMethod("*"); // 允许任何方法（post、get等）
        corsConfiguration.setAllowCredentials(true);
        return corsConfiguration;
    }
    
    @Bean
    public CorsFilter corsFilter() {
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", buildConfig()); // 对接口配置跨域设置
        return new CorsFilter(source);
    }
}
```

**允许访问第二种方式：**

```java
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration //加配置注解可以扫描到
public class WebConfig implements WebMvcConfigurer{
    
    //跨域请求配置
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        WebMvcConfigurer.super.addCorsMappings(registry);
        registry.addMapping("/**")// 对接口配置跨域设置
                .allowedHeaders("*")// 允许任何头
                .allowedMethods("POST","GET")// 允许方法（post、get等）
                .allowedOrigins("*")// 允许任何域名使用
                .allowCredentials(true);
    }
    
}
```

# @Value的使用

Springboot通过@Value注解将配置文件中的属性注入到容器内组件中

可用在@Controller @Service @Configuration @Component等Spring托管的类中

**1.普通字符串注入**

配置文件中：`name: zs`

@Value注入

```java
@Value("${name}")
public String name;
```

```java
@Value("${name:zch}") //带默认值，若name=  ，则为zch
public String name;// 此时，若配置文件中没有name这个key，变量name的值为zch
```

**2.常用的int、boolean类型**

port: 8888

flag: true

@Value注入

```java
@Value("${port}")
public int port;

@Value("${flag}")
public boolean flag;
```

**3.数组类型**

id: 1,2,3

@Value注入

```java
@Value("${id}")
public int[] idArray;
```

**4.list类型**

id: 1,2,3

@Value注入

```java
@Value("#{'${id}'.split(',')}")
public List<String> idList;
```

**5.map类型**

```yml
user: "{name: 'zs',age: '23'}" #注意此值用双引号包裹
```

@Value注入

```java
@Value("#{${user}}") 
public Map<String,String> userInfo;
```
