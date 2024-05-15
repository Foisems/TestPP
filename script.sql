USE [master]
GO
/****** Object:  Database [TestDB]    Script Date: 15.05.2024 3:46:48 ******/
CREATE DATABASE [TestDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TestDB', FILENAME = N'D:\Programms\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\TestDB.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TestDB_log', FILENAME = N'D:\Programms\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\TestDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [TestDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TestDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TestDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TestDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TestDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TestDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TestDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [TestDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TestDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TestDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TestDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TestDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TestDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TestDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TestDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TestDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TestDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TestDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TestDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TestDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TestDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TestDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TestDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TestDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TestDB] SET RECOVERY FULL 
GO
ALTER DATABASE [TestDB] SET  MULTI_USER 
GO
ALTER DATABASE [TestDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TestDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TestDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TestDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TestDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TestDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [TestDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [TestDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [TestDB]
GO
/****** Object:  Table [dbo].[Answer]    Script Date: 15.05.2024 3:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Answer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_Answer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AnswerInQuestion]    Script Date: 15.05.2024 3:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AnswerInQuestion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdAnswer] [int] NOT NULL,
	[IdQuestion] [int] NOT NULL,
	[Correct] [bit] NOT NULL,
 CONSTRAINT [PK_AnswerInQuestion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[IdAnswer] ASC,
	[IdQuestion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Group]    Script Date: 15.05.2024 3:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdName] [int] NOT NULL,
	[IdIndex] [int] NOT NULL,
 CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GroupIndex]    Script Date: 15.05.2024 3:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupIndex](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Index] [int] NOT NULL,
 CONSTRAINT [PK_GroupIndex] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GroupName]    Script Date: 15.05.2024 3:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupName](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](5) NOT NULL,
 CONSTRAINT [PK_GroupName] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Human]    Script Date: 15.05.2024 3:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Human](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[Surname] [nvarchar](100) NOT NULL,
	[Patronymic] [nvarchar](100) NULL,
	[IdGroup] [int] NULL,
	[IdSubject] [int] NULL,
 CONSTRAINT [PK_Human] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImageProfile]    Script Date: 15.05.2024 3:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImageProfile](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Image] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ImageProfile] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lecture]    Script Date: 15.05.2024 3:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lecture](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdSubject] [int] NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Lecture] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Lecture] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 15.05.2024 3:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionInTest]    Script Date: 15.05.2024 3:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionInTest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdQuestion] [int] NOT NULL,
	[IdTest] [int] NOT NULL,
	[Number] [int] NULL,
 CONSTRAINT [PK_QuestionInTest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[IdQuestion] ASC,
	[IdTest] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 15.05.2024 3:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Score]    Script Date: 15.05.2024 3:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Score](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Number] [int] NOT NULL,
 CONSTRAINT [PK_Score] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subject]    Script Date: 15.05.2024 3:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subject](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Subject] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Test]    Script Date: 15.05.2024 3:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Test](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdSubject] [int] NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_Test] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestScore]    Script Date: 15.05.2024 3:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestScore](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUser] [int] NOT NULL,
	[IdTest] [int] NOT NULL,
	[IdScore] [int] NOT NULL,
 CONSTRAINT [PK_TestScore] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 15.05.2024 3:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[IdRole] [int] NOT NULL,
	[IdHuman] [int] NOT NULL,
	[IdImage] [int] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Answer] ON 

INSERT [dbo].[Answer] ([Id], [Name]) VALUES (1, N'множество
предметов или явлений, объединенных каким-либо общим признаком или свойством качественного или количественного 
характера.')
INSERT [dbo].[Answer] ([Id], [Name]) VALUES (2, N'совокупность объектов, случайно отобранных из генеральной
совокупности. ')
INSERT [dbo].[Answer] ([Id], [Name]) VALUES (3, N'соответствие между вариантами и их частотами (или относительными частотами). ')
INSERT [dbo].[Answer] ([Id], [Name]) VALUES (24, N'10')
INSERT [dbo].[Answer] ([Id], [Name]) VALUES (25, N'12')
INSERT [dbo].[Answer] ([Id], [Name]) VALUES (26, N'15')
INSERT [dbo].[Answer] ([Id], [Name]) VALUES (27, N'13')
INSERT [dbo].[Answer] ([Id], [Name]) VALUES (28, N'8 яблок.')
INSERT [dbo].[Answer] ([Id], [Name]) VALUES (29, N'6 яблок.')
INSERT [dbo].[Answer] ([Id], [Name]) VALUES (30, N'9 яблок.')
INSERT [dbo].[Answer] ([Id], [Name]) VALUES (31, N'81')
INSERT [dbo].[Answer] ([Id], [Name]) VALUES (32, N'72')
INSERT [dbo].[Answer] ([Id], [Name]) VALUES (33, N'63')
INSERT [dbo].[Answer] ([Id], [Name]) VALUES (34, N'64')
INSERT [dbo].[Answer] ([Id], [Name]) VALUES (35, N'56')
INSERT [dbo].[Answer] ([Id], [Name]) VALUES (36, N'25')
INSERT [dbo].[Answer] ([Id], [Name]) VALUES (37, N'24')
INSERT [dbo].[Answer] ([Id], [Name]) VALUES (38, N'26')
INSERT [dbo].[Answer] ([Id], [Name]) VALUES (39, N'8')
INSERT [dbo].[Answer] ([Id], [Name]) VALUES (40, N'9')
INSERT [dbo].[Answer] ([Id], [Name]) VALUES (41, N'6')
SET IDENTITY_INSERT [dbo].[Answer] OFF
GO
SET IDENTITY_INSERT [dbo].[AnswerInQuestion] ON 

INSERT [dbo].[AnswerInQuestion] ([Id], [IdAnswer], [IdQuestion], [Correct]) VALUES (1, 1, 1, 1)
INSERT [dbo].[AnswerInQuestion] ([Id], [IdAnswer], [IdQuestion], [Correct]) VALUES (2, 2, 1, 0)
INSERT [dbo].[AnswerInQuestion] ([Id], [IdAnswer], [IdQuestion], [Correct]) VALUES (3, 3, 1, 0)
INSERT [dbo].[AnswerInQuestion] ([Id], [IdAnswer], [IdQuestion], [Correct]) VALUES (4, 24, 13, 0)
INSERT [dbo].[AnswerInQuestion] ([Id], [IdAnswer], [IdQuestion], [Correct]) VALUES (5, 25, 13, 1)
INSERT [dbo].[AnswerInQuestion] ([Id], [IdAnswer], [IdQuestion], [Correct]) VALUES (6, 26, 13, 0)
INSERT [dbo].[AnswerInQuestion] ([Id], [IdAnswer], [IdQuestion], [Correct]) VALUES (7, 27, 13, 0)
INSERT [dbo].[AnswerInQuestion] ([Id], [IdAnswer], [IdQuestion], [Correct]) VALUES (8, 28, 14, 0)
INSERT [dbo].[AnswerInQuestion] ([Id], [IdAnswer], [IdQuestion], [Correct]) VALUES (9, 29, 14, 0)
INSERT [dbo].[AnswerInQuestion] ([Id], [IdAnswer], [IdQuestion], [Correct]) VALUES (10, 30, 14, 1)
INSERT [dbo].[AnswerInQuestion] ([Id], [IdAnswer], [IdQuestion], [Correct]) VALUES (11, 31, 15, 0)
INSERT [dbo].[AnswerInQuestion] ([Id], [IdAnswer], [IdQuestion], [Correct]) VALUES (12, 32, 15, 1)
INSERT [dbo].[AnswerInQuestion] ([Id], [IdAnswer], [IdQuestion], [Correct]) VALUES (13, 33, 15, 0)
INSERT [dbo].[AnswerInQuestion] ([Id], [IdAnswer], [IdQuestion], [Correct]) VALUES (14, 34, 15, 0)
INSERT [dbo].[AnswerInQuestion] ([Id], [IdAnswer], [IdQuestion], [Correct]) VALUES (15, 35, 15, 0)
INSERT [dbo].[AnswerInQuestion] ([Id], [IdAnswer], [IdQuestion], [Correct]) VALUES (16, 36, 16, 1)
INSERT [dbo].[AnswerInQuestion] ([Id], [IdAnswer], [IdQuestion], [Correct]) VALUES (17, 37, 16, 0)
INSERT [dbo].[AnswerInQuestion] ([Id], [IdAnswer], [IdQuestion], [Correct]) VALUES (18, 38, 16, 0)
INSERT [dbo].[AnswerInQuestion] ([Id], [IdAnswer], [IdQuestion], [Correct]) VALUES (19, 39, 17, 0)
INSERT [dbo].[AnswerInQuestion] ([Id], [IdAnswer], [IdQuestion], [Correct]) VALUES (20, 40, 17, 1)
INSERT [dbo].[AnswerInQuestion] ([Id], [IdAnswer], [IdQuestion], [Correct]) VALUES (21, 41, 17, 0)
SET IDENTITY_INSERT [dbo].[AnswerInQuestion] OFF
GO
SET IDENTITY_INSERT [dbo].[Group] ON 

INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (1, 1, 1)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (2, 1, 2)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (3, 1, 3)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (4, 1, 4)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (5, 1, 5)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (6, 1, 6)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (7, 1, 7)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (8, 1, 8)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (9, 1, 9)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (10, 1, 10)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (11, 1, 11)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (12, 1, 12)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (13, 2, 1)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (14, 2, 2)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (15, 2, 3)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (16, 2, 4)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (17, 2, 5)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (18, 2, 6)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (19, 2, 7)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (20, 2, 8)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (21, 2, 9)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (22, 2, 10)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (23, 2, 11)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (24, 2, 12)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (25, 3, 1)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (26, 3, 2)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (27, 3, 3)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (28, 3, 4)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (29, 3, 5)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (30, 3, 6)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (31, 3, 7)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (32, 3, 8)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (33, 3, 9)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (34, 3, 10)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (35, 3, 11)
INSERT [dbo].[Group] ([Id], [IdName], [IdIndex]) VALUES (36, 3, 12)
SET IDENTITY_INSERT [dbo].[Group] OFF
GO
SET IDENTITY_INSERT [dbo].[GroupIndex] ON 

INSERT [dbo].[GroupIndex] ([Id], [Index]) VALUES (1, 11)
INSERT [dbo].[GroupIndex] ([Id], [Index]) VALUES (2, 12)
INSERT [dbo].[GroupIndex] ([Id], [Index]) VALUES (3, 13)
INSERT [dbo].[GroupIndex] ([Id], [Index]) VALUES (4, 21)
INSERT [dbo].[GroupIndex] ([Id], [Index]) VALUES (5, 22)
INSERT [dbo].[GroupIndex] ([Id], [Index]) VALUES (6, 23)
INSERT [dbo].[GroupIndex] ([Id], [Index]) VALUES (7, 31)
INSERT [dbo].[GroupIndex] ([Id], [Index]) VALUES (8, 32)
INSERT [dbo].[GroupIndex] ([Id], [Index]) VALUES (9, 33)
INSERT [dbo].[GroupIndex] ([Id], [Index]) VALUES (10, 41)
INSERT [dbo].[GroupIndex] ([Id], [Index]) VALUES (11, 42)
INSERT [dbo].[GroupIndex] ([Id], [Index]) VALUES (12, 43)
SET IDENTITY_INSERT [dbo].[GroupIndex] OFF
GO
SET IDENTITY_INSERT [dbo].[GroupName] ON 

INSERT [dbo].[GroupName] ([Id], [Name]) VALUES (1, N'ИС')
INSERT [dbo].[GroupName] ([Id], [Name]) VALUES (2, N'СИС')
INSERT [dbo].[GroupName] ([Id], [Name]) VALUES (3, N'ОИБ')
SET IDENTITY_INSERT [dbo].[GroupName] OFF
GO
SET IDENTITY_INSERT [dbo].[Human] ON 

INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (196, N'Дмитрий', N'Румянцев', N'Даниэльевич', 1, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (197, N'Дмитрий', N'Борисов', N'Максимович', 2, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (198, N'София', N'Алексеева', N'Адамовна', 3, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (199, N'Артемий', N'Фролов', N'Степанович', 4, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (200, N'Полина', N'Аксенова', N'Артёмовна', 5, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (201, N'Арсений', N'Аксенова', N'Дмитриевич', 6, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (202, N'Григорий', N'Антипов', N'Матвеевич', 7, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (203, N'Роман', N'Комаров', N'Владиславович', 8, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (204, N'Алёна', N'Власова', N'Ярославовна', 9, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (205, N'Григорий', N'Воронов', N'Эмильевич', 10, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (206, N'Максим', N'Одинцов', N'Иванович', 11, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (207, N'Евгений', N'Михеев', N'Александрович', 12, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (208, N'Наталья', N'Исаева', N'Михайловна', 13, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (209, N'Валерия', N'Головина', N'Романовна', 14, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (210, N'Анастасия', N'Алешина', N'Романовна', 15, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (211, N'Мира', N'Иванова', N'Александровна', 16, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (212, N'Александр', N'Овчинников', N'Александрович', 17, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (213, N'Анна', N'Масленникова', N'Глебовна', 18, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (214, N'Мария', N'Киселева', N'Николаевна', 19, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (215, N'Полина', N'Сидорова', N'Георгиевна', 20, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (216, N'Григорий', N'Соловьев', N'Романович', 21, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (217, N'Александр', N'Беляев', N'Артёмович', 22, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (218, N'Арина', N'Калинина', N'Лукинична', 23, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (219, N'Полина', N'Миронова', N'Ивановна', 24, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (220, N'Даниил', N'Котов', N'Николаевич', 25, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (221, N'Сафия', N'Блинова', N'Тимофеевна', 26, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (222, N'Александр', N'Филиппов', N'Александрович', 27, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (223, N'Фёдор', N'Соловьев', N'Тимофеевич', 28, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (224, N'Лев', N'Громов', N'Артурович', 29, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (225, N'Маргарита', N'Зубова', N'Святославовна', 30, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (226, N'Михаил', N'Морозов', N'Степанович', 31, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (227, N'Павел', N'Сидоров', N'Георгиевич', 32, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (228, N'Матвей', N'Соболев', N'Платонович', 33, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (229, N'Егор', N'Гончаров', N'Николаевич', 34, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (230, N'Вера', N'Зубкова', N'Марковна', 35, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (231, N'Ясмина', N'Артамонова', N'Михайловна', 36, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (232, N'Леон', N'Хомяков', N'Маркович', NULL, 1)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (233, N'Полина', N'Короткова', N'Тимофеевна', NULL, 2)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (234, N'Василий', N'Вишневский', N'Романович', NULL, 3)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (235, N'Арсений', N'Грачев', N'Платонович', NULL, 4)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (236, N'Марк', N'Мещеряков', N'Арсентьевич', NULL, 5)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (237, N'Василий', N'Смирнов', N'Владиславович', NULL, 6)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (238, N'Роман', N'Селезнев', N'Станиславович', NULL, 7)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (239, N'Ева', N'Савельева', N'Александровна', NULL, 8)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (240, N'Евгений', N'Хохлов', N'Адамович', NULL, 9)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (241, N'Александра', N'Степанова', N'Егоровна', NULL, 10)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (242, N'Мария', N'Дементьева', N'Александровна', NULL, NULL)
INSERT [dbo].[Human] ([Id], [FirstName], [Surname], [Patronymic], [IdGroup], [IdSubject]) VALUES (255, N'н', N'н', N'н', 3, NULL)
SET IDENTITY_INSERT [dbo].[Human] OFF
GO
SET IDENTITY_INSERT [dbo].[ImageProfile] ON 

INSERT [dbo].[ImageProfile] ([Id], [Image]) VALUES (1, N'C:\Users\Olya\Desktop\YP\ImageProfile\DefaultImg.png')
SET IDENTITY_INSERT [dbo].[ImageProfile] OFF
GO
SET IDENTITY_INSERT [dbo].[Lecture] ON 

INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (2, 1, N'ГЕНЕРАЛЬНАЯ СОВОКУПНОСТЬ. ВЫБОРКА. 
ВАРИАЦИОННЫЕ РЯДЫ И ИХ ГРАФИЧЕСКОЕ
ИЗОБРАЖЕНИЕ', N'C:\Users\Olya\Desktop\YP\Math\Математическая статистика_1.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (4, 1, N'ЭМПИРИЧЕСКАЯ ФУНКЦИЯ РАСПРЕДЕЛЕНИЯ 
И ЕЕ СВОЙСТВА. ЧИСЛОВЫЕ ХАРАКТЕРИСТИКИ
ВЫБОРКИ', N'C:\Users\Olya\Desktop\YP\Math\Математическая статистика_2.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (5, 1, N'ТОЧЕЧНЫЕ ОЦЕНКИ НЕИЗВЕСТНЫХ ПАРАМЕТРОВ
РАСПРЕДЕЛЕНИЯ ИССЛЕДУЕМОЙ СЛУЧАЙНОЙ
ВЕЛИЧИНЫ', N'C:\Users\Olya\Desktop\YP\Math\Математическая статистика_3.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (7, 1, N'ИНТЕРВАЛЬНЫЕ ОЦЕНКИ', N'C:\Users\Olya\Desktop\YP\Math\Математическая статистика_4.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (8, 2, N'ОСНОВНЫЕ ПОНЯТИЯ ХИМИИ', N'C:\Users\Olya\Desktop\YP\Chemistry\Химия_1.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (9, 2, N'СТРОЕНИЕ ВЕЩЕСТВА', N'C:\Users\Olya\Desktop\YP\Chemistry\Химия_2.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (10, 2, N'Периодический закон и Периодическая система элементов 
Д.И. Менделеева', N'C:\Users\Olya\Desktop\YP\Chemistry\Химия_3.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (11, 2, N'Молекулы, кристаллы, химическая связь
', N'C:\Users\Olya\Desktop\YP\Chemistry\Химия_4.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (14, 3, N'ФИЗИЧЕСКИЕ ОСНОВЫ МЕХАНИК', N'C:\Users\Olya\Desktop\YP\Physics\Физика_1.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (16, 3, N'МОЛЕКУЛЯРНАЯ ФИЗИКА И
ТЕРМОДИНАМИКА', N'C:\Users\Olya\Desktop\YP\Physics\Физика_2.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (17, 3, N'ЭЛЕКТРОСТАТИКА И ПОСТОЯННЫЙ ТОК', N'C:\Users\Olya\Desktop\YP\Physics\Физика_3.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (18, 3, N'ЭЛЕКТРОМАГНЕТИЗМ', N'C:\Users\Olya\Desktop\YP\Physics\Физика_4.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (19, 4, N'Информация и информатика', N'C:\Users\Olya\Desktop\YP\Computer science\Информатика_1.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (20, 4, N'История развития вычислительной техники.', N'C:\Users\Olya\Desktop\YP\Computer science\Информатика_2.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (21, 4, N'Типы запоминающих устройств. Хранение и обработка 
информации.
', N'C:\Users\Olya\Desktop\YP\Computer science\Информатика_3.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (22, 4, N'Программное обеспечение. ', N'C:\Users\Olya\Desktop\YP\Computer science\Информатика_4.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (23, 5, N'Правила безопасного поведения в условиях вынужденного 
автономного существования', N'C:\Users\Olya\Desktop\YP\ОБЖ\ОБЖ_1.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (24, 5, N'Правила безопасного 
поведения 
в ситуациях 
криминогенного характера. 

Уголовная ответственность 
несовершеннолетних. 
', N'C:\Users\Olya\Desktop\YP\ОБЖ\ОБЖ_2.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (26, 5, N'РСЧС', N'C:\Users\Olya\Desktop\YP\ОБЖ\ОБЖ_3.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (27, 5, N'Ядерное, химическое, бактериологическое оружие и 
обычные средства поражения.', N'C:\Users\Olya\Desktop\YP\ОБЖ\ОБЖ_4.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (28, 6, N'БЕЗОПАСНОСТЬ ЖИЗНЕДЕЯТЕЛЬНОСТИ В ПРОФЕССИОНАЛЬНОЙ ДЕЯТЕЛЬНОСТИ И В БЫТУ', N'C:\Users\Olya\Desktop\YP\БЖД\БЖД_1.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (29, 6, N'БЕЗОПАСНОСТЬ ЖИЗНЕДЕЯТЕЛЬНОСТИ В 
ЧРЕЗВЫЧАЙНЫХ СИТУАЦИЯХ', N'C:\Users\Olya\Desktop\YP\БЖД\БЖД_2.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (31, 6, N'ОСНОВЫ ВОЕННОЙ СЛУЖБЫ', N'C:\Users\Olya\Desktop\YP\БЖД\БЖД_3.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (32, 6, N'ОСНОВЫ МЕДИЦИНСКИХ ЗНАНИЙ И ЗДОРОВОГО ОБРАЗА 
ЖИЗНИ', N'C:\Users\Olya\Desktop\YP\БЖД\БЖД_4.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (33, 7, N'Введение в язык Kotlin', N'C:\Users\Olya\Desktop\YP\Разработка мобильных приложений\Лекция #1. Введение в язык Kotlin.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (34, 7, N'Основные операции в Kotlin', N'C:\Users\Olya\Desktop\YP\Разработка мобильных приложений\Лекция #2. Основные операции в Kotlin.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (35, 7, N'Выражения, функции, переменные и константы в Kotlin', N'C:\Users\Olya\Desktop\YP\Разработка мобильных приложений\Лекция #3. Выражения, функции, переменные и константы в Kotlin.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (36, 7, N'Лекция #4. Типы данных и операции в Kotlin, часть 1', N'C:\Users\Olya\Desktop\YP\Разработка мобильных приложений\Лекция #4. Типы данных и операции в Kotlin, часть 1.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (37, 8, N'Основы работы с HTML', N'C:\Users\Olya\Desktop\YP\Веб-программирование\Основы работы с HTML.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (38, 8, N'Оформление символов', N'C:\Users\Olya\Desktop\YP\Веб-программирование\Оформление символов.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (39, 8, N'Списки', N'C:\Users\Olya\Desktop\YP\Веб-программирование\Списки.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (40, 8, N'Таблицы', N'C:\Users\Olya\Desktop\YP\Веб-программирование\Таблицы.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (42, 9, N'Основные понятия БД', N'C:\Users\Olya\Desktop\YP\Базы данных\Лекция 1 Основные понятия БД.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (43, 9, N'Основные принципы проектирования ИС', N'C:\Users\Olya\Desktop\YP\Базы данных\Лекция 2 Основные принципы проектирования ИС.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (44, 9, N'СУБД', N'C:\Users\Olya\Desktop\YP\Базы данных\Лекция 3 СУБД.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (45, 9, N'Модели данных', N'C:\Users\Olya\Desktop\YP\Базы данных\Лекция 4 Модели данных.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (46, 10, N'Общие положения', N'C:\Users\Olya\Desktop\YP\ОС и среды\OS_lectures_1.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (47, 10, N'Общие принципы построения ОС
', N'C:\Users\Olya\Desktop\YP\ОС и среды\OS_lectures_2.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (48, 10, N'Память. Структура памяти.', N'C:\Users\Olya\Desktop\YP\ОС и среды\OS_lectures_3.pdf')
INSERT [dbo].[Lecture] ([Id], [IdSubject], [Name], [Lecture]) VALUES (49, 10, N'Машинно-независимые свойства ОС.', N'C:\Users\Olya\Desktop\YP\ОС и среды\OS_lectures_4.pdf')
SET IDENTITY_INSERT [dbo].[Lecture] OFF
GO
SET IDENTITY_INSERT [dbo].[Question] ON 

INSERT [dbo].[Question] ([Id], [Name]) VALUES (1, N'Статистической совокупностью называют')
INSERT [dbo].[Question] ([Id], [Name]) VALUES (13, N'Сколько будет 7+5?')
INSERT [dbo].[Question] ([Id], [Name]) VALUES (14, N'Если у вас есть 15 яблок и вы отдали другу 6, сколько яблок у вас осталось?')
INSERT [dbo].[Question] ([Id], [Name]) VALUES (15, N'Умножьте 8 на 9.')
INSERT [dbo].[Question] ([Id], [Name]) VALUES (16, N'Вычтите 20 из 45. Чему равен результат?')
INSERT [dbo].[Question] ([Id], [Name]) VALUES (17, N'Разделите 81 на 9.')
SET IDENTITY_INSERT [dbo].[Question] OFF
GO
SET IDENTITY_INSERT [dbo].[QuestionInTest] ON 

INSERT [dbo].[QuestionInTest] ([Id], [IdQuestion], [IdTest], [Number]) VALUES (1, 1, 1, 1)
INSERT [dbo].[QuestionInTest] ([Id], [IdQuestion], [IdTest], [Number]) VALUES (13, 13, 33, 1)
INSERT [dbo].[QuestionInTest] ([Id], [IdQuestion], [IdTest], [Number]) VALUES (14, 14, 33, 2)
INSERT [dbo].[QuestionInTest] ([Id], [IdQuestion], [IdTest], [Number]) VALUES (15, 15, 33, 3)
INSERT [dbo].[QuestionInTest] ([Id], [IdQuestion], [IdTest], [Number]) VALUES (16, 16, 33, 4)
INSERT [dbo].[QuestionInTest] ([Id], [IdQuestion], [IdTest], [Number]) VALUES (17, 17, 33, 5)
SET IDENTITY_INSERT [dbo].[QuestionInTest] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [Name]) VALUES (1, N'Администратор')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (2, N'Преподаватель')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (3, N'Студент')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[Score] ON 

INSERT [dbo].[Score] ([Id], [Number]) VALUES (1, 2)
INSERT [dbo].[Score] ([Id], [Number]) VALUES (2, 3)
INSERT [dbo].[Score] ([Id], [Number]) VALUES (3, 4)
INSERT [dbo].[Score] ([Id], [Number]) VALUES (4, 5)
SET IDENTITY_INSERT [dbo].[Score] OFF
GO
SET IDENTITY_INSERT [dbo].[Subject] ON 

INSERT [dbo].[Subject] ([Id], [Name]) VALUES (1, N'Математическа статистика')
INSERT [dbo].[Subject] ([Id], [Name]) VALUES (2, N'Химия')
INSERT [dbo].[Subject] ([Id], [Name]) VALUES (3, N'Физика')
INSERT [dbo].[Subject] ([Id], [Name]) VALUES (4, N'Информатика')
INSERT [dbo].[Subject] ([Id], [Name]) VALUES (5, N'ОБЖ')
INSERT [dbo].[Subject] ([Id], [Name]) VALUES (6, N'БЖД')
INSERT [dbo].[Subject] ([Id], [Name]) VALUES (7, N'Разработка мобильных приложений')
INSERT [dbo].[Subject] ([Id], [Name]) VALUES (8, N'Веб-программирование')
INSERT [dbo].[Subject] ([Id], [Name]) VALUES (9, N'Базы данных')
INSERT [dbo].[Subject] ([Id], [Name]) VALUES (10, N'Операционные системы и среды')
SET IDENTITY_INSERT [dbo].[Subject] OFF
GO
SET IDENTITY_INSERT [dbo].[Test] ON 

INSERT [dbo].[Test] ([Id], [IdSubject], [Name]) VALUES (1, 1, N'ГЕНЕРАЛЬНАЯ СОВОКУПНОСТЬ. ВЫБОРКА. ')
INSERT [dbo].[Test] ([Id], [IdSubject], [Name]) VALUES (33, 1, N'Простая арифметика')
SET IDENTITY_INSERT [dbo].[Test] OFF
GO
SET IDENTITY_INSERT [dbo].[TestScore] ON 

INSERT [dbo].[TestScore] ([Id], [IdUser], [IdTest], [IdScore]) VALUES (3, 59, 1, 2)
INSERT [dbo].[TestScore] ([Id], [IdUser], [IdTest], [IdScore]) VALUES (4, 58, 1, 4)
INSERT [dbo].[TestScore] ([Id], [IdUser], [IdTest], [IdScore]) VALUES (5, 60, 1, 1)
INSERT [dbo].[TestScore] ([Id], [IdUser], [IdTest], [IdScore]) VALUES (6, 56, 1, 4)
INSERT [dbo].[TestScore] ([Id], [IdUser], [IdTest], [IdScore]) VALUES (9, 98, 33, 4)
SET IDENTITY_INSERT [dbo].[TestScore] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (52, N'student1', N'student1', 3, 196, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (53, N'student2', N'student2', 3, 197, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (54, N'student3', N'student3', 3, 198, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (55, N'student4', N'student4', 3, 199, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (56, N'student5', N'student5', 3, 200, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (57, N'student6', N'student6', 3, 201, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (58, N'student7', N'student7', 3, 202, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (59, N'student8', N'student8', 3, 203, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (60, N'student9', N'student9', 3, 204, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (61, N'student10', N'student10', 3, 205, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (62, N'student11', N'student11', 3, 206, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (63, N'student12', N'student12', 3, 207, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (64, N'student13', N'student13', 3, 208, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (65, N'student14', N'student14', 3, 209, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (66, N'student15', N'student15', 3, 210, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (67, N'student16', N'student16', 3, 211, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (68, N'student17', N'student17', 3, 212, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (69, N'student18', N'student18', 3, 213, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (70, N'student19', N'student19', 3, 214, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (71, N'student20', N'student20', 3, 215, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (72, N'student21', N'student21', 3, 216, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (73, N'student22', N'student22', 3, 217, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (74, N'student23', N'student23', 3, 218, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (75, N'student24', N'student24', 3, 219, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (76, N'student25', N'student25', 3, 220, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (77, N'student26', N'student26', 3, 221, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (78, N'student27', N'student27', 3, 222, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (79, N'student28', N'student28', 3, 223, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (80, N'student29', N'student29', 3, 224, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (81, N'student30', N'student30', 3, 225, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (82, N'student31', N'student31', 3, 226, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (83, N'student32', N'student32', 3, 227, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (84, N'student33', N'student33', 3, 228, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (85, N'student34', N'student34', 3, 229, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (86, N'student35', N'student35', 3, 230, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (87, N'student36', N'student36', 3, 231, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (88, N'teacher1', N'teacher1', 2, 232, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (89, N'teacher2', N'teacher2', 2, 233, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (90, N'teacher3', N'teacher3', 2, 234, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (91, N'teacher4', N'teacher4', 2, 235, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (92, N'teacher5', N'teacher5', 2, 236, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (93, N'teacher6', N'teacher6', 2, 237, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (94, N'teacher7', N'teacher7', 2, 238, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (95, N'teacher8', N'teacher8', 2, 239, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (96, N'teacher9', N'teacher9', 2, 240, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (97, N'teacher10', N'teacher10', 2, 241, 1)
INSERT [dbo].[User] ([Id], [Login], [Password], [IdRole], [IdHuman], [IdImage]) VALUES (98, N'admin', N'admin', 1, 242, 1)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT ((1)) FOR [IdImage]
GO
ALTER TABLE [dbo].[AnswerInQuestion]  WITH CHECK ADD  CONSTRAINT [FK_AnswerInQuestion_Answer] FOREIGN KEY([IdAnswer])
REFERENCES [dbo].[Answer] ([Id])
GO
ALTER TABLE [dbo].[AnswerInQuestion] CHECK CONSTRAINT [FK_AnswerInQuestion_Answer]
GO
ALTER TABLE [dbo].[AnswerInQuestion]  WITH CHECK ADD  CONSTRAINT [FK_AnswerInQuestion_Question] FOREIGN KEY([IdQuestion])
REFERENCES [dbo].[Question] ([Id])
GO
ALTER TABLE [dbo].[AnswerInQuestion] CHECK CONSTRAINT [FK_AnswerInQuestion_Question]
GO
ALTER TABLE [dbo].[Group]  WITH CHECK ADD  CONSTRAINT [FK_Group_GroupIndex] FOREIGN KEY([IdIndex])
REFERENCES [dbo].[GroupIndex] ([Id])
GO
ALTER TABLE [dbo].[Group] CHECK CONSTRAINT [FK_Group_GroupIndex]
GO
ALTER TABLE [dbo].[Group]  WITH CHECK ADD  CONSTRAINT [FK_Group_GroupName] FOREIGN KEY([IdName])
REFERENCES [dbo].[GroupName] ([Id])
GO
ALTER TABLE [dbo].[Group] CHECK CONSTRAINT [FK_Group_GroupName]
GO
ALTER TABLE [dbo].[Human]  WITH CHECK ADD  CONSTRAINT [FK_Human_Group] FOREIGN KEY([IdGroup])
REFERENCES [dbo].[Group] ([Id])
GO
ALTER TABLE [dbo].[Human] CHECK CONSTRAINT [FK_Human_Group]
GO
ALTER TABLE [dbo].[Human]  WITH CHECK ADD  CONSTRAINT [FK_Human_Subject] FOREIGN KEY([IdSubject])
REFERENCES [dbo].[Subject] ([Id])
GO
ALTER TABLE [dbo].[Human] CHECK CONSTRAINT [FK_Human_Subject]
GO
ALTER TABLE [dbo].[Lecture]  WITH CHECK ADD  CONSTRAINT [FK_Lecture_Subject] FOREIGN KEY([IdSubject])
REFERENCES [dbo].[Subject] ([Id])
GO
ALTER TABLE [dbo].[Lecture] CHECK CONSTRAINT [FK_Lecture_Subject]
GO
ALTER TABLE [dbo].[QuestionInTest]  WITH CHECK ADD  CONSTRAINT [FK_QuestionInTest_Question] FOREIGN KEY([IdQuestion])
REFERENCES [dbo].[Question] ([Id])
GO
ALTER TABLE [dbo].[QuestionInTest] CHECK CONSTRAINT [FK_QuestionInTest_Question]
GO
ALTER TABLE [dbo].[QuestionInTest]  WITH CHECK ADD  CONSTRAINT [FK_QuestionInTest_Test] FOREIGN KEY([IdTest])
REFERENCES [dbo].[Test] ([Id])
GO
ALTER TABLE [dbo].[QuestionInTest] CHECK CONSTRAINT [FK_QuestionInTest_Test]
GO
ALTER TABLE [dbo].[Test]  WITH CHECK ADD  CONSTRAINT [FK_Test_Subject] FOREIGN KEY([IdSubject])
REFERENCES [dbo].[Subject] ([Id])
GO
ALTER TABLE [dbo].[Test] CHECK CONSTRAINT [FK_Test_Subject]
GO
ALTER TABLE [dbo].[TestScore]  WITH CHECK ADD  CONSTRAINT [FK_TestScore_Score] FOREIGN KEY([IdScore])
REFERENCES [dbo].[Score] ([Id])
GO
ALTER TABLE [dbo].[TestScore] CHECK CONSTRAINT [FK_TestScore_Score]
GO
ALTER TABLE [dbo].[TestScore]  WITH CHECK ADD  CONSTRAINT [FK_TestScore_Test] FOREIGN KEY([IdTest])
REFERENCES [dbo].[Test] ([Id])
GO
ALTER TABLE [dbo].[TestScore] CHECK CONSTRAINT [FK_TestScore_Test]
GO
ALTER TABLE [dbo].[TestScore]  WITH CHECK ADD  CONSTRAINT [FK_TestScore_User] FOREIGN KEY([IdUser])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[TestScore] CHECK CONSTRAINT [FK_TestScore_User]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Human] FOREIGN KEY([IdHuman])
REFERENCES [dbo].[Human] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Human]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_ImageProfile] FOREIGN KEY([IdImage])
REFERENCES [dbo].[ImageProfile] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_ImageProfile]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([IdRole])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
USE [master]
GO
ALTER DATABASE [TestDB] SET  READ_WRITE 
GO
