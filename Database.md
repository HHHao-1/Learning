# Mybatis

## 缓存

### 简介

> **缓存：**缓冲优化，用于数据优化提高程序执行效率的有效方式，数据存储在内存
>
> **一级缓存**：默认开启缓存范围SqlSession会话
>
> **二级缓存**：手动开启,属于范围Mapper Namespace

### 缓存的范围

> ![0DBF189A-62A1-40CC-81E4-209C3038B9F1](https://tva1.sinaimg.cn/large/007S8ZIlly1gfzxxmofdwj31400hfn8r.jpg)

### 二级缓存运行规则

> 二级开启后默认所有查询操作均使用缓存
>
> 写操作commit提交时对该namespace缓存强制清空
>
> 配置useCache=false可以不用缓存
>
> 配置flushCache=true代表强制清空缓

### 示例

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
    <!-- 单参数传递,使用parameterType指定参数的数据类型即可,SQL中#{value}提取参数-->
    <select id="selectById" parameterType="Integer" resultType="com.imooc.mybatis.entity.Goods">
        select * from t_goods where goods_id = #{value}
    </select>
    <!-- 多参数传递时,使用parameterType指定Map接口,SQL中#{key}提取参数 -->
    <select id="selectByPriceRange" parameterType="java.util.Map" resultType="com.imooc.mybatis.entity.Goods">
        select * from t_goods
        where
          current_price between  #{min} and #{max}
        order by current_price
        limit 0,#{limt}
    </select>

    <!-- 利用LinkedHashMap保存多表关联结果
        MyBatis会将每一条记录包装为LinkedHashMap对象
        key是字段名  value是字段对应的值 , 字段类型根据表结构进行自动判断
        优点: 易于扩展,易于使用
        缺点: 太过灵活,无法进行编译时检查
     -->
    <select id="selectGoodsMap" resultType="java.util.LinkedHashMap" flushCache="true">
        select g.* , c.category_name,'1' as test from t_goods g , t_category c
        where g.category_id = c.category_id
    </select>

    <!--结果映射-->
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
    <!--flushCache="true"在sql执行后强制清空缓存-->
    <insert id="insert" parameterType="com.imooc.mybatis.entity.Goods" flushCache="true">
        INSERT INTO t_goods(title, sub_title, original_cost, current_price, discount, is_free_delivery, category_id)
        VALUES (#{title} , #{subTitle} , #{originalCost}, #{currentPrice}, #{discount}, #{isFreeDelivery}, #{categoryId})
      <!--<selectKey resultType="Integer" keyProperty="goodsId" order="AFTER">-->
          <!--select last_insert_id()-->
      <!--</selectKey>-->
    </insert>

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
    <!--delete from t_goods where goods_id in (1920,1921)-->
    <delete id="delete" parameterType="Integer">
        delete from t_goods where goods_id = #{value}
    </delete>

    <select id="selectByTitle" parameterType="java.util.Map" resultType="com.imooc.mybatis.entity.Goods">
        select * from t_goods where title = #{title}
        ${order}
    </select>

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
        <collection property="goodsDetails" select="goodsDetail.selectByGoodsId"
                    column="goods_id"/>
    </resultMap>
    <select id="selectOneToMany" resultMap="rmGoods1">
        select * from t_goods limit 0,10
    </select>

    <select id="selectPage" resultType="com.imooc.mybatis.entity.Goods">
        select * from t_goods where current_price &lt; 1000
    </select>

    <!--INSERT INTO table-->
    <!--VALUES ("a" , "a1" , "a2"),("b" , "b1" , "b2"),(....)-->
    <insert id="batchInsert" parameterType="java.util.List">
        INSERT INTO t_goods(title, sub_title, original_cost, current_price, discount, is_free_delivery, category_id)
        VALUES
        <foreach collection="list" item="item" index="index" separator=",">
            (#{item.title},#{item.subTitle}, #{item.originalCost}, #{item.currentPrice}, #{item.discount}, #{item.isFreeDelivery}, #{item.categoryId})
        </foreach>
    </insert>
    <!--in (1901,1902)-->
    <delete id="batchDelete" parameterType="java.util.List">
        DELETE FROM t_goods WHERE goods_id in
        <foreach collection="list" item="item" index="index" open="(" close=")" separator=",">
            #{item}
        </foreach>
    </delete>
</mapper>
```

```JAVA
public void testSelectByPriceRange() throws Exception {
    SqlSession session = null;
    try{
        session = MyBatisUtils.openSession();
        Map param = new HashMap();
        param.put("min",100);
        param.put("max" , 500);
        param.put("limt" , 10);
        List<Goods> list = session.selectList("goods.selectByPriceRange", param);
        for(Goods g:list){
            System.out.println(g.getTitle() + ":" + g.getCurrentPrice());

        }
    }catch (Exception e){
        throw e;
    }finally {
        MyBatisUtils.closeSession(session);
    }
}
```

MyBatis多表级联查询

商品和详情对象关联查询

PageHelper使用流程
maven引入PageHelper与jsqlparser
mybatis-config.xml增加Plugin配置
代码中使用PageHelper.startPage()自动分页



pagehelper文档



不同数据库分页原理

MySQL分页
select * from table limit 10,20;



Oracle  12—20
select t3.* from (
select t2.*, rownum as row num from ( select * from table order by id aso
) t2 where rownum<-20
)t3
where t2.row num>11



旧版sql server  4-15

SQL Server 2000
select top 3 * from table where
id not in
(select top 15 id from table)



新版 5-9

SQL Server 2012+
select * from table order by ic
offset 4 rows fetch next 5 rows only



整合c3p0

# 问题记录

## 数据类型

### 1.char、varchar、nchar、nvarchar

> char：  固定长度，存储ANSI字符，不足的补英文半角空格。
>
> nchar：  固定长度，存储Unicode字符，不足的补英文半角空格
>
> varchar： 可变长度，存储ANSI字符，根据数据长度自动变化。
>
> nvarchar： 可变长度，存储Unicode字符，根据数据长度自动变化。

注意：

```css
nvarchar(n) ：包含 n个字符的可变长度 Unicode 字符数据。n 的值必须介于 1 与 4,000 之间。字节的存储大小是所输入字符个数的两倍。所输入的数据字符长度可以为零。

varchar[(n)]：长度为 n 个字节的可变长度且非 Unicode的字符数据。n 必须是一个介于  1 和 8,000之间的数值。存储大小为输入数据的字节的实际长度，而不是 n 个字节。所输入的数据字符长度可以为零。

ANSI主要是以单字节来存储数据，一般适合英文。而我们常用的汉字需要用两个字节来存储，所以就要使用unicode的数据类型，不然读取出来的数据可能会乱码。

char(255)和varchar(255)：在存储字符串"hello world"时，char会用一块255个字节的空间放那个11个字符；而varchar就不会用255个，它先计算字符串长度为11，然后再加上一个记录字符串长度的字节，一共用12个字节存储，这样varchar在存储不确定长度的字符串时会大大减少存储空间。
```

## 数据库排序规则

```sql
--中文乱码时，更改排序规则
CREATE DATABASE Student
COLLATE Chinese_PRC_CI_AS; 
```

## 随记

1. 外键：表B字段和表A主键字段之间的约束关系

如：message表中user_id字段与user表中id字段