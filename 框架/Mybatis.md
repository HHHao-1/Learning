

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

# 插件

##PageHelper

### 使用流程

> 引入PageHelper与jsqlparser依赖
>
> mybatis-config.xml增加Plugin配置
>
> 代码中使用PageHelper.startPage()自动分页

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

### 不同数据库分页原理

#### MySQL

```sql
select * from table limit 10,20;
```

#### Oracle 

```sql
--记录：[12~20]
select t3.* from (
select t2.*, rownum as row num from ( select * from table order by id aso
) t2 where rownum<-20
)t3
where t2.row num>11
```

#### sql server

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

## Mybatis-generator

### pom.xml

```xml
<build>
    <plugins>
        <plugin>
            <groupId>org.mybatis.generator</groupId>
            <artifactId>mybatis-generator-maven-plugin</artifactId>
            <version>1.4.0</version>
            <configuration>
                <!--mybatis的代码生成器的配置文件-->
                <configurationFile>src/main/resources/generatorConfig.xml</configurationFile>
                <!--允许覆盖生成的文件-->
                <overwrite>true</overwrite>
                <!--将当前pom的依赖项添加到生成器的类路径中-->
                <!--<includeCompileDependencies>true</includeCompileDependencies>-->
            </configuration>
            <dependencies>
                <!--mybatis-generator插件的依赖包-->
                <dependency>
                    <groupId>org.mybatis.generator</groupId>
                    <artifactId>mybatis-generator-core</artifactId>
                    <version>1.4.0</version>
                    <!--放在plugin外可使用provide-->
                    <!--<scope>provided</scope>-->
                </dependency>
                <!--mysql的JDBC驱动-->
                <dependency>
                    <groupId>mysql</groupId>
                    <artifactId>mysql-connector-java</artifactId>
                    <version>8.0.20</version>
                </dependency>
            </dependencies>
        </plugin>
    </plugins>
    <build>    
```

### generatorConfig.xml

```XML
<?xml version="1.0" encoding="UTF-8" ?>
<!--mybatis的代码生成器相关配置-->
<!DOCTYPE generatorConfiguration
        PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
        "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">

<generatorConfiguration>
    <!-- 引入配置文件 -->
    <properties resource="application-dev.properties"/>

    <!-- 一个数据库一个context,context的子元素必须按照它给出的顺序
        property*,plugin*,commentGenerator?,jdbcConnection,javaTypeResolver?,
        javaModelGenerator,sqlMapGenerator?,javaClientGenerator?,table+
    -->
    <!--id : 随便填，保证多个 context id 不重复就行
    defaultModelType ： 可以不填，默认值 conditional，flat表示一张表对应一个po
    targetRuntime ：可以不填，默认值 MyBatis3，常用的还有 MyBatis3Simple 
	MyBatis3生成的dao 和 mapper.xml多；MyBatis3Simple生成的少，只包含最常用的-->
    <context id="myContext" targetRuntime="MyBatis3" defaultModelType="flat">

        <!-- 这个插件给生成的Java模型对象增加了equals和hashCode方法 -->
        <!--<plugin type="org.mybatis.generator.plugins.EqualsHashCodePlugin"/>-->

        <!-- 注释 -->
        <commentGenerator>
            <!-- 是否不生成注释 -->
            <property name="suppressAllComments" value="true"/>
            <!-- 不希望生成的注释中包含时间戳 -->
            <!--<property name="suppressDate" value="true"/>-->
            <!-- 添加 db 表中字段的注释，只有suppressAllComments为false时才生效-->
            <!--<property name="addRemarkComments" value="true"/>-->
        </commentGenerator>


        <!-- jdbc连接 -->
        <jdbcConnection driverClass="${spring.datasource.driverClassName}"
                        connectionURL="${spring.datasource.url}"
                        userId="${spring.datasource.username}"
                        password="${spring.datasource.password}">
            <!--高版本的 mysql-connector-java 需要设置 nullCatalogMeansCurrent=true-->
            <property name="nullCatalogMeansCurrent" value="true"/>
        </jdbcConnection>

        <!-- 类型转换 -->
        <javaTypeResolver>
            <!--是否使用bigDecimal，默认false。
                false，把JDBC DECIMAL 和 NUMERIC 类型解析为 Integer
                true，把JDBC DECIMAL 和 NUMERIC 类型解析为java.math.BigDecimal-->
            <property name="forceBigDecimals" value="true"/>
            <!--默认false
                false，将所有 JDBC 的时间类型解析为 java.util.Date
                true，将 JDBC 的时间类型按如下规则解析
                    DATE	                -> java.time.LocalDate
                    TIME	                -> java.time.LocalTime
                    TIMESTAMP               -> java.time.LocalDateTime
                    TIME_WITH_TIMEZONE  	-> java.time.OffsetTime
                    TIMESTAMP_WITH_TIMEZONE	-> java.time.OffsetDateTime
                -->
            <!--<property name="useJSR310Types" value="false"/>-->
        </javaTypeResolver>

        <!-- 生成实体类地址 -->
        <javaModelGenerator targetPackage="com.wqlm.boot.user.po" targetProject="src/main/java">
            <!-- 是否让 schema 作为包的后缀，默认为false -->
            <!--<property name="enableSubPackages" value="false"/>-->
            <!-- 是否针对string类型的字段在set方法中进行修剪，默认false -->
            <property name="trimStrings" value="true"/>
        </javaModelGenerator>


        <!-- 生成Mapper.xml文件 -->
        <sqlMapGenerator targetPackage="mapper" targetProject="src/main/resources">
            <!--<property name="enableSubPackages" value="false"/>-->
        </sqlMapGenerator>

        <!-- 生成 XxxMapper.java 接口-->
        <javaClientGenerator targetPackage="com.wqlm.boot.user.dao" targetProject="src/main/java" type="XMLMAPPER">
            <!--<property name="enableSubPackages" value="false"/>-->
        </javaClientGenerator>


        <!-- schema为数据库名，oracle需要配置，mysql不需要配置。
             tableName为对应的数据库表名
             domainObjectName 是要生成的实体类名(可以不指定，默认按帕斯卡命名法将表名转换成类名)
             enableXXXByExample 默认为 true， 为 true 会生成一个对应Example帮助类，帮助你进行条件查询，不想要可以设为false
             -->
        <table schema="" tableName="user" domainObjectName="User"
               enableCountByExample="false" enableDeleteByExample="false" enableSelectByExample="false"
               enableUpdateByExample="false" selectByExampleQueryId="false">
            <!--是否使用实际列名,默认为false-->
            <!--<property name="useActualColumnNames" value="false" />-->
        </table>
    </context>
</generatorConfiguration>

```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE generatorConfiguration PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
  "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd" >

<generatorConfiguration>
    <!--mysql 连接数据库jar 这里选择自己本地位置;
  如果不知道maven本地仓库地址，可以使用EveryThing工具全局搜索mysql-connector-java，找到jar包位置；
  也可以手动下载一个jar放在指定位置，进行引用。
  -->
    <classPathEntry location="/usr/local/apache-maven-3.6.3/repository/mysql/mysql-connector-java/8.0.20/mysql-connector-java-8.0.20.jar"/>
    <!-- <context>元素用于指定生成一组对象的环境。例如指定要连接的数据库，要生成对象的类型和要处理的数据库中的表。-->
    <!--  其中的defaultModelType属性很重要，这个属性定义了MBG如何生成实体类，推荐使用flat模式，为每一张表只生成一个包含表所有字段的实体类。-->
    <context id="testTables" targetRuntime="MyBatis3Simple">
        <commentGenerator>
            <!-- 是否去除自动生成的注释,true：是,false:否 -->
            <property name="suppressAllComments" value="true"/>
        </commentGenerator>

        <!--数据库连接的信息：驱动类、连接地址、用户名、密码 -->
        <jdbcConnection driverClass="com.mysql.cj.jdbc.Driver"
                        connectionURL="jdbc:mysql://localhost:3306/babytun"
                        userId="root"
                        password="root">
        </jdbcConnection>

        <!-- 默认false，把JDBC DECIMAL 和 NUMERIC 类型解析为 Integer，为 true时把JDBC DECIMAL 和
       NUMERIC 类型解析为java.math.BigDecimal -->
        <javaTypeResolver>
            <property name="forceBigDecimals" value="false"/>
        </javaTypeResolver>

        <!-- 指定javaBean生成的位置
        targetPackage：生成的类要放的包，真实的包受enableSubPackages属性控制；
        targetProject：目标项目，指定一个存在的目录下，生成的内容会放到指定目录中，如果目录不存在，MBG不会自动建目录
     -->
        <javaModelGenerator targetPackage="com.hao.mybatis.entity" targetProject="src/main/java">
            <!-- 在targetPackage的基础上，根据数据库的schema再生成一层package，最终生成的类放在这个package下，默认为false；如果多个数据库改为true分目录 -->
            <property name="enableSubPackages" value="false"/>
            <!-- 设置是否在getter方法中，对String类型字段调用trim()方法 -->
            <property name="trimtrings" value="true"/>
        </javaModelGenerator>

        <!--  指定mapper映射文件生成的位置
       targetPackage、targetProject同javaModelGenerator中作用一样-->
        <sqlMapGenerator targetPackage="mybatis" targetProject="src/main/resources">
            <property name="enableSubPackages" value="false"/>
        </sqlMapGenerator>

        <!-- 指定mapper接口生成的位置
     targetPackage、targetProject同javaModelGenerator中作用一样
     -->
        <!-- 客户端代码，生成易于使用的针对Model对象和XML配置文件 的代码
                type="ANNOTATEDMAPPER",生成Java Model 和基于注解的Mapper对象
                type="MIXEDMAPPER",生成基于注解的Java Model 和相应的Mapper对象
                type="XMLMAPPER",生成SQLMap XML文件和独立的Mapper接口-->
        <javaClientGenerator type="XMLMAPPER" targetPackage="com.hao.mybatis.dao" targetProject="src/main/java">
            <property name="enableSubPackages" value="false"/>
        </javaClientGenerator>

        <!-- 指定数据库表
    domainObjectName：生成的domain类的名字,当表名和domain类的名字有差异时一定要设置，如果不设置，直接使用表名作为domain类的名字；
    可以设置为somepck.domainName，那么会自动把domainName类再放到somepck包里面；
    -->
        <!-- <table>可以配置多个，用于指定生成数据库中的那个表的底层类，可以指定生成的实体类的name，
    enableCountXXX属性可以去除不需要的sql方法，其中columnOverride可以指定表中使用的枚举类，ignoreColumn可以忽略表中的字段，
    columnOverride和ignoreColumn可以指定0个或多个-->
        <table tableName="t_goods" domainObjectName="Goods"></table>
        <!--    <table schema="ins_personal_claim" tableName="claim_apply_record" enableCountByExample="true" domainObjectName="ClaimApplyRecord">-->
        <!--      <columnOverride column="apply_for" javaType="com.jd.ins.personal.claim.domain.enums.ApplyForType" typeHandler="org.apache.ibatis.type.EnumTypeHandler"/>-->
        <!--      <ignoreColumn column="create_time"/>-->
        <!--      <ignoreColumn column="update_time"/>-->
        <!--    </table>-->

        <!--    <table schema="ins_personal_claim" tableName="claim_image_info" enableCountByExample="false" domainObjectName="ClaimImageInfo">-->
        <!--      <columnOverride column="image_type" javaType="com.jd.ins.personal.claim.domain.enums.ImageType" typeHandler="org.apache.ibatis.type.EnumTypeHandler"/>-->
        <!--      <ignoreColumn column="create_time"/>-->
        <!--      <ignoreColumn column="update_time"/>-->
        <!--    </table>-->
        <!--    generatorConfig.xml默认配置中是生成Example类的相关内容，如果不需要Example类，-->
        <!--    只需要将enableCountByExample、enableCountByExample、enableDeleteByExample、enableSelectByExample设置为true或者去掉这些配置。-->
    </context>
</generatorConfiguration>
```

### application-dev.properties

```PROPERTIES
# mysql
spring.datasource.driverClassName=com.mysql.cj.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3306/boot?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=Asia/Shanghai
spring.datasource.username=root
spring.datasource.password=123456

```

### MyBatis配置文件

> 修改 MyBatis全局配置文件 mybatis-config.xml

```xml
<manper resource="com/antisan/mvbatis/simple/manner/CountryMapper.xml" />
<mapper resource="example/xml/CountryMapper.xml"/>
```

### 修改log4j

> 便于查看mybatis的内部执行过程

```PROPERTIES
1og4j.logger.com. artisan. mybatis=TRACE
1og4j.logger. example. dao=TRACEl
```

### 结合lombok

> pojo类不生成getter、setter

1. generatorConfig.xml中加入

``` 
<plugin type="com.mybatis.plugin.IngoreSetterAndGetterPlugin" />
```

2. 新建一个com.mybatis.plugin的包，在包中新建一个类IngoreSetterAndGetterPlugin

```java
package com.mybatis.plugin;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.mybatis.generator.api.IntrospectedColumn;
import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.PluginAdapter;
import org.mybatis.generator.api.dom.java.Interface;
import org.mybatis.generator.api.dom.java.Method;
import org.mybatis.generator.api.dom.java.TopLevelClass;

public class IngoreSetterAndGetterPlugin extends PluginAdapter {
    @Override
    public boolean validate(List<String> list) {
        return true;
    }

    @Override
    public boolean modelBaseRecordClassGenerated(TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {
        //添加domain的import
        topLevelClass.addImportedType("lombok.Data");
        topLevelClass.addImportedType("lombok.NoArgsConstructor");
        topLevelClass.addImportedType("lombok.AllArgsConstructor");

        //添加domain的注解
        topLevelClass.addAnnotation("@Data");
        topLevelClass.addAnnotation("@NoArgsConstructor");
        topLevelClass.addAnnotation("@AllArgsConstructor");

        //添加domain的注释
        topLevelClass.addJavaDocLine("/**");
        topLevelClass.addJavaDocLine("* Created by Mybatis Generator on " + date2Str(new Date()));
        topLevelClass.addJavaDocLine("*/");

        return true;
    }

    @Override
    public boolean clientGenerated(Interface interfaze, TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {
        //Mapper文件的注释
        interfaze.addJavaDocLine("/**");
        interfaze.addJavaDocLine("* Created by Mybatis Generator on " + date2Str(new Date()));
        interfaze.addJavaDocLine("*/");
        return true;
    }

    @Override
    public boolean modelSetterMethodGenerated(Method method, TopLevelClass topLevelClass, IntrospectedColumn introspectedColumn, IntrospectedTable introspectedTable, ModelClassType modelClassType) {
        //不生成getter
        return false;
    }

    @Override
    public boolean modelGetterMethodGenerated(Method method, TopLevelClass topLevelClass, IntrospectedColumn introspectedColumn, IntrospectedTable introspectedTable, ModelClassType modelClassType) {
        //不生成setter
        return false;
    }

    private String date2Str(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        return sdf.format(date);
    }
}
```

 　如果出现上方的包不存在的情况，请在pom文件中加入以下依赖

```xml
<dependency>
    <groupId>org.mybatis.generator</groupId>
    <artifactId>mybatis-generator-core</artifactId>
    <version>1.3.7</version>
</dependency>
```

3. 以jar包的形式导出

将jar包导入本地Maven仓库

```
mvn install:install-file -DgroupId=org.N1ckeyQu -DartifactId=IngoreSetterAndGetterPlugin -Dversion=1.0.0 -Dpackaging=jar -Dfile=IngoreSetterAndGetterPlugin-1.0.0.jar
```

4. 在pom文件中加入我们刚才导入到本地Maven仓库的内容

```
        <dependency>
            <groupId>org.N1ckeyQu</groupId>
            <artifactId>IngoreSetterAndGetterPlugin</artifactId>
            <version>1.0.0</version>
        </dependency>
```

### Example用法

>  使用Example查询能够解决大部分复杂的单表操作，一定程度上减少工作量。 **但是建议在条件很多并且判断很多的情况下，避免使用Example查询， 这种情况下，使用XML方式会更有效。**

#### selectByExample

```java
package example.dao;
import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import com.artisan.mybatis.xml.mapper.BaseMapperTest;
import example.model.Country;
import example.model.CountryExample;

public class CountryMapperTest extends BaseMapperTest {
	@Test
	public void countryExampleTest() {
		// 获取sqlSession
		SqlSession sqlSession = getSqlSession();
		try {
			// 获取 CountryMapper 接口
			CountryMapper countryMapper = sqlSession.getMapper(CountryMapper.class);
			// 创建 Example 对象
			CountryExample example = new CountryExample();
			// 设置排序规则
			example.setOrderByClause("id desc, countryname asc");
			// 设置是否 distinct 去重
			example.setDistinct(true);
			// 创建条件，只能有一个 createCriteria
			CountryExample.Criteria criteria = example.createCriteria();
			// id >= 1
			criteria.andIdGreaterThanOrEqualTo(1);
			// id < 4
			criteria.andIdLessThan(4);
			// countrycode like '%U%'
			// 最容易出错的地方，注意 like 必须自己写上通配符的位置，不可能默认两边加 %，like 可以是任何情况
			criteria.andCountrycodeLike("%U%");
			// or 的情况，可以有多个 or
			CountryExample.Criteria or = example.or();
			// countryname = 中国
			or.andCountrynameEqualTo("中国");
			// 执行查询
			List<Country> countryList = countryMapper.selectByExample(example);
			printCountryList(countryList);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 不要忘记关闭 sqlSession
			sqlSession.close();
		}
	}

	private void printCountryList(List<Country> countryList) {
		for (Country country : countryList) {
			System.out.printf("%-4d%4s%4s\n", country.getId(), country.getCountryname(), country.getCountrycode());
		}
	}

}

//除了代码中注释内容外，特别需要注意的地方是or的方法。 当有多个or的时候，SQL语句就是类似 or(…) or(…)这样的SQL，如果一个or都没有，那就只有example.createCriteria()中的查询条件。
```

#### updateByExampleSelective

```java
@Test
public void updateByExampleSelectiveTest() {
    // 获取 sqlSession
    SqlSession sqlSession = getSqlSession();
    try {
        // 获取 CountryMapper 接口
        CountryMapper countryMapper = sqlSession.getMapper(CountryMapper.class);
        // 创建 Example 对象
        CountryExample example = new CountryExample();
        // 创建条件，只能有一个 createCriteria
        CountryExample.Criteria criteria = example.createCriteria();
        // 更新所有 id > 2 的国家
        criteria.andIdGreaterThan(2);
        // 创建一个要设置的对象
        Country country = new Country();
        // 将国家名字设置为 China
        country.setCountryname("China");
        // 执行查询
        countryMapper.updateByExampleSelective(country, example);
        // 在把符合条件的结果输出查看
        printCountryList(countryMapper.selectByExample(example));
    } finally {
        // 为了不影响数据，这里选择回滚
        sqlSession.rollback();
        // 不要忘记关闭 sqlSession
        sqlSession.close();
    }
}

//我们看CountryMapper接口，可以看到有 updateByExample和updateByExampleSelective。 这两个方法的区别是，当对象的属性为空的时候，第一个方法会将值更新为null , 第二个方法不会更新null属性的字段。 通过Example一般都是批量操作，由于country表存在主键id,不能被批量更新， 因此要使用updateByExampleSelective方法进行测试。
```

#### deleteByExample+countByExample

```java
@Test
public void deleteByExampleTest() {
    // 获取 sqlSession
    SqlSession sqlSession = getSqlSession();
    try {
        // 获取 CountryMapper 接口
        CountryMapper countryMapper = sqlSession.getMapper(CountryMapper.class);
        // 创建 Example 对象
        CountryExample example = new CountryExample();
        // 创建条件，只能有一个 createCriteria
        CountryExample.Criteria criteria = example.createCriteria();
        // 删除所有 id > 2 的国家
        criteria.andIdGreaterThan(2);
        // 执行查询
        countryMapper.deleteByExample(example);
        // 使用 countByExample 查询符合条件的数量，因为删除了，所以这里应该是 0
        Assert.assertEquals(0, countryMapper.countByExample(example));
    } finally {
        // 为了不影响数据，这里选择回滚
        sqlSession.rollback();
        // 不要忘记关闭 sqlSession
        sqlSession.close();
    }
}

```

## Mybatis-plugin

1. 页面跳转

> 接口与对应实现类页面跳转
>
> mapper与对应的sql语句页面跳转
>
> 注入的依赖跳转

2. Generator

   自动生成pojo、mapper、dao

   ![442C0E8E-E71A-4EB0-9EAC-13E93C0C777B](https://tva1.sinaimg.cn/large/007S8ZIlly1gg1j9sp2olj30du075wfx.jpg)

   ![6AB69592-821B-4331-BBBE-FDC5B4AE2366](https://tva1.sinaimg.cn/large/007S8ZIlly1gg1iurf7tvj30ya0jpajf.jpg)

## MybatisX

> Java 与 XML 调回跳转
>
> Mapper 方法自动生成 XML

![2D6F75E6-8AAE-404B-AFD5-9E2951B0C77F](https://tva1.sinaimg.cn/large/007S8ZIlly1gg1j8n8zlej30g1032q47.jpg)

## MyBatis Log Plugin

> 还原`MyBatis`输出的日志为完整的`SQL`语句。
>
> 把`SQL`日志里面的`?`替换为真正的参数值。
>
> 选中要还原的`MyBatis`日志，右键点击菜单`Restore Sql`，还原`SQL`语句.
>
> `Java`接口方法与`Mapper xml`文件互相跳转。

[![img](https://camo.githubusercontent.com/b5a4eccaf8a663994b909aeca082614f1f2f723f/68747470733a2f2f706c7567696e732e6a6574627261696e732e636f6d2f66696c65732f31333930352f32352d706167652f696d616765312e706e67)](https://camo.githubusercontent.com/b5a4eccaf8a663994b909aeca082614f1f2f723f/68747470733a2f2f706c7567696e732e6a6574627261696e732e636f6d2f66696c65732f31333930352f32352d706167652f696d616765312e706e67)

> **按钮作用**
>
> **Text**: 从文本内容还原`SQL`语句
>
> **Settings**: 导航跳转开关，配置不想要输出的`SQL`语句
>
> **Format**: 输出格式化过的`SQL`语句
>
> **Rerun**: 重启插件
>
> **Stop**: 停止插件