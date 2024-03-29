USE [exam]
GO
/****** Object:  UserDefinedFunction [dbo].[age_scope]    Script Date: 2020/6/15 2:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[age_scope] (@AGE1 INT,@AGE2 INT)
RETURNS INT
AS
BEGIN
    DECLARE @result INT
    SELECT @result=COUNT(ID) FROM [USER] WHERE AGE > @AGE1 AND AGE < @AGE2
    RETURN @result
END
GO
/****** Object:  UserDefinedFunction [dbo].[register]    Script Date: 2020/6/15 2:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[register] (@AGE1 INT,@AGE2 INT)
RETURNS INT
AS
BEGIN
    DECLARE @result INT
    SELECT @result=COUNT(ID) FROM [USER] WHERE AGE > @AGE1 AND AGE < @AGE2
    RETURN @result
END
GO
/****** Object:  Table [dbo].[comment]    Script Date: 2020/6/15 2:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[comment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](20) NOT NULL,
	[keywords] [varchar](10) NULL,
	[content] [varchar](800) NOT NULL,
	[location] [varchar](10) NULL,
	[visible] [char](2) NOT NULL,
	[likes] [int] NULL,
	[create_time] [datetime] NOT NULL,
	[user_id] [int] NOT NULL,
	[message_id] [int] NOT NULL,
 CONSTRAINT [PK_comment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[message]    Script Date: 2020/6/15 2:22:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[message](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](20) NOT NULL,
	[keywords] [varchar](20) NULL,
	[content] [varchar](800) NOT NULL,
	[sort] [varchar](10) NULL,
	[location] [varchar](10) NULL,
	[visible] [char](2) NOT NULL,
	[creat_time] [datetime] NOT NULL,
	[update_time] [datetime] NULL,
	[user_id] [int] NOT NULL,
	[likes] [int] NOT NULL,
	[forward] [int] NULL,
 CONSTRAINT [PK_message] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user]    Script Date: 2020/6/15 2:22:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[sex] [char](2) NOT NULL,
	[birthday] [date] NULL,
	[age] [int] NULL,
	[nation] [varchar](50) NULL,
	[phone] [char](11) NOT NULL,
	[school] [varchar](50) NULL,
	[professional] [varchar](50) NULL,
	[hobby] [varchar](50) NULL,
	[password] [varchar](50) NOT NULL,
	[creat_time] [datetime] NOT NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[count]    Script Date: 2020/6/15 2:22:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW  [dbo].[count]  
AS SELECT count(u.id) '用户总量',count(ms.id) '留言总量',count(m.id) '回复总量'
FROM [user] u
left JOIN [message] ms
on ms.id=ms.id
left JOIN [comment] m
on m.id=m.id
GO
/****** Object:  View [dbo].[回复信息]    Script Date: 2020/6/15 2:22:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW  [dbo].[回复信息]  
AS SELECT m.title 标题, m.content 回复, ms.content 留言, u.name 回复人
FROM [comment] m, [message] ms,[user] u where m.user_id = u.id	 and m.message_id = ms.id
GO
/****** Object:  View [dbo].[留言信息]    Script Date: 2020/6/15 2:22:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW  [dbo].[留言信息]  
AS SELECT m.title 标题, m.content 留言, m.creat_time 留言时间, m.likes 点赞量, u.name 作者,u.school 作者学校  
FROM [message] m,[user] u where m.user_id = u.id
GO
/****** Object:  View [dbo].[统计]    Script Date: 2020/6/15 2:22:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW  [dbo].[统计] as 
SELECT count(u.id) '用户总量',count(ms.id) '留言总量',count(m.id) '回复总量'
FROM [user] u
left JOIN [message] ms
on ms.id=u.id
left JOIN [comment] m
on m.id=u.id
GO
ALTER TABLE [dbo].[comment] ADD  CONSTRAINT [DF_comment_location]  DEFAULT ('是') FOR [location]
GO
ALTER TABLE [dbo].[message] ADD  CONSTRAINT [DF_message_visible]  DEFAULT ('是') FOR [visible]
GO
ALTER TABLE [dbo].[comment]  WITH CHECK ADD  CONSTRAINT [FK_comment_message] FOREIGN KEY([message_id])
REFERENCES [dbo].[message] ([id])
GO
ALTER TABLE [dbo].[comment] CHECK CONSTRAINT [FK_comment_message]
GO
ALTER TABLE [dbo].[comment]  WITH NOCHECK ADD  CONSTRAINT [FK_comment_user] FOREIGN KEY([user_id])
REFERENCES [dbo].[user] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[comment] NOCHECK CONSTRAINT [FK_comment_user]
GO
ALTER TABLE [dbo].[message]  WITH CHECK ADD  CONSTRAINT [FK_message_user] FOREIGN KEY([user_id])
REFERENCES [dbo].[user] ([id])
GO
ALTER TABLE [dbo].[message] CHECK CONSTRAINT [FK_message_user]
GO
ALTER TABLE [dbo].[comment]  WITH CHECK ADD  CONSTRAINT [CK_comment] CHECK  (([visible]='是' OR [visible]='否'))
GO
ALTER TABLE [dbo].[comment] CHECK CONSTRAINT [CK_comment]
GO
ALTER TABLE [dbo].[message]  WITH CHECK ADD  CONSTRAINT [CK_message] CHECK  (([visible]='是' OR [visible]='否'))
GO
ALTER TABLE [dbo].[message] CHECK CONSTRAINT [CK_message]
GO
ALTER TABLE [dbo].[user]  WITH CHECK ADD  CONSTRAINT [CK_user] CHECK  (([sex]='男' OR [sex]='女'))
GO
ALTER TABLE [dbo].[user] CHECK CONSTRAINT [CK_user]
GO
/****** Object:  StoredProcedure [dbo].[check]    Script Date: 2020/6/15 2:22:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[check] (@user_nam varchar(20),@check varchar(10) output)
AS
declare @flag int
select @flag = count(id) from [user] where name=@user_nam
if @flag=1
set @check = '存在'
else 
set @check = '不存在'
GO
/****** Object:  StoredProcedure [dbo].[have_msg_user]    Script Date: 2020/6/15 2:22:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[have_msg_user] as
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
GO
/****** Object:  StoredProcedure [dbo].[敏感词过滤]    Script Date: 2020/6/15 2:22:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[敏感词过滤] (@words varchar(50)) 
as
delete from [message] where content like '%'+@words+'%'
delete from [comment] where content like '%'+@words+'%'
GO
/****** Object:  StoredProcedure [dbo].[删除敏感内容]    Script Date: 2020/6/15 2:22:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[删除敏感内容] (@words varchar(50)) 
as
delete from [message] where content like '%'+@words+'%'
delete from [comment] where content like '%'+@words+'%'
GO
/****** Object:  StoredProcedure [dbo].[用户活跃度]    Script Date: 2020/6/15 2:22:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[用户活跃度] (@user_nam varchar(20))
as
SELECT u.name 姓名, count( m.id ) 回复量, count( ms.id ) 留言量
FROM [user] u
left JOIN [message] ms
on u.id=ms.user_id
left JOIN [comment] m
on u.id=m.user_id
GROUP BY u.name
having u.name= @user_nam
GO
