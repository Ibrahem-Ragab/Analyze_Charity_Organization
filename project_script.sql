USE [master]
GO
/****** Object:  Database [charity]    Script Date: 8/19/2023 10:46:32 PM ******/
CREATE DATABASE [charity]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'charity', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\charity.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'charity_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\charity_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [charity] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [charity].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [charity] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [charity] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [charity] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [charity] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [charity] SET ARITHABORT OFF 
GO
ALTER DATABASE [charity] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [charity] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [charity] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [charity] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [charity] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [charity] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [charity] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [charity] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [charity] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [charity] SET  DISABLE_BROKER 
GO
ALTER DATABASE [charity] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [charity] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [charity] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [charity] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [charity] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [charity] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [charity] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [charity] SET RECOVERY FULL 
GO
ALTER DATABASE [charity] SET  MULTI_USER 
GO
ALTER DATABASE [charity] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [charity] SET DB_CHAINING OFF 
GO
ALTER DATABASE [charity] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [charity] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [charity] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [charity] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'charity', N'ON'
GO
ALTER DATABASE [charity] SET QUERY_STORE = ON
GO
ALTER DATABASE [charity] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [charity]
GO
/****** Object:  UserDefinedFunction [dbo].[Get_Total_Salary]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Get_Total_Salary](@branch_id INT)
RETURNS int
AS
BEGIN
    DECLARE @Total_Salary int

    SELECT @Total_Salary = SUM(Salary)
    FROM Employee , charity_organization c
    WHERE c.id = @branch_id
	

    RETURN @Total_Salary
END
GO
/****** Object:  Table [dbo].[charity_organization]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[charity_organization](
	[id] [int] NOT NULL,
	[charity_name] [varchar](50) NULL,
	[charity_address] [varchar](50) NULL,
	[phone] [varchar](20) NULL,
	[contact_info] [varchar](30) NULL,
	[manager_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[project]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[project](
	[p_id] [int] NOT NULL,
	[p_name] [varchar](50) NULL,
	[org_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[p_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[projects_per_branch]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--create view that display number of projects per barnch 
create view [dbo].[projects_per_branch] 
as
select charity_name, count(p_id) total
from charity_organization ch inner join project p
on ch.id=p.org_id
group by charity_name
GO
/****** Object:  View [dbo].[projects_for_branchs]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[projects_for_branchs] 
as
select charity_name, count(p_id) total
from charity_organization ch inner join project p
on ch.id=p.org_id
group by charity_name
GO
/****** Object:  Table [dbo].[volunteers]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[volunteers](
	[vol_id] [int] NOT NULL,
	[vol_name] [varchar](50) NULL,
	[vol_mail] [varchar](30) NULL,
	[vol_phone] [varchar](20) NULL,
	[org_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[vol_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[volunteers_for_project]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[volunteers_for_project] 
as
select  p_name ,count( vol_id ) as total_volunteers
from project p inner join charity_organization ch on p.org_id = ch. id inner join volunteers v
on ch.id=v.org_id
group by p_name
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[emp_id] [int] NOT NULL,
	[emp_name] [varchar](50) NULL,
	[salary] [decimal](10, 2) NULL,
	[emp_phone] [varchar](20) NULL,
	[emp_mail] [varchar](30) NULL,
	[org_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[emp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[employee_salaries_more_than_avg]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[employee_salaries_more_than_avg] as
select ch.charity_name, e.emp_name,e.salary
from charity_organization  ch inner join  employee e 
ON ch.id=e.org_id
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employee
)

GO
/****** Object:  UserDefinedFunction [dbo].[Get_High_Salary_Employees]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Get_High_Salary_Employees](@MinSalary int)
RETURNS TABLE
AS
RETURN
(
    SELECT emp_id, emp_name, Salary
    FROM Employee
    WHERE Salary > @MinSalary
)
GO
/****** Object:  Table [dbo].[donor]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[donor](
	[donor_id] [int] NOT NULL,
	[donor_name] [varchar](50) NULL,
	[donation_amount] [decimal](10, 2) NULL,
	[donation_date] [date] NULL,
	[donor_phone] [varchar](20) NULL,
	[org_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[donor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[total_donation_per_branch1]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[total_donation_per_branch1] as
select id,charity_name , sum(donation_amount) Total_donation FROM charity_organization ch inner join donor d
on ch.id=d.org_id
group by id,charity_name
GO
/****** Object:  View [dbo].[manager_name_per_branch]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[manager_name_per_branch] as
select charity_name , emp_name as manager 
from charity_organization ch inner join employee e
on manager_id=e.emp_id
GO
/****** Object:  View [dbo].[average_salary_per_branch]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[average_salary_per_branch] as
SELECT ch.charity_name , AVG(e.salary) AS AverageSalary
FROM   charity_organization  ch inner join  employee e 
ON ch.id=e.org_id
GROUP BY ch.charity_name
GO
/****** Object:  Table [dbo].[beneficiaries]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[beneficiaries](
	[ben_id] [int] NOT NULL,
	[ben_name] [varchar](50) NULL,
	[ben_phone] [varchar](20) NULL,
	[ben_address] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ben_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[charity_beneficiaries]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[charity_beneficiaries](
	[ben_id] [int] NULL,
	[org_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[volunteers_project]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[volunteers_project](
	[pro_id] [int] NULL,
	[vol_id] [int] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20001, N'Silvanus Dragge', N'685-581-6856', N'5 Farmco Pass')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20002, N'Byran Lingfoot', N'108-241-5696', N'57136 Dixon Court')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20003, N'Ozzie Monck', N'955-513-1159', N'8619 Northport Way')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20004, N'Gerda Ambrois', N'563-888-2326', N'35000 Burrows Crossing')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20005, N'Lloyd Helmke', N'703-447-3490', N'561 Ludington Way')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20006, N'Vivianne Rochford', N'916-309-3717', N'88 Nevada Center')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20007, N'Dorella Fulmen', N'724-294-2383', N'29066 Reindahl Junction')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20008, N'Parsifal Gerran', N'340-225-9607', N'5386 Golf Way')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20009, N'Nikaniki Walisiak', N'940-739-8677', N'14505 Burrows Trail')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20010, N'Harri Mcimmie', N'869-728-3438', N'39890 Elka Plaza')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20011, N'Myra Luther', N'917-632-3216', N'2735 Westport Point')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20012, N'Farrand Paulig', N'255-571-5597', N'219 Di Loreto Alley')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20013, N'Sarene Buckler', N'123-980-0987', N'57683 Springs Pass')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20014, N'Tiena Caulkett', N'641-954-7913', N'53 Prentice Alley')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20015, N'Chelsae McPhee', N'227-578-3711', N'74400 Esch Crossing')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20016, N'Guy Walster', N'633-762-1563', N'072 Hudson Center')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20017, N'Si Westphalen', N'614-674-6385', N'29 Banding Way')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20018, N'Corinne Tenny', N'242-856-5373', N'08647 Bartillon Lane')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20019, N'Belita Iveson', N'391-250-0517', N'50369 Chinook Place')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20020, N'Magda Coppock.', N'323-804-7254', N'6948 Manitowish Terrace')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20021, N'Gratia Blunsden', N'580-444-0942', N'629 Dryden Crossing')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20022, N'Tonia Autie', N'879-873-9715', N'288 Dapin Way')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20023, N'Dukey Hyam', N'597-607-8916', N'58134 Jackson Avenue')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20024, N'Kathleen Quarton', N'532-666-2439', N'5 Colorado Trail')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20025, N'Jewelle Occleshaw', N'554-579-9048', N'533 Nancy Plaza')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20026, N'Desiri Belle', N'620-124-5944', N'8302 Ohio Junction')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20027, N'Margarette Halliwell', N'701-162-0176', N'5 Bowman Crossing')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20028, N'Anabelle Chamberlain', N'171-421-5364', N'09 Steensland Place')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20029, N'Murdock Charlewood', N'109-467-5613', N'2803 Quincy Road')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20030, N'Gordon Crowden', N'149-820-6724', N'3 Melvin Center')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20031, N'Hilary Loges', N'181-243-0688', N'88271 Redwing Avenue')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20032, N'Terri Lyddyard', N'851-157-8065', N'34906 Surrey Way')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20033, N'Jdavie Rosettini', N'400-263-2699', N'39 Eastwood Court')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20034, N'Ricard Drakes', N'707-968-0923', N'5493 Clove Place')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20035, N'Katharyn Lippard', N'984-683-0658', N'58 Bay Drive')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20036, N'Layne Fishleigh', N'567-405-1067', N'3809 Claremont Avenue')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20037, N'Betteann Truckell', N'309-313-9150', N'5 Northfield Terrace')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20038, N'Sydel Croxon', N'408-738-0578', N'78115 Michigan Parkway')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20039, N'Emylee Sturridge', N'819-571-9290', N'9 Ridge Oak Crossing')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20040, N'Sher Barajaz', N'748-339-7919', N'290 Clove Junction')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20041, N'Robinetta Colson', N'996-631-5078', N'9 Talisman Circle')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20042, N'Gilberta Godbold', N'853-414-8263', N'8431 Trailsway Hill')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20043, N'Hughie Moyne', N'542-806-6193', N'6153 Old Gate Plaza')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20044, N'Mara McGeechan', N'547-763-7083', N'37 Carpenter Avenue')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20045, N'Deva Thornber', N'250-236-5203', N'17165 Jenifer Center')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20046, N'Linet Huett', N'101-733-7996', N'55 Oriole Hill')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20047, N'Cody Tort', N'470-612-3034', N'3 Butterfield Alley')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20048, N'Cordy Isbell', N'369-116-6918', N'823 Helena Road')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20049, N'Evered Cawsey', N'998-694-9467', N'82142 Rockefeller Drive')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20050, N'Lorianne Schellig', N'677-237-6074', N'4 Dovetail Drive')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20051, N'Myrlene Le Leu', N'859-754-2759', N'8 Dexter Hill')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20052, N'Lynnea Imason', N'371-858-2305', N'008 Garrison Road')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20053, N'Grete Arndt', N'577-318-0383', N'70 Menomonie Place')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20054, N'Gus Chalcroft', N'906-212-6405', N'330 5th Point')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20055, N'Kippy Brafield', N'990-965-5377', N'4 Killdeer Crossing')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20056, N'Kailey Tadd', N'685-673-7685', N'90 East Plaza')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20057, N'Court Scranney', N'379-930-0182', N'2353 Thackeray Way')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20058, N'Tedman Bortol', N'168-180-6500', N'8 Briar Crest Drive')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20059, N'Ashleigh Metts', N'243-791-5297', N'912 Corry Avenue')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20060, N'Goddart Whitely', N'555-479-4361', N'39 Lake View Parkway')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20061, N'Catie Trenbey', N'763-897-4152', N'1985 Crowley Junction')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20062, N'Howie Paxeford', N'759-762-3154', N'997 Ridgeview Park')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20063, N'Garrett Sarginson', N'109-673-4256', N'80294 Saint Paul Point')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20064, N'Lauree Isted', N'777-524-1795', N'24 Oak Valley Center')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20065, N'Carmel Harrisson', N'418-648-4688', N'8903 Debra Point')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20066, N'Matti Meakes', N'115-656-5848', N'645 Moulton Place')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20067, N'Ida Darragh', N'112-286-9869', N'485 Schlimgen Road')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20068, N'Sosanna Vautier', N'232-656-4328', N'1 American Ash Way')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20069, N'Obediah Coal', N'627-400-7091', N'5074 Pearson Alley')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20070, N'Gasparo Marcombe', N'207-169-0379', N'22 Portage Way')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20071, N'Roseanna Gumn', N'535-852-6500', N'089 Toban Court')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20072, N'Camile Fearnyhough', N'462-985-0652', N'457 Nobel Crossing')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20073, N'Abbye Greenhough', N'284-963-5092', N'1108 David Parkway')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20074, N'Heinrick Kluge', N'436-438-9684', N'15 Reinke Lane')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20075, N'Koral Kernley', N'341-322-5561', N'397 Manufacturers Street')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20076, N'Clair Blackston', N'654-565-2894', N'1781 Butternut Terrace')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20077, N'Vladamir Dimelow', N'431-831-1011', N'989 Autumn Leaf Plaza')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20078, N'Ingrim Dumper', N'690-798-9226', N'796 Talisman Drive')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20079, N'Nessi Anthonies', N'215-346-1762', N'86 Shopko Crossing')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20080, N'Con Witterick', N'462-788-4766', N'509 Sauthoff Street')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20081, N'Gonzalo Joontjes', N'479-286-8150', N'060 Hazelcrest Point')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20082, N'Cobby Brimicombe', N'861-527-1569', N'841 Southridge Lane')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20083, N'Fanechka Poles', N'233-196-7099', N'611 Independence Alley')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20084, N'Renie Southerton', N'695-433-1222', N'270 Brentwood Street')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20085, N'Elset Beynkn', N'399-538-8804', N'89 Kropf Avenue')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20086, N'Ware Masseo', N'112-850-5793', N'9 Trailsway Circle')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20087, N'Darlleen Wellen', N'476-477-6873', N'7614 Quincy Parkway')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20088, N'Darbie Nial', N'819-608-2797', N'2460 Canary Point')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20089, N'Vassily Foulcher', N'749-654-0944', N'43073 Prentice Parkway')
INSERT [dbo].[beneficiaries] ([ben_id], [ben_name], [ben_phone], [ben_address]) VALUES (20090, N'Leland Waterfall', N'458-452-8031', N'358 2nd Circle')
GO
INSERT [dbo].[charity_beneficiaries] ([ben_id], [org_id]) VALUES (20050, 3)
INSERT [dbo].[charity_beneficiaries] ([ben_id], [org_id]) VALUES (20015, 2)
INSERT [dbo].[charity_beneficiaries] ([ben_id], [org_id]) VALUES (20053, 1)
INSERT [dbo].[charity_beneficiaries] ([ben_id], [org_id]) VALUES (20048, 3)
INSERT [dbo].[charity_beneficiaries] ([ben_id], [org_id]) VALUES (20048, 4)
INSERT [dbo].[charity_beneficiaries] ([ben_id], [org_id]) VALUES (20044, 1)
INSERT [dbo].[charity_beneficiaries] ([ben_id], [org_id]) VALUES (20081, 3)
INSERT [dbo].[charity_beneficiaries] ([ben_id], [org_id]) VALUES (20010, 4)
INSERT [dbo].[charity_beneficiaries] ([ben_id], [org_id]) VALUES (20065, 4)
INSERT [dbo].[charity_beneficiaries] ([ben_id], [org_id]) VALUES (20067, 4)
INSERT [dbo].[charity_beneficiaries] ([ben_id], [org_id]) VALUES (20065, 1)
INSERT [dbo].[charity_beneficiaries] ([ben_id], [org_id]) VALUES (20028, 1)
INSERT [dbo].[charity_beneficiaries] ([ben_id], [org_id]) VALUES (20041, 3)
INSERT [dbo].[charity_beneficiaries] ([ben_id], [org_id]) VALUES (20086, 1)
INSERT [dbo].[charity_beneficiaries] ([ben_id], [org_id]) VALUES (20051, 1)
INSERT [dbo].[charity_beneficiaries] ([ben_id], [org_id]) VALUES (20028, 2)
INSERT [dbo].[charity_beneficiaries] ([ben_id], [org_id]) VALUES (20086, 4)
INSERT [dbo].[charity_beneficiaries] ([ben_id], [org_id]) VALUES (20007, 2)
INSERT [dbo].[charity_beneficiaries] ([ben_id], [org_id]) VALUES (20022, 3)
INSERT [dbo].[charity_beneficiaries] ([ben_id], [org_id]) VALUES (20005, 4)
GO
INSERT [dbo].[charity_organization] ([id], [charity_name], [charity_address], [phone], [contact_info], [manager_id]) VALUES (1, N'mersal upper', N'261 Nova Trail', N'401-366-5843', N'bharriman0@tinypic.com', 522)
INSERT [dbo].[charity_organization] ([id], [charity_name], [charity_address], [phone], [contact_info], [manager_id]) VALUES (2, N'mersal cairo', N'47 Veith Crossing', N'604-190-4265', N'ihuygen1@google.de', 505)
INSERT [dbo].[charity_organization] ([id], [charity_name], [charity_address], [phone], [contact_info], [manager_id]) VALUES (3, N'mersal sinai', N'411 Twin Pines Place', N'964-724-2383', N'jrodrigo2@webeden.co.uk', 512)
INSERT [dbo].[charity_organization] ([id], [charity_name], [charity_address], [phone], [contact_info], [manager_id]) VALUES (4, N'mersal siwa', N'1 Ramsey Plaza', N'897-437-7022', N'galecock3@ft.com', 518)
GO
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15001, N'Honey Tiller', CAST(7306.00 AS Decimal(10, 2)), CAST(N'2023-04-10' AS Date), N'915-762-4175', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15002, N'Sydel Dyka', CAST(14930.00 AS Decimal(10, 2)), CAST(N'2023-08-12' AS Date), N'954-979-2603', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15003, N'Ebony MacConnel', CAST(15374.00 AS Decimal(10, 2)), CAST(N'2023-05-29' AS Date), N'804-904-8759', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15004, N'Marta Cairney', CAST(12078.00 AS Decimal(10, 2)), CAST(N'2022-09-26' AS Date), N'932-628-2530', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15005, N'Devinne Durrad', CAST(15814.00 AS Decimal(10, 2)), CAST(N'2022-11-09' AS Date), N'331-986-5989', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15006, N'Sophi Saldler', CAST(6100.00 AS Decimal(10, 2)), CAST(N'2022-12-07' AS Date), N'633-235-3553', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15007, N'Bord Boughtflower', CAST(13630.00 AS Decimal(10, 2)), CAST(N'2022-12-21' AS Date), N'683-219-6727', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15008, N'Sibel Harle', CAST(10858.00 AS Decimal(10, 2)), CAST(N'2022-11-02' AS Date), N'722-833-8340', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15009, N'Shelley Velasquez', CAST(5395.00 AS Decimal(10, 2)), CAST(N'2023-04-26' AS Date), N'177-803-4207', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15010, N'Jayne Shegog', CAST(16624.00 AS Decimal(10, 2)), CAST(N'2023-07-09' AS Date), N'655-192-2561', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15011, N'Lennie Flintiff', CAST(15240.00 AS Decimal(10, 2)), CAST(N'2023-02-02' AS Date), N'405-573-3184', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15012, N'Sari Pacitti', CAST(14350.00 AS Decimal(10, 2)), CAST(N'2023-06-17' AS Date), N'127-929-9688', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15013, N'Claudina Keane', CAST(11741.00 AS Decimal(10, 2)), CAST(N'2022-09-11' AS Date), N'325-539-3477', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15014, N'Gabriell Vallack', CAST(14221.00 AS Decimal(10, 2)), CAST(N'2023-05-16' AS Date), N'533-410-9088', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15015, N'Ileana Byer', CAST(10341.00 AS Decimal(10, 2)), CAST(N'2023-02-02' AS Date), N'669-527-2070', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15016, N'Zuzana Salvatore', CAST(16870.00 AS Decimal(10, 2)), CAST(N'2023-05-29' AS Date), N'632-554-8114', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15017, N'Romain Alkin', CAST(2699.00 AS Decimal(10, 2)), CAST(N'2022-11-24' AS Date), N'830-116-2382', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15018, N'Aimil Queyos', CAST(14423.00 AS Decimal(10, 2)), CAST(N'2022-12-19' AS Date), N'959-495-7053', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15019, N'Phaedra Rapi', CAST(4598.00 AS Decimal(10, 2)), CAST(N'2022-09-09' AS Date), N'605-728-4619', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15020, N'Jeanie Minghi', CAST(17048.00 AS Decimal(10, 2)), CAST(N'2023-01-21' AS Date), N'603-919-2538', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15021, N'Laurie Edgeler', CAST(341.00 AS Decimal(10, 2)), CAST(N'2022-09-03' AS Date), N'508-255-1901', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15022, N'Tristam Staker', CAST(17680.00 AS Decimal(10, 2)), CAST(N'2023-03-01' AS Date), N'741-753-8490', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15023, N'Jodi Harfleet', CAST(587.00 AS Decimal(10, 2)), CAST(N'2022-10-02' AS Date), N'428-570-2959', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15024, N'Brook Breadon', CAST(18400.00 AS Decimal(10, 2)), CAST(N'2023-04-11' AS Date), N'827-791-9339', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15025, N'Charissa Pim', CAST(12083.00 AS Decimal(10, 2)), CAST(N'2023-07-01' AS Date), N'447-420-3696', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15026, N'Ferdie Adamowitz', CAST(9535.00 AS Decimal(10, 2)), CAST(N'2022-10-02' AS Date), N'143-898-3561', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15027, N'Nerta Jakubczyk', CAST(2767.00 AS Decimal(10, 2)), CAST(N'2022-10-23' AS Date), N'945-791-9113', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15028, N'Bryant Tidey', CAST(19192.00 AS Decimal(10, 2)), CAST(N'2023-07-06' AS Date), N'983-907-3305', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15029, N'Gusta Jouhning', CAST(5202.00 AS Decimal(10, 2)), CAST(N'2023-04-27' AS Date), N'201-200-6324', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15030, N'Deeanne Beneteau', CAST(4526.00 AS Decimal(10, 2)), CAST(N'2023-02-06' AS Date), N'258-553-2120', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15031, N'Eleen Creyke', CAST(11454.00 AS Decimal(10, 2)), CAST(N'2023-04-11' AS Date), N'755-241-3117', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15032, N'Maude Blampy', CAST(16596.00 AS Decimal(10, 2)), CAST(N'2022-12-24' AS Date), N'294-540-8207', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15033, N'Emlyn Landrick', CAST(1309.00 AS Decimal(10, 2)), CAST(N'2023-07-15' AS Date), N'497-574-8059', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15034, N'Glenine Burchall', CAST(18702.00 AS Decimal(10, 2)), CAST(N'2023-06-30' AS Date), N'116-984-6803', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15035, N'Natasha Naisbet', CAST(4729.00 AS Decimal(10, 2)), CAST(N'2023-04-14' AS Date), N'530-178-5981', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15036, N'Lavena Thorneloe', CAST(15744.00 AS Decimal(10, 2)), CAST(N'2023-05-15' AS Date), N'163-312-4744', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15037, N'Ermin MacAnellye', CAST(3553.00 AS Decimal(10, 2)), CAST(N'2022-10-22' AS Date), N'595-189-2638', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15038, N'Nickola Dominichetti', CAST(19291.00 AS Decimal(10, 2)), CAST(N'2023-03-25' AS Date), N'653-291-6141', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15039, N'Morley Grenshields', CAST(10120.00 AS Decimal(10, 2)), CAST(N'2023-08-04' AS Date), N'635-259-1630', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15040, N'Violette Grisedale', CAST(5393.00 AS Decimal(10, 2)), CAST(N'2023-04-11' AS Date), N'364-410-7154', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15041, N'Darryl Udie', CAST(15369.00 AS Decimal(10, 2)), CAST(N'2023-04-29' AS Date), N'479-263-4728', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15042, N'Maje Kuhwald', CAST(16806.00 AS Decimal(10, 2)), CAST(N'2022-10-17' AS Date), N'593-988-7485', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15043, N'Domini Older', CAST(16223.00 AS Decimal(10, 2)), CAST(N'2023-06-07' AS Date), N'395-946-2447', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15044, N'Kitti Sealand', CAST(11179.00 AS Decimal(10, 2)), CAST(N'2023-06-04' AS Date), N'687-121-0872', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15045, N'Ronald Stocky', CAST(11638.00 AS Decimal(10, 2)), CAST(N'2022-10-05' AS Date), N'923-878-9643', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15046, N'Libbi Bentzen', CAST(19609.00 AS Decimal(10, 2)), CAST(N'2022-08-29' AS Date), N'156-655-9136', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15047, N'Anya Feacham', CAST(1122.00 AS Decimal(10, 2)), CAST(N'2022-08-26' AS Date), N'737-276-1718', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15048, N'Kaitlynn Matyatin', CAST(3893.00 AS Decimal(10, 2)), CAST(N'2023-03-09' AS Date), N'763-295-5124', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15049, N'Sibella Aleksic', CAST(10186.00 AS Decimal(10, 2)), CAST(N'2022-11-27' AS Date), N'752-565-0018', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15050, N'Shandee Ruberry', CAST(17918.00 AS Decimal(10, 2)), CAST(N'2023-07-09' AS Date), N'480-913-6490', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15051, N'Reece Milleton', CAST(14956.00 AS Decimal(10, 2)), CAST(N'2023-03-18' AS Date), N'144-414-2679', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15052, N'Sheffie Barcroft', CAST(15581.00 AS Decimal(10, 2)), CAST(N'2023-06-09' AS Date), N'122-122-3266', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15053, N'Heall Hanwell', CAST(15526.00 AS Decimal(10, 2)), CAST(N'2023-05-11' AS Date), N'322-380-4177', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15054, N'Susy Attlee', CAST(2070.00 AS Decimal(10, 2)), CAST(N'2022-09-26' AS Date), N'371-615-9018', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15055, N'Loria Gabel', CAST(14752.00 AS Decimal(10, 2)), CAST(N'2022-11-10' AS Date), N'746-962-3166', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15056, N'Xylia Fitzsimmons', CAST(15257.00 AS Decimal(10, 2)), CAST(N'2023-02-12' AS Date), N'784-281-1806', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15057, N'Demetrius Timothy', CAST(4675.00 AS Decimal(10, 2)), CAST(N'2023-03-01' AS Date), N'226-957-0279', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15058, N'Rosalynd Dugue', CAST(15078.00 AS Decimal(10, 2)), CAST(N'2023-07-31' AS Date), N'803-261-7049', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15059, N'Langston Everit', CAST(18810.00 AS Decimal(10, 2)), CAST(N'2022-08-24' AS Date), N'464-354-5552', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15060, N'Odessa Monkeman', CAST(3703.00 AS Decimal(10, 2)), CAST(N'2023-03-01' AS Date), N'616-271-0045', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15061, N'Vasili Dyet', CAST(14503.00 AS Decimal(10, 2)), CAST(N'2023-01-01' AS Date), N'841-366-7759', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15062, N'Trixie Hartly', CAST(14286.00 AS Decimal(10, 2)), CAST(N'2023-07-05' AS Date), N'486-595-3487', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15063, N'Peggie Colegrove', CAST(19898.00 AS Decimal(10, 2)), CAST(N'2022-12-02' AS Date), N'394-895-2211', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15064, N'Rene Itzcovich', CAST(11375.00 AS Decimal(10, 2)), CAST(N'2023-01-05' AS Date), N'783-995-0232', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15065, N'Jed Frentz', CAST(663.00 AS Decimal(10, 2)), CAST(N'2023-04-18' AS Date), N'632-114-1492', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15066, N'Walsh Pavitt', CAST(2819.00 AS Decimal(10, 2)), CAST(N'2023-02-07' AS Date), N'763-676-3499', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15067, N'Pepita Shafto', CAST(1404.00 AS Decimal(10, 2)), CAST(N'2023-02-08' AS Date), N'267-978-2203', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15068, N'Niels Fetherby', CAST(1792.00 AS Decimal(10, 2)), CAST(N'2023-07-10' AS Date), N'564-476-7595', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15069, N'Morgan Wilshaw', CAST(245.00 AS Decimal(10, 2)), CAST(N'2022-09-27' AS Date), N'937-207-3921', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15070, N'Chrisse Dowgill', CAST(18588.00 AS Decimal(10, 2)), CAST(N'2023-03-18' AS Date), N'846-739-2673', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15071, N'Ambrosius Larrad', CAST(11135.00 AS Decimal(10, 2)), CAST(N'2023-05-06' AS Date), N'916-454-9599', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15072, N'Lynnet Horribine', CAST(4659.00 AS Decimal(10, 2)), CAST(N'2023-05-29' AS Date), N'560-350-1543', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15073, N'Chaim Dumingos', CAST(11480.00 AS Decimal(10, 2)), CAST(N'2023-03-05' AS Date), N'615-919-3163', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15074, N'Kaela Foulcher', CAST(12175.00 AS Decimal(10, 2)), CAST(N'2022-09-11' AS Date), N'757-581-5065', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15075, N'Ludovico Gamlen', CAST(19202.00 AS Decimal(10, 2)), CAST(N'2022-12-05' AS Date), N'232-235-2413', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15076, N'Frederique Grimston', CAST(6977.00 AS Decimal(10, 2)), CAST(N'2023-06-16' AS Date), N'984-192-0167', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15077, N'Sophey Moorhouse', CAST(15146.00 AS Decimal(10, 2)), CAST(N'2023-05-13' AS Date), N'391-969-0070', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15078, N'Hadleigh Aindriu', CAST(3929.00 AS Decimal(10, 2)), CAST(N'2023-05-31' AS Date), N'409-328-0409', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15079, N'Donny Wank', CAST(7116.00 AS Decimal(10, 2)), CAST(N'2022-10-31' AS Date), N'565-299-7544', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15080, N'Lucila Nolin', CAST(6220.00 AS Decimal(10, 2)), CAST(N'2023-04-20' AS Date), N'665-175-7870', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15081, N'Clarice Kornilov', CAST(2310.00 AS Decimal(10, 2)), CAST(N'2023-02-02' AS Date), N'922-802-5356', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15082, N'Marquita Paireman', CAST(11637.00 AS Decimal(10, 2)), CAST(N'2023-07-16' AS Date), N'132-891-8446', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15083, N'Sella Chaimson', CAST(16819.00 AS Decimal(10, 2)), CAST(N'2023-05-05' AS Date), N'761-127-4670', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15084, N'Dominique Veasey', CAST(3029.00 AS Decimal(10, 2)), CAST(N'2022-10-10' AS Date), N'996-966-5586', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15085, N'Alina Dawtry', CAST(11320.00 AS Decimal(10, 2)), CAST(N'2023-01-30' AS Date), N'171-100-9790', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15086, N'Bevin Gagg', CAST(10692.00 AS Decimal(10, 2)), CAST(N'2023-05-30' AS Date), N'457-390-6785', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15087, N'Alysa Klaffs', CAST(15873.00 AS Decimal(10, 2)), CAST(N'2023-05-10' AS Date), N'962-842-9499', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15088, N'Amandy Egglestone', CAST(4001.00 AS Decimal(10, 2)), CAST(N'2022-12-11' AS Date), N'273-500-7273', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15089, N'Reidar Laterza', CAST(534.00 AS Decimal(10, 2)), CAST(N'2023-01-06' AS Date), N'420-981-5686', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15090, N'Dorene Magnus', CAST(19211.00 AS Decimal(10, 2)), CAST(N'2023-02-03' AS Date), N'123-577-1857', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15091, N'Alejandrina Gateshill', CAST(18703.00 AS Decimal(10, 2)), CAST(N'2023-07-19' AS Date), N'362-118-7394', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15092, N'Aldridge McGibbon', CAST(6644.00 AS Decimal(10, 2)), CAST(N'2023-02-10' AS Date), N'392-269-9104', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15093, N'Cindee Ainslie', CAST(6730.00 AS Decimal(10, 2)), CAST(N'2022-12-23' AS Date), N'549-668-5189', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15094, N'Cad Tapson', CAST(13573.00 AS Decimal(10, 2)), CAST(N'2023-07-15' AS Date), N'708-881-8922', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15095, N'Aidan Raddon', CAST(15944.00 AS Decimal(10, 2)), CAST(N'2023-04-04' AS Date), N'902-511-8622', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15096, N'Bertrand Derye-Barrett', CAST(18526.00 AS Decimal(10, 2)), CAST(N'2023-03-04' AS Date), N'924-463-4283', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15097, N'Chucho Szanto', CAST(15031.00 AS Decimal(10, 2)), CAST(N'2022-09-03' AS Date), N'773-438-5423', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15098, N'Blondell Ondrousek', CAST(18583.00 AS Decimal(10, 2)), CAST(N'2022-11-06' AS Date), N'430-199-1767', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15099, N'Fraze Jodlkowski', CAST(11363.00 AS Decimal(10, 2)), CAST(N'2022-10-13' AS Date), N'997-948-5439', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15100, N'Kailey Rosie', CAST(3817.00 AS Decimal(10, 2)), CAST(N'2022-11-04' AS Date), N'561-502-3227', 4)
GO
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15102, N'Faustine Walworche', CAST(100.00 AS Decimal(10, 2)), CAST(N'2023-01-20' AS Date), N'599-808-2443', 3)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15103, N'Erda Tym', CAST(4291.00 AS Decimal(10, 2)), CAST(N'2023-02-05' AS Date), N'708-657-3206', 4)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15104, N'Quintana Morl', CAST(5393.00 AS Decimal(10, 2)), CAST(N'2023-04-23' AS Date), N'211-928-1699', 1)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15105, N'Gladi Human', CAST(2285.00 AS Decimal(10, 2)), CAST(N'2023-02-17' AS Date), N'829-324-2755', 2)
INSERT [dbo].[donor] ([donor_id], [donor_name], [donation_amount], [donation_date], [donor_phone], [org_id]) VALUES (15106, N'Jude Coulling', CAST(4215.00 AS Decimal(10, 2)), CAST(N'2022-11-17' AS Date), N'639-926-4154', 3)
GO
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (501, N'Guinna Navarijo', CAST(38230.70 AS Decimal(10, 2)), N'760-855-5748', N'gnavarijo0@webs.com', 4)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (502, N'Dorothea Trenoweth', CAST(32726.10 AS Decimal(10, 2)), N'143-393-7138', N'dtrenoweth1@ft.com', 3)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (503, N'Hurley Franssen', CAST(13888.46 AS Decimal(10, 2)), N'176-754-8435', N'hfranssen2@ihg.com', 3)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (504, N'Reeva MacCall', CAST(16248.36 AS Decimal(10, 2)), N'429-412-5785', N'rmaccall3@paypal.com', 1)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (505, N'Orin Preskett', CAST(19344.26 AS Decimal(10, 2)), N'320-469-9947', N'opreskett4@feedburner.com', 1)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (506, N'Carlee Coppenhall', CAST(36585.34 AS Decimal(10, 2)), N'765-927-7343', N'ccoppenhall5@qq.com', 4)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (507, N'Nikki Skedgell', CAST(30624.45 AS Decimal(10, 2)), N'797-837-8817', N'nskedgell6@sogou.com', 3)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (508, N'Jacqueline Barukh', CAST(26832.74 AS Decimal(10, 2)), N'212-972-3881', N'jbarukh7@posterous.com', 4)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (509, N'Victoria Mithan', CAST(15220.85 AS Decimal(10, 2)), N'718-152-0066', N'vmithan8@accuweather.com', 4)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (510, N'Penny Scoffham', CAST(33229.22 AS Decimal(10, 2)), N'803-115-1001', N'pscoffham9@meetup.com', 3)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (511, N'Felipa Baudassi', CAST(21742.72 AS Decimal(10, 2)), N'773-888-1023', N'fbaudassia@cargocollective.com', 1)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (512, N'Gabriel Courtese', CAST(29340.10 AS Decimal(10, 2)), N'517-858-9435', N'gcourteseb@flickr.com', 4)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (513, N'Carina Bunton', CAST(20680.73 AS Decimal(10, 2)), N'348-871-4235', N'cbuntonc@imageshack.us', 4)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (514, N'Boigie Sawbridge', CAST(29624.91 AS Decimal(10, 2)), N'500-193-3630', N'bsawbridged@blogspot.com', 1)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (515, N'Reinald McKinnon', CAST(32377.41 AS Decimal(10, 2)), N'224-108-7149', N'rmckinnone@meetup.com', 1)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (516, N'Ilene Pfeffer', CAST(25300.45 AS Decimal(10, 2)), N'487-646-2517', N'ipfefferf@ox.ac.uk', 3)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (517, N'Gareth Mulholland', CAST(27734.89 AS Decimal(10, 2)), N'849-466-8151', N'gmulhollandg@marketwatch.com', 1)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (518, N'Ronni Severn', CAST(20121.57 AS Decimal(10, 2)), N'277-298-6656', N'rsevernh@stumbleupon.com', 2)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (519, N'Parry Chasier', CAST(32203.05 AS Decimal(10, 2)), N'200-346-5736', N'pchasieri@msu.edu', 1)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (520, N'Abbie Serris', CAST(20193.40 AS Decimal(10, 2)), N'649-235-9414', N'aserrisj@xrea.com', 3)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (521, N'Isa Chadbourne', CAST(31673.28 AS Decimal(10, 2)), N'753-780-8124', N'ichadbournek@mapy.cz', 3)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (522, N'Nataniel Strachan', CAST(21017.29 AS Decimal(10, 2)), N'580-354-8638', N'nstrachanl@statcounter.com', 3)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (523, N'Dulcea Antonelli', CAST(35260.32 AS Decimal(10, 2)), N'959-933-8666', N'dantonellim@i2i.jp', 3)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (524, N'Sindee Cabrara', CAST(19479.99 AS Decimal(10, 2)), N'554-103-0069', N'scabraran@discovery.com', 3)
INSERT [dbo].[Employee] ([emp_id], [emp_name], [salary], [emp_phone], [emp_mail], [org_id]) VALUES (525, N'Tomasina Lacaze', CAST(31246.03 AS Decimal(10, 2)), N'745-764-7613', N'tlacazeo@hibu.com', 3)
GO
INSERT [dbo].[project] ([p_id], [p_name], [org_id]) VALUES (10001, N'Perl Breinl', 1)
INSERT [dbo].[project] ([p_id], [p_name], [org_id]) VALUES (10002, N'Stanly Mettricke', 1)
INSERT [dbo].[project] ([p_id], [p_name], [org_id]) VALUES (10003, N'Erl O''Devey', 1)
INSERT [dbo].[project] ([p_id], [p_name], [org_id]) VALUES (10004, N'Elenore Hazelhurst', 3)
INSERT [dbo].[project] ([p_id], [p_name], [org_id]) VALUES (10005, N'Mirabelle Rodder', 4)
INSERT [dbo].[project] ([p_id], [p_name], [org_id]) VALUES (10006, N'Royall Medland', 4)
INSERT [dbo].[project] ([p_id], [p_name], [org_id]) VALUES (10007, N'Clarinda Cadle', 2)
INSERT [dbo].[project] ([p_id], [p_name], [org_id]) VALUES (10008, N'Celia Ramalhete', 2)
INSERT [dbo].[project] ([p_id], [p_name], [org_id]) VALUES (10009, N'Gray Gritsaev', 1)
INSERT [dbo].[project] ([p_id], [p_name], [org_id]) VALUES (10010, N'Doris MacCafferky', 4)
GO
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3001, N'Reena Cluley', N'rcluley0@booking.com', N'874-279-3239', 1)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3002, N'Rici Kob', N'rkob1@soup.io', N'468-208-7797', 2)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3003, N'Eric Wolton', N'ewolton2@howstuffworks.com', N'156-363-7755', 2)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3004, N'Hubie McCallam', N'hmccallam3@dell.com', N'594-498-1099', 2)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3005, N'Marty Cheesley', N'mcheesley4@163.com', N'603-747-6770', 4)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3006, N'Patten Heppenspall', N'pheppenspall5@washington.edu', N'317-432-1266', 2)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3007, N'Jobyna Eadmeads', N'jeadmeads6@cdbaby.com', N'346-943-1427', 4)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3008, N'Rubia Maharey', N'rmaharey7@livejournal.com', N'259-171-9480', 4)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3009, N'Nita McMickan', N'nmcmickan8@toplist.cz', N'592-803-4350', 4)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3010, N'Teirtza Guilaem', N'tguilaem9@mozilla.org', N'152-945-7030', 4)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3011, N'Berte Somner', N'bsomnera@youku.com', N'976-672-5405', 2)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3012, N'Gertrud Van Arsdall', N'gvanb@sogou.com', N'562-924-7628', 3)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3013, N'Corinna Feathers', N'cfeathersc@bloomberg.com', N'493-270-5876', 1)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3014, N'Ninnette Sabbin', N'nsabbind@plala.or.jp', N'881-353-9234', 4)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3015, N'Alysia Normington', N'anormingtone@ustream.tv', N'737-363-0595', 2)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3016, N'Victoir Bixley', N'vbixleyf@spiegel.de', N'291-974-6981', 1)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3017, N'Slade Greenleaf', N'sgreenleafg@mlb.com', N'555-801-6204', 2)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3018, N'Vallie Fagge', N'vfaggeh@jiathis.com', N'218-552-9559', 4)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3019, N'Ofelia Jammet', N'ojammeti@networksolutions.com', N'816-692-2813', 4)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3020, N'Sandye Cummins', N'scumminsj@soundcloud.com', N'121-731-3152', 1)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3021, N'Alejoa de Courcey', N'adek@sphinn.com', N'611-287-1556', 3)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3022, N'Herbert Calderwood', N'hcalderwoodl@alibaba.com', N'476-484-6701', 4)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3023, N'Dorolice Burde', N'dburdem@storify.com', N'314-207-5765', 3)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3024, N'Ardys Karlsen', N'akarlsenn@mit.edu', N'888-276-6474', 4)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3025, N'Cele Beany', N'cbeanyo@usa.gov', N'914-778-6343', 4)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3026, N'Bertrand Batrim', N'bbatrimp@uiuc.edu', N'983-903-2459', 4)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3027, N'Aldo Oliva', N'aolivaq@un.org', N'332-965-2420', 3)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3028, N'Horton Hawkin', N'hhawkinr@amazon.com', N'259-835-7366', 2)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3029, N'Ransom Enever', N'renevers@cnet.com', N'819-907-4795', 1)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3030, N'Austin Janes', N'ajanest@dmoz.org', N'256-516-9174', 4)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3031, N'Merridie MacIver', N'mmaciveru@about.com', N'638-954-5667', 4)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3032, N'Berthe Lutsch', N'blutschv@unicef.org', N'338-182-1803', 3)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3033, N'Pryce Snoddin', N'psnoddinw@newsvine.com', N'830-974-1037', 2)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3034, N'Matty Maydway', N'mmaydwayx@instagram.com', N'138-314-4996', 2)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3035, N'Madelene Halliwell', N'mhalliwelly@netlog.com', N'449-342-1554', 4)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3036, N'Timothee Oddie', N'toddiez@state.gov', N'781-242-0312', 4)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3037, N'Lisabeth Snelson', N'lsnelson10@slashdot.org', N'944-945-7717', 1)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3038, N'Vikki Szimon', N'vszimon11@de.vu', N'391-396-4871', 1)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3039, N'Birgit Dansey', N'bdansey12@bbc.co.uk', N'482-552-6357', 1)
INSERT [dbo].[volunteers] ([vol_id], [vol_name], [vol_mail], [vol_phone], [org_id]) VALUES (3040, N'Yale Higford', N'yhigford13@is.gd', N'190-593-9211', 4)
GO
INSERT [dbo].[volunteers_project] ([pro_id], [vol_id]) VALUES (10008, 3009)
INSERT [dbo].[volunteers_project] ([pro_id], [vol_id]) VALUES (10005, 3006)
INSERT [dbo].[volunteers_project] ([pro_id], [vol_id]) VALUES (10003, 3022)
INSERT [dbo].[volunteers_project] ([pro_id], [vol_id]) VALUES (10008, 3037)
INSERT [dbo].[volunteers_project] ([pro_id], [vol_id]) VALUES (10008, 3002)
INSERT [dbo].[volunteers_project] ([pro_id], [vol_id]) VALUES (10010, 3027)
INSERT [dbo].[volunteers_project] ([pro_id], [vol_id]) VALUES (10005, 3014)
INSERT [dbo].[volunteers_project] ([pro_id], [vol_id]) VALUES (10001, 3012)
INSERT [dbo].[volunteers_project] ([pro_id], [vol_id]) VALUES (10002, 3007)
INSERT [dbo].[volunteers_project] ([pro_id], [vol_id]) VALUES (10008, 3015)
INSERT [dbo].[volunteers_project] ([pro_id], [vol_id]) VALUES (10008, 3038)
INSERT [dbo].[volunteers_project] ([pro_id], [vol_id]) VALUES (10003, 3020)
INSERT [dbo].[volunteers_project] ([pro_id], [vol_id]) VALUES (10008, 3033)
INSERT [dbo].[volunteers_project] ([pro_id], [vol_id]) VALUES (10007, 3033)
INSERT [dbo].[volunteers_project] ([pro_id], [vol_id]) VALUES (10003, 3003)
INSERT [dbo].[volunteers_project] ([pro_id], [vol_id]) VALUES (10004, 3024)
INSERT [dbo].[volunteers_project] ([pro_id], [vol_id]) VALUES (10004, 3007)
INSERT [dbo].[volunteers_project] ([pro_id], [vol_id]) VALUES (10009, 3018)
INSERT [dbo].[volunteers_project] ([pro_id], [vol_id]) VALUES (10010, 3008)
INSERT [dbo].[volunteers_project] ([pro_id], [vol_id]) VALUES (10006, 3033)
GO
ALTER TABLE [dbo].[charity_beneficiaries]  WITH CHECK ADD  CONSTRAINT [beneficiaries_charitybeneficiaries_fk] FOREIGN KEY([ben_id])
REFERENCES [dbo].[beneficiaries] ([ben_id])
GO
ALTER TABLE [dbo].[charity_beneficiaries] CHECK CONSTRAINT [beneficiaries_charitybeneficiaries_fk]
GO
ALTER TABLE [dbo].[charity_beneficiaries]  WITH CHECK ADD  CONSTRAINT [charity_charitybeneficiaries_fk] FOREIGN KEY([org_id])
REFERENCES [dbo].[charity_organization] ([id])
GO
ALTER TABLE [dbo].[charity_beneficiaries] CHECK CONSTRAINT [charity_charitybeneficiaries_fk]
GO
ALTER TABLE [dbo].[charity_organization]  WITH CHECK ADD  CONSTRAINT [employee_charity_fk] FOREIGN KEY([manager_id])
REFERENCES [dbo].[Employee] ([emp_id])
GO
ALTER TABLE [dbo].[charity_organization] CHECK CONSTRAINT [employee_charity_fk]
GO
ALTER TABLE [dbo].[donor]  WITH CHECK ADD  CONSTRAINT [charity_organization_donor_fk] FOREIGN KEY([org_id])
REFERENCES [dbo].[charity_organization] ([id])
GO
ALTER TABLE [dbo].[donor] CHECK CONSTRAINT [charity_organization_donor_fk]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [chariy_employee_fk] FOREIGN KEY([org_id])
REFERENCES [dbo].[charity_organization] ([id])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [chariy_employee_fk]
GO
ALTER TABLE [dbo].[project]  WITH CHECK ADD  CONSTRAINT [chariy_project_fk] FOREIGN KEY([org_id])
REFERENCES [dbo].[charity_organization] ([id])
GO
ALTER TABLE [dbo].[project] CHECK CONSTRAINT [chariy_project_fk]
GO
ALTER TABLE [dbo].[volunteers]  WITH CHECK ADD  CONSTRAINT [chariy_volunteers_fk] FOREIGN KEY([org_id])
REFERENCES [dbo].[charity_organization] ([id])
GO
ALTER TABLE [dbo].[volunteers] CHECK CONSTRAINT [chariy_volunteers_fk]
GO
ALTER TABLE [dbo].[volunteers_project]  WITH CHECK ADD  CONSTRAINT [project_volunteersproject_fk] FOREIGN KEY([pro_id])
REFERENCES [dbo].[project] ([p_id])
GO
ALTER TABLE [dbo].[volunteers_project] CHECK CONSTRAINT [project_volunteersproject_fk]
GO
ALTER TABLE [dbo].[volunteers_project]  WITH CHECK ADD  CONSTRAINT [volunteers_volunteersproject_fk] FOREIGN KEY([vol_id])
REFERENCES [dbo].[volunteers] ([vol_id])
GO
ALTER TABLE [dbo].[volunteers_project] CHECK CONSTRAINT [volunteers_volunteersproject_fk]
GO
/****** Object:  StoredProcedure [dbo].[DeleteColumn1]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteColumn1]
AS
BEGIN
    ALTER TABLE donor
    DROP COLUMN donor_mail;
END

EXEC DeleteColumn1;
GO
/****** Object:  StoredProcedure [dbo].[donations_per_branch]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[donations_per_branch]
as
SELECT ch.id , ch.charity_name,sum(d.donation_amount) total_donation
FROM charity_organization ch inner join donor d
on ch.id=d.org_id
group by ch.id , ch.charity_name
GO
/****** Object:  StoredProcedure [dbo].[IncrementEmployeeSalary]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IncrementEmployeeSalary]
AS
BEGIN
    DECLARE @emp_id INT, @salary DECIMAL(10,2), @ch_name VARCHAR(100)

    DECLARE increment_employee CURSOR FOR
        SELECT e.emp_id, e.salary, ch.charity_name
        FROM employee e
        INNER JOIN charity_organization ch ON e.org_id = ch.id
        ORDER BY ch.charity_name

    OPEN increment_employee

    FETCH NEXT FROM increment_employee INTO @emp_id, @salary, @ch_name

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF (@ch_name = 'mersal sinai')
        BEGIN
            SET @salary = @salary + 1000 -- Increment salary by a fixed amount
        END
        ELSE
        BEGIN
            SET @salary = @salary + 500 -- Increment salary by a different fixed amount
        END

        UPDATE Employee
        SET salary = @salary
        WHERE CURRENT OF increment_employee

        FETCH NEXT FROM increment_employee INTO @emp_id, @salary, @ch_name
    END

    CLOSE increment_employee
    DEALLOCATE increment_employee
END
GO
/****** Object:  StoredProcedure [dbo].[Insertdonors]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insertdonors] (
    @id int,
    @name VARCHAR(50),
    @Phone VARCHAR(20),
    @mail VARCHAR(20),
    @donation_amount decimal(10,2),
    @donation_date date,
    @org_id int

)
AS
BEGIN
    INSERT INTO donor (donor_id, donor_name, donor_phone, donor_mail, donation_amount, donation_date, donor.org_id)
    VALUES (@id, @name, @Phone, @mail, @donation_amount, @donation_date,  @org_id)
END
GO
/****** Object:  StoredProcedure [dbo].[Insertdonors2]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insertdonors2] (
    @id int,
    @name VARCHAR(50),
    @donation_amount decimal(10,2),
      @donation_date date,
  @Phone VARCHAR(20),
    @org_id int
)
AS
BEGIN
    INSERT INTO donor (donor_id, donor_name, donation_amount, donation_date, donor_phone, org_id)
    VALUES (@id, @name, @donation_amount ,@donation_date, @Phone, @org_id)
END
GO
/****** Object:  StoredProcedure [dbo].[project_names_per_branch]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[project_names_per_branch]
as
SELECT ch.id , ch.charity_name, p_name
FROM charity_organization ch inner join project p
on ch.id=p.org_id
order by ch.id
GO
/****** Object:  StoredProcedure [dbo].[volunteer_based_project]    Script Date: 8/19/2023 10:46:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[volunteer_based_project] as
select vol_name, p_name ,p_id , row_number() over (partition by p_id order by p_id ) as rn
from project p inner join charity_organization ch on p.org_id = ch. id inner join volunteers v
on ch.id=v.org_id
GO
USE [master]
GO
ALTER DATABASE [charity] SET  READ_WRITE 
GO
