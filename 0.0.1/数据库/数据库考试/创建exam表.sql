/****** Object:  Table [dbo].[comment]    Script Date: 2020/6/15 2:19:13 ******/
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
/****** Object:  Table [dbo].[message]    Script Date: 2020/6/15 2:19:13 ******/
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
/****** Object:  Table [dbo].[user]    Script Date: 2020/6/15 2:19:13 ******/
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
