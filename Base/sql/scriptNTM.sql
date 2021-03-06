USE [ntm_checknetvn]
GO
/****** Object:  Table [dbo].[User]    Script Date: 6/5/2022 3:33:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[User_ID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](200) NULL,
	[Password] [nvarchar](200) NULL,
	[FullName] [nvarchar](500) NULL,
	[Avatar] [nvarchar](500) NULL,
	[Address] [nvarchar](500) NULL,
	[Email] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[Position] [nvarchar](500) NULL,
	[CreateDate] [datetime] NULL,
	[ModifyDate] [datetime] NULL,
	[CreateBy] [int] NULL,
	[ModifyBy] [int] NULL,
	[Status] [int] NULL,
	[Sort] [int] NULL,
	[BirthDay] [datetime] NULL,
	[Gender] [int] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[User_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([User_ID], [UserName], [Password], [FullName], [Avatar], [Address], [Email], [Phone], [Position], [CreateDate], [ModifyDate], [CreateBy], [ModifyBy], [Status], [Sort], [BirthDay], [Gender]) VALUES (1, N'admin', N'c78124b5f3133b0a4ef0eebf1f156e96', N'Doãn Đình Chúc', N'/Backend/data/user/3_3_2021_10_59_48z2219504800430_21ea8b4fd414a49f38abdac09be5a203.jpg', N'PHÙ LỖ SÓC SƠN HN', N'duong2492.dd@gmail.com', N'+84366176880', NULL, NULL, CAST(N'2021-03-12T13:57:21.493' AS DateTime), NULL, 1, 1, 1, CAST(N'1980-01-26T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([User_ID], [UserName], [Password], [FullName], [Avatar], [Address], [Email], [Phone], [Position], [CreateDate], [ModifyDate], [CreateBy], [ModifyBy], [Status], [Sort], [BirthDay], [Gender]) VALUES (2, N'tintuc', N'303f8bb684c26c66578e963100ec20b1', N'Quản lý tin tức', NULL, NULL, N'Quản lý tin tức', N'0123544789', NULL, CAST(N'2021-03-01T10:09:48.210' AS DateTime), NULL, 1, NULL, 1, NULL, CAST(N'1980-01-18T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[User] ([User_ID], [UserName], [Password], [FullName], [Avatar], [Address], [Email], [Phone], [Position], [CreateDate], [ModifyDate], [CreateBy], [ModifyBy], [Status], [Sort], [BirthDay], [Gender]) VALUES (3, N'news', N'96e79218965eb72c92a549dd5a330112', N'news', NULL, NULL, N'news', N'+84366176880', NULL, CAST(N'2021-03-01T10:11:34.650' AS DateTime), NULL, 1, NULL, -1, NULL, CAST(N'1980-08-07T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[User] ([User_ID], [UserName], [Password], [FullName], [Avatar], [Address], [Email], [Phone], [Position], [CreateDate], [ModifyDate], [CreateBy], [ModifyBy], [Status], [Sort], [BirthDay], [Gender]) VALUES (4, N'quantrivien', N'202cb962ac59075b964b07152d234b70', N'QTV', NULL, NULL, N'QTV', N'+84366176880', NULL, CAST(N'2021-03-01T10:13:28.027' AS DateTime), NULL, 1, NULL, -1, NULL, CAST(N'1980-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[User] ([User_ID], [UserName], [Password], [FullName], [Avatar], [Address], [Email], [Phone], [Position], [CreateDate], [ModifyDate], [CreateBy], [ModifyBy], [Status], [Sort], [BirthDay], [Gender]) VALUES (5, N'tintuc1', N'202cb962ac59075b964b07152d234b70', N'Đặng Đình Dương', NULL, NULL, N'Đặng Đình Dương', N'+84366176880', NULL, CAST(N'2021-03-01T10:24:18.353' AS DateTime), NULL, 1, NULL, -1, NULL, CAST(N'1980-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[User] ([User_ID], [UserName], [Password], [FullName], [Avatar], [Address], [Email], [Phone], [Position], [CreateDate], [ModifyDate], [CreateBy], [ModifyBy], [Status], [Sort], [BirthDay], [Gender]) VALUES (6, N'test', N'303f8bb684c26c66578e963100ec20b1', N'Đặng Đình Dương', N'/Backend/data/user/1_3_2021_16_22_53Bn_3.jpg', N'', N'duong2492.dd@gmail.com', N'+84366176880', NULL, CAST(N'2021-03-01T13:43:37.777' AS DateTime), CAST(N'2021-03-04T14:50:16.203' AS DateTime), 1, 6, -1, NULL, CAST(N'1980-01-25T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([User_ID], [UserName], [Password], [FullName], [Avatar], [Address], [Email], [Phone], [Position], [CreateDate], [ModifyDate], [CreateBy], [ModifyBy], [Status], [Sort], [BirthDay], [Gender]) VALUES (7, N'quantri1', N'202cb962ac59075b964b07152d234b70', N'QT1', N'/Backend/data/user/2_3_2021_8_51_14rau cai bap_ tam xá.png', N'HN', N'QT1', N'099999999', NULL, CAST(N'2021-03-02T08:51:14.513' AS DateTime), NULL, 1, NULL, -1, NULL, CAST(N'1980-05-21T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([User_ID], [UserName], [Password], [FullName], [Avatar], [Address], [Email], [Phone], [Position], [CreateDate], [ModifyDate], [CreateBy], [ModifyBy], [Status], [Sort], [BirthDay], [Gender]) VALUES (8, N'lan.bt', N'9678566b45a6ecb80b90fe77d99c5558', N'Đinh Thị Lan', NULL, N'', N'Đinh Thị Lan', N'', NULL, CAST(N'2021-03-10T09:54:43.940' AS DateTime), NULL, 1, NULL, 1, NULL, CAST(N'1980-01-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[User] ([User_ID], [UserName], [Password], [FullName], [Avatar], [Address], [Email], [Phone], [Position], [CreateDate], [ModifyDate], [CreateBy], [ModifyBy], [Status], [Sort], [BirthDay], [Gender]) VALUES (9, N'trang.bt', N'9678566b45a6ecb80b90fe77d99c5558', N'Vũ Thị Huyền Trang', NULL, N'', N'Vũ Thị Huyền Trang', N'', NULL, CAST(N'2021-03-10T09:55:48.063' AS DateTime), NULL, 1, NULL, 1, NULL, CAST(N'1980-01-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[User] ([User_ID], [UserName], [Password], [FullName], [Avatar], [Address], [Email], [Phone], [Position], [CreateDate], [ModifyDate], [CreateBy], [ModifyBy], [Status], [Sort], [BirthDay], [Gender]) VALUES (10, N'ha.bt', N'9678566b45a6ecb80b90fe77d99c5558', N'Lê Thị Hà', NULL, N'', N'Lê Thị Hà', N'', NULL, CAST(N'2021-03-10T10:02:27.097' AS DateTime), NULL, 1, NULL, 1, NULL, CAST(N'1980-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[User] ([User_ID], [UserName], [Password], [FullName], [Avatar], [Address], [Email], [Phone], [Position], [CreateDate], [ModifyDate], [CreateBy], [ModifyBy], [Status], [Sort], [BirthDay], [Gender]) VALUES (11, N'van.bt', N'9678566b45a6ecb80b90fe77d99c5558', N'Nguyễn Thị Vân', NULL, N'', N'Nguyễn Thị Vân', N'', NULL, CAST(N'2021-03-10T10:02:50.730' AS DateTime), NULL, 1, NULL, 1, NULL, CAST(N'1980-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[User] ([User_ID], [UserName], [Password], [FullName], [Avatar], [Address], [Email], [Phone], [Position], [CreateDate], [ModifyDate], [CreateBy], [ModifyBy], [Status], [Sort], [BirthDay], [Gender]) VALUES (12, N'manh.bt', N'7a31f24557580e71f4236ed2abf03be7', N'Nguyễn Đức Mạnh', NULL, N'', N'Nguyễn Đức Mạnh', N'', NULL, CAST(N'2021-06-08T13:34:31.433' AS DateTime), NULL, 1, NULL, 1, NULL, CAST(N'1980-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([User_ID], [UserName], [Password], [FullName], [Avatar], [Address], [Email], [Phone], [Position], [CreateDate], [ModifyDate], [CreateBy], [ModifyBy], [Status], [Sort], [BirthDay], [Gender]) VALUES (13, N'nguyen.ntm', N'303f8bb684c26c66578e963100ec20b1', N'Ngô Xuân Nguyên', NULL, N'', N'Ngô Xuân Nguyên', N'', NULL, CAST(N'2021-10-19T16:16:16.813' AS DateTime), NULL, 12, NULL, 1, NULL, CAST(N'1980-01-01T00:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
USE [checkproductman_dev]
GO
/****** Object:  StoredProcedure [dbo].[GenerateMENU]    Script Date: 6/5/2022 5:04:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<DANG DINH DUONG>
-- Create date: <15/09/2020>
-- Description:	<Phan quyen menu>
-- =============================================
--SELECT PageFunction_ID, Name, Url, Folder,DisplayMenu FROM PageFunction where Function_ID=4 and PageFunction_ID in( select PageFunction_ID from UserVsPageFunction where UserId='6C5C51B0-3245-42C9-BEDF-7CAE0A074EFE')
ALTER Proc [dbo].[GenerateMENU] --'6C5C51B0-3245-42C9-BEDF-7CAE0A074EFE'
@UserId varchar(100)

as


DECLARE @html nvarchar(MAX)
DECLARE @htmlChild nvarchar(MAX)
DECLARE @numrows int
DECLARE @i int
DECLARE @numrowsChild int
DECLARE @iChild int
DECLARE @Function_ID int
DECLARE @Name nvarchar(500)
DECLARE @CssClass nvarchar(200)
DECLARE @NameLoop nvarchar(500)
DECLARE @CssClassLoop nvarchar(200)
DECLARE @Function_IDLoop int

DECLARE @NameChild nvarchar(500)
DECLARE @UrlChild nvarchar(500)
DECLARE @FolderChild nvarchar(500)
DECLARE @DisplayMenuChild int
DECLARE @tblTemp TABLE (
    idx smallint Primary Key IDENTITY(1,1)
    , Function_ID int
    , Name nvarchar(500)
    , CssClass nvarchar(MAX)
)
DECLARE @tblTempChild TABLE (
    idx smallint Primary Key IDENTITY(1,1)
    , PageFunction_ID int
    , Name nvarchar(500)
    , Url nvarchar(500)
    , Folder nvarchar(500)
    , DisplayMenu int
)


INSERT @tblTemp
SELECT Function_ID, Name, ISNULL( CssClass,'') FROM [Function] where Active=1  order by Sort ASC

SET @html='';
-- enumerate the table
SET @i = 1
SET @numrows = (SELECT COUNT(*) FROM @tblTemp)
IF @numrows > 0
    WHILE (@i <= (SELECT MAX(idx) FROM @tblTemp))
    BEGIN
		SET @Function_IDLoop= (SELECT Function_ID FROM @tblTemp WHERE idx = @i)
		DELETE FROM @tblTempChild	
			BEGIN		            
				INSERT @tblTempChild
				SELECT PageFunction_ID, Name, Url, Folder,DisplayMenu FROM PageFunction where Active=1 and Function_ID=@Function_IDLoop and PageFunction_ID in ( select PageFunction_ID from UserVsPageFunction where UserId=@UserId)   order by Sort ASC  
			END
		SET @numrowsChild = (SELECT COUNT(*) FROM @tblTempChild)  
		SET @NameLoop = (SELECT Name FROM @tblTemp WHERE idx = @i)
		SET @CssClassLoop = (SELECT CssClass FROM @tblTemp WHERE idx = @i)
		IF @numrowsChild>0
			BEGIN
			SET @html = @html+ '<li class="leftbar-menu-item"><a href="javascript: void(0);" class="menu-link">'+@CssClassLoop+'<span>'+@NameLoop+'</span><span class="menu-arrow"><i class="mdi mdi-chevron-right"></i></span></a>' ;
			END
		ELSE
			BEGIN	
			SET @html = @html+ '<li class="leftbar-menu-item none"><a href="javascript: void(0);" class="menu-link">'+@CssClassLoop+@NameLoop+'</span><span class="menu-arrow"></span></a>' ;
			END
			                            
        SET @html = @html +' <ul class="nav-second-level" aria-expanded="false">'
        
			SET @iChild = 1
			SET @htmlChild='';
			IF  @numrowsChild > 0
				BEGIN
					
					WHILE (@iChild <= (SELECT MAX(idx) FROM @tblTempChild))
					BEGIN
						SET @NameChild= (SELECT Name FROM @tblTempChild WHERE idx = @iChild)
						SET @UrlChild = (SELECT Url FROM @tblTempChild WHERE idx = @iChild)
						SET @FolderChild = (SELECT Folder FROM @tblTempChild WHERE idx = @iChild)
						SET @DisplayMenuChild = (SELECT DisplayMenu FROM @tblTempChild WHERE idx = @iChild)
						IF @NameChild<>''
							BEGIN
								IF @DisplayMenuChild=1
									BEGIN
										SET @htmlChild =@htmlChild + '<li class="nav-item"><a class="nav-link" href="/Admin/'+@FolderChild+'/'+REPLACE(@UrlChild,'.aspx','')+'"><i class="ti-control-record"></i>'+@NameChild+'</a></li>'
									END
								ELSE
									BEGIN	
										SET @htmlChild =@htmlChild + '<li class="nav-item none"><a class="nav-link" href="/Admin/'+@FolderChild+'/'+REPLACE(@UrlChild,'.aspx','')+'"><i class="ti-control-record"></i>'+@NameChild+'</a></li>'
									END
							END
						SET @iChild = @iChild + 1
					END
				END
        
            SET @html = @html +@htmlChild   
            SET @htmlChild=''
            --DELETE FROM @tblTempChild              
		SET @html = @html +'</ul></li>'             
        SET @i = @i + 1
     
    END
    --set @html +=@NameLoop
    
select isnull(@html,'') as MENU

--SELECT PageFunction_ID, Name, Url, Folder,DisplayMenu FROM PageFunction where Function_ID=1 and PageFunction_ID in ( select PageFunction_ID from UserVsPageFunction where UserId='06dfe050-4407-4492-b1fd-656ccb8a82b6')   order by Sort ASC
