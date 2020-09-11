# CRUD总览

<img src="https://tva1.sinaimg.cn/large/007S8ZIlly1gih7hr88lij30j81lujyb.jpg" alt="数据库" style="zoom:200%;" />

# 数据类型

1. char、varchar、nchar、nvarchar

> char：  固定长度，存储ANSI字符，不足的补英文半角空格。
>
> nchar：  固定长度，存储Unicode字符，不足的补英文半角空格
>
> varchar： 可变长度，存储ANSI字符，根据数据长度自动变化。
>
> nvarchar： 可变长度，存储Unicode字符，根据数据长度自动变化。

注意：

```css
nvarchar(n) ：n为字符数

1. 包含 n个字符的可变长度 Unicode 字符数据。n 的值必须介于 1 与 4,000 之间。字节的存储大小是所输入字符个数的两倍。
2. 所输入的数据字符长度可以为零。
3. Unicode每个字符占两个字节

varchar(n)：n为字节数

1. 长度为 n 个字节的可变长度且非Unicode的字符数据。n 必须是一个介于  1 和 8,000之间的数值。存储大小为输入数据的字节的实际长度，而不是 n 个字节。
2. 所输入的数据字符长度可以为零。
```

# 视图&临时表

- 临时表

```sql
-- 创建临时表：给正常的CREATE TABLE语句加上TEMPORARY关键字：
-- 临时表在MySQL连接期间存在。断开时，MySQL将自动删除表并释放所用的空间。也可以自己删除释放空间。

create temporary table tes (
  id int unsigned NOT NULL AUTO_INCREMENT,
  dp_id int DEFAULT NULL,
  name varchar(20) NOT NULL,
  money float(10,2) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
);
drop table tmp_table;
```

- 视图

```sql
-- 概念：
-- 视图是一个虚拟表，其内容由查询定义。
-- 视图不在数据库中以存储的数据值集形式存在。数据来自由定义视图的查询所引用的表，并且在引用视图时动态生成。

-- 作用：
-- 1. 提高了重用性，如果要频繁获取user的name 和 goods的name。
-- 2. 对数据库重构，却不影响程序的运行。如因为某种需求，需要将user拆房表usera和表userb
-- 3.  提高了安全性能。可以对不同的用户，设定不同的视图。例如：某用户只能获取user表的name和age数据，不能获取sex数据：
		create view other as select a.name, a.age from user as a;
-- 让数据更加清晰。想要什么样的数据，就创建什么样的视图。

create view test AS select * from employees;
drop view if exists test1; 
```

# SQL编程

- 存储过程

```sql
-- 参数类型（in out inout）:
-- 1. IN 输入参数：表示调用者向过程传入值（传入值可以是字面量或变量）
-- 2. OUT 输出参数：表示过程向调用者传出值(可以返回多个值)（传出值只能是变量）
-- 3. INOUT 输入输出参数：既表示调用者向过程传入值，又表示过程向调用者传出值（传出值只能是变量）

-- 注意：
-- 1. 参数可以没有
-- 2. 如果存储过程提仅仅只有一句话，那么BEGIN END 可以省略


CREATE PROCEDURE update_user (in_name VARCHAR(20),in_money INT)
BEGIN
    declare num int;
    select count(*) into num from employees where name = in_name;
    if(num=0)
        Then
        insert into employees(name,money) select in_name,in_money;
    else
        update employees set money=money+in_money where name = in_name;
  end if;
END;

call update_user ('小明',1234);

drop procedure update_user;
```

- 自定义函数

```sql
-- 注意:
-- 1. 参数可以没有
-- 2. 创建函数错误：This function has none of DETERMINISTIC, NO SQL...
-- 解决方法：set global log_bin_trust_function_creators = 1;

create function 函数名([参数列表]) returns 数据类型
begin
 		sql语句;
 		return 值;
end;

create function test1(name varchar(15)) returns int
begin 
    declare c int;
    select count(id) from employees where `name`=name into c;
    return c;
end;

select test1("小明");

drop function test1;
```

- 存储过程和自定义函数的区别

```css
1. 返回值：
	- 函数只能返bai回一个变量，而存du储过程可以返回多个；
	- 存储过程可以返回参数，如记录集，函数只能返回值或者表对象；

2. 限制：
	- 函数的限制比较多，不能用临时表，只能用表变量，有些函数不能用，存储过程限制少；

3. 功能：
	- 存储过程处理的功能比较复杂，而函数实现的功能针对性强；

4. 权限：
	- 存储过程可以执行修改表的操作，但是函数不能执行一组修改全局数据库状态的操作（既不能修改表）；

5. 用途：
	- 存储过程一般是作为独立部分来执行，而函数可以作为查询语句的一个部分来调用
	- 由于函数可以返回一个表对象，所以在查询中位于from关键字后面，sql语句中不可以含有存储过程。

6.存储过程优点：
	- 执行效率很高，因为存储过程是预编译的，即创建时编译，而SQL语句是执行一次，编译一次。调用存储过程可以大大减少同数据库的交互次数。
```

# 变量

- 局部变量

```sql
在存储过程体/自定义函数体中

声明：
declare num int [default 0];

赋值：
SET 变量名 = 表达式值 /值

作用域：
过程体中
```

- 用户变量

```sql
不需要声明

赋值：
1. SET 方式
	SET @ variable = expr
	SET @ variable := expr -- 必须 := ，否则可能会被编译为比较运算符 
2. SELECT 方式
	SELECT expr into @variable
	SELECT @variable := expr -- 必须 := ，否则可能会被编译为比较运算符 

作用域:
1. 当前整个连接，当前连接断开后，其所定义的用户变量都会消失
2. 当使用了连接池，自定义的用户变量又没有正确初始化，容易出现意想不到的问题。因为它实际上并没有被销毁，依旧记录者上一次的结果。
```

# SELECT记录

```sql
-- 以下三条：都是查看是否有记录，一般作条件用。select 1 from 中的1是一常量（可为任意值），查到的所有行的值都是它
-- 从效率上来说，1>anycol>*，因为不用查字典表。

select 1 from employees;

select id from employees;

select * from employees;

-- insert ... select 实现插入操作

insert into employees(dp_id,name,money) select 1,'小明',3000;

-- select ... into 实现复制操作

SELECT * INTO Persons_backup FROM Persons

-- insert ... select 1/anycol 实现插入前判断是否存在

insert into employees(dp_id,name,money) select 1,'小明',3000 where not exists(select 1 from employees where name='小明');

insert into employees(dp_id,name,money) select 1,'小明',3000 from dual where not exists(select 1 from employees where name='小明');
```

#  实际运用

## 函数

### CAST()

```sql
-- CAST强转函数语法规则是：Cast (字段名 as 转换的类型 )
-- 其中类型可以为：CHAR(N) ，DATE ，TIME，DATETIME ，DECIMAL，BINARY，SIGNED，UNSIGNED

select cast(id as char(64)) as id from employees;

select cast(id as date) as id from employees;
```

### 时间戳

获得当前日期+时间（date + time）函数：now()

### DATE函数

DATE_ADD() 函数向日期添加指定的时间间隔。

**语法**

```
DATE_ADD(date,INTERVAL expr type)
```

> *date* 参数是合法的日期表达式。
>
> *expr* 参数是您希望添加的时间间隔。
>
> type 参数可以是下列值DAY,HOUR，等等一堆

**示例：**

假设我们有如下的表：

| OrderId | ProductName | OrderDate               |
| :------ | :---------- | :---------------------- |
| 1       | 'Computer'  | 2008-12-29 16:25:46.635 |

现在，我们希望向 "OrderDate" 添加 2 天，这样就可以找到付款日期。

```sql
SELECT OrderId,DATE_ADD(OrderDate,INTERVAL 2 DAY) AS OrderPayDate
FROM Orders
```

结果：

| OrderId | OrderPayDate            |
| :------ | :---------------------- |
| 1       | 2008-12-31 16:25:46.635 |

 ### 备份表

sql server中用法:

```sql
Select * Into new_table_name from old_table_name; 这是
```

mysql中用法:

```sql
Create table new_table_name (Select * from old_table_name);
```

## 操作字段名

select语句中，对表字段名的所有操作，其实是对字段对应的记录值进行操作。

如：+，-，聚合函数，concat拼接函数,distinct去重关键字

> 注意：+号，在mysql中+号不能作为字符串连接符，如果两个字符串用+连接，会自动把两边转化成数字类型再进行相加操作，如果哪一边字符串不能转为数字，哪一边就返回0。

```sql
-- 除distinct，其他操作未指定别名是，列名为原表达式

SELECT money + 1 FROM employees;

SELECT money - 1 FROM employees;

SELECT max(money) as max FROM employees;

SELECT min(money) FROM employees;

SELECT count(money) FROM employees;

SELECT sum(money) FROM employees;

SELECT avg(money) FROM employees;

--这里第二个name列，列名为name(1)
SELECT CONCAT(name,name) as Name FROM employees;

SELECT name,name FROM employees;

SELECT CONCAT(2,1) FROM employees;

SELECT DISTINCT money - 1 FROM employees;
```

## 派生表

派生表和子查询通常可互换使用。当`SELECT`语句的`FROM`子句中使用独立子查询时，我们将其称为派生表。

派生表必须具有别名。

## 嵌套查询

### 简介

定义：

```
一个内层查询语句(select-from-where)块可以嵌套在另外一个外层查询块的where子句中，其中外层查询也称为父查询，主查询。内层查询也称子查询，从查询。子查询一般不使用order by子句，只能对最终查询结果进行排序。
```

嵌套查询的工作方式是：

```
先处理内查询，由内向外处理，外层查询利用内层查询的结果嵌套查询不仅仅可以用于父查询select语句使用，还可以用于insert、update、delete语句或其他子查询中。
```

子查询的语法规则：

```
子查询的select查询总是使用圆括号括起来；

任何可以使用表达式的地方都可以使用子查询，只要它返回的是单个值；

如果某个表只出现在子查询中而不出现在外部查询中，那么该表的列就无法包含在输出中；

一般，对于子查询生成的表都给它起个别名。
```

重点：

> **1. 子查询一般用在WHERE后**
>
> **2. 本质上说，嵌套查询就是每行的特定字段值代入表达式之后，只有表达式结果为true的那行记录才会被输出。**

### 子查询返回值

```sql
-- 当子查询的返回值只有一个时，可以使用比较运算符如=、<、>、>=、<=、!=、<>等（<>与!=都是不等）

-- 如果子查询的返回值不止一个，而是一个集合时，则不能直接使用比较运算符
-- 子查询关键字来啦

1. any 必须与=、>、>=、<、<=、<>结合起来使用，分别表示等于、大于、大于等于、小于、小于等于、不等于其中的任何一个数据

注意：some是any的别名，用法相同

select s1 from t1 where s1 > any (select s1 from t2);


2. all 必须与=、>、>=、<、<=、<>结合是来使用，分别表示等于、大于、大于等于、小于、小于等于、不等于其中的其中的所有数据

select s1 from t1 where s1 > all(select s1 from t2);

3. in 查询相当于多个or条件的叠加

select * from user where userId in (1, 2, 3);
select * from user where userId = 1 or userId = 2 or userId = 3;

4. not in与in相反

select * from user where userId not in (1, 2, 3);
select * from user where userId != 1 and userId != 2 and userId != 3;

-- 值得一提的是，in查询的子条件返回结果必须只有一个字段：
select * from user where userId in (select id from B);
而不能是
select * from user where userId in (select id, age from B);

5. exists 表示存在，它常常和子查询配合使用

SELECT * FROM `user WHERE exists (SELECT * FROM `order` WHERE user.id = order.user_id)

-- exists用于检查子查询是否至少会返回一行数据，该子查询实际上并不返回任何数据，而是返回值 True 或 False
-- 当子查询返回为真时，则外层查询语句将进行查询。当子查询返回为假时，外层查询语句将不进行查询或者查询不出任何记录
```

## NULL相关函数

1. is NULL与ISNULL()的比较

```sql
SELECT * from 表名 where 字段名 is NULL

SELECT * from 表名 where ISNULL(字段名)

-- is NULL要比ISNULL()快一点
```

2. is NULL和IFNULL()的比较

```sql
SELECT * from 表名 where 字段名 is NULL

SELECT * from 表名 where IFNULL(字段名,'0') = '0';

IFNULL()要比is NULL快一点。
```

综上所述，**查询空值的运行速度基本上为IFNULL()>is NULL>ISNULL()。**

## dual表

在Mysql和SQL Server中可以直接`select 1`不需要加from 表名就可以执行 ,而在Oracle中要满足`select from`的结构：select 1 from dual

在mysql5.1之后引入dual虚拟表：官方声明纯粹是为了满足`select ... from..`.这一习惯问题，mysql会忽略对该表的引用：select 1 from dual

```sql
insert into `Test` select 1 , 'cao' where not exists(select 1 from Test where id=1);

insert into `Test` select 1 , 'cao' from dual where not exists(select 1 from Test where id=1);
```

## 变量赋值

在MySQL存储过程中使用SELECT …INTO语句为变量赋值：

　　用来将查询返回的一行的各个列值保存到局部变量中。

要求：

　　查询的结果集中只能有1行。

> SELECT col_name[,...] INTO var_name[,...] table_expr

使用SELECT …INTO语句在数据库中进行查询，并将得到的结果赋值给变量。

　　①col_name：要从数据库中查询的列字段名；

　　②var_name：变量名，列字段名按照在列清单和变量清单中的位置对应，将查询得到的值赋给对应位置的变量；

　　③table_expr：SELECT语句中的其余部分，包括可选的FROM子句和WHERE子句。

## 分组聚合

**分组一般和聚合一块出现！！！！！**

分组，说白就是找相同，根据字段值，相同就是一组

分组聚合，在已经分好组的前提上，对每组进行操作，返回对每组操作的结果，也就是一组只有一个结果。比如，如果想知道每组里有多少条记录，可以用count(1)

分组查询，如果查询的字段名和group by 的字段名是一样的，输出结果集就是不同的各个组名（字段名），这很好理解；但如果查询的不光是group by的字段名，那结果集是每组查到的第一条记录，注意是一条，如果你想看每个分组的所有数据，建议你用order by和where。

分组排序：是先排序后分组，造成的结果是，如果查询的不光是group by的字段名，那结果集会因为顺序不同而变化，当然，也只是每个分组里的一条不同记录罢了。

## 临时表

​    **临时表主要用于对大数据量的表上作一个子集，提高查询效率**。

 **临时表使用有一些限制条件**：

　　* 不能使用rename来重命名临时表。但是可以alter table rename代替：

​      　mysql>ALTER TABLE orig_name RENAME new_name;

　　* 可以复制临时表得到一个新的临时表，如：

​        mysql>create temporary table new_table select * from old_table;

　　*  但在同一个query语句中，相同的临时表只能出现一次。如：

​        可以使用：mysql> select * from temp_tb;

​        但不能使用：mysql> select * from temp_tb, temp_tb as t;

​        错误信息：  ERROR 1137 (HY000): Can't reopen table: 'temp_tb'

​    同样相同临时表不能在存储函数中出现多次，如果在一个存储函数里，用不同的别名查找一个临时表多次，或者在这个存储函数里用不同的语句查找，都会出现这个错误。

既然子查询中不能再次打开临时表，那么就使用其他临时表 先把子查询的数据存起来，然后再处理。

　　* 但不同的临时表可以出现在同一个query语句中，如临时表temp_tb1, temp_tb2：

​         Mysql> select * from temp_tb1, temp_tb2;

​    临时表可以手动删除：

​         DROP TEMPORARY TABLE IF EXISTS temp_tb;

# 函数

## 流程控制函数

### IF函数

> IF 语句允许您根据表达式的结果来执行一组 SQL 语句。
>
> 要在 MySQL 中形成一个表达式，可以结合文字，变量，运算符，甚至函数来组合。表达式可以返回 TRUE,FALSE 或 NULL，这三个值之一。

语法：

```sql
IF(expr,v1,v2)

其中：表达式 expr 得到不同的结果，当 expr 为真是返回 v1 的值，否则返回 v2.
```

示例：

```sql
SELECT IF(1<2,1,0) c1,IF(1>5,'√','×') c2,IF(STRCMP('abc','ab'),'yes','no') c3;

+----+----+-----+
| c1 | c2 | c3  |
+----+----+-----+
|  1 | × | yes |
+----+----+-----+
1 row in set, 2 warnings (0.00 sec)
```

在 c3 中，先用 STRCMP(s1,s2) 函数比较两个字符串的大小，字符串 'abc' 和 'ab' 比较结果的返回值为 1，也就是表达式 expr 的返回结果不等于 0 且不等于 NULL，则返回值为 v1，即字符串 'yes'。

### IFNULL 函数

> IFNULL 函数接受两个参数，如果不是 NULL，则返回第一个参数。 否则，IFNULL 函数返回第二个参数。两个参数可以是文字值或表达式。IFNULL()的返回值是数字或是字符串，具体情况取决于其所使用的语境。 

语法：

```sql
IFNULL(v1,v2);

其中：如果 v1 不为 NULL，则 IFNULL 函数返回 v1; 否则返回 v2 的结果。
```

示例：

```sql
SELECT IFNULL(5,8),IFNULL(NULL,'OK'),IFNULL(SQRT(-8),'FALSE'),SQRT(-8);

+-------------+-------------------+--------------------------+----------+
| IFNULL(5,8) | IFNULL(NULL,'OK') | IFNULL(SQRT(-8),'FALSE') | SQRT(-8) |
+-------------+-------------------+--------------------------+----------+
|           5 | OK                | FALSE                    |     NULL |
+-------------+-------------------+--------------------------+----------+
1 row in set (0.00 sec)
```

当 v1=SQRT(-8) 时，SQRT(-8) 函数的返回值为NULL，即 v1=NULL，所以返回 v2 为字符串 'false'。

### NULLIF()

语法：

```
NULLIF(expr1,expr2);

如果expr1 = expr2 成立，那么返回值为NULL，否则返回值为 expr1。这和CASE WHEN expr1 = expr2  THEN NULL ELSE expr1 END相同。
```

### CASE函数

*CASE  WHEN  THEN  ELSE  END*

> 注意：
>
> 1. 其实从case到end的这段语句完全可以看作一个字段名，后边可以也必须加AS，给结果集中的这个字段添加别名，不然字段名显示的就是从case到end的这段语句！！！！
> 2. 注意：Case函数只返回第一个符合条件的值，剩下的Case部分将会被自动忽略！！！
>
> ```sql
> -- 比如说，下面这段SQL，永远无法得到“第二类”这个结果 
> 
> CASE WHEN col_1 IN ( 'a', 'b') THEN '第一类' 
>      WHEN col_1 IN ('a')    THEN '第二类' 
> ELSE'其他' END 
> ```
>
> 3. 如果省略 ELSE 子句，并且找不到匹配项，MySQL 将引发错误。

CASE 语句有两种形式：简单的和可搜索 CASE 语句。

#### 简单CASE 语句

用来检查表达式的值与另一组唯一值的匹配。

语法：

```
CASE  <表达式>
   WHEN <值1> THEN <唯一值>
   WHEN <值2> THEN <唯一值>
   ...
   ELSE <唯一值>
END ;
```

示例：

```sql
SELECT CASE WEEKDAY(NOW()) WHEN 0 THEN '星期一' WHEN 1 THEN '星期二' WHEN
2 THEN '星期三' WHEN 3 THEN '星期四' WHEN 4 THEN '星期五' WHEN 5 THEN '星期六'
ELSE '星期天' END AS COLUMN1,NOW(),WEEKDAY(NOW()),DAYNAME(NOW());

+-----------+---------------------+----------------+----------------+
| COLUMN1   | NOW()               | WEEKDAY(NOW()) | DAYNAME(NOW()) |
+-----------+---------------------+----------------+----------------+
| 星期五    | 2020-09-04 15:23:35 |              4 | Friday         |
+-----------+---------------------+----------------+----------------+
1 row in set (0.01 sec)
```

```sql
SELECT NAME '英雄',CASE NAME WHEN '德莱文' THEN '斧子' WHEN '德玛西亚-盖伦' THEN '大宝剑' WHEN '暗夜猎手-VN' THEN '弩' ELSE '无' END '装备' FROM user_info;
```

#### 搜索 CASE 语句

 可搜索 CASE 语句等同于 IF 语句，但是它的构造更加可读。

语法：

```
CASE
    WHEN <条件1> THEN <命令>
    WHEN <条件2> THEN <命令>
    ...
    ELSE commands
END ;
```

示例：

```sql
SELECT CASE WHEN WEEKDAY(NOW())=0 THEN '星期一' WHEN WEEKDAY(NOW())=1 THEN '星期二'  WHEN WEEKDAY(NOW())=2 THEN '星期三' WHEN WEEKDAY(NOW())=3 THEN '星期
四' WHEN WEEKDAY(NOW())=4 THEN '星期五' WHEN WEEKDAY(NOW())=5 THEN '星期六' WHEN
WEEKDAY(NOW())=6 THEN '星期天' END AS COLUMN1,NOW(),WEEKDAY(NOW()),DAYNAME(NOW(
));

+-----------+---------------------+----------------+-----------------+
| COLUMN1   | NOW()               | WEEKDAY(NOW()) | DAYNAME(NOW(
)) |
+-----------+---------------------+----------------+-----------------+
| 星期五    | 2020-09-04 15:29:02 |              4 | Friday          |
+-----------+---------------------+----------------+-----------------+
1 row in set (0.01 sec)
```

```sql
SELECT NAME '英雄',age '年龄',CASE WHEN age< 18 THEN '少年' WHEN age< 30 THEN '青年' WHEN age>=30 AND age< 50 THEN '中年' ELSE '老年' END '状态' FROM user_info;
```

#### 结合函数

将sum()、count()与case结合使用，可以实现分段统计。

示例：

```sql
select sum(case u.sex when 1 then 1 else 0 end) 男性,  sum(case u.sex when 2 then 1 else 0 end) 女性,sum(case when u.sex <>1 and u.sex<>2 then 1 else 0 end) 性别为空 from users u;

select count(case when u.sex=1 then 1 end) 男性, count(case when u.sex=2 then 1 end) 女,count(case when u.sex <>1 and u.sex<>2 then 1 end) 性别为空 from users u;
```

## 数值型函数

| 函数名称                                                     | 作 用                                                      |
| ------------------------------------------------------------ | ---------------------------------------------------------- |
| [ABS](http://c.biancheng.net/mysql/abc.html)                 | 求绝对值                                                   |
| [SQRT](http://c.biancheng.net/mysql/sqrt.html)               | 求二次方根                                                 |
| [MOD](http://c.biancheng.net/mysql/mod.html)                 | 求余数                                                     |
| [CEIL 和 CEILING](http://c.biancheng.net/mysql/ceil_celing.html) | 两个函数功能相同，都是返回不小于参数的最小整数，即向上取整 |
| [FLOOR](http://c.biancheng.net/mysql/floor.html)             | 向下取整，返回值转化为一个BIGINT                           |
| [RAND](http://c.biancheng.net/mysql/rand.html)               | 生成一个0~1之间的随机数，传入整数参数是，用来产生重复序列  |
| [ROUND](http://c.biancheng.net/mysql/round.html)             | 对所传参数进行四舍五入                                     |
| [SIGN](http://c.biancheng.net/mysql/sign.html)               | 返回参数的符号                                             |
| [POW 和 POWER](http://c.biancheng.net/mysql/pow_power.html)  | 两个函数的功能相同，都是所传参数的次方的结果值             |
| [SIN](http://c.biancheng.net/mysql/sin.html)                 | 求正弦值                                                   |
| [ASIN](http://c.biancheng.net/mysql/asin.html)               | 求反正弦值，与函数 SIN 互为反函数                          |
| [COS](http://c.biancheng.net/mysql/cos.html)                 | 求余弦值                                                   |
| [ACOS](http://c.biancheng.net/mysql/acos.html)               | 求反余弦值，与函数 COS 互为反函数                          |
| [TAN](http://c.biancheng.net/mysql/tan.html)                 | 求正切值                                                   |
| [ATAN](http://c.biancheng.net/mysql/atan.html)               | 求反正切值，与函数 TAN 互为反函数                          |
| [COT](http://c.biancheng.net/mysql/cot.html)                 | 求余切值                                                   |

## 字符串函数

| 函数名称                                                 | 作 用                                                        |
| -------------------------------------------------------- | ------------------------------------------------------------ |
| [LENGTH](http://c.biancheng.net/mysql/length.html)       | 计算字符串长度函数，返回字符串的字节长度                     |
| [CONCAT](http://c.biancheng.net/mysql/concat.html)       | 合并字符串函数，返回结果为连接参数产生的字符串，参数可以使一个或多个 |
| [INSERT](http://c.biancheng.net/mysql/insert.html)       | 替换字符串函数                                               |
| [LOWER](http://c.biancheng.net/mysql/lower.html)         | 将字符串中的字母转换为小写                                   |
| [UPPER](http://c.biancheng.net/mysql/upper.html)         | 将字符串中的字母转换为大写                                   |
| [LEFT](http://c.biancheng.net/mysql/left.html)           | 从左侧字截取符串，返回字符串左边的若干个字符                 |
| [RIGHT](http://c.biancheng.net/mysql/right.html)         | 从右侧字截取符串，返回字符串右边的若干个字符                 |
| [TRIM](http://c.biancheng.net/mysql/trim.html)           | 删除字符串左右两侧的空格                                     |
| [REPLACE](http://c.biancheng.net/mysql/replace.html)     | 字符串替换函数，返回替换后的新字符串                         |
| [SUBSTRING](http://c.biancheng.net/mysql/substring.html) | 截取字符串，返回从指定位置开始的指定长度的字符换             |
| [REVERSE](http://c.biancheng.net/mysql/reverse.html)     | 字符串反转（逆序）函数，返回与原始字符串顺序相反的字符串     |

##  日期时间函数

| 函数名称                                                     | 作 用                                                        |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [CURDATE 和 CURRENT_DATE](http://c.biancheng.net/mysql/curdate_current_date.html) | 两个函数作用相同，返回当前系统的日期值                       |
| [CURTIME 和 CURRENT_TIME](http://c.biancheng.net/mysql/curtime_current_time.html) | 两个函数作用相同，返回当前系统的时间值                       |
| [NOW 和 SYSDATE](http://c.biancheng.net/mysql/now_sysdate.html) | 两个函数作用相同，返回当前系统的日期和时间值                 |
| [UNIX_TIMESTAMP](http://c.biancheng.net/mysql/unix_timestamp.html) | 获取UNIX时间戳函数，返回一个以 UNIX 时间戳为基础的无符号整数 |
| [FROM_UNIXTIME](http://c.biancheng.net/mysql/from_unixtime.html) | 将 UNIX 时间戳转换为时间格式，与UNIX_TIMESTAMP互为反函数     |
| [MONTH](http://c.biancheng.net/mysql/month.html)             | 获取指定日期中的月份                                         |
| [MONTHNAME](http://c.biancheng.net/mysql/monthname.html)     | 获取指定日期中的月份英文名称                                 |
| [DAYNAME](http://c.biancheng.net/mysql/dayname.html)         | 获取指定曰期对应的星期几的英文名称                           |
| [DAYOFWEEK](http://c.biancheng.net/mysql/dayofweek.html)     | 获取指定日期对应的一周的索引位置值                           |
| [WEEK](http://c.biancheng.net/mysql/week.html)               | 获取指定日期是一年中的第几周，返回值的范围是否为 0〜52 或 1〜53 |
| [DAYOFYEAR](http://c.biancheng.net/mysql/dayofyear.html)     | 获取指定曰期是一年中的第几天，返回值范围是1~366              |
| [DAYOFMONTH](http://c.biancheng.net/mysql/dayofmonth.html)   | 获取指定日期是一个月中是第几天，返回值范围是1~31             |
| [YEAR](http://c.biancheng.net/mysql/year.html)               | 获取年份，返回值范围是 1970〜2069                            |
| [TIME_TO_SEC](http://c.biancheng.net/mysql/time_to_sec.html) | 将时间参数转换为秒数                                         |
| [SEC_TO_TIME](http://c.biancheng.net/mysql/sec_to_time.html) | 将秒数转换为时间，与TIME_TO_SEC 互为反函数                   |
| [DATE_ADD 和 ADDDATE](http://c.biancheng.net/mysql/date_add_adddate.html) | 两个函数功能相同，都是向日期添加指定的时间间隔               |
| [DATE_SUB 和 SUBDATE](http://c.biancheng.net/mysql/date_sub_subdate.html) | 两个函数功能相同，都是向日期减去指定的时间间隔               |
| [ADDTIME](http://c.biancheng.net/mysql/addtime.html)         | 时间加法运算，在原始时间上添加指定的时间                     |
| [SUBTIME](http://c.biancheng.net/mysql/subtime.html)         | 时间减法运算，在原始时间上减去指定的时间                     |
| [DATEDIFF](http://c.biancheng.net/mysql/datediff.html)       | 获取两个日期之间间隔，返回参数 1 减去参数 2 的值             |
| [DATE_FORMAT](http://c.biancheng.net/mysql/date_format.html) | 格式化指定的日期，根据参数返回指定格式的值                   |
| [WEEKDAY](http://c.biancheng.net/mysql/weekday.html)         | 获取指定日期在一周内的对应的工作日索引                       |

## 聚合函数

| 函数名称                                         | 作用                             |
| ------------------------------------------------ | -------------------------------- |
| [MAX](http://c.biancheng.net/mysql/max.html)     | 查询指定列的最大值               |
| [MIN](http://c.biancheng.net/mysql/min.html)     | 查询指定列的最小值               |
| [COUNT](http://c.biancheng.net/mysql/count.html) | 统计查询结果的行数               |
| [SUM](http://c.biancheng.net/mysql/sum.html)     | 求和，返回指定列的总和           |
| [AVG](http://c.biancheng.net/mysql/avg.html)     | 求平均值，返回指定列数据的平均值 |

# 案例

## 有则修改，无则添加

- 用户存在时money加1000，用户不存在时添加用户，money设为null

```sql
alter table employees add unique (name);

replace into employees(name,money) select "张三",money+1000 from employees right join (select 1 ) tab on name ="张三";
```

- 用户存在时money加1000；用户不存在时添加用户，money设为3000

```sql
alter table employees add unique (name);

-- 如果在INSERT语句末尾指定了ON DUPLICATE KEY UPDATE，并且插入行后会导致在一个UNIQUE索引或PRIMARY KEY中出现重复值，则在出现重复值的行执行UPDATE；如果不会导致唯一值列重复的问题，则插入新行
-- ON DUPLICATE KEY UPDATE只是MySQL的特有语法，不是SQL标准语法！

insert into employees(name,money) select "张三",3000 ON DUPLICATE KEY update money=money+1000;
```

```sql
-- 使用存储过程
CREATE PROCEDURE add_user (IN in_name VARCHAR(20),IN in_money INT,IN add_money INT)
BEGIN
    declare num int;
    select count(*) into num from employees where name = in_name;
    if(num=0)
        Then
        insert into employees(name,money) select in_name,in_money;
    else
        update employees set money=money+add_money where name = in_name;
  end if;
END;
call add_user('张三',3000,1000);
```

```sql
-- 使用exists判断
insert into employees(name,money) select '张三',3000 where not exists(select 1 from employees where name = '张三');
update employees set money=money+1000 where name = '张三';
```

```sql
-- 使用count()函数计数判断
set @count = (select count(1) from employees where name = '张三');
insert into employees(name,money) select '张三',3000 where @count = 0;
update employees set money=money+1000 where name = '张三';
```

## 删除重复记录

```sql
-- 删除email相同的记录
DELETE FROM Person WHERE id NOT IN (SELECT id FROM (SELECT min(id) AS id FROM Person GROUP BY email) AS m);
```

