
use [exam]

--视图
go
CREATE VIEW  [留言信息]  
AS SELECT m.title 标题, m.content 留言, m.creat_time 留言时间, m.likes 点赞量, u.name 作者,u.school 作者学校  
FROM [message] m,[user] u where m.user_id = u.id

go
SELECT * FROM [留言信息] WHERE 标题 = '返校通知'

go
CREATE VIEW  [回复信息]  
AS SELECT m.title 标题, m.content 回复, ms.content 留言, u.name 回复人
FROM [comment] m, [message] ms,[user] u where m.user_id = u.id	 and m.message_id = ms.id

go
SELECT * FROM [回复信息] WHERE 标题 like '回复%'

go
CREATE VIEW  [统计] as 
SELECT count(u.id) '用户总量',count(ms.id) '留言总量',count(m.id) '回复总量'
FROM [user] u
left JOIN [message] ms
on ms.id=u.id
left JOIN [comment] m
on m.id=u.id

go
SELECT * FROM [统计]

--存储过程
go
create procedure [用户活跃度] (@user_nam varchar(20))
as
SELECT u.name 姓名, count( m.id ) 回复量, count( ms.id ) 留言量
FROM [user] u
left JOIN [message] ms
on u.id=ms.user_id
left JOIN [comment] m
on u.id=m.user_id
GROUP BY u.name
having u.name= @user_nam

exec [用户活跃度] '小明'

go
create procedure [check] (@user_nam varchar(20),@check varchar(10) output)
AS
declare @flag int
select @flag = count(id) from [user] where name=@user_nam
if @flag=1
set @check = '存在'
else 
set @check = '不存在'

declare @check varchar(10)
exec [check] '小明',@check output
select @check as '用户检测'

--游标
go
create procedure [have_msg_user] as
declare my_cursor cursor for select user_id from [message]
open my_cursor                
declare @id int                   
fetch next from my_cursor into @id
while @@FETCH_STATUS=0 
begin
select name,sex,school,professional from [user] where id=@id  
fetch next from my_cursor into @id
end
close my_cursor
deallocate my_cursor

exec [have_msg_user]

go
create procedure [敏感词过滤] (@words varchar(50)) 
as
delete from [message] where content like '%'+@words+'%'
delete from [comment] where content like '%'+@words+'%'

INSERT [message]
VALUES ('测试','测试','反华','测试','西安','是','2020-06-08 12:30:00',NULL,5,1,1)
exec [敏感词过滤] '反华'

--临时表
select name,school,phone into #temp from [user]
delete from #temp where school like '%'+'工业'+'%'

SELECT * into #temp1 FROM information_schema.tables

select * from #temp
select * from #temp1

--自定义函数
GO
CREATE FUNCTION age_scope (@AGE1 INT,@AGE2 INT)
RETURNS INT
AS
BEGIN
    DECLARE @result INT
    SELECT @result=COUNT(ID) FROM [USER] WHERE AGE > @AGE1 AND AGE < @AGE2
    RETURN @result
END
GO

select dbo.age_scope(18, 25) 人数

/*
增删改查
*/
--插入
INSERT [user]
VALUES ( '小安','男','1999-09-09',21,'汉族','13992099111','西安工业大学','计算机','篮球','123','2020-06-10 12:30:20' )
, ( '小明','男','1999-09-09',21,'汉族','1399209911','西安工业大学','计算机','看书','abc','2020-06-09 12:30:30' ) 
, ( '小娜','女','1998-07-22',21,'回族','13888099661','西安工业大学','文学院','运动','abc','2020-06-11 15:30:30' ) 
,( '小迪','女','1996-09-02',21,'汉族','15292099101','西安工业大学','电信','跳舞','abc','2020-06-12 18:30:30' ) 
,( '小虎','男','1998-12-09',21,'维族','17892099188','西安工业大学','机电','健身','abc','2020-06-13 10:30:30' ) 

INSERT [message]
VALUES ( '返校通知','学校文件','所有第二批返校学生于6月18日之前返校','校园通知','西安','是','2020-06-08 12:30:00',NULL,1,66,199)
, ( '寻物启事','丢失饭卡','本人于今天下午在食堂丢失饭卡','寻人寻物','西安','是','2020-06-10 12:30:00',NULL,3,12,0)
, ( '社团招新','招新','摄影协会即将招新，敬请期待','课余活动','西安','是','2020-06-01 10:00:00',NULL,2,30,18)
, ( '校园夏日','学校风景','这是今天学校午后的阳光','校园风景','西安','是','2020-06-05 08:30:00','2020-06-06 18:00:00',1,88,20)

INSERT [comment]
VALUES ( '回复：返校通知',NULL,'收到','西安','是','0','2020-06-08 12:30:00',2,1)
, ( '回复：返校通知',NULL,'收到','西安','是','0','2020-06-08 12:30:00',3,1)
, ( '回复：返校通知',NULL,'收到','西安','是','0','2020-06-08 12:30:00',4,1)
, ( '回复：返校通知',NULL,'收到','西安','是','0','2020-06-08 12:30:00',5,1)

--查询
SELECT *FROM   [USER]
SELECT *FROM   [MESSAGE]
SELECT *FROM   [COMMENT]

--更新
update [user] set sex='女' where name='小安'  

--order by
select id,title 标题,content 内容,creat_time 发布时间,likes 点赞 
from [message] order by id desc

--group by
select sort 类别,count(content) 内容,sum(likes) 点赞 
from [message] group by sort with rollup

select sort 类别,count(content) 内容,sum(likes) 点赞
from [message] group by sort having sum(likes) >50

select top (3) sort 类别,count(content) 内容,sum(likes) 点赞 
from [message] group by sort 

--条件查询
select * from [user] where hobby is not null
select * from [user] where nation in ('回族','维族')
select * from [message] where likes between 10 and 50
select * from [message] where user_id=1 and update_time is not null
select * from [message] where keywords not like '%学校%'
--ANY,SOME,ALL：ANY和SOME等价，=ANY与IN等效
SELECT *FROM [user]
WHERE name != ALL(SELECT name FROM [user]where id > 2)

--聚合函数
select min(creat_time) 首位用户注册时间 from [user]
select avg(likes) from [message]

--合并查询结果集，union不包括重复行，union all包括重复行
select title from [message]
union
select title from [comment]

--联结查询：查询条件一定要是明确的可比较的，否则会出现各种不可预知的问题
select m.title 留言标题,m.content 留言内容, c.title 回复标题,c.content 回复内容
from [message] m inner join [comment] c
on m.user_id = c.user_id

--SELECT嵌套
SELECT title,content FROM [comment] 
WHERE user_id=(SELECT id FROM [user] where name ='小明')

--EXISTS用法：先判断存在或不存，再执行前面的语句
SELECT * FROM [user] WHERE EXISTS (SELECT name FROM [user] WHERE id=1)
SELECT * FROM [user] WHERE not EXISTS (SELECT name FROM [user] WHERE id=2)

--select...into
insert [user] select 
name, sex, birthday, age, nation, phone, school, professional, hobby, password, creat_time
from [user] where id =3

-- DISTINCT:去掉字段的重复值
SELECT DISTINCT(name) FROM [user]

delete from [comment] where id =1

--select做条件
delete from [comment] 
where user_id =(select id from [user] where name='小迪')

--删除约束
alter table [comment] drop constraint FK_comment_user

--添加字段
alter table [user] add location varchar(50) default '西安'

--设置自增起始值
DBCC CHECKIDENT ('user', RESEED, 2)
