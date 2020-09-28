# CRUD总览

1、执行WHERE筛选数据

2、执行GROUP BY分组形成中间分组表

3、执行WITH ROLLUP生成统计分析数据记录并加入中间分组表

4、执行HAVING筛选中间分组表

5、执行ORDER BY排序

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

# 排序&分组

- ORDER BY... ... ASC：将查询数据排序后再返回数据

  > 可以使用任何字段来作为排序的条件
  >
  > 可以设定多个字段来排序
  >
  > 可以使用 ASC 或 DESC 关键字来设置查询结果是按升序或降序排列， 默认升序

```sql
-- MySQL 拼音排序

如果字符集采用的是 gbk(汉字编码字符集)，直接在查询语句后边添加 ORDER BY：
SELECT * 
FROM runoob_tbl
ORDER BY runoob_title;

如果字符集采用的是 utf8(万国码)，需要先对字段进行转码然后排序：
SELECT * 
FROM runoob_tbl
ORDER BY CONVERT(runoob_title using gbk);
```

- GROUP BY 根据一个或多个列对结果集进行分组

  > GROUP BY 一般和聚合函数配合使用

```sql
SELECT name, COUNT(*) FROM   employee GROUP BY name  with rollup ;
+--------+--------------+
| name   | singin_count |
+--------+--------------+
| 小丽 		|            2 |
| 小明 		|            7 |
| 小王 		|            7 |
| NULL   |           16 |   -- whith rollup：在group分组字段的基础上再进行统计数据
+--------+--------------+

SELECT name, COUNT(*) FROM   employee GROUP BY name  having name = '小王' ;
+--------+--------------+
| name   | singin_count |
+--------+--------------+
| 小丽 		|            2 |  -- WHERE 关键字无法与聚合函数一起使用，HAVING 可以让我们筛选分组后的各组数据。
+--------+--------------+
```

# 联结查询

![未命名](https://tva1.sinaimg.cn/large/007S8ZIlly1gireod4nzhj315n0dx75l.jpg)

MySQL联结查询大致分为四种：

1．内联结：

两个表中存在联结关系的字段，将符合联结关系的那些记录形成记录集的联结。

```sql
Select A.name B.name From A Inner Join B On A.id=B.id   -- inner可省略
```

2．外联结：

分为外左联结和外右联结。

左联结A、B表：将表A中的全部记录➕表B中与A表内联结形成的记录集的联结；

右联结A、B表：将表B中的全部记录➕表A中与B表内联结形成的记录集的联结；

```sql
-- 以下两句执行结果相同

Select A.name B.name From A Left Join B On A.id=B.id

Select A.name B.name From B Right Join A on B.id=A.id
```

3．全联结：

将两个表中存在联结关系的字段的所有记录取出形成记录集的联结。

既：只要是查询中提到了的表的字段都会取出，无论是否符合联结条件，因此意义不大

```sql
-- MySQL本身不支持你所说的full join（全连接），但可以通过union来实现
-- UNION 与 UNION ALL 的区别：
-- 当使用 UNION 时，MySQL 会把结果集中重复的记录删掉，而使用 UNION ALL ，MySQL 会把所有的记录返回，且效率高于 UNION

SELECT * FROM t1
LEFT JOIN t2 ON t1.id = t2.id
UNION
SELECT * FROM t1
RIGHT JOIN t2 ON t1.id = t2.id
```

4．自联结：

没有使用联结功能，也有自联结的说法。

注：无限级分类的实现形式，商品类目表，如一张表中：id=product_id

- **补充：笛卡尔积**

假设集合A={a,b}，集合B={0,1,2}，则两个集合的笛卡尔积为{(a,0),(a,1),(a,2),(b,0),(b,1),(b,2)},把集合A，B合成集合A×B

```sql
select * from t_user, t_address;

select * from t_user inner join t_address;
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

# 关键字

### limit

```sql
mysql> SELECT * FROM table LIMIT 5,10; // 检索记录行 6-15
 
mysql> SELECT * FROM table LIMIT 95,-1; // 检索记录行 96-last.

mysql> SELECT * FROM table LIMIT 5; //检索前 5 个记录行  -- LIMIT n 等价于 LIMIT 0,n。
```

### distinct

```sql
-- 用来去除查询结果中的重复记录的

select distinct country from person;

-- 当distinct应用到多个字段的时候，其应用的范围是其后面的所有字段，而不只是紧挨着它的一个字段
-- distinct只能放到所有字段的前面
select distinct country, province from person;
SELECT country, distinct province from person; -- 该语句是错误的

-- 使用distinct对*操作
select DISTINCT * from person 
-- 相当于
select DISTINCT id, `name`, country, province, city from person;
```

# 数据类型

## char、varchar、text

- char长度固定， 即每条数据占用等长字节空间；适合用在身份证号码、手机号码等定。

- varchar可变长度，可以设置最大长度；适合用在长度可变的属性。

- text不设置长度， 当不知道属性的最大长度时，适合用text。

  按照查询速度： char最快， varchar次之，text最慢。

## JSON类型

### 简介

MySQL支持JSON数据类型。相比于Json格式的字符串类型，JSON数据类型的优势有：

- 存储在JSON列中的JSON文档的会被自动验证。无效的文档会产生错误；
- 最佳存储格式。存储在JSON列中的JSON文档会被转换为允许快速读取文档元素的内部格式。

存储在JSON列中的任何JSON文档的大小都受系统变量`max_allowed_packet`的值的限制，可以使用`JSON_STORAGE_SIZE()`函数获得存储JSON文档所需的空间。

### 创建

JSON数组包含在 字符`[`和`]`字符中，其中为一个由逗号分隔的值列表：

```json
["abc", 10, null, true, false]
```

JSON对象包含在字符`{`和`}`字符中，其中为一组由逗号分隔的键值对，键必须是字符串：

```json
{"k1": "value", "k2": 10}
```

在JSON数组和JSON对象的值中允许嵌套：

```json
[99, {"id": "HK500", "cost": 75.99}, ["hot", "cold"]]
{"k1": "value", "k2": [10, 20]}
```

### 插入

下例中向创建一个只有一个JSON列的表格`t_json`，并向其中添加JSON值：

```csharp
mysql> CREATE TABLE t_json (jdoc JSON) ENGINE=InnoDB DEFAULT CHARSET=utf8;
Query OK, 0 rows affected, 1 warning (0.73 sec)

mysql> INSERT INTO t_json VALUES('[1,2]');
Query OK, 1 row affected (0.17 sec

mysql> INSERT INTO t_json VALUES('{"key1":"value1","key2":"value2"}');
Query OK, 1 row affected (0.27 sec)

mysql> INSERT INTO t_json VALUES('"HELLO"');
Query OK, 1 row affected (0.20 sec)
```

若添加的值为非JSON格式，则报错：

```csharp
mysql> INSERT INTO t_json VALUES("HELLO");
ERROR 3140 (22032): Invalid JSON text: "Invalid value." at position 0 in value for column 't_json.jdoc'.
```

### JSON值的规范化

解析字符串并发现字符串是有效的JSON文档时，它在被解析时也会被规范化。对于重复的键（`key`）,后面的值（`value`）会覆盖前面的值。如下：

```bash
mysql> SELECT JSON_OBJECT('x',1,'y',2,'x','a','x','b');
+------------------------------------------+
| JSON_OBJECT('x',1,'y',2,'x','a','x','b') |
+------------------------------------------+
| {"x": "b", "y": 2}                       |
+------------------------------------------+
1 row in set (0.07 sec)
```

这种“覆盖”在向JSON列添加值时也会发生。

 在MySQL8.0.3之前的版本中，与此相反，对于被重复的键，它的第一个值会被保留，后添加的值则会被抛弃。

### 值的局部更新

在MySQL8.0中，优化器可以执行JSON列的局部就地更新，而不用删除旧文档再将整个新文档写入该列。局部更新的条件：

- 正在更新的列被声明为JSON；
- 该UPDATE语句使用任一的三个函数 `JSON_SET()`， `JSON_REPLACE()`或 `JSON_REMOVE()`更新列；
- 输入列和目标列必须是同一列；
- 所有更改都使用新值替换现有数组或对象值，并且不向父对象或数组添加任何新元素；
- 新值不能大于旧值；

### 函数操作

#### 插入数据

可以一定程度地避免输入格式错误

- `JSON_TYPE()`函数尝试将传入的值其解析为JSON值。如果值有效，则返回值的JSON类型，否则产生错误：

```swift
mysql> SELECT JSON_TYPE('["a","b",true,13]');
+--------------------------------+
| JSON_TYPE('["a","b",true,13]') |
+--------------------------------+
| ARRAY                          |
+--------------------------------+
1 row in set (0.04 sec)
```

- `JSON_ARRAY()`接收传入的值列表（可以为空），返回包含这些值的JSON数组：

```bash
mysql> SELECT JSON_ARRAY('ab',false,13);
+---------------------------+
| JSON_ARRAY('ab',false,13) |
+---------------------------+
| ["ab", false, 13]         |
+---------------------------+
1 row in set (0.00 sec)
```

- `JSON_OBJECT()` 接收传入的键值对列表（可以为空），并返回包含这些键值对的JSON对象，如果传入的参数不能组成键值对，则报错：：

```bash
mysql> SELECT JSON_OBJECT('key1','a','key2','b');
+------------------------------------+
| JSON_OBJECT('key1','a','key2','b') |
+------------------------------------+
| {"key1": "a", "key2": "b"}         |
+------------------------------------+
1 row in set (0.03 sec)
```

- `JSON_MERGE_PRESERVE()` 获取两个或多个JSON文档并返回组合结果：

```swift
mysql> SELECT JSON_MERGE_PRESERVE('["a", 1]', '{"key": "value"}');
+-----------------------------------------------------+
| JSON_MERGE_PRESERVE('["a", 1]', '{"key": "value"}') |
+-----------------------------------------------------+
| ["a", 1, {"key": "value"}]                          |
+-----------------------------------------------------+
1 row in set (0.03 sec)
```

#### 合并JSON值

MySQL8.0.3及更高版本中，有两种合并函数：`JSON_MERGE_PRESERVE()`和 `JSON_MERGE_PATCH()`。下面具讨论它们的区别。

- 合并数组：

```rust
mysql> SELECT JSON_MERGE_PATCH('[1, 2]', '["a", "b", "c"]','[1, 2]', '[true, false]');
+-------------------------------------------------------------------------+
| JSON_MERGE_PATCH('[1, 2]', '["a", "b", "c"]','[1, 2]', '[true, false]') |
+-------------------------------------------------------------------------+
| [true, false]                                                           |
+-------------------------------------------------------------------------+
1 row in set (0.00 sec)

mysql> SELECT JSON_MERGE_PRESERVE('[1, 2]', '["a", "b", "c"]','[1, 2]', '[true, false]');
+----------------------------------------------------------------------------+
| JSON_MERGE_PRESERVE('[1, 2]', '["a", "b", "c"]','[1, 2]', '[true, false]') |
+----------------------------------------------------------------------------+
| [1, 2, "a", "b", "c", 1, 2, true, false]                                   |
+----------------------------------------------------------------------------+
1 row in set (0.00 sec)
```

合并数组时，`JSON_MERGE_PRESERVE`只保留最后传入的数组参数，而`JSON_MERGE_PRESERVE`则按传入顺序将数组参数连接。

- 合并对象

```swift
mysql> SELECT JSON_MERGE_PATCH('{"a": 3, "b": 2}', '{"c": 3, "a": 4}', '{"c": 5, "d": 3}');
+------------------------------------------------------------------------------+
| JSON_MERGE_PATCH('{"a": 3, "b": 2}', '{"c": 3, "a": 4}', '{"c": 5, "d": 3}') |
+------------------------------------------------------------------------------+
| {"a": 4, "b": 2, "c": 5, "d": 3}                                             |
+------------------------------------------------------------------------------+
1 row in set (0.00 sec)

mysql> SELECT JSON_MERGE_PRESERVE('{"a": 3, "b": 2}', '{"c": 3, "a": 4}', '{"c": 5, "d": 3}');
+---------------------------------------------------------------------------------+
| JSON_MERGE_PRESERVE('{"a": 3, "b": 2}', '{"c": 3, "a": 4}', '{"c": 5, "d": 3}') |
+---------------------------------------------------------------------------------+
| {"a": [3, 4], "b": 2, "c": [3, 5], "d": 3}                                      |
+---------------------------------------------------------------------------------+
1 row in set (0.00 sec)
```

合并对象时，对重复键，`JSON_MERGE_PRESERVE`只保留最后传入的键值，而`JSON_MERGE_PRESERVE`重复键的所有值保留为数组。

#### 搜索和修改JSON值

在了解搜索和修改JSON值之前，先来看看JSON的路径语法。

##### 路径语法

- `.keyName`：JSON对象中键名为`keyName`的值；

- 对于不合法的键名（如有空格），在路径引用中必须用双引号`"`将键名括起来，例，`."key name"`；

- `[index]`：JSON数组中索引为`index`的值，JSON数组的索引同样从0开始；

- `[index1 to index2]`：JSON数组中从`index1`到`index2`的值的集合；

- `.*`: JSON对象中的所有`value`；

- `[*]`: JSON数组中的所有值；

- `prefix**suffix`: 以`prefix`开头并以`suffix`结尾的路径；

- `**.keyName`为多个路径，如对于JSON对象`'{"a": {"b": 1}, "c": {"b": 2}}'`,`'$**.b'`指路径`$.a.b`和`$.c.b`；

- 不存在的路径返回结果为NULL；

- 前导$字符表示当前正在使用的JSON文档

  示例：对于数组

  ```json
  [3, {"a": [5, 6], "b": 10}, [99, 100]]
  
  $[1]         为 {"a": [5, 6], "b": 10}
  [1].a        为 [5, 6]
  $[1].a[1]    为 6。
  $[1].b       为 10。
  $[2][0]      为 99。
  ```

##### 搜索

`JSON_EXTRACT`提取JSON值，直接看例子：

- JSON对象

```swift
mysql> SELECT JSON_EXTRACT('{"id": 29, "name": "Taylor"}', '$.name');
+--------------------------------------------------------+
| JSON_EXTRACT('{"id": 29, "name": "Taylor"}', '$.name') |
+--------------------------------------------------------+
| "Taylor"                                               |
+--------------------------------------------------------+
1 row in set (0.00 sec)

mysql> SELECT JSON_EXTRACT('{"id": 29, "name": "Taylor"}', '$.*');
+-----------------------------------------------------+
| JSON_EXTRACT('{"id": 29, "name": "Taylor"}', '$.*') |
+-----------------------------------------------------+
| [29, "Taylor"]                                      |
+-----------------------------------------------------+
1 row in set (0.00 sec)
```

- JSON数组

```swift
mysql> SELECT JSON_EXTRACT('["a", "b", "c"]', '$[1]');
+-----------------------------------------+
| JSON_EXTRACT('["a", "b", "c"]', '$[1]') |
+-----------------------------------------+
| "b"                                     |
+-----------------------------------------+
1 row in set (0.00 sec)

mysql> SELECT JSON_EXTRACT('["a", "b", "c"]', '$[1 to 2]');
+----------------------------------------------+
| JSON_EXTRACT('["a", "b", "c"]', '$[1 to 2]') |
+----------------------------------------------+
| ["b", "c"]                                   |
+----------------------------------------------+
1 row in set (0.00 sec)

mysql> SELECT JSON_EXTRACT('["a", "b", "c"]', '$[*]');
+-----------------------------------------+
| JSON_EXTRACT('["a", "b", "c"]', '$[*]') |
+-----------------------------------------+
| ["a", "b", "c"]                         |
+-----------------------------------------+
1 row in set (0.00 sec)
```

##### 修改

- `JSON_REPLACE` 替换值（只替换已经存在的旧值）
- `JSON_SET` 设置值（替换旧值，并插入不存在的新值）
- `JSON_INSERT` 插入值（插入新值，但不替换已经存在的旧值）
- `JSON_REMOVE` 删除JSON数据，删除指定值后的JSON文档

1. `JSON_REPLACE`与`JSON_SET`的区别：

```rust
// 旧值存在
mysql> SELECT JSON_REPLACE('{"id": 29, "name": "Taylor"}', '$.name', 'Mere');
+----------------------------------------------------------------+
| JSON_REPLACE('{"id": 29, "name": "Taylor"}', '$.name', 'Mere') |
+----------------------------------------------------------------+
| {"id": 29, "name": "Mere"}                                     |
+----------------------------------------------------------------+
1 row in set (0.00 sec)

mysql> SELECT JSON_SET('{"id": 29, "name": "Taylor"}', '$.name', "Mere");
+------------------------------------------------------------+
| JSON_SET('{"id": 29, "name": "Taylor"}', '$.name', 'Mere') |
+------------------------------------------------------------+
| {"id": 29, "name": "Mere"}                                 |
+------------------------------------------------------------+
1 row in set (0.00 sec)

// 旧值不存在
mysql> SELECT JSON_REPLACE('{"id": 29, "name": "Taylor"}', '$.cat', 'Mere');
+---------------------------------------------------------------+
| JSON_REPLACE('{"id": 29, "name": "Taylor"}', '$.cat', 'Mere') |
+---------------------------------------------------------------+
| {"id": 29, "name": "Taylor"}                                  |
+---------------------------------------------------------------+
1 row in set (0.00 sec)

mysql> SELECT JSON_SET('{"id": 29, "name": "Taylor"}', '$.cat', 'Mere');
+-----------------------------------------------------------+
| JSON_SET('{"id": 29, "name": "Taylor"}', '$.cat', 'Mere') |
+-----------------------------------------------------------+
| {"id": 29, "cat": "Mere", "name": "Taylor"}               |
+-----------------------------------------------------------+
1 row in set (0.00 sec)
```

2. `JSON_INSERT`和`JSON_SET`:

```csharp
// 旧值存在
mysql> SELECT JSON_INSERT('[1, 2, 3]', '$[1]', 4);
+-------------------------------------+
| JSON_INSERT('[1, 2, 3]', '$[1]', 4) |
+-------------------------------------+
| [1, 2, 3]                           |
+-------------------------------------+
1 row in set (0.00 sec)

mysql> SELECT JSON_SET('[1, 2, 3]', '$[1]', 4);
+----------------------------------+
| JSON_SET('[1, 2, 3]', '$[1]', 4) |
+----------------------------------+
| [1, 4, 3]                        |
+----------------------------------+
1 row in set (0.00 sec)

//旧值不存在
mysql> SELECT JSON_INSERT('[1, 2, 3]', '$[4]', 4);
+-------------------------------------+
| JSON_INSERT('[1, 2, 3]', '$[4]', 4) |
+-------------------------------------+
| [1, 2, 3, 4]                        |
+-------------------------------------+
1 row in set (0.00 sec)

mysql> SELECT JSON_SET('[1, 2, 3]', '$[4]', 4);
+----------------------------------+
| JSON_SET('[1, 2, 3]', '$[4]', 4) |
+----------------------------------+
| [1, 2, 3, 4]                     |
+----------------------------------+
1 row in set (0.00 sec)
```

3. `JSON_REMOVE`:

```bash
mysql> SELECT JSON_REMOVE('[1, 2, 3]', '$[1]');
+----------------------------------+
| JSON_REMOVE('[1, 2, 3]', '$[1]') |
+----------------------------------+
| [1, 3]                           |
+----------------------------------+
1 row in set (0.00 sec)

mysql> SELECT JSON_REMOVE('[1, 2, 3]', '$[4]');
+----------------------------------+
| JSON_REMOVE('[1, 2, 3]', '$[4]') |
+----------------------------------+
| [1, 2, 3]                        |
+----------------------------------+
1 row in set (0.00 sec)

mysql> SELECT JSON_REMOVE('{"id": 29, "name": "Taylor"}', '$.name');
+-------------------------------------------------------+
| JSON_REMOVE('{"id": 29, "name": "Taylor"}', '$.name') |
+-------------------------------------------------------+
| {"id": 29}                                            |
+-------------------------------------------------------+
1 row in set (0.00 sec)
```

#### JSON值的比较和排序

可以使用`=`，`<`，`<=`，`>`，`>=`，`<>`，`!=`，和 `<=>`对JSON值进行比较。

 JSON值的比较先比较值的类型。如果类型不同，则直接返回类型的优先级的比较结果；如果类型相同，再进行值的内容的比较。

- JSON中值的类型的优先级从高到低为：

```php
BLOB
BIT
OPAQUE
DATETIME
TIME
DATE
BOOLEAN
ARRAY
OBJECT
STRING
INTEGER, DOUBLE
NULL
```

`OPAQUE`值是不属于其他类型的值。

#### JSON内容比较规则

  - 任何JSON值与NULL比较的结果为`UNKOWN`

  - JSON值与非JSON值比较时，非JSON值会被转为JSON值

```css
  BLOB
  比较两个值的前N个字节，其中N为较短的值的字节数。前N个字节相同，则较短的值较小。BIT和OPAQUE与BLOB的规则相同。
  
  DATETIME
  较早时间点的值较小。两个值分别为 MySQL DATETIME and TIMESTAMP类型且表示的是相同的时间点，则这两个值相等。
  
  TIME
  较少的是时间值较小。
  
  DATE
  较早的日期值较小。
  
  ARRAY
  较短的数组较小。
  如果两个数组长度相同，且相同索引处的值相同，则两个数组相等。
  对于不行等的数组，它们的大小顺序由两数组中第一个不同的元素决定。
  [] < ["a"] < ["ab"] < ["ab", "cd", "ef"] < ["ab", "ef"]
  
  BOOLEAN
  `false` < `true`
  OBJECT
  具有完全相同的键值对的两对象相等。如
  {"a": 1, "b": 2} = {"b": 2, "a": 1}

  STRING
  与BLOB比较规则相似。区分大小写。
  "A"<"a" < "ab" < "b" < "bc"
  
  INTEGER， DOUBLE
  如果进行INTEGER列和DOUBLE列的比较，则integer数会被转为double数，即精确值转为近似值，再进行比较；
  如果查询比较包含数字的两个JSON列，则无法预知数字是INTEGER还是DOUBLE，比较时会将近似值转为精确值，在进行比较。
  
  INTEGER比较
  9223372036854775805 < 9223372036854775806 < 9223372036854775807
  
  DOUBLE比较
  9223372036854775805 = 9223372036854775806 = 9223372036854775807 = 9.223372036854776e18
```


### JSON值和非JSON值转换

转换规则为：

| other type                               | CAST(other type AS JSON)                                     | CAST(JSON AS other type)                                     |
| ---------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| JSON                                     | 没变化                                                       | 没变化                                                       |
| `utf8`字符类型(`utf8mb4`,`utf8`,`ascii`) | 字符串被解析为JSON值                                         | JSON值被序列化为`utf8mb4`字符串                              |
| 其他字符类型                             | 其他字符编码被隐式转换为`utf8mb4`，并按`utf8`字符类型进行处理 | JSON值被序列化为`utf8mb4`字符串，然后再被转换为其他字符编码。结果可能没有意义。 |
| NULL                                     | 结果为JSON类型的NULL值                                       | 不适用                                                       |
| Geometry类型                             | `ST_AsGeoJSON()`将Geometry值转换为JSON文档                   | 非法操作。解决办法: 将`CAST(JSON AS other type)`的结果传递给`CHAR)ST_GeomFromGeoJSON()` |
| 所有其他类型                             | 转换结果是由单个标量值组成的JSON文档                         | 如果JSON文档由目标类型的单个标量值组成，并且标量值可以强制转换为目标类型，则成功转换。否则，返回NULL 并发出警告。 |

# 索引

## 简介

> 拿汉语字典的目录页（索引）打比方，我们可以按拼音、笔画、偏旁部首等排序的目录（索引）快速查找到需要的字。
>
> **创建索引时，你需要确保该索引是应用在 SQL 查询语句的条件(一般作为 WHERE 子句的条件)。**
>
> 实际上，索引也是一张表，该表保存了主键与索引字段，并指向实体表的记录。
>
> 索引分为：聚簇索引和非聚簇索引两种，聚簇索引是按照数据存放的物理位置为顺序的，而非聚簇索引就不一样了；聚簇索引能提高多行检索的速度，而非聚簇索引对于单行的检索很快
>
> 索引分为：单列索引和组合索引 ----- 单列索引：一个索引只包含单个列；组合索引：一个索引包含多个列。

- 优点：

  1、索引可以大大提高MySQL的检索速度

- 缺点：

  1、虽然索引大大提高了查询速度，同时却会降低更新表的速度，如对表进行INSERT、UPDATE和DELETE。因为更新表时，MySQL不仅要保存数据，还要保存一下索引文件。

  2、建立索引会占用磁盘空间的索引文件。

## BTREE&HASH

### BTREE

![25D0B4DD-EE84-4DF1-9764-3E3B0D827C80](https://tva1.sinaimg.cn/large/007S8ZIlly1girnc7d4b7j31vg0pib0m.jpg)

从上图可以看出：

> （1）所有关键字都出现在叶子结点的链表中（稠密索引），且链表中的关键字恰好是有序的
>
> （2）非叶子结点存储的是叶子结点的索引（稀疏索引），叶子结点存储的是关键字和数据
>
> （3）非叶子结点不能存数据
>
> （4）顺序存储，每一个叶子节点到根结点的距离是相同的
>
> （5）根节点横向也有链指针
>
> 可以用Btree索引进行全关键字、关键字范围和关键字前缀查询。如果使用索引，必须保证按索引最左边前缀进行查询。由于Btree中节点是顺序存储的，可以对查询结果进行order by。

限制：

> （1）查询必须从索引的最左边的列开始
>
> （2）不能跳过某一索引列。
>
> （3）存储引擎不能使用索引中范围条件右边的列。
>
>  例如，如果你的查询语句为WHERE last_name=”Smith” AND first_name LIKE ‘J%’ AND dob=’1976-12-23’，则该查询只会使用索引中的前两列，因为LIKE是范围查询。

### HASH

![image-20200915212626145](https://tva1.sinaimg.cn/large/007S8ZIlly1girnmlt77xj310c0lyttq.jpg)

简单地说，哈希索引就是采用一定的哈希算法，把键值换算成新的哈希值，检索时不需要类似B+树那样从根节点到叶子节点逐级查找，只需一次哈希算法即可立刻定位到相应的位置，速度非常快。

### 区别

从上面的图来看，Btree索引和Hash索引的明显区别是：

> （1）如果是等值查询，那么哈希索引明显有绝对优势，因为只需要经过一次算法即可找到相应的键值；当然了，这个前提是，键值都是唯一的。如果键值不是唯一的，就需要先找到该键所在位置，然后再根据链表往后扫描，直到找到相应的数据；
>
>  （2）从示意图中也能看到，如果是范围查询检索，这时候哈希索引就毫无用武之地了，因为原先是有序的键值，经过哈希算法后，有可能变成不连续的了，就没办法再利用索引完成范围查询检索；
>
> 同理，哈希索引也没办法利用索引完成排序，以及like ‘xxx%’ 这样的部分模糊查询（这种部分模糊查询，其实本质上也是范围查询）；
>
>  （3）哈希索引也不支持多列联合索引的最左匹配规则；
>
>  （4）Btree的关键字检索效率比较平均，不像Hash那样波动幅度大，在有大量重复键值情况下，哈希索引的效率也是极低的，因为存在所谓的哈希碰撞问题。

## key和index

mysql的key和index多少有点令人迷惑，这实际上考察对数据库体系结构的了解的

### key 

是数据库的物理结构

它包含两层意义，一是约束（偏重于约束和规范数据库的结构完整性），二是索引（辅助查询用的）。包括primary key, unique key, foreign key 等。

- primary key 有两个作用，一是约束作用（constraint），用来规范一个存储主键和唯一性，但同时也在此key上建立了一个index；

- unique key 也有两个作用，一是约束作用（constraint），规范数据的唯一性，但同时也在这个key上建立了一个index；

-  foreign key也有两个作用，一是约束作用（constraint），规范数据的引用完整性，但同时也在这个key上建立了一个index；

   可见，mysql的key是同时具有constraint和index的意义，这点和其他数据库表现的可能有区别。（至少在[Oracle](http://lib.csdn.net/base/oracle)上建立外键，不会自动建立index），因此创建key也有如下几种方式：

  （1）在字段级以key方式建立， 如 `create table t (id int not null primary key);`

  （2）在表级以constraint方式建立，如`create table t(id int, CONSTRAINT pk_t_id PRIMARY key (id));`

  （3）在表级以key方式建立，如`create table t(id int, primary key (id));`

   其它key创建类似，但不管那种方式，既建立了constraint，又建立了index，只不过index使用的就是这个constraint或key。

### index

是数据库的物理结构

它只是辅助查询的，它创建时会在另外的表空间（mysql中的innodb表空间）以一个类似目录的结构存储。索引要分类的话，分为前缀索引、全文本索引等；

 因此，索引只是索引，它不会去约束索引的字段的行为（那是key要做的事情）。

 如：`create table t(id int, index inx_tx_id (id));`

### 疑问

(1).我们说索引分类，分为主键索引、唯一索引、普通索引(这才是纯粹的index)等，也是基于是不是把index看作了key。

比如 `create table t(id int, unique index inx_tx_id  (id));  --index当作了key使用`

(2).最重要的也就是，不管如何描述，理解index是纯粹的index，还是被当作key，当作key时则会有两种意义或起两种作用。

## Key索引

### 唯一索引

- 与普通索引类似，不同的就是：索引列的值必须唯一，但允许有空值（注意和主键不同）。

- 如果是组合索引，则列值的组合必须唯一，创建方法和普通索引类似。

- 如果能确定某个数据列将只包含彼此各不相同的值，为这个数据列创建索引的时候就应该用UNIQUE把它定义为一个唯一索引。

  > 这么做的**好处**：
  >
  > 一是简化了MySQL对这个索引的管理工作，这个索引也因此而变得更有效率；
  >
  > 二是MySQL会在有新记录插入数据表时，自动检查新记录的这个字段的值是否已经在某个记录的这个字段里出现过了；如果是，MySQL将拒绝插入那条新记录。也就是说，唯一索引可以保证数据记录的唯一性。
  >
  > 事实上，在许多场合，人们创建唯一索引的目的往往不是为了提高访问速度，而只是为了避免数据出现重复。 

```sql
-- 创建唯一索引  
CREATE UNIQUE INDEX index_name ON table_name(column_name)  
-- 修改表结构  
ALTER TABLE table_name ADD UNIQUE index_name ON (column_name)  
-- 创建表的时候直接指定  
CREATE TABLE `table_name` (  
`id` int(11) NOT NULL AUTO_INCREMENT ,  
`title` char(255) NOT NULL ,  
PRIMARY KEY (`id`),  
UNIQUE index_name (title)  
);  
```

### 主键索引

必须为主键字段创建一个索引，这个索引就是所谓的"主索引"。主索引与唯一索引的唯一区别是：前者在定义时使用的关键字是PRIMARY而不是UNIQUE。 

### 外键索引

　　如果为某个外键字段定义了一个外键约束条件，MySQL就会定义一个内部索引来帮助自己以最有效率的方式去管理和使用外键约束条件。 

## Index索引

### 普通索（NORMAL）

- 普通索引(由关键字KEY或INDEX定义的索引)的唯一任务是加快对数据的访问速度。

- 因此，应该只为那些最经常出现在查询条件(WHERE column = ...)或排序条件(ORDER BY column)中的数据列创建索引。

- 只要有可能，就应该选择一个数据最整齐、最紧凑的数据列(如一个整数类型的数据列)来创建索引。 

```sql
-- 直接创建索引(length表示使用名称前1ength个字符)  
CREATE INDEX index_name ON table_name(column_name(length))  
-- 修改表结构的方式添加索引  
ALTER TABLE table_name ADD INDEX index_name ON (column_name)  
-- 创建表的时候同时创建索引  
CREATE TABLE `table_name` (  
`id` int(11) NOT NULL AUTO_INCREMENT ,  
`title` char(255) NOT NULL ,  
PRIMARY KEY (`id`),  
INDEX index_name (title)  
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;  
-- 删除索引  
DROP INDEX index_name ON table_name;  
-- 建立复合索引
CREATE INDEX mytable_categoryid_userid ON mytable (category_id,user_id);  

-- #注意命名时的习惯了吗？使用"表名_字段1名_字段2名"的方式     
```

### 全文索引（FULLTEXT）

全文索引可以从CHAR、VARCHAR或TEXT列中作为CREATE TABLE语句的一部分被创建，或是随后使用ALTER TABLE 或CREATE INDEX被添加。

对于较大的数据集，将你的资料输入一个没有FULLTEXT索引的表中，然后创建索引，其速度比把资料输入现有FULLTEXT索引的速度更为快。不过切记对于大容量的数据表，生成全文索引是一个非常消耗时间非常消耗硬盘空间的做法。

 普通索引只能加快对出现在字段内容最前面的字符串(也就是字段内容开头的字符)进行检索操作。如果字段里存放的是由几个、甚至是多个单词构成的较大段文字，普通索引就没什么作用了。这种检索往往以LIKE %word%的形式出现，这对MySQL来说很复杂，如果需要处理的数据量很大，响应时间就会很长。 

这类场合正是全文索引(full-text index)可以大显身手的地方。在生成这种类型的索引时，MySQL将把在文本中出现的所有单词创建为一份清单，查询操作将根据这份清单去检索有关的数据记录。

```sql
-- 创建索引  
CREATE TABLE article (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    title VARCHAR(200),
    body TEXT,
    FULLTEXT(title, body)
) ;

ALTER TABLE table_name ADD FULLTEXT(column1, column2) 
```

有了全文索引，就可以用SELECT查询命令去检索包含着一个或多个给定单词的数据记录了。下面是这类查询命令的基本语法：　

```sql
-- 上把column1和column2字段里有word1、word2和word3的数据记录全部查询出来
SELECT * FROM table_name WHERE MATCH(column1, column2) AGAINST('word1', 'word2', 'word3') 
```

### SPATIAL 索引

SPATIAL 索引（空间索引）是对空间数据类型的字段建立的索引，MYSQL中的空间数据类型有4种，分别是GEOMETRY、POINT、LINESTRING、POLYGON。MYSQL使用SPATIAL关键字进行扩展，使得能够用于创建正规索引类型的语法创建空间索引。创建空间索引的列，必须将其声明为NOT NULL，空间索引只能在存储引擎为MYISAM的表中创建

```sql
CREATE TABLE tb_geo(
id INT PRIMARY KEY AUTO_INCREMENT,
NAME VARCHAR(128) NOT NULL,
pnt POINT NOT NULL,
SPATIAL INDEX `spatIdx` (`pnt`)
)
```

补充：空间数据类型（几何数据类型）

**Geometry**：

> geometry是所有此扩展中类型得基类，其他类型如Point,LineString,Polygon都是Geometry的子类。Geometry有一些属性，这些属性是所有其他几何类的共有属性：
>
> - type: 类型（Point, LineString,...）
> - SRID: 该值确定了用于描述定义几何对象的坐标空间的空间坐标系统
> - coordinates: 坐标值
> - interior, boundary, exterior: interior是几何对象所展空间的部分，boundary是几何对象的边界，exterior是几何对象未占有的空间。
> - MBR: 能够覆盖几何对象的最小矩形，可以想象成信封，它由几何对象中最大最小的坐标值组合而成：((MINX MINY, MAXX MINY, MAXX MAXY, MINX MAXY, MINX MINY))
> - simple/nonsimple: 几何对象是否简单
> - closed/not closed: 几何对象是否封闭
> - dimension: 维度数（Point: 0, LineString: 1, Polygon: 2）

**Point**: 顾名思义就是点，有一个坐标值，没有长度、面积、边界。

**LineString**: 线，由一系列点连接而成。

- 如果线从头至尾没有交叉，那就是简单的（simple）

- 如果起点和终点重叠，那就是封闭的（closed）

**Polygon**:多边形。可以是一个实心平面形，即没有内部边界，也可以有空洞，类似纽扣。

## 索引组合

### 单列索引、多列索引

  多个单列索引与单个多列索引的查询效果不同，因为执行查询时，MySQL只能使用一个索引，会从多个索引中选择一个限制最为严格的索引。

### 组合(复合)索引（最左前缀）

  平时用的SQL查询语句一般都有比较多的限制条件，所以为了进一步榨取MySQL的效率，就要考虑建立组合索引。例如上表中针对title和time建立一个组合索引：ALTER TABLE article ADD INDEX index_titme_time (title(50),time(10))。建立这样的组合索引，其实是相当于分别建立了下面两组组合索引：

> title,time
>
> title

为什么没有time这样的组合索引呢？**这是因为MySQL组合索引“最左前缀”的结果。简单的理解就是只从最左面的开始组合**。并不是只要包含这两列的查询都会用到该组合索引，如下面的几个SQL所示：

```sql
-- 使用到上面的索引

SELECT * FROM article WHREE title='测试' AND time=1234567890;
SELECT * FROM article WHREE title='测试';

-- 不使用上面的索引

SELECT * FROM article WHREE time=1234567890;
```

# 伪列&虚拟列

## 伪列

- 概念

> ORACLE中的概念，ROWNUM像一个隐藏的字段。记录的是行数。
>
> SELECT ROWNUM,A.* FROM TABLE A 就出来了
>
> 般情况下分页的时候是需要的关键字：
>
> MySQL中是limit关键字，MSSQL中是top关键字，Oracle中则是rownum。还有rownum < 5就只能查出5条数据，从0开始的。

- mysql实现伪列

```sql
SELECT @rownum:=@rownum+1 AS rownum, t_s_base_user.* FROM (SELECT @rownum:=0) r, t_s_base_user
```

**但是程序会报错“Parameter '@rownum' must be defined.”**

这时在配置文件数据库链接串后面加上“Allow User Variables=True”

```xml
<!--mysql连接字符串-->  
<conmectionStrings>
  <add key="MySqlConn" value="Server=192.168.1.238;DataBase=gm;Uid=root;Pwd=000000;Allow User Variables=True;"/>
</conmectionStrings>
```

或者：jdbc:mysql://localhost:3306/DBS?Allow User Variables=True

##虚拟列

- Generated Column

在MySQL 5.7中，支持两种Generated Column，即Virtual Generated Column和Stored Generated Column，前者只将Generated Column保存在数据字典中（表的元数据），并不会将这一列数据持久化到磁盘上；后者会将Generated Column持久化到磁盘上，而不是每次读取的时候计算所得。很明显，后者存放了可以通过已有数据计算而得的数据，需要更多的磁盘空间，与Virtual Column相比并没有优势，因此，MySQL 5.7中，不指定Generated Column的类型，默认是Virtual Column。

综上，一般情况下，都使用Virtual Generated Column，这也是MySQL默认的方式 

- 虚拟列使用

**语法：**

<type> [ GENERATED ALWAYS ] AS ( <expression> ) [ VIRTUAL|STORED ]
[ UNIQUE [KEY] ] [ [PRIMARY] KEY ] [ NOT NULL ] [ COMMENT <text> ] 

**应用：**

为了实现对json数据中部分数据的索引查询，可以使用MySQL5.7中的虚拟列（virtual column）功能

创建表

```sql
create table user(uid int auto_increment,data json,primary key(uid));
```

构建数据

```sql
insert into user values (NULL,'{"name":"wang","address":"shenyang"}');
insert into user values (NULL,'{"name":"zhao","address":"riben"}');
```

 ![img](https://tva1.sinaimg.cn/large/007S8ZIlly1gir9xar7ngj30ay0320si.jpg)

构建姓名的虚拟列

```sql
alter table user add user_name varchar(20) generated always as (data->'$.name');
```

![img](https://tva1.sinaimg.cn/large/007S8ZIlly1gira05fvc8j30fr03i743.jpg)

构建索引

```sql
alter table user add index idx_name(user_name);
```

 查询

```sql
select * from user where user_name='"wang"';
```

查询分析（explain  ……  \G）

![img](https://tva1.sinaimg.cn/large/007S8ZIlly1gira142czlj30ds06qdfo.jpg)

可以看出用了索引了

注意：

此时的表的结构由于多出了user_name这一虚拟列，再插入数据要注意在表后指明插入列（不能给虚拟列插入数据）

```sql
insert into user(uid,data) values (NULL,'{"name":"pan","address":"sichuan"}');
```

# for update

## 简介

for update是在数据库中上锁用的，可以为数据库中的行上一个排它锁。当一个事务的操作未完成时候，其他事务可以读取但是不能写入或更新。

- 使用场景

> 如果遇到存在高并发并且对于数据的准确性很有要求的场景，是需要了解和使用for update的。
>
> 比如涉及到金钱、库存等。一般这些操作都是很长一串并且是开启事务的。如果库存刚开始读的时候是1，而立马另一个进程进行了update将库存更新为0了，而事务还没有结束，会将错的数据一直执行下去，就会有问题。所以需要for upate 进行数据加锁防止高并发时候数据出错。

**记住一个原则：一锁二判三更新**

## 使用

```
select * from table where xxx for update
```

### 锁表级别

InnoDB默认是行级别的锁，当有明确指定的主键时候，是行级锁。否则是表级别。

例子: 假设表foods ，存在有id跟name、status三个字段，id是主键，status有索引。

例1: (明确指定主键，并且有此记录，行级锁)

```
SELECT * FROM foods WHERE id=1 FOR UPDATE;
SELECT * FROM foods WHERE id=1 and name=’咖啡色的羊驼’ FOR UPDATE;
```

例2: (明确指定主键/索引，若查无此记录，无锁)

```
SELECT * FROM foods WHERE id=-1 FOR UPDATE;
```

例3: (无主键/索引，表级锁)

```
SELECT * FROM foods WHERE name=’咖啡色的羊驼’ FOR UPDATE;
```

例4: (主键/索引不明确，表级锁)

```
SELECT * FROM foods WHERE id<>’3’ FOR UPDATE;
SELECT * FROM foods WHERE id LIKE ‘3’ FOR UPDATE;
```

### 注意

1.for update 仅适用于InnoDB，并且必须开启事务，在begin与commit之间才生效。

2.要测试for update的锁表情况，可以利用MySQL的Command Mode，开启二个视窗来做测试。

### 疑问点

1.当开启一个事务进行for update的时候，另一个事务也有for update的时候会一直等着，直到第一个事务结束吗？

```
答：会的。除非第一个事务commit或者rollback或者断开连接，第二个事务会立马拿到锁进行后面操作。
```

2.如果没查到记录会锁表吗？

```
答：会的。表级锁时，不管是否查询到记录，都会锁定表。
```

3.select for update后，其他事务还能读吗？

```
答：Innodb引擎，select ... for update后，对所在行加了互斥锁，而你使用select ...在Innodb里是快照读，是不涉及到锁的问题的，如果想要验证加锁是否成功，需要对查询加共享锁 lock in share mode或互斥锁for update
```

### for update 和 for update nowait区别

1.前者阻塞其他事务，后者拒绝其他事务

2.for update锁住表或者锁住行，只允许当前事务进行操作（读写），其他事务被阻塞（可以读），直到当前事务提交或者回滚，被阻塞的事务自动执行

3.for update nowait 锁住表或者锁住行，只允许当前事务进行操作（读写），其他事务被拒绝（可用度），事务占据的statement连接也会被断开

## 互斥锁

在编程中，引入了对象*互斥锁*的概念，来保证共享数据操作的完整性。每个对象都对应于一个可称为" *互斥锁*" 的标记，这个标记用来保证在任一时刻，只能有一个线程访问该对象。

互斥锁是互斥标志。它充当一段代码的网守，允许一个线程进入并阻止所有其他线程的访问。这样可以确保被控制的代码一次只能被单个线程访问。只要确保完成后释放互斥量即可。

# explain

explain（执行计划），使用explain关键字可以模拟优化器执行sql查询语句，从而知道MySQL是如何处理sql语句。

explain主要用于分析查询语句或表结构的性能瓶颈。

## explain作用
通过explain+sql句可以知道如下内容:

1、表的读取顺序。(对应id)

2、数据读取操作的操作类型。(对应select type)

3、哪些索引可以使用。(对应possible-keys)

4、哪些索引被实际使用。(对应key)

5、表直接的引用。(对应ref)

6、每张表有多少行被优化器查询。(对应rows)

## explain表头

### id

id的值表示select子句或表的执行顺序, id相同,执行顺序从上到下, id不同,值越大的执行优先级越高。

### select_type

查询的类型，主要用于区别普通查询、联合查询、子查询等复杂的查询。其值主要有六个：

```css
SIMPLE
简单的select查询，查询中不包含子查询或union查询。

PRIMARY
查询中若包含任何复杂的子部分，最外层查询为PRIMARY，也就是最后加载的就是PRIMARY。

SUBQUERY
在select或where列表中包含了子查询，就为被标记为SUBQUERY。

DERIVED
在from列表中包含的子查询会被标记为DERIVED(衍生)，MySQL会递归执行这些子查询，将结果放在临时表中。

UNION
若第二个select出现在union后，则被标记为UNION，若union包含在from子句的子查询中，外层select将被标记为DERIVED。

UNION RESULT
从union表获取结果的select。
```

### table

显示sql操作属于哪张表的。

### partitions

官方定义为The matching partitions（匹配的分区），该字段是看table所在的分区。值为NULL表示表未被分区。

### type

表示查询所使用的访问类型，type的值主要有八种，该值表示查询的sql语句好坏，从最好到最差依次为：

```css
system > const > eq_ref > ref > range > index > ALL
```

### possible_keys、key、key_len

> possible_keys：
>
> ```
> 显示可能应用在表中的索引，可能一个或多个。查询涉及到的字段若存在索引，则该索引将被列出，但不一定被查询实际使用。
> ```
>
> key：
>
> ```
> 实际中使用的索引，如为NULL，则表示未使用索引。若查询中使用了覆盖索引，则该索引和查询的select字段重叠。
> ```
>
> key_len：
>
> ```
> 表示索引中所使用的字节数，可通过该列计算查询中使用的索引长度。在不损失精确性的情况下，长度越短越好。key_len显示的值为索引字段的最大可能长度，并非实际使用长度，即key_len是根据表定义计算而得，并不是通过表内检索出的。比如说，对于一个INTEGER数据列的索引，这个字节长度将是4。如果用到了复合索引，在key_len数据列里还可以看到MySQL具体使用了它的哪些部分。
> ```
>
> 简单理解：
>
> possible_keys表示理论上可能用到的索引，key表示实际中使用的索引。
>
> 示例：
>
> ①possible_keys为NULL表示可能未用到索引，但key=idx_deptid表示在实际查询的过程中进行了索引的全扫描。
>
> ②理解key_len:
>
> 首先为name字段创建索引：
>
> ```
> create index idx_name on tb_emp(name);
> ```
> ​	![image-20200913185918485](https://tva1.sinaimg.cn/large/007S8ZIlly1gip84zbqtej31y60ii104.jpg)
>
> 注：在使用索引查询时，当条件越精确，key_len的长度可能会越长，所以在不影响结果的情况下，key_len的值越短越好。
>

### ref

> 显示关联的字段。如果使用常数等值查询，则显示const，如果是连接查询，则会显示关联的字段。
>
> ![img](https://tva1.sinaimg.cn/large/007S8ZIlly1gip877e4dej31fn062q3h.jpg)
>

### rows

根据表统计信息及索引选用情况大致估算出找到所需记录所要读取的行数。当然该值越小越好。

### filtered

百分比值，表示存储引擎返回的数据经过滤后，剩下多少满足查询条件记录数量的比例。

### Extra

> 显示十分重要的额外信息。其取值有以下几个：
>
> \#1.Using filesort
>
> Using filesort表明mysql会对数据使用一个外部的索引排序，而不是按照表内的索引顺序进行读取。
>
> mysql中无法利用索引完成的排序操作称为“文件排序”。
>
> 出现Using filesort就非常危险了，在数据量非常大的时候几乎“九死一生”。出现Using filesort尽快优化sql语句。
>
> deptname字段未建索引的情况。
>
> ![img](https://tva1.sinaimg.cn/large/007S8ZIlly1gip8d4vx5fj31d505u0t4.jpg)
>
> 为deptname字段创建索引后。
>
> ![img](https://tva1.sinaimg.cn/large/007S8ZIlly1gip8ednmmpj31ff09aadu.jpg)
>
> \#2.Using temporary
>
> 使用了临时表保存中间结果，常见于排序order by和分组查询group by。非常危险，“十死无生”，急需优化。
>
> 将tb_emp中name的索引先删除，出现如下图结果，非常烂，Using filesort和Using temporary，“十死无生”。
>
> ![img](https://tva1.sinaimg.cn/large/007S8ZIlly1gip8elazayj31ff05ggly.jpg)
>
> 为name字段创建索引后。
>
> ![img](https://tva1.sinaimg.cn/large/007S8ZIlly1gip8eo3ivmj318k07zjs0.jpg)
>
> \#3.Using index
>
> 表明相应的select操作中使用了覆盖索引，避免访问表的额外数据行，效率不错。
>
> 如果同时出现了Using where，表明索引被用来执行索引键值的查找。（where deptid=1）
>
> 如果没有同时出现Using where，表明索引用来读取数据而非执行查找动作。
>
> 删除tb_emp表中name和deptid字段的单独索引，创建复合索引。
>
> ![img](https://images2018.cnblogs.com/blog/706569/201806/706569-20180622162414976-876933935.png)
>
>  **从这里给出覆盖索引的定义：select的数据列只从索引中就能取得数据，不必读取数据行。通过上面的例子理解：创建了（name，deptid）的复合索引，查询的时候也使用复合索引或部分，这就形成了覆盖索引。简记：查询使用复合索引，并且查询的列就是索引列，不能多，个数需对应。**
>
> **使用优先级Using index > Using filesort（九死一生）> Using temporary（十死无生）。也就说出现后面两项表明sql语句是非常烂的，急需优化！！！**

## 总结
explain（执行计划）包含的信息十分的丰富，着重关注以下几个字段信息。

```css
①id，select子句或表执行顺序，id相同，从上到下执行，id不同，id值越大，执行优先级越高。

②type，type主要取值及其表示sql的好坏程度（由好到差排序）：

system>const>eq_ref>ref>range>index>ALL。保证range，最好到ref。

③key，实际被使用的索引列。

④ref，关联的字段，常量等值查询，显示为const，如果为连接查询，显示关联的字段。

⑤Extra，额外信息，使用优先级Using index>Using filesort（九死一生）>Using temporary（十死无生）。
```

着重关注上述五个字段信息，对日常生产过程中调优十分有用。

# 表分区

## 概念

- 什么是表分区?

> 通俗地讲表分区是将一个大表,根据条件分割成若干个小表。mysql5.1开始支持数据表分区。
>
> 如:某用户表的记录超过了600万条仓储信息,那么就可以根据入库日期将表分区,也可以根据所在地将表分区。当然也可根据其他的条件分区。

- 为什么要对表进行分区？

> 为了改善大型表以及具有各种访问模式的表的可伸缩性,可管理性和提高数据库效率。
>
> 分区的一些优点包括：
>
> 1、与单个磁盘或文件系统分区相比,可以存储更多的数据。
>
> 2、通过删除与增加那些数据有关的分区,很容易地删除或增加那些数据。
>
> 3、一些查询可以得到极大的优化。
>
> 4、通过跨多个磁盘甚至服务器来分散数据查询,来获得更大的查询吞吐量。
>
> 5、MySQL5.5之后支持所有函数的分区优化。限定只查指定的分区。
>
> ​		`select count(*) from employees where gender='F';`
>
> ​		如：根据男女分区，where之后的语句可以省略

- 基本分区类型

> 1. RANGE分区:
>
> 基于属于一个给定连续区间的列值,把多行分配给分区。
>
> 2. LIST分区：
>
> 类似于按RANGE分区,区别在于LIST分区是基于列值匹配一个离散值集合中的某个值来进行选择。
>
> 3. HASH分区:
>
> 根据haash运算进行分区
>
> 基于用户定义的表达式的返回值来进行选择的分区,该表达式使用将要插入到表中的这些行的列值进行计算。这个函数可以包含MysQLR有效的、产生非负整数值的任何表达式。
>
> 4. KEY分区：
>
> *类似于按HASH分区,区别在于KEY分区只支持计算一列*或多列,且MySQL服务器提供其自身的哈希函数。必须有一列或多列包含整数值。

## 创建分区

### 表存储

.frm表结构文件

.par（partition）分区信息文件

p01.ibd 数据的表空间文件

> 从frm读取表结构定义，然后从par读取分区定义、定位到我们要读取的那个分区ibd，找子分区的时候定为要找哪个子分区，从子分区的isl文件知道子分区的文件目录

```shell
cd /var/Lib/mysql/tube/

ls
# b.opt t1.frm ti.par t1#P#pol.ibd t1#P#p02.ibd t1#P#p03.ibd t1P#p04.ibd  
# t5.frm  t5.par  t5#P#p01#SP#s0.isl

file t1.par  
# t1.par: data

cat t5#P#p01#SP#s0.isl
# /var/a/data/tube/t5#P#p01#SP#se.ibd
```

### RANGE分区

> 基于属于一个给定连续区间的列值,把多行分配给分区。
>
> 这些区间要连续且不能相互重叠,使用VALUES LESSTHAN操作符来进行定义。

```sql
ALTER TABLE titles
partition by range (year(from_date))
partition p01 values less than (1985), partition p02 values less than (1986), partition p03 values less than (1987), partition p04 values less than (1988), partition p15 values less than (1999), partition p16 values less than (MAXVALUE)
);
```

```sql
案例：

在创建表的过程中也可以直接创建分区。例如:将用户表按照年龄每隔10岁进行分区。
注意!分区的名字基本上遵循其他MySQL标识符应当遵循的原则,例如用于表和数据库名字的标识符。但是应当注意,分区的名字是不区分大小写的。

mysgl> create table t1 ( id int,name varchar(20),age int) 
-> partition by range (age)
->(
-> partition p01 values less than (10),
-> partition p02 values less than (20),
-> partition p03 values less than (30),
-> partition p04 values less than (maxvalue)
-> );

-- 注意：
-- 小于10不包括10
-- 分区名称不包括大小写
```

### LIST分区

```sql
案例：

对于一个综合性的网店来说,商品分为诸多种类。我们可以按照商品DD进行range分区,也可以按照商品的类型划分分区。在这个例子中, LIST分区给了我们更多的选择。

mysql> create table t2 (id int,cid int,name varchar(20),pos_date datetime)
-> partition by list (cid)
->(
-> partition p01 values in (1,2,3),
-> partition p02 values in (4,5,6),
-> partition p03 values in (7,8,9)
->);
```

### HASH分区

```sql
案例：

另外,在MySQL Cluster中,分区行为是自动的。默认情况下,分区的数量和ndb node数量相同。通常在节点数很多的情况下,会通过配置分区数和node group搭配进行调整。

mysql> create table t2 (id int,cid int,name varchar(20),pos_date datetime) 
-> partition by hash (cid)
-> partitions 4;  -- 分成4个分区
```

### LINEAR HASH分区

> 线性与常规哈希的区别在于,线性哈希功能使用的一个线性的2的幕( powers-of-two )运算法则,而常规哈希使用的是求哈希函数值的模数。按照线性哈希分区的优点在于增加、删除、合并和拆分分区将变得更加快捷,有利于处理含有极其大量(1T)数据的表。
>
> 不过, MySQL的线性哈希算法导致相比较常规哈希,数据可能分布的不那么均衡,容易产生"hotspot nodes"--有的分区被频繁使用，有的很少使用
>
> 和hash算法不同
> 缺陷：数据分布可能不均匀，有的多有的少；有的分区经常被用到，有的不经常用

```sql
案例：

线性哈希分区和常规哈希分区在语法上的唯一区别在于，在"PARTITION BY"子句中添加"LINEAR"关键字。
mysql> create table t2 (id int,cid int,name varchar(20),pos_date datetime) 
-> partition by,linear hash (cid)
-> partitions 4;
```

KEY分区

> 不常用
>
> 按照KEY进行分区类似于按照HASH分区,除了HASH分区使用的用户定义的表达式,而KEY分区的哈希函数是由MysQL服务器提供。MysQL簇( Cluster )使用函数MD5()来实现KEY分区;对于使用其他存储引擎的表,服务器使用其自己内部的哈希函数,这些函数是基于与PASSWORD()一样的运算法则。

```sql
mysgl> create table t2 (id int,cid int,name varchar(20),pos_date datetime) 
-> partition by linear key (cid)
-> partitions 4;
```

### 多列分区

> mysql5.5之后引入
>
> COLUMNS关键字允许字符串和日期列作为分区定义列,同时还允许使用多个列定义一个分区。

```sql
mysql> create table t3 (a int,b int,c int)
-> partition by range columns(a,b)
->(
-> partition po1 values less than (10,10)
-> partition p02 values less than (10,20)
-> partition p03 values less than (10,30)
-> partition p04 values less than (10,maxvalue),
-> partition p05 values less than (maxvalue,maxvalue) ->);
```

```sql
案例：

第一个分区用来存储雇佣于1990年以前的女职员,第二个分区存储股用于1990-2000年之间的女职员,第三个分区存储所有剩下的女职员。对于分区p04到p06,我们策略是一样的,只不过存储的是男职员。最后一个分区是控制情况。
mysgl> create table employees (emp_no int,birth date date, first_name
varchar(20),last_name varchar(20),gender char(1),hire_date date)engine=myisam
-> partition by range columns(gender,hire date) 
->( partition p01 values less than ('F','1990-01-01'),
-> partition p02 values less than ('F','2000-01-01'), 
-> partition p03 values less than ('F',maxvalue),
-> partition p04 values less than ('M','1990-01-01'), 
-> partition p05 values less than ('M','2000-01-01'), 
-> partition p06 values less than ('M',maxvalue),
-> partition p07 values less than (maxvalue,maxvalue));
```

### 子分区

> 子分区是分区表中每个分区的再次分割。
>
> 子分区可以用于特别大的表,在多个磁盘间分配数据和索引。

```sql
mysql> CREATE TABLE t5 (id INT, udate DATE) >PARTITION BY RANGE(YEAR(udate)) 
->SUBPARTITION BY HASH(TO DAYS(udate))
-> SUBPARTITIONS 2
->(
-> PARTITION pO VALUES LESS THAN (1990).
-> PARTITION p1 VALUES LESS THAN (2000), ->PARTITION p2 VALUES LESS THAN MAXVALUE ->)；
```

```sql
案例:

将每个子分区保存在不同的存储上,优化10性能。

mysql> CREATE TABLE ts (id INT, udate DATE) 
->PARTITION BY RANGE(YEAR(udate))   -- year函数提取date的年份
->SUBPARTITION BY HASH(TO DAYS(udate)).
-> (PARTITION p0 VALUES LESS THAN (1990) ->(
->SUBPARTITION s0
-> DATA DIRECTORY ='/diskO/data' 
->INDEX DIRECTORY = '/diskO/idx', 
->SUBPARTITION s1
->DATA DIRECTORY ='/disk1/data' 
->INDEX DIRECTORY =/disk1/idx
->)
```

- **子分区语法要求**

> 每个分区必须有相同数量的子分区。
>
> 如果在一个分区表上的任何分区上使用SUBPARTITION来明确定义任何子分区,那么就必须定义所有的子分区。

换句话说,下面的语句将执行失败:

```sql
mysql> create table t5 (id int,udate date) -> partition by range (year(udate)
-> subpartition by hash (to days(udate)) ->(
-> partition p01 values less than (1990)
-> (subpartition so,subpartition s1),
-> partition p02 values less than (2000)
-> (subpartition s2,subpartition s3),
-> partition p03 values less than (maxvalue) 
->);
```

## 管理分区

> 增加、删除、修改分区

### 简单修改分区

下面这个例子使用ALTER语句简单修改了分区。效果和先删除原表再按新的分区方式重新建表效果相同。

按照使用id列值作为键的基础,通过KEY分区把它重新分成两个分区。

> 生产环境不要用，ddl语句执行会阻塞dml语句执行，会有大量io操作

```sql
mysql> ALTER TABLE t3 PARTITION BY KEY(id) PARTITIONS 2;
```

### RANG&LIST删除分区

- RANG&LIST分区之删除指定分区

删除指定的RANG或LIST分区非常简单,但是要注意删除分区也同时删除了该分区中所有的数据。

如果仅仅想删除分区中的数据,应该使用TRUNCATE语句。

```sql
truncate效率比delete高

mysql> ALTER TABLE t1 DROP PARTITION p02;

mysal> ALTER TABLE t1 TRUNCATE PARTITION p01;
```

### RANG增加分区

要增加一个新的RANGE或LIST分区到一个前面已经分区了的表,使用"ALTER TABLE ADD PARTITION"语句。对于使用RANGE分区的表,可以用这个语句添加新的区间到已有分区的序列的前面或后面。

注意!对于RANGE分区的表,只可以使用ADD PARTITION添加新的分区到分区列表的高端。例如下面的例子会报错:

```sql
...
PARTITION BY RANGE(YEAR(dob)) (
PARTITION pO VALUES LESS THAN (1970)
PARTITION p1 VALUES LESS THAN (1980)
);
mysql> ALTER TABLE t1 ADD PARTITION (PARTITION p2 VALUES LESS THAN (1990)
```

### LIST分增加分区

对LIST分区增加分区的语法和RANG类似。

注意！增加新分区时,不可以包含现有分区值列表中的任意值。例如下面的例子会报错:

```sql
...
PARTITION BY LIST(data) (
PARTITION pO VALUES IN (5, 10, 15),
PARTITION p1 VALUES IN (6, 12, 18)
);
mysql> ALTER TABLE t2 ADD PARTITION (PARTITION p2 VALUES IN
(4, 8, 12));
```

### 分区之重组

使用REORGANIZE可以对现有的分区进行重组。这样可以实现将一个已存在的分区重分成多个分区,也可以实现将多个分区合并成一个分区。

注意!新分区模式不能有任何重叠的区间(适用于按照RANGE分区的表)或值集合(适用于重新组织按照LIST分区的表) ,也必须覆盖原有区间。

另外,对于按照RANGE分区的表,只能重新组织相邻的分区;不能跳过RANGE分区。

```sql
ALTER TABLE t1 REORGANIZE PARTITION p01 INTO ( PARTITION SO VALUES LESS THAN (5).
PARTITION s1 VALUES LESS THAN (10));
ALTER TABLE t1 REORGANIZE PARTITION s0,s1 INTO ( PARTITION pO1 VALUES LESS THAN (10);
```

### HASH&KEY修改分区数量

对于HASH分区和KEY分区,可以使用COALESCE缩减分区的数量,使用ALTER ADD PARTITION增加分区数量。

```sql
mysql -> ALTER TABLE t2 COALESCE PARTITION 2;
mysql -> ALTER TABLE t2 ADD PARTITION PARTITIONS 6;
```

## 分区维护

> 分区出现问题怎么办

- 重建分区
- 优化分区
- 检查与修复分区

# 实际应用

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

