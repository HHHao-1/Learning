

# 快速使用

## 工具类

```java
/**
 * MyBatisUtils工具类,创建全局唯一的SqlSessionFactory对象
 */
public class MyBatisUtils {
    //利用static(静态)属于类不属于对象,且全局唯一
    private static SqlSessionFactory sqlSessionFactory = null;
    //利用静态块在初始化类时实例化sqlSessionFactory
    static {
        Reader reader = null;
        try {
            reader = Resources.getResourceAsReader("mybatis-config.xml");
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
        } catch (IOException e) {
            e.printStackTrace();
            //初始化错误时,通过抛出异常ExceptionInInitializerError通知调用者
            throw new ExceptionInInitializerError(e);
        }
    }

    /**
     * openSession 创建一个新的SqlSession对象
     * @return SqlSession对象
     */
    public static SqlSession openSession(){
        //默认SqlSession对自动提交事务数据(commit)
        //设置false代表关闭自动提交,改为手动提交事务数据
        return sqlSessionFactory.openSession(false);
    }

    /**
     * 释放一个有效的SqlSession对象
     * @param session 准备释放SqlSession对象
     */
    public static void closeSession(SqlSession session){
        if(session != null){
            session.close();
        }
    }
}
```

## 整合c3p0

> **整合流程：**
>
> 配置依赖 --> 创建C3P0数据源工厂类 --> mybatis.xml连接池配置

```java 
//C3P0与MyBatis兼容使用的数据源工厂类
public class C3P0DataSourceFactory extends UnpooledDataSourceFactory {
    public C3P0DataSourceFactory(){
        this.dataSource = new ComboPooledDataSource();
    }
}
```

## 配置文件

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <settings>
        <!-- goods_id ==> goodsId 驼峰命名转换 -->
        <setting name="mapUnderscoreToCamelCase" value="true"/>
    </settings>
    
    <!--启用Pagehelper分页插件-->
    <plugins>
        <plugin interceptor="com.github.pagehelper.PageInterceptor">
            <!--设置数据库类型-->
            <property name="helperDialect" value="mysql"/>
            <!--分页合理化；pageNum<=0时会查询第一页，pageNum>=最后页时会查询最后一页-->
            <property name="reasonable" value="true"/>
        </plugin>
    </plugins>
    
    <!--设置默认指向的数据库-->
    <environments default="dev">
        <!--配置环境，不同的环境不同的id名字-->
        <environment id="dev">
            <!-- 采用JDBC方式对数据库事务进行commit/rollback -->
            <transactionManager type="JDBC"></transactionManager>
            
            <!--1.C3P0连接池，采用连接池方式管理数据库连接-->
            <!--<dataSource type="POOLED">-->
            <dataSource type="com.imooc.mybatis.datasource.C3P0DataSourceFactory">
                <property name="driverClass" value="com.mysql.jdbc.Driver"/>
                <property name="jdbcUrl" value="jdbc:mysql://localhost:3306/babytun?useUnicode=true&amp;characterEncoding=UTF-8"/>
                <property name="user" value="root"/>
                <property name="password" value="root"/>
                <!--管理连接池相关的参数-->
                <property name="initialPoolSize" value="5"/>
                <property name="maxPoolSize" value="20"/>
                <property name="minPoolSize" value="5"/>
                <!--...-->
            </dataSource>
        </environment>
        <environment id="prd">
            <!-- 采用JDBC方式对数据库事务进行commit/rollback -->
            <transactionManager type="JDBC"></transactionManager>
            
            <!--2.mybatis默认连接池，采用连接池方式管理数据库连接-->
            <dataSource type="POOLED">
                <property name="driver" value="com.mysql.jdbc.Driver"/>
                <property name="url" value="jdbc:mysql://192.168.1.155:3306/babytun?useUnicode=true&amp;characterEncoding=UTF-8"/>
                <property name="username" value="root"/>
                <property name="password" value="root"/>
            </dataSource>
        </environment>
    </environments>

    <!--1.mapper.xml方式；适合大型项目，多人协作-->
    <mappers>
        <mapper resource="mappers/goods.xml"/>
        <mapper resource="mappers/goods_detail.xml"/>
    </mappers>
    
    <!--2.注解方式；适合小型项目，敏捷式开发-->
    <mappers>
        <!--<mapper class="com.imooc.mybatis.dao.GoodsDAO"/>-->
        <package name="com.imooc.mybatis.dao"/>
    </mappers>
</configuration>
```

## 常用mapper.xml

```xml
<!--查找-->

<!-- useCache="false"代表不使用缓存 -->
<select id="selectAll" resultType="com.imooc.mybatis.entity.Goods" useCache="false">
    select * from t_goods order by goods_id desc limit 10
</select>

<!-- 单参数传递,使用parameterType指定参数的数据类型即可,SQL中#{value}提取参数-->
<select id="selectById" parameterType="Integer" resultType="com.imooc.mybatis.entity.Goods">
    select * from t_goods where goods_id = #{value}
</select>

<!-- 多参数传递-->
<!--使用parameterType指定Map接口,SQL中#{key}提取参数 -->
<select id="selectByPriceRange" parameterType="java.util.Map" resultType="com.imooc.mybatis.entity.Goods">
    select * from t_goods
    where
    current_price between  #{min} and #{max}
    order by current_price
    limit 0,#{limt}
</select>

<!--多表联查-->
<!-- 1. 利用LinkedHashMap保存多表关联结果
        MyBatis会将每一条记录包装为LinkedHashMap对象
        key是字段名  value是字段对应的值 , 字段类型根据表结构进行自动判断
        优点: 易于扩展,易于使用
        缺点: 太过灵活,无法进行编译时检查
-->
<select id="selectGoodsMap" resultType="java.util.LinkedHashMap" flushCache="true">
    select g.* , c.category_name,'1' as test from t_goods g , t_category c
    where g.category_id = c.category_id
</select>

<!-- 2. 结果映射-->
<!-- DTO不是实体对象或者属性没有按照驼峰命名转换规则书写，要用到结果映射-->
<resultMap id="rmGoods" type="com.imooc.mybatis.dto.GoodsDTO">
    <!--设置主键字段与属性映射-->
    <id property="goods.goodsId" column="goods_id"></id>
    <!--设置非主键字段与属性映射-->
    <result property="goods.title" column="title"></result>
    <result property="goods.originalCost" column="original_cost"></result>
    <result property="goods.currentPrice" column="current_price"></result>
    <result property="goods.discount" column="discount"></result>
    <result property="goods.isFreeDelivery" column="is_free_delivery"></result>
    <result property="goods.categoryId" column="category_id"></result>
    <result property="category.categoryId" column="category_id"></result>
    <result property="category.categoryName" column="category_name"></result>
    <result property="category.parentId" column="parent_id"></result>
    <result property="category.categoryLevel" column="category_level"></result>
    <result property="category.categoryOrder" column="category_order"></result>
    <result property="test" column="test"/>
</resultMap>
<select id="selectGoodsDTO" resultMap="rmGoods">
    select g.* , c.*,'1' as test from t_goods g , t_category c
    where g.category_id = c.category_id
</select>
-----------------------------------------------------------------------------------------
<!--插入-->
<!--flushCache="true"在sql执行后强制清空缓存-->
<insert id="insert" parameterType="com.imooc.mybatis.entity.Goods" flushCache="true">
    INSERT INTO t_goods(title, sub_title, original_cost, current_price, discount, is_free_delivery, category_id)
    VALUES (#{title} , #{subTitle} , #{originalCost}, #{currentPrice}, #{discount}, #{isFreeDelivery}, #{categoryId})
    <!--插入之后获取最新插入主键的编号,这里after与注解有区别-->
    <!--<selectKey resultType="Integer" keyProperty="goodsId" order="AFTER">-->
    <!--select last_insert_id();执行mysql内置函数-->
    <!--</selectKey>-->
</insert>
-----------------------------------------------------------------------------------------
<!--更新-->
<update id="update" parameterType="com.imooc.mybatis.entity.Goods">
    UPDATE t_goods
    SET
    title = #{title} ,
    sub_title = #{subTitle} ,
    original_cost = #{originalCost} ,
    current_price = #{currentPrice} ,
    discount = #{discount} ,
    is_free_delivery = #{isFreeDelivery} ,
    category_id = #{categoryId}
    WHERE
    goods_id = #{goodsId}
</update>
-----------------------------------------------------------------------------------------
<!--删除-->
<!--delete from t_goods where goods_id in (1920,1921)-->
<delete id="delete" parameterType="Integer">
    delete from t_goods where goods_id = #{value}
</delete>
-----------------------------------------------------------------------------------------
<!--预防SQL注入-->
<select id="selectByTitle" parameterType="java.util.Map" resultType="com.imooc.mybatis.entity.Goods">
    select * from t_goods where title = #{title}
    ${order}
</select>
-----------------------------------------------------------------------------------------
<!--动态sql语句-->
<select id="dynamicSQL" parameterType="java.util.Map" resultType="com.imooc.mybatis.entity.Goods">
    select * from t_goods
    <where>
        <if test="categoryId != null">
            and category_id = #{categoryId}
        </if>
        <if test="currentPrice != null">
            and current_price &lt; #{currentPrice}
        </if>
    </where>
</select>
```

```java
//DTO(数据传输对象)
public class GoodsDTO {
    private Goods goods = new Goods();
    private Category category = new Category();
    private String test;
    getter...setter...
}
```

```java
//测试--核心代码
List<Goods> list = session.selectList("goods.selectAll");
-----------------------------------------------------------------------------------------
Goods goods = session.selectOne("goods.selectById" , 1603);
-----------------------------------------------------------------------------------------
Map param = new HashMap();
param.put("min",100);
param.put("max" , 500);
param.put("limt" , 10);
List<Goods> list = session.selectList("goods.selectByPriceRange", param);
-----------------------------------------------------------------------------------------
List<Map> list = session.selectList("goods.selectGoodsMap");
-----------------------------------------------------------------------------------------
List<GoodsDTO> list = session.selectList("goods.selectGoodsDTO");
-----------------------------------------------------------------------------------------
Goods goods = new Goods();
goods.setTitle("测试商品");
goods.setSubTitle("测试子标题");
goods.setOriginalCost(200f);
goods.setCurrentPrice(100f);
goods.setDiscount(0.5f);
goods.setIsFreeDelivery(1);
goods.setCategoryId(43);
//insert()方法返回值代表本次成功插入的记录总数
int num = session.insert("goods.insert", goods);
session.commit();//提交事务数据
-----------------------------------------------------------------------------------------
Goods goods = session.selectOne("goods.selectById", 739);
goods.setTitle("更新测试商品");
int num = session.update("goods.update" , goods);
session.commit();//提交事务数据
-----------------------------------------------------------------------------------------
public void testDelete() throws Exception {
    SqlSession session = null;
    try{
        session = MyBatisUtils.openSession();
        int num = session.delete("goods.delete" , 739);
        session.commit();//提交事务数据
    }catch (Exception e){
        if(session != null){
            session.rollback();//回滚事务
        }
        throw e;
    }finally {
        MyBatisUtils.closeSession(session);
    }
}
-----------------------------------------------------------------------------------------
//预防SQL注入
@Test
public void testSelectByTitle() throws Exception {
    SqlSession session = null;
    try{
        session = MyBatisUtils.openSession();
        Map param = new HashMap();
        // ${}原文传值
        // #{}预编译
        param.put("title","'' or 1=1 or title='【德国】爱他美婴幼儿配方奶粉1段800g*2罐 铂金版'");
        param.put("order" , " order by title desc");
        List<Goods> list = session.selectList("goods.selectByTitle", param);
        for(Goods g:list){
            System.out.println(g.getTitle() + ":" + g.getCurrentPrice());
        }
    }catch (Exception e){
        throw e;
    }finally {
        MyBatisUtils.closeSession(session);
    }
}
-----------------------------------------------------------------------------------------
//动态SQL
Map param = new HashMap();
param.put("categoryId", 44);
param.put("currentPrice", 500);
//查询条件
List<Goods> list = session.selectList("goods.dynamicSQL", param);
```

## 多表级联查询

> 属性是一个对象，如：商品和详情对象关联查询

### 1. 一对多

```java
public class Goods {
    private Integer goodsId;//商品编号
    private String title;//标题
    private String subTitle;//子标题
    private Float originalCost;//原始价格
    private Float currentPrice;//当前价格
    private Float discount;//折扣率
    private Integer isFreeDelivery;//是否包邮 ,1-包邮 0-不包邮
    private Integer categoryId;//分类编号
    private List<GoodsDetail> goodsDetails;
    getter...setter...
}
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="goods">
    <!--
        resultMap可用于说明一对多或者多对一的映射逻辑
        id 是resultMap属性引用的标志
        type 指向One的实体(Goods)
	-->
    <resultMap id="rmGoods1" type="com.imooc.mybatis.entity.Goods">
        <!-- 映射goods对象的主键到goods_id字段 -->
        <id column="goods_id" property="goodsId"></id>
        <!--
            collection的含义是,在
            select * from t_goods limit 0,1 得到结果后,对所有Goods对象遍历得到goods_id字段值,
            并代入到goodsDetail命名空间的findByGoodsId的SQL中执行查询,
            将得到的"商品详情"集合赋值给goodsDetails List对象.
        -->
        <!--这里一对多是collection集合-->
        <collection property="goodsDetails" select="goodsDetail.selectByGoodsId"
                    column="goods_id"/>
    </resultMap>
    <select id="selectOneToMany" resultMap="rmGoods1">
        select * from t_goods limit 0,10
    </select>
</mapper>
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="goodsDetail">
    <!-- 一对多（商品对商品细节，一个商品有多个商品细节对象）-->
    <select id="selectByGoodsId" parameterType="Integer"
            resultType="com.imooc.mybatis.entity.GoodsDetail">
        select * from t_goods_detail where goods_id = #{value}
    </select>
</mapper>
```

### 2. 多对一

```java
public class GoodsDetail {
    private Integer gdId;
    private Integer goodsId;
    private String gdPicUrl;
    private Integer gdOrder;
    private Goods goods;
    getter...setter...
}
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="goodsDetail">
<!-- 多对一（商品细节对商品）-->
    <resultMap id="rmGoodsDetail" type="com.imooc.mybatis.entity.GoodsDetail">
        <id column="gd_id" property="gdId"/>
        <result column="goods_id" property="goodsId"/>
        <!--这里goods_id是将selectManyToOne查询到的GoodsDetail表的goods_id字段赋值给goods.selectById-->
        <!--这里多对一是association关联-->
        <association property="goods" select="goods.selectById" column="goods_id"></association>
    </resultMap>
    <select id="selectManyToOne" resultMap="rmGoodsDetail">
        select * from t_goods_detail limit 0,20
    </select>
</mapper>
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="goods">
<!-- 单参数传递,使用parameterType指定参数的数据类型即可,SQL中#{value}提取参数-->
    <select id="selectById" parameterType="Integer" resultType="com.imooc.mybatis.entity.Goods">
        select * from t_goods where goods_id = #{value}
    </select>
</mapper>
```

### Test

```java
public void testOneToMany() throws Exception {
//public void testManyToOne() throws Exception
    SqlSession session = null;
    try {
        session = MyBatisUtils.openSession();
        List<Goods> list = session.selectList("goods.selectOneToMany");
        //List<GoodsDetail> list = session.selectList("goodsDetail.selectManyToOne");
        for(Goods goods:list) {
            System.out.println(goods.getTitle() + ":" + goods.getGoodsDetails().size());
            // System.out.println(gd.getGdPicUrl() + ":" + gd.getGoods().getTitle());
        }
    } catch (Exception e) {
        throw e;
    } finally {
        MyBatisUtils.closeSession(session);
    }
}
```

# 缓存

## 简介

> **缓存：**缓冲优化，用于数据优化提高程序执行效率的有效方式，数据存储在内存
>
> **一级缓存**：默认开启缓存范围SqlSession会话
>
> **二级缓存**：手动开启,属于范围Mapper Namespace
>
> **二级缓存开启原因：**一级缓存命中率不高，为提高程序执行效率

## 缓存的范围

> ![0DBF189A-62A1-40CC-81E4-209C3038B9F1](https://tva1.sinaimg.cn/large/007S8ZIlly1gfzxxmofdwj31400hfn8r.jpg)

## 二级缓存运行规则

> 二级开启后默认所有查询操作均使用缓存
>
> 写操作commit提交时对该namespace缓存强制清空
>
> 配置useCache=false可以不用缓存
>
> 配置flushCache=true代表强制清空缓（一般在修改数据）

## 应用

```XML
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="goods">
    <!--开启了二级缓存
        eviction是缓存的清除策略,当缓存对象数量达到上限后,自动触发对应算法对缓存对象清除
            1.LRU – 最近最少使用的:移除最长时间不被使用的对象。
            2.FIFO – 先进先出:按对象进入缓存的顺序来移除它们。
            3.SOFT – 软引用:移除基于垃圾回收器状态和软引用规则的对象。
            4.WEAK – 弱引用:更积极地移除基于垃圾收集器状态和弱引用规则的对象。
        flushInterval 代表间隔多长时间自动清空缓存,单位毫秒,600000毫秒 = 10分钟
        size 缓存存储上限,用于保存对象或集合(1个集合算1个对象)的数量上限
        readOnly 设置为true ,代表返回只读缓存,每次从缓存取出的是缓存对象本身.这种执行效率较高
                 设置为false , 代表每次取出的是缓存对象的"副本",每次取出对象都是不同的,这种安全性较高
    -->
    <cache eviction="LRU" flushInterval="600000" size="512" readOnly="true"/>
    <!-- useCache="false"代表不使用缓存 -->
    <select id="selectAll" resultType="com.imooc.mybatis.entity.Goods" useCache="false">
        select * from t_goods order by goods_id desc limit 10
    </select>
    <!--flushCache="true"在sql执行后强制清空缓存-->
    <insert id="insert" parameterType="com.imooc.mybatis.entity.Goods" flushCache="true">
        INSERT INTO t_goods(title, sub_title, original_cost, current_price, discount, is_free_delivery, category_id)
        VALUES (#{title} , #{subTitle} , #{originalCost}, #{currentPrice}, #{discount}, #{isFreeDelivery}, #{categoryId})
    </insert>
</mapper>
```

# PageHelper

## 使用流程

> 引入PageHelper与jsqlparser依赖
>
> mybatis-config.xml增加Plugin配置
>
> 代码中使用PageHelper.startPage()自动分页
>

```xml
<select id="selectPage" resultType="com.imooc.mybatis.entity.Goods">
    select * from t_goods where current_price &lt; 1000
</select>
```

```java
/*startPage方法会自动将下一次查询进行分页*/
//查询第2页，每页10条记录
PageHelper.startPage(2,10);
Page<Goods> page = (Page) session.selectList("goods.selectPage");
System.out.println("总页数:" + page.getPages());
System.out.println("总记录数:" + page.getTotal());
System.out.println("开始行号:" + page.getStartRow());
System.out.println("结束行号:" + page.getEndRow());
System.out.println("当前页码:" + page.getPageNum());
List<Goods> data = page.getResult();//当前页数据
```

## 不同数据库分页原理

### MySQL
```sql
select * from table limit 10,20;
```

### Oracle 
```sql
--记录：[12~20]
select t3.* from (
select t2.*, rownum as row num from ( select * from table order by id aso
) t2 where rownum<-20
)t3
where t2.row num>11
```

### sql server

1. **SQL Server 2000（旧版）**

```sql
--记录：[4~15]
select top 3 * from table where
id not in
(select top 15 id from table)
```

2. SQL Server 2012+

```sql
--记录：[5~9]
select * from table order by ic
offset 4 rows fetch next 5 rows only
```

# 批处理

> 原理：用集合保存批处理的数据，再利用批处理sql一次性完成
>
> 优点：提高执行效率，批处理sql执行时间明显减少
>
> JDBC批处理：效率高于mybatis批处理
>
> - mybaitis使用sql拼接与条件集合筛选等方式，一次只能执行同一类型sql操作
>
> - JDBC使用sql批处理机制，一次可执行多类型sql操作（增删改查、有参无参）
>
>   

## 批量插入

> 注意：数据太多，sql太长导致会拒绝，可采取分段的形式，如：1000万次拆分100次

```xml
<!--原理：INSERT INTO table VALUES ("a" , "a1" , "a2"),("b" , "b1" , "b2"),(....)-->
<insert id="batchInsert" parameterType="java.util.List">
    INSERT INTO t_goods(title, sub_title, original_cost, current_price, discount, is_free_delivery, category_id)
    VALUES
    <foreach collection="list" item="item" index="index" separator=",">
        (#{item.title},#{item.subTitle}, #{item.originalCost}, #{item.currentPrice}, #{item.discount}, #{item.isFreeDelivery}, #{item.categoryId})
    </foreach>
</insert>
```

```java
List list = new ArrayList();
for (int i = 0; i < 10000; i++) {
    Goods goods = new Goods();
    goods.setTitle("测试商品");
    goods.setSubTitle("测试子标题");
    goods.setOriginalCost(200f);
    goods.setCurrentPrice(100f);
    goods.setDiscount(0.5f);
    goods.setIsFreeDelivery(1);
    goods.setCategoryId(43);
    //insert()方法返回值代表本次成功插入的记录总数
    list.add(goods);
}
session.insert("goods.batchInsert", list);
```

## 批量删除

```xml
<!--原理：delete from t_goods where goods_id in (1920,1921)-->
<delete id="batchDelete" parameterType="java.util.List">
    DELETE FROM t_goods WHERE goods_id in
    <foreach collection="list" item="item" index="index" open="(" close=")" separator=",">
        #{item}
    </foreach>
</delete>
```

```java
List list = new ArrayList();
list.add(1920);
list.add(1921);
list.add(1922);
session.insert("goods.batchDelete", list);
session.commit();//提交事务数据
```

## JDBC批处理

> 作用：开启批处理，提高数据处理速度；批处理只针对更新(增,删,改)语句.
>
> 开启：MySql 的批处理默认是关闭的, 需要在 url 中配置参数
>
> - jdbc:mysal://localhost:3306/mydb1?rewriteBatchedStatements=true
>
> 使用：batchSize
>
> - 每条操作参数设置完之后，调用addBatch方法，然后再所有操作都pstmt.addBatch()完之后，调用pstmt.executeBatch()这种方式有个缺陷就是数据量大容易消耗内存，因此建议再分批次处理；小批量提交,避免OOM（内存不足）

```properties
#useSSL=false 解决驱动与mysql版本问题
#url=jdbc:mysql://localhost:3306/king?useSSL=false
jdbc.url=jdbc:mysql://localhost:3306/mybatis?useUnicode=true&characterEncoding=utf8&allowMultiQueries=true&rewriteBatchedStatements=true
jdbc.driverName=com.mysql.jdbc.Driver/com.mysql.cj.jdbc.Driver
```

```java
public class JdbcBatchHandleByPrepareStatement {
    @Test
    public void testJdbcBatchHandleByPrepareStatement(){
        long starttime = System.currentTimeMillis();
        Connection conn = null;
        PreparedStatement st = null;
        try{
            conn = JdbcUtils.getConnection();
            String sql = "insert into testbatch(id,name) values(?,?)";
            st = conn.prepareStatement(sql);
            for(int i=1;i<1000008;i++){  //i=1000  2000
                st.setInt(1, i);
                st.setString(2, "aa" + i);
                st.addBatch();
                if(i%1000==0){
                    st.executeBatch();
                    st.clearBatch();
                }
            }
            st.executeBatch();
        }catch (Exception e) {
            e.printStackTrace();
        }finally{
            JdbcUtils.release(conn, st, rs);
        }
        long endtime = System.currentTimeMillis();
        System.out.println("程序花费时间：" + (endtime-starttime)/1000 + "秒！！");
    }
}
```

# 注解开发

```java
//在接口中使用注解开发
public interface GoodsDAO {
    @Select("select * from t_goods where current_price between  #{min} and #{max} order by current_price limit 0,#{limt}")
    public List<Goods> selectByPriceRange(@Param("min") Float min ,@Param("max") Float max ,@Param("limt") Integer limt);

    @Insert("INSERT INTO t_goods(title, sub_title, original_cost, current_price, discount, is_free_delivery, category_id) VALUES (#{title} , #{subTitle} , #{originalCost}, #{currentPrice}, #{discount}, #{isFreeDelivery}, #{categoryId})")
    //插入之后获取最新插入主键的编号,这里before相当于<selectKey>中的各after；执行mysql内置函数
    @SelectKey(statement = "select last_insert_id()" , before = false , keyProperty = "goodsId" , resultType = Integer.class)
    public int insert(Goods goods);

    @Select("select * from t_goods")
    //<resultMap>；DTO不是实体对象或者属性没有按照驼峰命名转换规则书写，要用到结果映射
    @Results({
        //<id>
        @Result(column = "goods_id" ,property = "goodsId" , id = true) ,
        //<result>
        @Result(column = "title" ,property = "title"),
        @Result(column = "current_price" ,property = "currentPrice")
    })
    public List<GoodsDTO> selectAll();
}
```

```JAVA
//不是表对应的实体对象，只取了部分实体对象的属性或加入了其他属性，进行数据传输
public class GoodsDTO {
    private Integer goodsId;//商品编号
    private String title;//标题
    private Float currentPrice;//当前价格
     getter...setter...
}
```

# 问题记录

1. 字段与属性映射

> 只需要指定id，其他字段与属性只要符合驼峰命名转换规则就可以自动完成数据填充

2. sql语句中特殊字符

>  select * from t_goods where current_price \&lt; 1000
>
>  如：< 小于号要进行实体引用