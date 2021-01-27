# Optional类

## 简介

> 是一个容器类,代表一个值存在或不存在,原来用null表示一个值不存在,现在Optional可以更好的表达这个概念。并且可以避免空指针异常，或快速锁定空指针异常位置。

## 方法

| **方法**                                                     | **方法描述**                                                 | 分类     |
| ------------------------------------------------------------ | ------------------------------------------------------------ | -------- |
| boolean **equals**(Object obj)                               | 其他对象是否“等于”this Optional                              |          |
| String **toString**()                                        | 返回字符串                                                   |          |
| Optional<T> **filter**(Predicate<? super T> predicate)       | 如果存在值，则执行filter，否则返回empty Optional             | 聚合操作 |
| <U> Optional<U> **map**(Function<? super T,? extends U> mapper) | 如果存在值，则执行map，否则返回empty Optional                |          |
| <U> Optional<U> **flatMap**(Function<? super T,Optional<U>> mapper) | 如果存在值，则执行flatMap，否则返回empty Optional            |          |
| static <T> Optional<T> **empty**()                           | 返回一个空的Optional instance                                | static   |
| static <T> Optional<T> **of**(T value)                       | 返回一个具有指定当前非空值的Optional                         |          |
| static <T> Optional<T> **ofNullable**(T value)               | 如果存在值，返回一个描述指定值的Optional，否则返回一个空Optional |          |
| T **get**()                                                  | 如果存在值.，则返回该值，否则抛NoSuchElementException        | 判断包含 |
| int **hashCode**()                                           | 如果有值，返回当前值的哈希码值；如果没有，返回0              |          |
| void **ifPresent**(Consumer<? super T> consumer)             | 如果存在值，执行函数操作，否则不执行任何操作                 |          |
| boolean **isPresent**()                                      | 如果存在值，返回true，否则为false。                          |          |
| T **orElse**(T other)                                        | 如果存在值，则返回值，否则返回other。                        |          |
| T **orElseGet**(Supplier<? extends T> other)                 | 如果存在值，则返回值，否则调用其他值，并返回该调用的结果     |          |
| <X extends Throwable> T **orElseThrow**(Supplier<? extends X> exceptionSupplier) | 返回包含的值(如果存在)，否则抛出exceptionSupplier            |          |

**示例：**

```java
String isocode = user.getAddress().getCountry().getIsocode().toUpperCase();
//如果我们需要确保不触发异常，就得在访问每一个值之前对其进行明确地检查：
if (user != null) {
    Address address = user.getAddress();
    if (address != null) {
        Country country = address.getCountry();
        if (country != null) {
            String isocode = country.getIsocode();
            if (isocode != null) {
                isocode = isocode.toUpperCase();
            }
        }
    }
}
```

```java
@Test
public void whenChaining_thenOk() {
    User user = new User("anna@gmail.com", "1234");

    String result1 = Optional.ofNullable(user)
        .flatMap(u -> u.getAddress())
        .flatMap(a -> a.getCountry())
        .map(c -> c.getIsocode())
        .orElse("default");

    String result2 = Optional.ofNullable(user)
        .flatMap(User::getAddress)
        .flatMap(Address::getCountry)
        .map(Country::getIsocode)
        .orElse("default");

    assertEquals(result, "default");//result为“default”说明操作过程中有null值
}
```
