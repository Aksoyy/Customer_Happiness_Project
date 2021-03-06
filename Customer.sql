USE [master]
GO
/****** Object:  Database [Customer]    Script Date: 28.08.2018 17:13:04 ******/
CREATE DATABASE [Customer]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Customer', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Customer.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Customer_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Customer_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 COLLATE SQL_Latin1_General_CP1_CI_AS
GO
ALTER DATABASE [Customer] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Customer].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Customer] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Customer] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Customer] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Customer] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Customer] SET ARITHABORT OFF 
GO
ALTER DATABASE [Customer] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Customer] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Customer] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Customer] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Customer] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Customer] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Customer] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Customer] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Customer] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Customer] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Customer] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Customer] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Customer] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Customer] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Customer] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Customer] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Customer] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Customer] SET RECOVERY FULL 
GO
ALTER DATABASE [Customer] SET  MULTI_USER 
GO
ALTER DATABASE [Customer] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Customer] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Customer] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Customer] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Customer] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Customer', N'ON'
GO
ALTER DATABASE [Customer] SET QUERY_STORE = OFF
GO
USE [Customer]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Customer]
GO
/****** Object:  Table [dbo].[Member_Answer]    Script Date: 28.08.2018 17:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_Answer](
	[Member_Answer_Id] [int] IDENTITY(1,1) NOT NULL,
	[User_Answer_Id] [int] NOT NULL,
	[Answer] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Member_Answer] PRIMARY KEY CLUSTERED 
(
	[Member_Answer_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question_Type]    Script Date: 28.08.2018 17:13:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question_Type](
	[Question_Type_Id] [int] IDENTITY(1,1) NOT NULL,
	[Type_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CreationDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[Logical_Delete_Key] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Question_Type] PRIMARY KEY CLUSTERED 
(
	[Question_Type_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Answer]    Script Date: 28.08.2018 17:13:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Answer](
	[User_Answer_Id] [int] IDENTITY(1,1) NOT NULL,
	[User_Question_Id] [int] NOT NULL,
	[Section_A] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Section_B] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Section_C] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Section_D] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CreationDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[Logical_Delete_Key] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_User_Answer] PRIMARY KEY CLUSTERED 
(
	[User_Answer_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Login]    Script Date: 28.08.2018 17:13:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Login](
	[User_login_Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Password] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Statu] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CreationDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[Logical_Delete_Key] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_User_Login] PRIMARY KEY CLUSTERED 
(
	[User_login_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Question]    Script Date: 28.08.2018 17:13:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Question](
	[User_Question_Id] [int] IDENTITY(1,1) NOT NULL,
	[Question] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Question_Type_Id] [int] NOT NULL,
	[User_Login_Id] [int] NOT NULL,
	[CreationDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[Logical_delete_key] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_User_Question] PRIMARY KEY CLUSTERED 
(
	[User_Question_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Session]    Script Date: 28.08.2018 17:13:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Session](
	[User_session_Id] [int] IDENTITY(1,1) NOT NULL,
	[User_login_Id] [int] NOT NULL,
	[Session_key] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CreationDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[Logical_delete_key] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Session_Key] PRIMARY KEY CLUSTERED 
(
	[User_session_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Question_Type] ON 

INSERT [dbo].[Question_Type] ([Question_Type_Id], [Type_Name], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (1, N'İletişim', CAST(N'1997-03-15T00:00:00.000' AS DateTime), CAST(N'1997-03-15T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Question_Type] ([Question_Type_Id], [Type_Name], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (2, N'Spor', CAST(N'1907-07-19T00:00:00.000' AS DateTime), CAST(N'1907-07-19T00:00:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Question_Type] OFF
SET IDENTITY_INSERT [dbo].[User_Answer] ON 

INSERT [dbo].[User_Answer] ([User_Answer_Id], [User_Question_Id], [Section_A], [Section_B], [Section_C], [Section_D], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (6, 14, N'a', N'b', N'c', N'd', CAST(N'2018-08-15T21:43:53.420' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Answer] ([User_Answer_Id], [User_Question_Id], [Section_A], [Section_B], [Section_C], [Section_D], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (7, 15, N'a', N'b', N'c', N'd', CAST(N'2018-08-15T22:28:06.483' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Answer] ([User_Answer_Id], [User_Question_Id], [Section_A], [Section_B], [Section_C], [Section_D], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (8, 16, N'a', N'b', N'c', N'd', CAST(N'2018-08-15T22:28:25.410' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Answer] ([User_Answer_Id], [User_Question_Id], [Section_A], [Section_B], [Section_C], [Section_D], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (9, 25, N'a', N'b', N'c', N'd', CAST(N'2018-08-16T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Answer] ([User_Answer_Id], [User_Question_Id], [Section_A], [Section_B], [Section_C], [Section_D], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (10, 26, N'evet', N'hayır', N'eh işte', N'idare eder', CAST(N'2018-08-16T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Answer] ([User_Answer_Id], [User_Question_Id], [Section_A], [Section_B], [Section_C], [Section_D], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (11, 27, N'evet', N'hayır', N'eh işte', N'idare eder', CAST(N'2018-08-16T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Answer] ([User_Answer_Id], [User_Question_Id], [Section_A], [Section_B], [Section_C], [Section_D], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (12, 28, N'acep', N'ace', N'ac', N'a', CAST(N'2018-08-17T00:00:00.000' AS DateTime), CAST(N'2018-08-17T16:17:05.110' AS DateTime), NULL)
INSERT [dbo].[User_Answer] ([User_Answer_Id], [User_Question_Id], [Section_A], [Section_B], [Section_C], [Section_D], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (13, 29, N'evet', N'hayır', N'eh işte', N'idare eder', CAST(N'2018-08-17T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Answer] ([User_Answer_Id], [User_Question_Id], [Section_A], [Section_B], [Section_C], [Section_D], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (14, 30, N'evet', N'hayır', N'eh işte', N'idare eder', CAST(N'2018-08-17T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Answer] ([User_Answer_Id], [User_Question_Id], [Section_A], [Section_B], [Section_C], [Section_D], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (15, 31, N'evet', N'hayır', N'eh işte', N'idare eder', CAST(N'2018-08-27T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Answer] ([User_Answer_Id], [User_Question_Id], [Section_A], [Section_B], [Section_C], [Section_D], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (16, 32, N'biraz', N'kısmen', N'eh işte', N'idare eder', CAST(N'2018-08-27T00:00:00.000' AS DateTime), CAST(N'2018-08-27T17:31:47.993' AS DateTime), N'32')
INSERT [dbo].[User_Answer] ([User_Answer_Id], [User_Question_Id], [Section_A], [Section_B], [Section_C], [Section_D], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (17, 33, N'biraz', N'kısmen', N'eh işte', N'idare eder', CAST(N'2018-08-28T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Answer] ([User_Answer_Id], [User_Question_Id], [Section_A], [Section_B], [Section_C], [Section_D], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (18, 34, N'biraz', N'kısmen', N'eh işte', N'idare eder', CAST(N'2018-08-28T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Answer] ([User_Answer_Id], [User_Question_Id], [Section_A], [Section_B], [Section_C], [Section_D], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (19, 35, N'biraz', N'kısmen', N'eh işte', N'idare eder', CAST(N'2018-08-28T00:00:00.000' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[User_Answer] OFF
SET IDENTITY_INSERT [dbo].[User_Login] ON 

INSERT [dbo].[User_Login] ([User_login_Id], [Username], [Password], [Statu], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (1, N'admin', N'admin', N'PASIF', NULL, CAST(N'2018-08-15T13:54:36.400' AS DateTime), NULL)
INSERT [dbo].[User_Login] ([User_login_Id], [Username], [Password], [Statu], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (2, N'cemil', N'12345', N'AKTIF', NULL, NULL, NULL)
INSERT [dbo].[User_Login] ([User_login_Id], [Username], [Password], [Statu], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (3, N'hakan', N'1234567', N'AKTIF', NULL, NULL, NULL)
INSERT [dbo].[User_Login] ([User_login_Id], [Username], [Password], [Statu], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (4, N'emre', N'1234567', N'AKTIF', NULL, NULL, NULL)
INSERT [dbo].[User_Login] ([User_login_Id], [Username], [Password], [Statu], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (5, N'nihal', N'1234567', N'AKTIF', NULL, NULL, NULL)
INSERT [dbo].[User_Login] ([User_login_Id], [Username], [Password], [Statu], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (6, N'Nihat', N'123', N'AKTIF', NULL, NULL, NULL)
INSERT [dbo].[User_Login] ([User_login_Id], [Username], [Password], [Statu], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (7, N'Nihat2', N'123', N'PASIF', NULL, CAST(N'2018-08-15T16:04:31.740' AS DateTime), NULL)
INSERT [dbo].[User_Login] ([User_login_Id], [Username], [Password], [Statu], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (8, N'admin3', N'admin', N'AKTIF', NULL, NULL, NULL)
INSERT [dbo].[User_Login] ([User_login_Id], [Username], [Password], [Statu], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (9, N'admin4', N'admin', N'PASIF', NULL, CAST(N'2018-08-15T16:01:49.480' AS DateTime), NULL)
INSERT [dbo].[User_Login] ([User_login_Id], [Username], [Password], [Statu], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (10, N'admin5', N'admin', N'AKTIF', NULL, NULL, NULL)
INSERT [dbo].[User_Login] ([User_login_Id], [Username], [Password], [Statu], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (11, N'admin6', N'admin', N'AKTIF', NULL, NULL, NULL)
INSERT [dbo].[User_Login] ([User_login_Id], [Username], [Password], [Statu], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (12, N'admin7', N'admin', N'AKTIF', NULL, NULL, NULL)
INSERT [dbo].[User_Login] ([User_login_Id], [Username], [Password], [Statu], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (13, N'admin8', N'admin', N'AKTIF', NULL, NULL, NULL)
INSERT [dbo].[User_Login] ([User_login_Id], [Username], [Password], [Statu], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (14, N'Satliye', N'Aksoy', N'AKTIF', NULL, NULL, NULL)
INSERT [dbo].[User_Login] ([User_login_Id], [Username], [Password], [Statu], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (15, N'Eylül', N'Aksoy', N'AKTIF', CAST(N'2018-08-16T14:15:17.103' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Login] ([User_login_Id], [Username], [Password], [Statu], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (16, N'Emre2', N'Sert', N'PASIF', CAST(N'2018-08-16T14:20:04.473' AS DateTime), CAST(N'2018-08-16T16:42:27.950' AS DateTime), NULL)
INSERT [dbo].[User_Login] ([User_login_Id], [Username], [Password], [Statu], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (17, N'Emre3', N'SERTas', N'AKTIF', CAST(N'2018-08-16T16:42:46.373' AS DateTime), CAST(N'2018-08-16T17:24:01.277' AS DateTime), NULL)
INSERT [dbo].[User_Login] ([User_login_Id], [Username], [Password], [Statu], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (18, N'Emre4', N'Sert', N'AKTIF', CAST(N'2018-08-17T14:37:08.253' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Login] ([User_login_Id], [Username], [Password], [Statu], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (19, N'Emre5', N'Sert', N'AKTIF', CAST(N'2018-08-27T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Login] ([User_login_Id], [Username], [Password], [Statu], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (20, N'Hasan', N'Sari', N'AKTIF', CAST(N'2018-08-27T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Login] ([User_login_Id], [Username], [Password], [Statu], [CreationDate], [UpdateDate], [Logical_Delete_Key]) VALUES (21, N'Alperen', N'Cubuk', N'AKTIF', CAST(N'2018-08-28T00:00:00.000' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[User_Login] OFF
SET IDENTITY_INSERT [dbo].[User_Question] ON 

INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (12, N'deneme', 2, 7, CAST(N'2018-08-15T20:52:43.133' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (13, N'deneme', 2, 7, CAST(N'2018-08-15T20:53:14.280' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (14, N'deneme', 2, 7, CAST(N'2018-08-15T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (15, N'deneme2', 2, 7, CAST(N'2018-08-15T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (16, N'deneme3', 2, 7, CAST(N'2018-08-15T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (17, N'deneme4', 2, 7, CAST(N'2018-08-16T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (18, N'deneme5', 2, 7, CAST(N'2018-08-16T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (19, N'deneme6', 2, 7, CAST(N'2018-08-16T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (20, N'deneme9', 2, 7, CAST(N'2018-08-16T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (21, N'deneme9', 2, 7, CAST(N'2018-08-16T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (22, N'deneme9', 2, 7, CAST(N'2018-08-16T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (23, N'deneme9', 2, 7, CAST(N'2018-08-16T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (24, N'deneme10', 2, 7, CAST(N'2018-08-16T12:05:31.297' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (25, N'deneme11', 2, 7, CAST(N'2018-08-16T13:51:55.590' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (26, N'Hizmetten memnun kaldınız mı?', 2, 16, CAST(N'2018-08-16T14:24:09.127' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (27, N'Hizmetten memnun kaldınız mı?', 2, 17, CAST(N'2018-08-16T16:43:15.807' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (28, N'Deneme', 2, 18, CAST(N'2018-08-17T14:37:43.987' AS DateTime), CAST(N'2018-08-17T16:16:59.440' AS DateTime), NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (29, N'Hizmetten memnun kaldınız mi?', 2, 18, CAST(N'2018-08-17T14:37:52.307' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (30, N'Hizmetten memnun kaldıniz mi?', 2, 18, CAST(N'2018-08-17T14:38:00.253' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (31, N'Hizmetten memnun kaldıniz mi?', 2, 20, CAST(N'2018-08-27T17:23:31.530' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (32, N'Hizmetten memnun kaldıniz mi?', 2, 20, CAST(N'2018-08-27T17:24:21.037' AS DateTime), CAST(N'2018-08-27T17:31:32.483' AS DateTime), N'32')
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (33, N'Soru deneme', 2, 21, CAST(N'2018-08-28T11:10:12.087' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (34, N'Soru deneme2', 2, 21, CAST(N'2018-08-28T11:10:16.437' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Question] ([User_Question_Id], [Question], [Question_Type_Id], [User_Login_Id], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (35, N'Soru deneme3', 2, 21, CAST(N'2018-08-28T11:10:20.583' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[User_Question] OFF
SET IDENTITY_INSERT [dbo].[User_Session] ON 

INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (1, 6, N'215fdsf21', CAST(N'1997-01-01T00:00:00.000' AS DateTime), CAST(N'1997-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (2, 6, N'215fdsf21', CAST(N'1997-01-01T00:00:00.000' AS DateTime), CAST(N'1997-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (3, 6, N'215fdsf21', CAST(N'1997-01-01T00:00:00.000' AS DateTime), CAST(N'1997-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (6, 1, N'596ecdc9-bced-4b95-9919-cc0d715b529b', CAST(N'2018-08-14T23:02:27.943' AS DateTime), CAST(N'2018-08-14T23:03:58.470' AS DateTime), N'6')
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (7, 1, N'69529ffe-f66d-4148-91b8-f7872a1f4bb7', CAST(N'2018-08-14T23:04:46.280' AS DateTime), CAST(N'2018-08-14T23:05:13.810' AS DateTime), N'7')
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (8, 1, N'77892405-7412-424b-9806-d4cc7d9b85bb', CAST(N'2018-08-14T23:16:31.373' AS DateTime), CAST(N'2018-08-14T23:16:51.240' AS DateTime), N'8')
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (9, 1, N'aa1bfc94-72e1-4b30-b063-7344b6951ff8', CAST(N'2018-08-14T23:16:59.650' AS DateTime), CAST(N'2018-08-15T15:19:09.200' AS DateTime), N'9')
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (10, 1, N'596ecdc9-bced-4b95-9919-cc0d715b529b', CAST(N'2018-08-15T13:53:51.677' AS DateTime), NULL, N'10')
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (11, 1, N'04f77ed0-6bcb-4a76-8261-fa4cdedb56e1', CAST(N'2018-08-15T15:19:09.200' AS DateTime), CAST(N'2018-08-15T15:19:11.593' AS DateTime), N'11')
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (12, 1, N'd9be3e5b-7ae9-4151-8ba6-7fa29945d7ad', CAST(N'2018-08-15T15:19:11.593' AS DateTime), CAST(N'2018-08-15T15:19:12.470' AS DateTime), N'12')
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (13, 1, N'39c9b2ce-09e3-4e83-b97c-8d3d301d255f', CAST(N'2018-08-15T15:19:12.470' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (14, 9, N'8461a939-fcf5-42d5-842e-0e0c14b77af7', CAST(N'2018-08-15T15:19:47.230' AS DateTime), CAST(N'2018-08-15T15:53:36.243' AS DateTime), N'14')
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (15, 7, N'f679ad67-5354-46b4-8d23-dc6ee23fa0a3', CAST(N'2018-08-15T16:04:03.297' AS DateTime), CAST(N'2018-08-15T20:52:55.743' AS DateTime), N'15')
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (16, 7, N'3ed8e914-0a6b-4dcf-88d4-f643abeb61f7', CAST(N'2018-08-15T20:52:55.747' AS DateTime), CAST(N'2018-08-16T14:10:03.497' AS DateTime), N'16')
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (17, 7, N'216130d8-2ec7-49a3-b436-eaa974ef7fc3', CAST(N'2018-08-16T14:10:03.647' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (18, 15, N'6bc59872-6668-4869-b36d-a36a661fdb26', CAST(N'2018-08-16T14:15:57.423' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (19, 16, N'32462684-079f-44db-a6b0-f3e0358cd023', CAST(N'2018-08-16T14:20:32.210' AS DateTime), CAST(N'2018-08-16T16:21:52.160' AS DateTime), N'19')
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (20, 16, N'106baf87-0e6f-43d9-969b-73575f96fa77', CAST(N'2018-08-16T16:21:52.303' AS DateTime), CAST(N'2018-08-16T16:41:49.463' AS DateTime), N'20')
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (21, 16, N'075f1e41-af83-41db-86ef-16f8d3d8ea19', CAST(N'2018-08-16T16:41:49.610' AS DateTime), CAST(N'2018-08-16T16:42:37.727' AS DateTime), N'21')
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (22, 17, N'0e0230fa-efe0-4588-964d-5f672c5557e3', CAST(N'2018-08-16T16:42:52.890' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (23, 18, N'1ce60585-0cf4-419e-a6d1-d2b85d6c1e32', CAST(N'2018-08-17T14:37:16.730' AS DateTime), CAST(N'2018-08-27T17:22:34.120' AS DateTime), N'23')
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (24, 18, N'00fc4e6c-1202-464d-b6ff-20320eb56982', CAST(N'2018-08-27T17:22:34.147' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (25, 20, N'e7c15abb-a374-4c1d-a6b4-8230113ee2cd', CAST(N'2018-08-27T17:23:15.370' AS DateTime), NULL, NULL)
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (26, 21, N'16dd2dd6-840f-4bf0-95e3-fb67b62300af', CAST(N'2018-08-28T11:09:28.517' AS DateTime), CAST(N'2018-08-28T11:10:39.673' AS DateTime), N'26')
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (27, 21, N'3e5c32cb-b584-4ff3-88a6-a2906656a2bf', CAST(N'2018-08-28T11:11:49.160' AS DateTime), CAST(N'2018-08-28T11:12:06.593' AS DateTime), N'27')
INSERT [dbo].[User_Session] ([User_session_Id], [User_login_Id], [Session_key], [CreationDate], [UpdateDate], [Logical_delete_key]) VALUES (28, 21, N'ff8657b6-c0c0-46ef-80f9-00e37b5661c6', CAST(N'2018-08-28T11:12:22.183' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[User_Session] OFF
ALTER TABLE [dbo].[Member_Answer]  WITH CHECK ADD  CONSTRAINT [FK_Member_Answer_User_Answer] FOREIGN KEY([User_Answer_Id])
REFERENCES [dbo].[User_Answer] ([User_Answer_Id])
GO
ALTER TABLE [dbo].[Member_Answer] CHECK CONSTRAINT [FK_Member_Answer_User_Answer]
GO
ALTER TABLE [dbo].[User_Answer]  WITH CHECK ADD  CONSTRAINT [FK_User_Answer_User_Question] FOREIGN KEY([User_Question_Id])
REFERENCES [dbo].[User_Question] ([User_Question_Id])
GO
ALTER TABLE [dbo].[User_Answer] CHECK CONSTRAINT [FK_User_Answer_User_Question]
GO
ALTER TABLE [dbo].[User_Question]  WITH CHECK ADD  CONSTRAINT [FK_User_Question_Question_Type] FOREIGN KEY([Question_Type_Id])
REFERENCES [dbo].[Question_Type] ([Question_Type_Id])
GO
ALTER TABLE [dbo].[User_Question] CHECK CONSTRAINT [FK_User_Question_Question_Type]
GO
ALTER TABLE [dbo].[User_Question]  WITH CHECK ADD  CONSTRAINT [FK_User_Question_User_Login] FOREIGN KEY([User_Login_Id])
REFERENCES [dbo].[User_Login] ([User_login_Id])
GO
ALTER TABLE [dbo].[User_Question] CHECK CONSTRAINT [FK_User_Question_User_Login]
GO
ALTER TABLE [dbo].[User_Session]  WITH CHECK ADD  CONSTRAINT [FK_User_Session_User_Login] FOREIGN KEY([User_login_Id])
REFERENCES [dbo].[User_Login] ([User_login_Id])
GO
ALTER TABLE [dbo].[User_Session] CHECK CONSTRAINT [FK_User_Session_User_Login]
GO
USE [master]
GO
ALTER DATABASE [Customer] SET  READ_WRITE 
GO
