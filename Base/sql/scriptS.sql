

create proc [dbo].[spGetCountProductOnDistrict]
@District_ID int
AS

select District_ID,Name from District  where Location_ID=92

--Lấy số lượng sản phẩm của huyện
select Count(*) as ProductOnDistrict from Product p 
left join ProductBrand pb on pb.ProductBrand_ID = p.ProductBrand_ID 
left join District d on pb.District_ID = d.District_ID
where d.District_ID = @District_ID
GO
/****** Object:  StoredProcedure [dbo].[spGetDocument_paging]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spGetDocument_paging] --1,10,10,'',0,'2010-08-01 00:11:37.933','2021-08-01 00:11:37.933','',''
@currentPage int,
@recodperpage int,
@PageSize int,
@Title nvarchar(400) = N'',
@DocumentCategory_ID int,
@StartDate datetime,
@EndDate datetime,
@Where nvarchar(400) = N'',
@orderby nvarchar(4000) = ''
AS

declare @sql nvarchar(4000)

set @sql = ' Where DO.Active=1 '

if(@Title<>'')
	set @sql +=  ' And (DO.Title like N''%'+@Title+'%'')'
if(@DocumentCategory_ID > 0)
	set @sql +=  ' And DO.DocumentCategory_ID = '+ CONVERT(varchar(50), @DocumentCategory_ID)
if(@Where<>'')
	set @sql +=  @Where
set @sql += 'and Convert(date, DO.CreateDate) between ''' + CONVERT(varchar(50),CONVERT(date,@StartDate)) + ''' and ''' + CONVERT(varchar(50),CONVERT(date,@EndDate))+''''

IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currentPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currentPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

declare @strSql2 nvarchar(4000)
	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
		BEGIN
			EXEC spGetDocument_paging @Tolal, ' + Cast(@currentPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
		END ELSE
			SELECT '''' AS PhanTrang '

	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY DO.Document_ID DESC) AS RowNum ,DO.Document_ID, DO.Title,DO.Summary,DO.Image,DO.CreateDate, DO.Active, DC.Title as NameDC from BNN_Document DO left join BNN_DocumentCategory DC on DO.DocumentCategory_ID = DC.DocumentCategory_ID ' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby+ '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from BNN_Document DO left join BNN_DocumentCategory DC on DO.DocumentCategory_ID = DC.DocumentCategory_ID
' + @sql + @strSql2

+' 	SELECT Count(*) as TotalRecord from BNN_Document DO left join BNN_DocumentCategory DC on DO.DocumentCategory_ID = DC.DocumentCategory_ID
' + @sql 
)
GO
/****** Object:  StoredProcedure [dbo].[spGetFarm_paging]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<NGUYEN MINH CHAU>
-- Create date: <11/09/2020>
-- Description:	<Phan trang farm>
-- =============================================
CREATE PROCEDURE [dbo].[spGetFarm_paging]  --1, 1000,7,0,0,0,'',''


@currPage int,
@recodperpage int,
@Pagesize int,
@ProductBrand_ID int,
@Zone_ID int,
@Area_ID int,
@Workshop_ID int,
@Name nvarchar(400)= N'',
@orderby nvarchar(4000) = ''


AS
 declare @sql nvarchar(4000)
set @sql = ' Where 1=1 '
if(@ProductBrand_ID>0)
	set @sql +=  ' And F.ProductBrand_ID = '+ CONVERT(varchar(50), @ProductBrand_ID)
if(@Zone_ID >0)
	set @sql +=  ' And F.Zone_ID ='+ CONVERT(varchar(50), @Zone_ID)
if(@Area_ID > 0)
	set @sql +=  ' And F.Area_ID ='+ CONVERT(varchar(50), @Area_ID)
if(@Workshop_ID > 0)
	set @sql +=  ' And F.Workshop_ID ='+ CONVERT(varchar(50), @Workshop_ID)
if(@Name<>'')
	set @sql +=  ' And F.Name like N''%'+@Name+'%'''
IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

declare @strSql2 nvarchar(4000)
	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
		BEGIN
			EXEC spProduct_pagination @Tolal, ' + Cast(@currPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
		END ELSE
			SELECT '''' AS PhanTrang '
	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY F.Name ASC) AS RowNum,F.Farm_ID, F.Name, F.Phone, F.Email, F.Address, F.Acreage, WS.Name as WorkshopName , F.CreateDate
		   from Farm F
		   inner join ProductBrand PB on F.ProductBrand_ID = PB.ProductBrand_ID 
		   left join Workshop WS on F.Workshop_ID = WS.Workshop_ID
	
' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby + '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from Farm F
		   inner join ProductBrand PB on F.ProductBrand_ID = PB.ProductBrand_ID 
		   left join Workshop WS on F.Workshop_ID = WS.Workshop_ID
' + @sql + @strSql2

+' 	SELECT Count(*) as TotalRecord from Farm F
		   inner join ProductBrand PB on F.ProductBrand_ID = PB.ProductBrand_ID 
		   left join Workshop WS on F.Workshop_ID = WS.Workshop_ID

' + @sql 
)
GO
/****** Object:  StoredProcedure [dbo].[spGetHistoryLogin_paging]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spGetHistoryLogin_paging]--1,10,10
@currentPage int,
@recodperPage int,
@Pagesize int,
@Where nvarchar(max) = N'',
@orderby nvarchar(400)= ''
AS
declare @sql nvarchar(Max)
set @sql = 'Where 1=1 and '
if(@Where<>'')
	set @sql +=  @Where
--if(@Name<>'')
--	set @sql += ' and ( P.Title like N''%'+@Name+'%'' or P.Summary like N''%'+@Name+'%'' or P.Description like N''%'+@Name+'%'') '
--if(@ShareHolderCategory_ID >0)
--	 set @sql += ' And P.ShareHolderCategory_ID='+ CONVERT(varchar(50), @ShareHolderCategory_ID)
--if(@Where <> '')
--	set @sql += @Where
--if(@orderby <> '')
--	set @orderby = ' ORDER BY ' + @orderby
--else
set @orderby=' ORDER BY SystemLog_ID DESC '
declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currentPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currentPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''


execute('
	DECLARE @Total int
	
		WITH tbl_temp AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER('+@orderby+') AS RowNum,Name, CreateDate  from SystemLog '+@sql+'
		) 
		Select * From tbl_temp '+@strSql1+'
	
	 -- Tính tổng số bản ghi
		SELECT @Total=Count(*) from  SystemLog '

+' 	SELECT Count(*) as TotalRecord  from SystemLog  ' + @sql )






		 
GO
/****** Object:  StoredProcedure [dbo].[spGetNews_paging]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spGetNews_paging] --1,5,10,'',13,'',''
@currentPage int,
@recodperPage int,
@Pagesize int,
@Name nvarchar(400)= N'',
@NewsCategory_ID int,
@Where nvarchar(400)= N'',
@orderby nvarchar(400)= ''
AS
declare @sql nvarchar(4000)
declare @sub nvarchar(4000)
set @sql = 'Where NN.Active = 1 '
if(@Name<>'')
	set @sql += ' and NN.Title like N''%'+@Name+'%'''
if(@NewsCategory_ID > 0 )
Begin
	set @sql += ' and NN.NewsCategory_ID ='+ CONVERT(varchar(50), @NewsCategory_ID)
	set @sub = 'or  NN.Title like N''%'+@Name+'%'' and (NN.NewsCategory_ID in (Select NewsCategory_ID from BNN_NewsCategory where Parent_ID='+ CONVERT(varchar(50), @NewsCategory_ID)+'))'
	end
if(@Where <> '')
	set @sql += @Where
if(@orderby <> '')
	set @sql += ' ORDER BY' + @orderby
declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currentPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currentPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

execute('
	DECLARE @Total int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY News_ID DESC) AS RowNum, (select top 1 Title from BNN_NewsCategory where NewsCategory_ID= NC.Parent_ID) as CateName, NN.Title,NN.News_ID,NC.Parent_ID, NN.Image,U.UserName, NN.NewsCategory_ID, NN.CreateDate, NN.IsHome, NN.IsHot, NN.Active, NC.Title as TitleCate
		    from BNN_News NN left join BNN_NewsCategory NC on NN.NewsCategory_ID= NC.NewsCategory_ID left join aspnet_Users U on U.UserID= NN.CreateBy ' + @sql+ @sub+'
		) 
		Select distinct * From s ' + @strSql1+ @orderby+ '
	
	 -- Tính tổng số bản ghi
		SELECT @Total=Count(*) from BNN_News NN left join BNN_NewsCategory NC on NN.NewsCategory_ID= NC.NewsCategory_ID left join aspnet_Users U on U.UserID= NN.CreateBy ' + @sql --+ @strSql2

+' 	SELECT Count(*) as TotalRecord from BNN_News NN left join BNN_NewsCategory NC on NN.NewsCategory_ID= NC.NewsCategory_ID left join aspnet_Users U on U.UserID= NN.CreateBy 
' + @sql +@sub
)

GO
/****** Object:  StoredProcedure [dbo].[spGetNews_paging1]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spGetNews_paging1] --1,10,10,'',12,'',''
@currentPage int,
@recodperPage int,
@Pagesize int,
@Name nvarchar(400)= N'',
@NewsCategory_ID int,
@Where nvarchar(400)= N'',
@orderby nvarchar(400)= ''
AS

declare @sub  nvarchar(4000)

declare @sql nvarchar(4000)
set @sql = 'Where NN.Active = 1 '
if(@Name<>'')
	set @sql += ' and NN.Title like N''%'+@Name+'%'''
if(@NewsCategory_ID >0)
	BEGIN
	set @sql += ' and NN.NewsCategory_ID ='+ CONVERT(varchar(50), @NewsCategory_ID)
	set @sub = ' or (NN.NewsCategory_ID in ( select NewsCategory_ID from BNN_NewsCategory where Parent_ID='+ CONVERT(varchar(50), @NewsCategory_ID)+'))'
	END
if(@Where <> '')
	set @sql += @Where
if(@orderby <> '')
	set @sql += ' ORDER BY' + @orderby
declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currentPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currentPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

execute('
	DECLARE @Total int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY News_ID DESC) AS RowNum, (select top 1 Title from BNN_NewsCategory where NewsCategory_ID= NC.Parent_ID) as CateName, NN.Title,NN.News_ID,NC.Parent_ID, NN.Image,U.UserName, NN.NewsCategory_ID, NN.CreateDate, NN.IsHome, NN.IsHot, NN.Active, NC.Title as TitleCate
		    from BNN_News NN left join BNN_NewsCategory NC on NN.NewsCategory_ID= NC.NewsCategory_ID left join aspnet_Users U on U.UserID= NN.CreateBy ' + @sql +@sub+'
		) 
		Select distinct * From s ' + @strSql1+ @orderby+ '
	
	 -- Tính tổng số bản ghi
		SELECT @Total=Count(*) from BNN_News NN left join BNN_NewsCategory NC on NN.NewsCategory_ID= NC.NewsCategory_ID left join aspnet_Users U on U.UserID= NN.CreateBy ' + @sql --+ @strSql2

+' 	SELECT Count(*) as TotalRecord from BNN_News NN left join BNN_NewsCategory NC on NN.NewsCategory_ID= NC.NewsCategory_ID left join aspnet_Users U on U.UserID= NN.CreateBy 
' + @sql +@sub
)



GO
/****** Object:  StoredProcedure [dbo].[spGetNews_paging2]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spGetNews_paging2] --1,10,10,'','2000-01-01','9999-01-01','',''
@currentPage int,
@recodperpage int,
@PageSize int,
@Title nvarchar(400) = N'',
@StartDate datetime,
@EndDate datetime,
@Where nvarchar(400) = N'',
@orderby nvarchar(4000) = ''
AS

declare @sql nvarchar(4000)

set @sql = ' Where Active=1 '

if(@Title<>'')
		set @sql +=  ' And (Title like N''%'+@Title+'%'')'
if(@Where<>'')
	set @sql +=  @Where
set @sql += 'and Convert(date, CreateDate) between ''' + CONVERT(varchar(50),CONVERT(date,@StartDate)) + ''' and ''' + CONVERT(varchar(50),CONVERT(date,@EndDate))+''''

IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currentPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currentPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

--declare @strSql2 nvarchar(4000)
--	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
--		BEGIN
--			EXEC spGetNews_paging2 @Tolal, ' + Cast(@currentPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
--		END ELSE
--			SELECT '''' AS PhanTrang '

	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY News_ID DESC) AS RowNum,News_ID, NewsCategory_ID, Title,Summary,Image,CreateDate, Active, Author,Location_ID from BNN_News ' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby+ '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from BNN_News
' + @sql --+ @strSql2

+' 	SELECT Count(*) as TotalRecord from BNN_News
' + @sql 
)
GO
/****** Object:  StoredProcedure [dbo].[spGetNews_paging3]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spGetNews_paging3] --1,10,10,'','2000-01-01','2020-01-01','',''
@currentPage int,
@recodperpage int,
@PageSize int,
@Title nvarchar(400) = N'',
@StartDate datetime,
@EndDate datetime,
@Where nvarchar(400) = N'',
@orderby nvarchar(4000) = ''
AS

declare @sql nvarchar(4000)

set @sql = ' Where Active=1 '

if(@Title<>'')
		set @sql +=  ' And (Title like N''%'+@Title+'%'')'
if(@Where<>'')
	set @sql +=  @Where
set @sql += 'and Convert(date, CreateDate) between ''' + CONVERT(varchar(50),CONVERT(date,@StartDate)) + ''' and ''' + CONVERT(varchar(50),CONVERT(date,@EndDate))+''''

IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currentPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currentPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

declare @strSql2 nvarchar(4000)
	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
		BEGIN
			EXEC spGetNews_paging2 @Tolal, ' + Cast(@currentPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
		END ELSE
			SELECT '''' AS PhanTrang '

	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY News_ID DESC) AS RowNum,News_ID, NewsCategory_ID, Title,Summary,Image,CreateDate, Active, Author,Location_ID from BNN_News ' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby+ '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from BNN_News
' + @sql + @strSql2

+' 	SELECT Count(*) as TotalRecord from BNN_News
' + @sql 
)
GO
/****** Object:  StoredProcedure [dbo].[spGetProduct_paging]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<DANG DINH DUONG>
-- Create date: <28/08/2020>
-- Description:	<Phan trang san pham>
-- =============================================
 --select  CONVERT(varchar(50),Convert(date,'2010-09-20 00:11:37.933'))
-- select  CONVERT(varchar(50),Convert(date,'2010-09-20 00:11:37.933'))
 
CREATE PROCEDURE [dbo].[spGetProduct_paging] --1, 10,7,0,0,0,0,'','2010-08-01 00:11:37.933','2020-08-31 00:11:37.933','lợn',' Product_ID ASC'
@currPage int,
@recodperpage int,
@Pagesize int,
@ProductCategory_ID int,
@Quality_ID int,
@ProductBrand_ID int,
@Country_ID int,
@CreateBy varchar(50),
@FromDate datetime,
@ToDate datetime,
@Name nvarchar(400)= N'',
@Where nvarchar(400)= N'',
@orderby nvarchar(4000) = ''
AS

declare @sql nvarchar(4000)

--SQL 2012 trở lên
--set @sql = CONCAT(@sql, ' Where 1=1')
--if(@ProductCategory_ID > 0)
--	set @sql = CONCAT(@sql, ' And P.ProductCategory_ID='+@ProductCategory_ID)
--if(@Quality_ID >0)
--	set @sql = CONCAT(@sql, ' And P.Quality_ID ='+@Quality_ID)
--if(@ProductBrand_ID>0)
--	set @sql = CONCAT(@sql, ' And P.ProductBrand_ID = '+@ProductBrand_ID)
--if(@Country_ID > 0)
--	set @sql = CONCAT(@sql, ' And P.Country_ID ='+@Country_ID)
--if(@CreateBy<>'')
--	set @sql = CONCAT(@sql, ' And P.CreateBy = '''+@CreateBy+''''

--set @sql= CONCAT(@sql, ' And P.CreateDate between  '+ @FromDate +' and '+ @ToDate)

set @sql = ' Where 1=1 '
if(@ProductCategory_ID > 0)
	 set @sql += ' And P.ProductCategory_ID='+ CONVERT(varchar(50), @ProductCategory_ID)
if(@Quality_ID >0)
	set @sql +=  ' And P.Quality_ID ='+ CONVERT(varchar(50), @Quality_ID)
if(@ProductBrand_ID>0)
	set @sql +=  ' And P.ProductBrand_ID = '+ CONVERT(varchar(50), @ProductBrand_ID)
if(@Country_ID > 0)
	set @sql +=  ' And P.Country_ID ='+ CONVERT(varchar(50), @Country_ID)
if(@CreateBy<>'')
	set @sql +=  ' And P.CreateBy = '''+@CreateBy+''''
if(@Name<>'')
	set @sql +=  ' And P.Name like N''%'+@Name+'%'''
if(@Where<>'')
	set @sql +=  @Where
set @sql +=  ' And Convert(date,P.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''

IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

--Declare @strWhere nvarchar(4000)
--Set @strWhere = REPLACE(@where, 'N''%','N''''%')
--Set @strWhere = REPLACE(@strWhere, '%''','%''''')
declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

declare @strSql2 nvarchar(4000)
	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
		BEGIN
			EXEC spProduct_pagination @Tolal, ' + Cast(@currPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
		END ELSE
			SELECT '''' AS PhanTrang '
	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY P.Product_ID DESC) AS RowNum, 
		   P.Name, P.Product_ID, P.Image, P.Active, U.UserName, UE.UserName as NguoiSua
	, P.CreateDate, P.ProductCategory_ID, P.CreateBy, P.LastEditBy
	, P.LastEditDate , isnull( PC.Name,N''Chưa xác định'') as ProductCategoryName from Product P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join ProductCategory PC on PC.ProductCategory_ID= P.ProductCategory_ID
' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby + '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from Product P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join ProductCategory PC on PC.ProductCategory_ID= P.ProductCategory_ID
' + @sql + @strSql2

+' 	SELECT Count(*) as TotalRecord from Product P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join ProductCategory PC on PC.ProductCategory_ID= P.ProductCategory_ID
' + @sql 

)
GO
/****** Object:  StoredProcedure [dbo].[spGetProduct_paging1]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spGetProduct_paging1] --1,5,10,'',2,2,'',''
@currentPage int,
@recodperPage int,
@Pagesize int,
@Name nvarchar(400)= N'',
@Location_ID int,
@Region_ID int,
@Where nvarchar(400)= N'',
@orderby nvarchar(400)= ''
AS
declare @sql nvarchar(4000)
set @sql = ' Where pro.Active = 1'
if(@Name<>'')
	set @sql += ' and pro.Title like N''%'+@Name+'%'''
if(@Location_ID > 0 )
	set @sql += ' and l.Location_ID  ='+ CONVERT(varchar(50), @Location_ID)
if(@Region_ID > 0 )
	set @sql += ' and r.Region_ID  ='+ CONVERT(varchar(50), @Region_ID)
if(@Where <> '')
	set @sql += @Where
if(@orderby <> '')
	set @sql += ' ORDER BY' + @orderby
declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currentPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currentPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

execute('
	DECLARE @Total int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY pro.Product_ID DESC) AS RowNum ,pro.Product_ID,pro.Title,pro.Summary,CAST(pro.Description AS nvarchar(MAX))AS Description,pro.Image,pro.[View],pro.IsHot,pro.IsHome,pro.Active,pro.Sort,l.Location_ID,l.Name as NameLocation,r.Region_ID,R.Title as TitleRegion 
from BNN_Product pro 
left join Location l on l.Location_ID = pro.Location_ID 
left join BNN_RegionVsLocation rl on l.Location_ID = rl.Location_ID 
left join BNN_Region r on r.Region_ID = rl.Region_ID ' + @sql +'
		) 
		Select distinct * From s ' + @strSql1+ @orderby+ '
	
	 -- Tính tổng số bản ghi
		SELECT @Total=Count(*) from BNN_Product pro 
left join Location l on l.Location_ID = pro.Location_ID 
left join BNN_RegionVsLocation rl on l.Location_ID = rl.Location_ID 
left join BNN_Region r on r.Region_ID = rl.Region_ID' + @sql --+ @strSql2

+' 	SELECT Count(*) as TotalRecord from BNN_Product pro 
left join Location l on l.Location_ID = pro.Location_ID 
left join BNN_RegionVsLocation rl on l.Location_ID = rl.Location_ID 
left join BNN_Region r on r.Region_ID = rl.Region_ID 
' + @sql 
)
GO
/****** Object:  StoredProcedure [dbo].[spGetProduct_pagingV3]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<DANG DINH DUONG>
-- Create date: <19/06/2021>
-- Description:	<Phan trang san pham>
-- =============================================
 --select  CONVERT(varchar(50),Convert(date,'2010-09-20 00:11:37.933'))
-- select  CONVERT(varchar(50),Convert(date,'2010-09-20 00:11:37.933'))
 
CREATE PROCEDURE [dbo].[spGetProduct_pagingV3] --1, 10,7,0,0,0,0,'','2010-08-01 00:11:37.933','2020-08-31 00:11:37.933','lợn',' Product_ID ASC'
@currPage int,
@recodperpage int,
@Pagesize int,
@ProductCategory_ID int,
@Quality_ID int,
@ProductBrand_ID int,
@Country_ID int,
@Location_ID int,
@District_ID int,
@Ward_ID int,
@DepartmentMan_ID int,
@CreateBy varchar(50),
@FromDate datetime,
@ToDate datetime,
@ListCategoryID varchar(4000),
@Name nvarchar(400)= N'',
@Where nvarchar(400)= N'',
@orderby nvarchar(4000) = '',
@Approve int
AS

declare @sql nvarchar(4000)

--SQL 2012 trở lên
--set @sql = CONCAT(@sql, ' Where 1=1')
--if(@ProductCategory_ID > 0)
--	set @sql = CONCAT(@sql, ' And P.ProductCategory_ID='+@ProductCategory_ID)
--if(@Quality_ID >0)
--	set @sql = CONCAT(@sql, ' And P.Quality_ID ='+@Quality_ID)
--if(@ProductBrand_ID>0)
--	set @sql = CONCAT(@sql, ' And P.ProductBrand_ID = '+@ProductBrand_ID)
--if(@Country_ID > 0)
--	set @sql = CONCAT(@sql, ' And P.Country_ID ='+@Country_ID)
--if(@CreateBy<>'')
--	set @sql = CONCAT(@sql, ' And P.CreateBy = '''+@CreateBy+''''

--set @sql= CONCAT(@sql, ' And P.CreateDate between  '+ @FromDate +' and '+ @ToDate)

set @sql = ' Where 1=1 '

if(@ListCategoryID<>'')
	set @sql += ' and P.ProductCategory_ID in ('+@ListCategoryID+') '
if(@ProductCategory_ID > 0)
	 set @sql += ' And P.ProductCategory_ID='+ CONVERT(varchar(50), @ProductCategory_ID)
if(@Location_ID > 0)
	 set @sql += ' And P.ProductBrand_ID in (Select ProductBrand_ID from ProductBrand where Location_ID ='+ CONVERT(varchar(50), @Location_ID) +')'
if(@District_ID > 0)
	 set @sql += ' And P.ProductBrand_ID in (Select ProductBrand_ID from ProductBrand where District_ID ='+ CONVERT(varchar(50), @District_ID) +')'
if(@Ward_ID > 0)
	 set @sql += ' And P.ProductBrand_ID in (Select ProductBrand_ID from ProductBrand where Ward_ID ='+ CONVERT(varchar(50), @Ward_ID) +')'
if(@DepartmentMan_ID > 0)
	 set @sql += ' And P.ProductBrand_ID in (Select ProductBrand_ID from ProductBrand where DepartmentMan_ID ='+ CONVERT(varchar(50), @DepartmentMan_ID) +')'
if(@Quality_ID >0)
	set @sql +=  ' And P.Quality_ID ='+ CONVERT(varchar(50), @Quality_ID)
if(@ProductBrand_ID>0)
	set @sql +=  ' And P.ProductBrand_ID = '+ CONVERT(varchar(50), @ProductBrand_ID)
if(@Country_ID > 0)
	set @sql +=  ' And P.Country_ID ='+ CONVERT(varchar(50), @Country_ID)
if(@CreateBy<>'')
	set @sql +=  ' And P.CreateBy = '''+@CreateBy+''''
if(@Name<>'')
	set @sql +=  ' And P.Name like N''%'+@Name+'%'''
if(@Approve>0)
	set @sql +=  ' And P.Approve = '+ CONVERT(varchar(50), @Approve)
else if(@Approve = 0)
	set @sql += ' And  P.Approve is null'
if(@Where<>'')
	set @sql +=  @Where
set @sql +=  ' And Convert(date,P.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''

IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

--Declare @strWhere nvarchar(4000)
--Set @strWhere = REPLACE(@where, 'N''%','N''''%')
--Set @strWhere = REPLACE(@strWhere, '%''','%''''')
declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

declare @strSql2 nvarchar(4000)
	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
		BEGIN
			EXEC spProduct_pagination @Tolal, ' + Cast(@currPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
		END ELSE
			SELECT '''' AS PhanTrang '
	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY P.Product_ID DESC) AS RowNum, 
		   P.Name, P.Product_ID, P.Image, P.Active, P.Approve, U.UserName, UE.UserName as NguoiSua,U1.UserName as TenNguoiTao,UE1.UserName as NguoiLam,PMW.CreateDate as NgayTao,PMW.CreateBy as TaoBoi,PMW.LastEditDate as Ngaysua,PMW.LastEditBy as Suaboi
	, P.CreateDate, P.ProductCategory_ID, P.CreateBy, P.LastEditBy
	, P.LastEditDate , isnull( PC.Name,N''Chưa xác định'') as ProductCategoryName, PB.Name as ProductBrandName from Product P
	left join ProductVsMaterialWh PMW on PMW.Product_ID = P.Product_ID

	left join aspnet_Users U1 on U1.UserId = PMW.CreateBy
	left join aspnet_Users UE1 on UE1.UserId = PMW.LastEditBy
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join ProductCategory PC on PC.ProductCategory_ID= P.ProductCategory_ID
	left join ProductBrand PB on PB.ProductBrand_ID= P.ProductBrand_ID 
' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby + '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from Product P
	left join ProductVsMaterialWh PMW on PMW.Product_ID = P.Product_ID
	left join aspnet_Users U1 on U1.UserId = PMW.CreateBy
	left join aspnet_Users UE1 on UE1.UserId = PMW.LastEditBy
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join ProductCategory PC on PC.ProductCategory_ID= P.ProductCategory_ID
	left join ProductBrand PB on PB.ProductBrand_ID= P.ProductBrand_ID
' + @sql + @strSql2

+' 	SELECT Count(*) as TotalRecord from Product P
	left join ProductVsMaterialWh PMW on PMW.Product_ID = P.Product_ID
	left join aspnet_Users U1 on U1.UserId = PMW.CreateBy
	left join aspnet_Users UE1 on UE1.UserId = PMW.LastEditBy
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join ProductCategory PC on PC.ProductCategory_ID= P.ProductCategory_ID
	left join ProductBrand PB on PB.ProductBrand_ID= P.ProductBrand_ID
' + @sql 

)
GO
/****** Object:  StoredProcedure [dbo].[spGetProductBrand_paging]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spGetProductBrand_paging]--1,1000,1000,N'',0,0,0,'',''
@currentPage int,
@recodperPage int,
@Pagesize int,
@Name nvarchar(400)= N'',
@Ministry_ID int,
@Branch_ID int,
@Location_ID int,
@Where nvarchar(400)= N'',
@orderby nvarchar(400)= ''
AS

declare @sql nvarchar(4000)
set @sql = ' Where pb.Active = 1'
if(@Name<>'')
	set @sql += ' and pb.Name like N''%'+@Name+'%'''
if(@Ministry_ID >0)
	set @sql += ' and pb.DepartmentMan_ID = (Select DepartmentMan_ID from DepartmentMan where Parent_ID = '+ CONVERT(varchar(50), @Ministry_ID) +')'
if(@Branch_ID >0)
	set @sql += ' and pb.Branch_ID ='+ CONVERT(varchar(50), @Branch_ID)
if(@Location_ID>0)
	set @sql += ' and pb.Location_ID ='+ CONVERT(varchar(50), @Location_ID)

if(@Where <> '')
	set @sql += @Where
if(@orderby <> '')
	set @sql += ' ORDER BY' + @orderby
declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currentPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currentPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

--declare @strSql2 nvarchar(4000)
--	SET @strSql2 = ' if(@Total > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Total)
--		BEGIN
--			EXEC spGetProductBrand_paging @Total, ' + Cast(@currentPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
--		END ELSE
--			SELECT '''' AS PhanTrang '
create table #Temp
(
	RowNum int,
    ProductBrand_ID int,
	Name nvarchar(500),
	VerifyApproveDate datetime,
	Address nvarchar(500),
	Active bit,
	CreateDate datetime,
	Image nvarchar(500),
	DepartmentMan_ID int,
	Location_ID int,
	Title nvarchar(500)

)

execute('
	DECLARE @Total int
	
		WITH tbl_temp AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY ProductBrand_ID DESC) AS RowNum,pb.ProductBrand_ID,pb.Name,pb.VerifyApproveDate,pb.Address,pb.Active,pb.CreateDate,pb.Image,pb.DepartmentMan_ID,pb.Location_ID,b.Title from ProductBrand pb 
		   left join BusinessType b on pb.BusinessType_ID = b.BusinessType_ID' + @sql+'
		) 
		Insert Into #Temp select distinct * from tbl_temp '+ @orderby+ ';
		Select * From #Temp '+@strSql1+'
	
	 -- Tính tổng số bản ghi
		SELECT @Total=Count(*) from ProductBrand pb 
		   left join BusinessType b on pb.BusinessType_ID = b.BusinessType_ID' + @sql --+ @strSql2

+' 	SELECT Count(*) as TotalRecord from ProductBrand pb 
		   left join BusinessType b on pb.BusinessType_ID = b.BusinessType_ID
' + @sql 
+'select Count(*) as TotalProduct from Product p where p.ProductBrand_ID in (select ProductBrand_ID from #Temp)  and p.Active = 1;
drop table #Temp;
')


--select Count(*) as TotalProduct from Product p where p.ProductBrand_ID in (891,695,694)  and p.Active = 1
GO
/****** Object:  StoredProcedure [dbo].[spGetProductBrand_paging1]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetProductBrand_paging1]-- 1,100,100,0,'',0,0,'2021-06-21 00:00:37.933','2021-06-22 00:11:37.933',''
@currPage int,
@recodperpage int,
@Pagesize int,
@ProductBrandType_ID_List int,
@Name nvarchar(400)= N'',
@FunctionGroup_ID int,
@Location_ID int,
@FromDate datetime,
@ToDate datetime,
@orderby nvarchar(400)= ''
AS

declare @sql nvarchar(4000)

--set @sql = ' Where 1=1 and PB.Active=1 '
set @sql = ' Where 1=1 '

if(@ProductBrandType_ID_List <>'')
	set @sql +=  ' And PB.ProductBrandType_ID_List like ''%,'+CONVERT(varchar(50), @ProductBrandType_ID_List)+',%'''
if(@Name<>'')
	set @sql += ' and PB.Name like N''%'+@Name+'%'''
if(@FunctionGroup_ID>0)
	set @sql +=  ' And PB.FunctionGroup_ID = '+ CONVERT(varchar(50), @FunctionGroup_ID)	
if(@Location_ID>0)
	set @sql += ' and PB.Location_ID ='+ CONVERT(varchar(50), @Location_ID)


set @sql +=  ' And Convert(date,PB.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''

IF @orderby <> '' 
	SET @orderby = ' ORDER BY CreateDate DESC' --+ @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currPage-1) AS nvarchar(6)) + ')*' + Cast((@recodperpage) AS nvarchar(6)) + '+' + Cast((1) AS nvarchar(6)) + ' 
		AND ' + Cast(@currPage AS nvarchar(6)) + '*' + Cast(@recodperpage AS nvarchar(6)) + ''

--declare @strSql2 nvarchar(4000)
--	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
	--	BEGIN
--			EXEC spProductBrand_pagination @Tolal, ' + Cast(@currPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
	--	END ELSE
	--		SELECT '''' AS PhanTrang '
	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY PB.CreateDate DESC) AS RowNum, 
PB.ProductBrand_ID, PB.Name , PB.Telephone , PB.Mobile, PB.Email, PB.DirectorName as Director  , PB.Address , PB.ProductBrandType_ID_List, PB.Active ,PB.CreateDate, PB.CreateBy , FG.Name as FunctionGroupname
  from ProductBrand PB
  left join FunctionGroup FG on PB.FunctionGroup_ID = FG.FunctionGroup_ID
' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby + '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from ProductBrand PB
  left join FunctionGroup FG on PB.FunctionGroup_ID = FG.FunctionGroup_ID
' + @sql --+ @strSql2

+' 	SELECT Count(*) as TotalRecord from ProductBrand PB
  left join FunctionGroup FG on PB.FunctionGroup_ID = FG.FunctionGroup_ID
' + @sql 

)
GO
/****** Object:  StoredProcedure [dbo].[spGetProductBrand_paging3]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spGetProductBrand_paging3] --1,1000,1000,N'',0,0,'',''
@currentPage int,
@recodperPage int,
@Pagesize int,
@Name nvarchar(400)= N'',
@DepartmentMan_ID int,
@District_ID int,
@Where nvarchar(400)= N'',
@orderby nvarchar(400)= ''
AS

declare @sql nvarchar(4000)
set @sql = ' Where Active = 1'
if(@Name<>'')
	set @sql += ' and Name like N''%'+@Name+'%'''
if(@DepartmentMan_ID >0)
	set @sql += ' and DepartmentMan_ID = '+ CONVERT(varchar(50), @DepartmentMan_ID)
if(@District_ID>0)
	set @sql += ' and District_ID ='+ CONVERT(varchar(50), @District_ID)
if(@Where <> '')
	set @sql += @Where
if(@orderby <> '')
	set @sql += ' ORDER BY' + @orderby
declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currentPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currentPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

--declare @strSql2 nvarchar(4000)
--	SET @strSql2 = ' if(@Total > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Total)
--		BEGIN
--			EXEC spGetProductBrand_paging @Total, ' + Cast(@currentPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
--		END ELSE
--			SELECT '''' AS PhanTrang '
create table #Temp
(
	RowNum int,
    ProductBrand_ID int,
	Name nvarchar(500),
	VerifyApproveDate datetime,
	Address nvarchar(500),
	Active bit,
	CreateDate datetime,
	Image nvarchar(500),
	DepartmentMan_ID int,
	District_ID int,
	BusinessArea nvarchar(500)
)

execute('
	DECLARE @Total int
	
		WITH tbl_temp AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY ProductBrand_ID DESC) AS RowNum,ProductBrand_ID,Name,VerifyApproveDate,Address,Active,CreateDate,Image,DepartmentMan_ID,District_ID,BusinessArea from ProductBrand ' + @sql+'
		) 
		Insert Into #Temp select distinct * from tbl_temp '+ @orderby+ ';
		Select * From #Temp '+@strSql1+'
	
	 -- Tính tổng số bản ghi
		SELECT @Total=Count(*) from ProductBrand' + @sql --+ @strSql2

+' 	SELECT Count(*) as TotalRecord from ProductBrand
' + @sql 
+'select Count(*) as TotalProduct from Product p where p.ProductBrand_ID in (select ProductBrand_ID from #Temp)  and p.Active = 1;
drop table #Temp;
')
select pb.ProductBrand_ID, d.Name as NameDistrict from ProductBrand pb left join District d on pb.District_ID = d.District_ID where pb.District_ID = @District_ID
--select Count(*) as TotalProduct from Product p where p.ProductBrand_ID in (891,695,694)  and p.Active = 1
GO
/****** Object:  StoredProcedure [dbo].[spGetProductBrand_pagingV2]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetProductBrand_pagingV2] --1,10,10,0,'',0,0,'2015-04-28 00:11:37.933','2021-04-30 00:11:37.933','','7CC0F71A-3CCC-4C00-B7C9-279396B65478'
@currPage int,
@recodperpage int,
@Pagesize int,
@ProductBrandType_ID_List int,
@Name nvarchar(400)= N'',
@FunctionGroup_ID int,
@Location_ID int,
@DepartmentMan_ID int,
@District_ID int,
@Ward_ID int,
@FromDate datetime,
@ToDate datetime,
@orderby nvarchar(400)= '',
@SalesID varchar(50),
@ChainLink_ID int
AS

declare @sql nvarchar(4000)

--set @sql = ' Where 1=1 and PB.Active=1 '
set @sql = ' Where 1=1 '

if(@ProductBrandType_ID_List <>'')
	set @sql +=  ' And PB.ProductBrandType_ID_List like ''%,'+CONVERT(varchar(50), @ProductBrandType_ID_List)+',%'''
if(@Name<>'')
	set @sql += ' and PB.Name like N''%'+@Name+'%'''
if(@SalesID<>'')
	set @sql += ' and PB.Sales_ID =UPPER('''+@SalesID+''')'
if(@FunctionGroup_ID>0)
	set @sql +=  ' And PB.FunctionGroup_ID = '+ CONVERT(varchar(50), @FunctionGroup_ID)	
if(@Location_ID>0)
	set @sql += ' and PB.Location_ID ='+ CONVERT(varchar(50), @Location_ID)
if(@District_ID>0)
	set @sql += ' and PB.District_ID ='+ CONVERT(varchar(50), @District_ID)
if(@Ward_ID>0)
	set @sql += ' and PB.Ward_ID ='+ CONVERT(varchar(50), @Ward_ID)
if(@DepartmentMan_ID>0)
	set @sql += ' and PB.DepartmentMan_ID ='+ CONVERT(varchar(50), @DepartmentMan_ID)
if(@ChainLink_ID>0)
	set @sql += ' and PB.ChainLink_ID ='+ CONVERT(varchar(50), @ChainLink_ID)
set @sql +=  ' And Convert(date,PB.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''

IF @orderby <> '' 
	set @sql += 'and PB.ProductBrand_ID in('+ CONVERT(varchar(50), @orderby)+')'
	SET @orderby =  ' ORDER BY CreateDate DESC' --+ @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currPage-1) AS nvarchar(6)) + ')*' + Cast((@recodperpage) AS nvarchar(6)) + '+' + Cast((1) AS nvarchar(6)) + ' 
		AND ' + Cast(@currPage AS nvarchar(6)) + '*' + Cast(@recodperpage AS nvarchar(6)) + ''

--declare @strSql2 nvarchar(4000)
--	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
	--	BEGIN
--			EXEC spProductBrand_pagination @Tolal, ' + Cast(@currPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
	--	END ELSE
	--	SELECT '''' AS PhanTrang '
	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
	   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY PB.CreateDate DESC) AS RowNum, 
PB.ProductBrand_ID, PB.Name , PB.Telephone , PB.Mobile, PB.Email, PB.DirectorName as Director  , PB.Address , PB.ProductBrandType_ID_List, PB.Active ,PB.CreateDate,PB.LastEditDate, PB.CreateBy , FG.Name as FunctionGroupname,U.UserName, UE.UserName as NguoiSua, (Select Top 1 E.Star From Evaluate E where E.ProductBrand_ID = PB.ProductBrand_ID order by E.CreateDate DESC ) as SoSao, PB.RoleChain_ID, (Select Top 1 E.LastEditDate From Evaluate E where E.ProductBrand_ID = PB.ProductBrand_ID order by E.CreateDate DESC ) as Vaoluc,((Select Top 1 UES.UserName From Evaluate E left join aspnet_Users UES on E.LastEditBy = UES.UserId  where E.ProductBrand_ID = PB.ProductBrand_ID  order by E.CreateDate DESC )) as NguoiDanhGia, (SELECT COUNT(Product_ID) as SoSP FROM Product P WHERE  P.ProductBrand_ID = PB.ProductBrand_ID) as SoSP,(SELECT SUM(QRCodeNumber) as SoTemLop1 FROM QRCodePackage QP WHERE QP.QRCodePackageType_ID=1 and QP.ProductBrand_ID = PB.ProductBrand_ID) as SoTemLop1,(SELECT SUM(QRCodeNumber) as SoTemLop2 FROM QRCodePackage QP WHERE QP.QRCodePackageType_ID=2 and QP.ProductBrand_ID = PB.ProductBrand_ID) as SoTemLop2,CL.Name as TenChuoi,RC.RoleName
  from ProductBrand PB
  left join FunctionGroup FG on PB.FunctionGroup_ID = FG.FunctionGroup_ID
  left join aspnet_Users U on U.UserId=PB.CreateBy
	left join aspnet_Users UE on UE.UserId=PB.LastEditBy
	left JOIN ChainLink CL on CL.ChainLink_ID=PB.ChainLink_ID
	left join RoleChain RC on RC.RoleChain_ID = PB.RoleChain_ID

' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby + '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from ProductBrand PB
  left join FunctionGroup FG on PB.FunctionGroup_ID = FG.FunctionGroup_ID
    left join aspnet_Users U on U.UserId=PB.CreateBy
	left join aspnet_Users UE on UE.UserId=PB.LastEditBy
	left JOIN ChainLink CL on CL.ChainLink_ID=PB.ChainLink_ID
	left join RoleChain RC on RC.RoleChain_ID = PB.RoleChain_ID

' + @sql --+ @strSql2

+' 	SELECT Count(*) as TotalRecord from ProductBrand PB
  left join FunctionGroup FG on PB.FunctionGroup_ID = FG.FunctionGroup_ID
    left join aspnet_Users U on U.UserId=PB.CreateBy
	left join aspnet_Users UE on UE.UserId=PB.LastEditBy
	left JOIN ChainLink CL on CL.ChainLink_ID=PB.ChainLink_ID
	left join RoleChain RC on RC.RoleChain_ID = PB.RoleChain_ID

' + @sql 

)
GO
/****** Object:  StoredProcedure [dbo].[spGetProductBrand_pagingV3]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetProductBrand_pagingV3] --1,10,10,0,'',0,0,'2015-04-28 00:11:37.933','2021-04-30 00:11:37.933','','7CC0F71A-3CCC-4C00-B7C9-279396B65478'
@currPage int,
@recodperpage int,
@Pagesize int,
@ProductBrandType_ID_List int,
@Name nvarchar(400)= N'',
@FunctionGroup_ID int,
@Location_ID int,
@DepartmentMan_ID int,
@District_ID int,
@Ward_ID int,
@FromDate datetime,
@ToDate datetime,
@orderby nvarchar(400)= '',
@SalesID varchar(50),
@ChainLink_ID int
AS

declare @sql nvarchar(4000)

--set @sql = ' Where 1=1 and PB.Active=1 '
set @sql = ' Where 1=1 '

if(@ProductBrandType_ID_List <>'')
	set @sql +=  ' And PB.ProductBrandType_ID_List like ''%,'+CONVERT(varchar(50), @ProductBrandType_ID_List)+',%'''
if(@Name<>'')
	set @sql += ' and PB.Name like N''%'+@Name+'%'''
if(@SalesID<>'')
	set @sql += ' and PB.Sales_ID =UPPER('''+@SalesID+''')'
if(@FunctionGroup_ID>0)
	set @sql +=  ' And PB.FunctionGroup_ID = '+ CONVERT(varchar(50), @FunctionGroup_ID)	
if(@Location_ID>0)
	set @sql += ' and PB.Location_ID ='+ CONVERT(varchar(50), @Location_ID)
if(@District_ID>0)
	set @sql += ' and PB.District_ID ='+ CONVERT(varchar(50), @District_ID)
if(@Ward_ID>0)
	set @sql += ' and PB.Ward_ID ='+ CONVERT(varchar(50), @Ward_ID)
if(@DepartmentMan_ID>0)
	set @sql += ' and PB.DepartmentMan_ID ='+ CONVERT(varchar(50), @DepartmentMan_ID)
if(@ChainLink_ID>0)
	set @sql += ' and PB.ChainLink_ID ='+ CONVERT(varchar(50), @ChainLink_ID)
set @sql +=  ' And Convert(date,PB.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''

IF @orderby <> '' 
	set @sql += 'and PB.ProductBrand_ID in('+ CONVERT(varchar(50), @orderby)+')'
	SET @orderby =  ' ORDER BY CreateDate DESC' --+ @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currPage-1) AS nvarchar(6)) + ')*' + Cast((@recodperpage) AS nvarchar(6)) + '+' + Cast((1) AS nvarchar(6)) + ' 
		AND ' + Cast(@currPage AS nvarchar(6)) + '*' + Cast(@recodperpage AS nvarchar(6)) + ''

--declare @strSql2 nvarchar(4000)
--	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
	--	BEGIN
--			EXEC spProductBrand_pagination @Tolal, ' + Cast(@currPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
	--	END ELSE
	--	SELECT '''' AS PhanTrang '
	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY PB.CreateDate DESC) AS RowNum, 
PB.ProductBrand_ID, PB.Name , PB.Telephone , PB.Mobile, PB.Email, PB.DirectorName as Director  , PB.Address , PB.ProductBrandType_ID_List, PB.Active ,PB.CreateDate,PB.LastEditDate, PB.CreateBy , FG.Name as FunctionGroupname,U.UserName, UE.UserName as NguoiSua
  from ProductBrand PB
  left join FunctionGroup FG on PB.FunctionGroup_ID = FG.FunctionGroup_ID
  left join aspnet_Users U on U.UserId=PB.CreateBy
	left join aspnet_Users UE on UE.UserId=PB.LastEditBy
' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby + '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from ProductBrand PB
  left join FunctionGroup FG on PB.FunctionGroup_ID = FG.FunctionGroup_ID
    left join aspnet_Users U on U.UserId=PB.CreateBy
	left join aspnet_Users UE on UE.UserId=PB.LastEditBy
' + @sql --+ @strSql2

+' 	SELECT Count(*) as TotalRecord from ProductBrand PB
  left join FunctionGroup FG on PB.FunctionGroup_ID = FG.FunctionGroup_ID
    left join aspnet_Users U on U.UserId=PB.CreateBy
	left join aspnet_Users UE on UE.UserId=PB.LastEditBy
' + @sql 

)
GO
/****** Object:  StoredProcedure [dbo].[spGetProductPackage_Export]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[spGetProductPackage_Export]
@currPage int,
@recodperpage int,
@Pagesize int,
@ProductPackage_ID int,
@Zone_ID int,
@Area_ID int,
@ProductBrand_ID int,
@Workshop_ID int,
@ProductPackageStatus_ID int,
@Department_ID int,
@Location_ID int,
@District_ID int,
@Ward_ID int,
@ProductPackageOrder_ID int,
@CreateBy varchar(50),
@FromDate datetime,
@ToDate datetime,
@CODE nvarchar(400)= '',
@SGIN nvarchar(400)= '',
@Product_ID int,
@Name nvarchar(400)= N'',
@ProductBrandList nvarchar(4000),
@orderby nvarchar(4000) = ''
AS

declare @sql nvarchar(4000)

set @sql = ' Where 1=1 and PP.ProductPackageStatus_ID<>6 '
if(@ProductPackage_ID>0)
	set @sql +=  ' And PP.ProductPackage_ID = '+ CONVERT(varchar(50), @ProductPackage_ID)
if(@ProductBrandList<>'')
	set @sql +=  ' And PP.ProductBrand_ID in( '+ @ProductBrandList +' ) '
if(@ProductBrand_ID>0)
	set @sql +=  ' And PP.ProductBrand_ID = '+ CONVERT(varchar(50), @ProductBrand_ID)	
if(@Department_ID >0)
	set @sql +=  ' And PP.ProductBrand_ID in (Select ProductBrand_ID From ProductBrand where DepartmentMan_ID ='+ CONVERT(varchar(50), @Department_ID) + ')'
if(@Location_ID >0)
	set @sql +=   ' And PP.ProductBrand_ID in (Select ProductBrand_ID From ProductBrand where Location_ID ='+ CONVERT(varchar(50), @Location_ID) + ')'
if(@District_ID >0)
	set @sql +=  ' And PP.ProductBrand_ID in (Select ProductBrand_ID From ProductBrand where District_ID ='+ CONVERT(varchar(50), @District_ID) + ')'
if(@Ward_ID >0)
	set @sql +=  ' And PP.ProductBrand_ID in (Select ProductBrand_ID From ProductBrand where Ward_ID ='+ CONVERT(varchar(50), @Ward_ID) + ')'
if(@Workshop_ID > 0)
	 set @sql += ' And PP.Workshop_ID='+ CONVERT(varchar(50), @Workshop_ID)
if(@ProductPackageOrder_ID > 0)
	 set @sql += ' And PP.ProductPackageOrder_ID='+ CONVERT(varchar(50), @ProductPackageOrder_ID)
if(@Zone_ID > 0)
	 set @sql += ' And PP.Zone_ID='+ CONVERT(varchar(50), @Zone_ID)
if(@Area_ID > 0)
	 set @sql += ' And PP.Area_ID='+ CONVERT(varchar(50), @Area_ID)
if(@ProductPackageStatus_ID >0)
	set @sql +=  ' And PP.ProductPackageStatus_ID ='+ CONVERT(varchar(50), @ProductPackageStatus_ID)
if(@CreateBy<>'')
	set @sql +=  ' And PP.CreateBy = '''+@CreateBy+''''
if(@SGIN<>'')
	set @sql +=  ' And PP.SGTIN like N''%'+@SGIN+'%'''
if(@Product_ID >0)
	set @sql +=  ' And PP.Product_ID='+ CONVERT(varchar(50), @Product_ID)
if(@Name<>'')
	set @sql +=  ' And PP.Name like N''%'+@Name+'%'' OR PP.ProductPackageOrder_ID in (Select ProductPackageOrder_ID from ProductPackageOrder where CodePO =N'''+@Name+''')'
if(@CODE<>'')
	set @sql +=  ' And PP.Code like ''%'+@CODE+'%'''
set @sql +=  ' And Convert(date,PP.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''

IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

declare @strSql2 nvarchar(4000)
	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)

		BEGIN
			EXEC spProductPackage_pagination @Tolal, ' + Cast(@currPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
		END ELSE
			SELECT '''' AS PhanTrang '

	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		
	
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY P.CreateDate DESC) AS RowNum,
	PP.Name as ProductPackageName,PB.Name as ProductBrandName, PP.Code,CONCAT(PP.SGTIN, '' - '' + PP.Name) as LS, U.UserName, w.Name as HoSX, P.Name as ProductName, PS.Name as TrangThai, PP.StartDate, PP.EndDate , Z.Name as ZoneName, PP.ExpectedProductivity,(select ISNULL( SUM(Amount),0) from Task where ProductPackage_ID=PP.ProductPackage_ID AND TaskType_ID=3) as TongThuhoach,(select ISNULL( SUM(Amount),0) from Task where ProductPackage_ID=PP.ProductPackage_ID AND TaskType_ID=6) as Tongbanhang
	from ProductPackage PP
	left join aspnet_Users U on U.UserId=PP.CreateBy
	left join Product P on P.Product_ID= PP.Product_ID
	left join ProductPackageStatus PS on PS.ProductPackageStatus_ID= PP.ProductPackageStatus_ID
	left join Workshop w on w.Workshop_ID= PP.Workshop_ID
	left join ProductPackageOrder PO on PO.ProductPackageOrder_ID = PP.ProductPackageOrder_ID
	left join ProductBrand PB on PB.ProductBrand_ID=PP.ProductBrand_ID
	left join Zone Z on Z.Zone_ID= PP.Zone_ID
' + @sql+'
		) 
		
		Select distinct * From s ' + @strSql1 + @orderby + '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from ProductPackage PP
	left join aspnet_Users U on U.UserId=PP.CreateBy
	left join Product P on P.Product_ID= PP.Product_ID
	left join ProductPackageStatus PS on PS.ProductPackageStatus_ID= PP.ProductPackageStatus_ID
	left join Workshop w on w.Workshop_ID= PP.Workshop_ID
	left join ProductPackageOrder PO on PO.ProductPackageOrder_ID = PP.ProductPackageOrder_ID
	left join ProductBrand PB on PB.ProductBrand_ID=PP.ProductBrand_ID
	left join Zone Z on Z.Zone_ID= PP.Zone_ID

' + @sql + @strSql2

+' 	SELECT Count(*) as TotalRecord from ProductPackage PP
	left join aspnet_Users U on U.UserId=PP.CreateBy
	left join Product P on P.Product_ID= PP.Product_ID
	left join ProductPackageStatus PS on PS.ProductPackageStatus_ID= PP.ProductPackageStatus_ID
	left join Workshop w on w.Workshop_ID= PP.Workshop_ID
	left join ProductPackageOrder PO on PO.ProductPackageOrder_ID = PP.ProductPackageOrder_ID
	left join ProductBrand PB on PB.ProductBrand_ID=PP.ProductBrand_ID
	left join Zone Z on Z.Zone_ID= PP.Zone_ID
' + @sql 


)
GO
/****** Object:  StoredProcedure [dbo].[spGetProductPackage_paging]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<DANG DINH DUONG>
-- Create date: <28/08/2020>
-- Description:	<Phân trang lô>
-- =============================================

 
CREATE PROCEDURE [dbo].[spGetProductPackage_paging] --1, 10,7,0,0,0,0,'','2010-08-01 00:11:37.933','2020-09-30 00:11:37.933','','',N'lưỡi',' LastEditDate DESC'
@currPage int,
@recodperpage int,
@Pagesize int,
@ProductPackage_ID int,
@ProductBrand_ID int,
@Workshop_ID int,
@ProductPackageStatus_ID int,
@CreateBy varchar(50),
@FromDate datetime,
@ToDate datetime,
@CODE nvarchar(400)= '',
@SGIN nvarchar(400)= '',
@Name nvarchar(400)= N'',
@ProductBrandList nvarchar(4000),
@orderby nvarchar(4000) = ''
AS

declare @sql nvarchar(4000)

set @sql = ' Where 1=1 and P.ProductPackageStatus_ID<>6 '
if(@ProductPackage_ID>0)
	set @sql +=  ' And P.ProductPackage_ID = '+ CONVERT(varchar(50), @ProductPackage_ID)
if(@ProductBrandList<>'')
	set @sql +=  ' And P.ProductBrand_ID in( '+ @ProductBrandList +' ) '
if(@ProductBrand_ID>0)
	set @sql +=  ' And P.ProductBrand_ID = '+ CONVERT(varchar(50), @ProductBrand_ID)	
if(@Workshop_ID > 0)
	 set @sql += ' And P.Workshop_ID='+ CONVERT(varchar(50), @Workshop_ID)
if(@ProductPackageStatus_ID >0)
	set @sql +=  ' And P.ProductPackageStatus_ID ='+ CONVERT(varchar(50), @ProductPackageStatus_ID)
if(@CreateBy<>'')
	set @sql +=  ' And P.CreateBy = '''+@CreateBy+''''
if(@SGIN<>'')
	set @sql +=  ' And P.SGTIN like N''%'+@SGIN+'%'''
if(@Name<>'')
	set @sql +=  ' And P.Name like N''%'+@Name+'%'''
if(@CODE<>'')
	set @sql +=  ' And P.Code like ''%'+@CODE+'%'''
set @sql +=  ' And Convert(date,P.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''

IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

declare @strSql2 nvarchar(4000)
	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
		BEGIN
			EXEC spProductPackage_pagination @Tolal, ' + Cast(@currPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
		END ELSE
			SELECT '''' AS PhanTrang '
	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY P.LastEditDate DESC) AS RowNum, 
	P.Name,P.ItemCount, P.Product_ID,PB.Name as ProductBrandName,Q.Name as QualityName,PB.Address as ProductBrandAddress, P.ProductPackage_ID, P.Code, P.SGTIN , U.UserName, UE.UserName as NguoiSua, PO.Name as TenLenh
	, P.CreateDate, P.CreateBy, P.LastEditBy, w.Name as HoSX, w.Type, Z.Name as ZoneName
	, P.LastEditDate , PD.Name as ProductName,PD.Image, PS.Name as TrangThai, P.StartDate, P.EndDate 
	from ProductPackage P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join Product PD on PD.Product_ID= P.Product_ID
	left join ProductPackageStatus PS on PS.ProductPackageStatus_ID= P.ProductPackageStatus_ID
	left join Workshop w on w.Workshop_ID= P.Workshop_ID
	left join ProductPackageOrder PO on PO.ProductPackageOrder_ID = P.ProductPackageOrder_ID
	left join ProductBrand PB on PB.ProductBrand_ID=P.ProductBrand_ID
	left join Quality Q on Q.Quality_ID=PD.Quality_ID
	left join Zone Z on Z.Zone_ID= P.Zone_ID
' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby + '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from ProductPackage P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join Product PD on PD.Product_ID= P.Product_ID
	left join ProductPackageStatus PS on PS.ProductPackageStatus_ID= P.ProductPackageStatus_ID
	left join Workshop w on w.Workshop_ID= P.Workshop_ID
	left join ProductPackageOrder PO on PO.ProductPackageOrder_ID = P.ProductPackageOrder_ID
	left join ProductBrand PB on PB.ProductBrand_ID=P.ProductBrand_ID
	left join Quality Q on Q.Quality_ID=PD.Quality_ID
	left join Zone Z on Z.Zone_ID= P.Zone_ID
' + @sql + @strSql2

+' 	SELECT Count(*) as TotalRecord from ProductPackage P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join Product PD on PD.Product_ID= P.Product_ID
	left join ProductPackageStatus PS on PS.ProductPackageStatus_ID= P.ProductPackageStatus_ID
	left join Workshop w on w.Workshop_ID= P.Workshop_ID
	left join ProductPackageOrder PO on PO.ProductPackageOrder_ID = P.ProductPackageOrder_ID
	left join ProductBrand PB on PB.ProductBrand_ID=P.ProductBrand_ID
	left join Quality Q on Q.Quality_ID=PD.Quality_ID
	left join Zone Z on Z.Zone_ID= P.Zone_ID
' + @sql 

)
GO
/****** Object:  StoredProcedure [dbo].[spGetProductPackage_paging_V1]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<DANG DINH DUONG>
-- Create date: <28/08/2020>
-- Description:	<Phân trang lô>
-- =============================================

 
CREATE PROCEDURE [dbo].[spGetProductPackage_paging_V1] --1, 10,7,0,0,0,0,'','2010-08-01 00:11:37.933','2020-09-30 00:11:37.933','','',N'lưỡi',' LastEditDate DESC'
@currPage int,
@recodperpage int,
@Pagesize int,
@ProductPackage_ID int,
@Zone_ID int,
@Area_ID int,
@ProductBrand_ID int,
@Workshop_ID int,
@ProductPackageStatus_ID int,
@Department_ID int,
@Location_ID int,
@District_ID int,
@Ward_ID int,
@ProductPackageOrder_ID int,
@CreateBy varchar(50),
@FromDate datetime,
@ToDate datetime,
@CODE nvarchar(400)= '',
@SGIN nvarchar(400)= '',
@Product_ID int,
@Name nvarchar(400)= N'',
@ProductBrandList nvarchar(4000),
@orderby nvarchar(4000) = ''
AS

declare @sql nvarchar(4000)

set @sql = ' Where 1=1 and P.ProductPackageStatus_ID<>6 '
if(@ProductPackage_ID>0)
	set @sql +=  ' And P.ProductPackage_ID = '+ CONVERT(varchar(50), @ProductPackage_ID)
if(@ProductBrandList<>'')
	set @sql +=  ' And P.ProductBrand_ID in( '+ @ProductBrandList +' ) '
if(@ProductBrand_ID>0)
	set @sql +=  ' And P.ProductBrand_ID = '+ CONVERT(varchar(50), @ProductBrand_ID)	
if(@Department_ID >0)
	set @sql +=  ' And P.ProductBrand_ID in (Select ProductBrand_ID From ProductBrand where DepartmentMan_ID ='+ CONVERT(varchar(50), @Department_ID) + ')'
if(@Location_ID >0)
	set @sql +=   ' And P.ProductBrand_ID in (Select ProductBrand_ID From ProductBrand where Location_ID ='+ CONVERT(varchar(50), @Location_ID) + ')'
if(@District_ID >0)
	set @sql +=  ' And P.ProductBrand_ID in (Select ProductBrand_ID From ProductBrand where District_ID ='+ CONVERT(varchar(50), @District_ID) + ')'
if(@Ward_ID >0)
	set @sql +=  ' And P.ProductBrand_ID in (Select ProductBrand_ID From ProductBrand where Ward_ID ='+ CONVERT(varchar(50), @Ward_ID) + ')'
if(@Workshop_ID > 0)
	 set @sql += ' And P.Workshop_ID='+ CONVERT(varchar(50), @Workshop_ID)
if(@ProductPackageOrder_ID > 0)
	 set @sql += ' And P.ProductPackageOrder_ID='+ CONVERT(varchar(50), @ProductPackageOrder_ID)
if(@Zone_ID > 0)
	 set @sql += ' And P.Zone_ID='+ CONVERT(varchar(50), @Zone_ID)
if(@Area_ID > 0)
	 set @sql += ' And P.Area_ID='+ CONVERT(varchar(50), @Area_ID)
if(@ProductPackageStatus_ID >0)
	set @sql +=  ' And P.ProductPackageStatus_ID ='+ CONVERT(varchar(50), @ProductPackageStatus_ID)
if(@CreateBy<>'')
	set @sql +=  ' And P.CreateBy = '''+@CreateBy+''''
if(@SGIN<>'')
	set @sql +=  ' And P.SGTIN like N''%'+@SGIN+'%'''
if(@Product_ID >0)
	set @sql +=  ' And P.Product_ID='+ CONVERT(varchar(50), @Product_ID)
if(@Name<>'')
	set @sql +=  ' And P.Name like N''%'+@Name+'%'' OR P.ProductPackageOrder_ID in (Select ProductPackageOrder_ID from ProductPackageOrder where CodePO =N'''+@Name+''')'
if(@CODE<>'')
	set @sql +=  ' And P.Code like ''%'+@CODE+'%'''
set @sql +=  ' And Convert(date,P.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''

IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

declare @strSql2 nvarchar(4000)
	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
		BEGIN
			EXEC spProductPackage_pagination @Tolal, ' + Cast(@currPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
		END ELSE
			SELECT '''' AS PhanTrang '
	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY P.LastEditDate DESC) AS RowNum, 
	P.Name,P.ItemCount, P.Product_ID,PB.Name as ProductBrandName,Q.Name as QualityName,PB.Address as ProductBrandAddress, P.ProductPackage_ID, P.Code, P.SGTIN , U.UserName, UE.UserName as NguoiSua, PO.Name as TenLenh,PO.CodePO
	, P.CreateDate, P.CreateBy, P.LastEditBy, w.Name as HoSX, w.Type, w.Address
	, P.LastEditDate , P.Name as ProductName,PD.Image, PD.Name as Pname, PS.Name as TrangThai, P.StartDate, P.EndDate , Z.Name as ZoneName,F.Address as AddressFarm, P.ManufactureTech_ID,P.Type as TypeP
	from ProductPackage P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join Product PD on PD.Product_ID= P.Product_ID
	left join ProductPackageStatus PS on PS.ProductPackageStatus_ID= P.ProductPackageStatus_ID
	left join Workshop w on w.Workshop_ID= P.Workshop_ID
	left join ProductPackageOrder PO on PO.ProductPackageOrder_ID = P.ProductPackageOrder_ID
	left join ProductBrand PB on PB.ProductBrand_ID=P.ProductBrand_ID
	left join Quality Q on Q.Quality_ID=PD.Quality_ID
	left join Zone Z on Z.Zone_ID= P.Zone_ID
	left join Farm F on F.Farm_ID= P.Farm_ID
' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby + '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from ProductPackage P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join Product PD on PD.Product_ID= P.Product_ID
	left join ProductPackageStatus PS on PS.ProductPackageStatus_ID= P.ProductPackageStatus_ID
	left join Workshop w on w.Workshop_ID= P.Workshop_ID
	left join ProductPackageOrder PO on PO.ProductPackageOrder_ID = P.ProductPackageOrder_ID
	left join ProductBrand PB on PB.ProductBrand_ID=P.ProductBrand_ID
	left join Quality Q on Q.Quality_ID=PD.Quality_ID
	left join Zone Z on Z.Zone_ID= P.Zone_ID
	left join Farm F on F.Farm_ID= P.Farm_ID
' + @sql + @strSql2

+' 	SELECT Count(*) as TotalRecord from ProductPackage P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join Product PD on PD.Product_ID= P.Product_ID
	left join ProductPackageStatus PS on PS.ProductPackageStatus_ID= P.ProductPackageStatus_ID
	left join Workshop w on w.Workshop_ID= P.Workshop_ID
	left join ProductPackageOrder PO on PO.ProductPackageOrder_ID = P.ProductPackageOrder_ID
	left join ProductBrand PB on PB.ProductBrand_ID=P.ProductBrand_ID
	left join Quality Q on Q.Quality_ID=PD.Quality_ID
	left join Zone Z on Z.Zone_ID= P.Zone_ID
	left join Farm F on F.Farm_ID= P.Farm_ID
' + @sql 

)
GO
/****** Object:  StoredProcedure [dbo].[spGetProductPackage_paging_V2]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[spGetProductPackage_paging_V2]
@currPage int,
@recodperpage int,
@Pagesize int,
@ProductPackage_ID int,
@Zone_ID int,
@Area_ID int,
@ProductBrand_ID int,
@Workshop_ID int,
@ProductPackageStatus_ID int,
@Department_ID int,
@Location_ID int,
@District_ID int,
@Ward_ID int,
@ProductPackageOrder_ID int,
@CreateBy varchar(50),
@FromDate datetime,
@ToDate datetime,
@CODE nvarchar(400)= '',
@SGIN nvarchar(400)= '',
@Product_ID int,
@Name nvarchar(400)= N'',
@ProductBrandList nvarchar(4000),
@orderby nvarchar(4000) = ''
AS

declare @sql nvarchar(4000)

set @sql = ' Where 1=1 and P.ProductPackageStatus_ID<>6 '
if(@ProductPackage_ID>0)
	set @sql +=  ' And P.ProductPackage_ID = '+ CONVERT(varchar(50), @ProductPackage_ID)
if(@ProductBrandList<>'')
	set @sql +=  ' And P.ProductBrand_ID in( '+ @ProductBrandList +' ) '
if(@ProductBrand_ID>0)
	set @sql +=  ' And P.ProductBrand_ID = '+ CONVERT(varchar(50), @ProductBrand_ID)	
if(@Department_ID >0)
	set @sql +=  ' And P.ProductBrand_ID in (Select ProductBrand_ID From ProductBrand where DepartmentMan_ID ='+ CONVERT(varchar(50), @Department_ID) + ')'
if(@Location_ID >0)
	set @sql +=   ' And P.ProductBrand_ID in (Select ProductBrand_ID From ProductBrand where Location_ID ='+ CONVERT(varchar(50), @Location_ID) + ')'
if(@District_ID >0)
	set @sql +=  ' And P.ProductBrand_ID in (Select ProductBrand_ID From ProductBrand where District_ID ='+ CONVERT(varchar(50), @District_ID) + ')'
if(@Ward_ID >0)
	set @sql +=  ' And P.ProductBrand_ID in (Select ProductBrand_ID From ProductBrand where Ward_ID ='+ CONVERT(varchar(50), @Ward_ID) + ')'
if(@Workshop_ID > 0)
	 set @sql += ' And P.Workshop_ID='+ CONVERT(varchar(50), @Workshop_ID)
if(@ProductPackageOrder_ID > 0)
	 set @sql += ' And P.ProductPackageOrder_ID='+ CONVERT(varchar(50), @ProductPackageOrder_ID)
if(@Zone_ID > 0)
	 set @sql += ' And P.Zone_ID='+ CONVERT(varchar(50), @Zone_ID)
if(@Area_ID > 0)
	 set @sql += ' And P.Area_ID='+ CONVERT(varchar(50), @Area_ID)
if(@ProductPackageStatus_ID >0)
	set @sql +=  ' And P.ProductPackageStatus_ID ='+ CONVERT(varchar(50), @ProductPackageStatus_ID)
if(@CreateBy<>'')
	set @sql +=  ' And P.CreateBy = '''+@CreateBy+''''
if(@SGIN<>'')
	set @sql +=  ' And P.SGTIN like N''%'+@SGIN+'%'''
if(@Product_ID >0)
	set @sql +=  ' And P.Product_ID='+ CONVERT(varchar(50), @Product_ID)
if(@Name<>'')
	set @sql +=  ' And P.Name like N''%'+@Name+'%'' OR P.ProductPackageOrder_ID in (Select ProductPackageOrder_ID from ProductPackageOrder where CodePO =N'''+@Name+''')'
if(@CODE<>'')
	set @sql +=  ' And P.Code like ''%'+@CODE+'%'''
set @sql +=  ' And Convert(date,P.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''

IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

declare @strSql2 nvarchar(4000)
	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)

		BEGIN
			EXEC spProductPackage_pagination @Tolal, ' + Cast(@currPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
		END ELSE
			SELECT '''' AS PhanTrang '

	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		
	
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY P.LastEditDate DESC) AS RowNum,
	P.Name,P.ItemCount, P.Product_ID,PB.Name as ProductBrandName,Q.Name as QualityName,PB.Address as ProductBrandAddress, P.ProductPackage_ID, P.Code, P.SGTIN , U.UserName, UE.UserName as NguoiSua, PO.Name as TenLenh,PO.CodePO
	, P.CreateDate, P.CreateBy, P.LastEditBy, w.Name as HoSX, w.Type, w.Address
	, P.LastEditDate , P.Name as ProductName,PD.Image, PD.Name as Pname, PS.Name as TrangThai, P.StartDate, P.EndDate , Z.Name as ZoneName,F.Address as AddressFarm, P.ManufactureTech_ID,P.Type as TypeP, P.ExpectedProductivity,(select ISNULL( SUM(Amount),0) from Task where ProductPackage_ID=P.ProductPackage_ID AND TaskType_ID=3) as TongThuhoach,(select ISNULL( SUM(Amount),0) from Task where ProductPackage_ID=P.ProductPackage_ID AND TaskType_ID=6) as Tongbanhang
	from ProductPackage P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join Product PD on PD.Product_ID= P.Product_ID
	left join ProductPackageStatus PS on PS.ProductPackageStatus_ID= P.ProductPackageStatus_ID
	left join Workshop w on w.Workshop_ID= P.Workshop_ID
	left join ProductPackageOrder PO on PO.ProductPackageOrder_ID = P.ProductPackageOrder_ID
	left join ProductBrand PB on PB.ProductBrand_ID=P.ProductBrand_ID
	left join Quality Q on Q.Quality_ID=PD.Quality_ID
	left join Zone Z on Z.Zone_ID= P.Zone_ID
	left join Farm F on F.Farm_ID= P.Farm_ID
' + @sql+'
		) 
		
		Select distinct * From s ' + @strSql1 + @orderby + '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from ProductPackage P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join Product PD on PD.Product_ID= P.Product_ID
	left join ProductPackageStatus PS on PS.ProductPackageStatus_ID= P.ProductPackageStatus_ID
	left join Workshop w on w.Workshop_ID= P.Workshop_ID
	left join ProductPackageOrder PO on PO.ProductPackageOrder_ID = P.ProductPackageOrder_ID
	left join ProductBrand PB on PB.ProductBrand_ID=P.ProductBrand_ID
	left join Quality Q on Q.Quality_ID=PD.Quality_ID
	left join Zone Z on Z.Zone_ID= P.Zone_ID
	left join Farm F on F.Farm_ID= P.Farm_ID

' + @sql + @strSql2

+' 	SELECT Count(*) as TotalRecord from ProductPackage P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join Product PD on PD.Product_ID= P.Product_ID
	left join ProductPackageStatus PS on PS.ProductPackageStatus_ID= P.ProductPackageStatus_ID
	left join Workshop w on w.Workshop_ID= P.Workshop_ID
	left join ProductPackageOrder PO on PO.ProductPackageOrder_ID = P.ProductPackageOrder_ID
	left join ProductBrand PB on PB.ProductBrand_ID=P.ProductBrand_ID
	left join Quality Q on Q.Quality_ID=PD.Quality_ID
	left join Zone Z on Z.Zone_ID= P.Zone_ID
	left join Farm F on F.Farm_ID= P.Farm_ID
' + @sql 


)
GO
/****** Object:  StoredProcedure [dbo].[spGetProductPackage_paging_V2Farm]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<DANG DINH DUONG>
-- Create date: <28/08/2020>
-- Description:	<Phân trang lô>
-- =============================================

 CREATE PROCEDURE [dbo].[spGetProductPackage_paging_V2Farm]-- 1, 100,100,0,0,0,0,361,0,'','2010-08-01 00:11:37.933','2033-09-30 00:11:37.933','','','','',''
@currPage int,
@recodperpage int,
@Pagesize int,
@ProductPackage_ID int,
@Zone_ID int,
@ProductBrand_ID int,
@Workshop_ID int,
@Farm_ID int,
@ProductPackageStatus_ID int,
@CreateBy varchar(50),
@FromDate datetime,
@ToDate datetime,
@CODE nvarchar(400)= '',
@SGIN nvarchar(400)= '',
@Name nvarchar(400)= N'',
@ProductBrandList nvarchar(4000),
@orderby nvarchar(4000) = ''
AS

declare @sql nvarchar(4000)

set @sql = ' Where 1=1 and P.ProductPackageStatus_ID<>6'
if(@ProductPackage_ID>0)
	set @sql +=  ' And P.ProductPackage_ID = '+ CONVERT(varchar(50), @ProductPackage_ID)
if(@ProductBrandList<>'')
	set @sql +=  ' And P.ProductBrand_ID in( '+ @ProductBrandList +' ) '
if(@ProductBrand_ID>0)
	set @sql +=  ' And P.ProductBrand_ID = '+ CONVERT(varchar(50), @ProductBrand_ID)	
if(@Workshop_ID > 0)
	 set @sql += ' And P.Workshop_ID='+ CONVERT(varchar(50), @Workshop_ID)
if(@Zone_ID > 0)
	 set @sql += ' And P.Zone_ID='+ CONVERT(varchar(50), @Zone_ID)
if(@Farm_ID > 0)
	 set @sql += ' And P.Farm_ID='+ CONVERT(varchar(50), @Farm_ID)
if(@ProductPackageStatus_ID >0)
	set @sql +=  ' And P.ProductPackageStatus_ID ='+ CONVERT(varchar(50), @ProductPackageStatus_ID)
if(@CreateBy<>'')
	set @sql +=  ' And P.CreateBy = '''+@CreateBy+''''
if(@SGIN<>'')
	set @sql +=  ' And P.SGTIN like N''%'+@SGIN+'%'''
if(@Name<>'')
	set @sql +=  ' And P.Name like N''%'+@Name+'%'''
if(@CODE<>'')
	set @sql +=  ' And P.Code like ''%'+@CODE+'%'''
set @sql +=  ' And Convert(date,P.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''

IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

declare @strSql2 nvarchar(4000)
	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
		BEGIN
			EXEC spProductPackage_pagination @Tolal, ' + Cast(@currPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
		END ELSE
			SELECT '''' AS PhanTrang '
	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY P.LastEditDate DESC) AS RowNum, 
	P.Name,P.ItemCount, P.Product_ID,PB.Name as ProductBrandName,Q.Name as QualityName,PB.Address as ProductBrandAddress, P.ProductPackage_ID, P.Code, P.SGTIN , U.UserName, UE.UserName as NguoiSua, PO.Name as TenLenh
	, P.CreateDate, P.CreateBy, P.LastEditBy, w.Name as HoSX, w.Type, F.Address,w.Address as WorkshopAddress
	, P.LastEditDate , P.Name as ProductName,PD.Image, PD.Name as Pname, PS.Name as TrangThai, P.StartDate, P.EndDate , Z.Name as ZoneName, PD.Image as ImageP
	from ProductPackage P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join Product PD on PD.Product_ID= P.Product_ID
	left join ProductPackageStatus PS on PS.ProductPackageStatus_ID= P.ProductPackageStatus_ID
	left join Workshop w on w.Workshop_ID= P.Workshop_ID
	left join ProductPackageOrder PO on PO.ProductPackageOrder_ID = P.ProductPackageOrder_ID
	left join ProductBrand PB on PB.ProductBrand_ID=P.ProductBrand_ID
	left join Quality Q on Q.Quality_ID=PD.Quality_ID
	left join Zone Z on Z.Zone_ID= P.Zone_ID
	left join Farm F on F.Farm_ID= P.Farm_ID
' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby + '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from ProductPackage P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join Product PD on PD.Product_ID= P.Product_ID
	left join ProductPackageStatus PS on PS.ProductPackageStatus_ID= P.ProductPackageStatus_ID
	left join Workshop w on w.Workshop_ID= P.Workshop_ID
	left join ProductPackageOrder PO on PO.ProductPackageOrder_ID = P.ProductPackageOrder_ID
	left join ProductBrand PB on PB.ProductBrand_ID=P.ProductBrand_ID
	left join Quality Q on Q.Quality_ID=PD.Quality_ID
	left join Zone Z on Z.Zone_ID= P.Zone_ID
	left join Farm F on F.Farm_ID= P.Farm_ID
' + @sql + @strSql2

+' 	SELECT Count(*) as TotalRecord from ProductPackage P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join Product PD on PD.Product_ID= P.Product_ID
	left join ProductPackageStatus PS on PS.ProductPackageStatus_ID= P.ProductPackageStatus_ID
	left join Workshop w on w.Workshop_ID= P.Workshop_ID
	left join ProductPackageOrder PO on PO.ProductPackageOrder_ID = P.ProductPackageOrder_ID
	left join ProductBrand PB on PB.ProductBrand_ID=P.ProductBrand_ID
	left join Quality Q on Q.Quality_ID=PD.Quality_ID
	left join Zone Z on Z.Zone_ID= P.Zone_ID
	left join Farm F on F.Farm_ID= P.Farm_ID
' + @sql 

)

	   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY P.LastEditDate DESC) AS RowNum, 
	P.Name,P.ItemCount, P.Product_ID,PB.Name as ProductBrandName,Q.Name as QualityName,PB.Address as ProductBrandAddress, P.ProductPackage_ID, P.Code, P.SGTIN , U.UserName, UE.UserName as NguoiSua, PO.Name as TenLenh
	, P.CreateDate, P.CreateBy, P.LastEditBy, w.Name as HoSX, w.Type, F.Address,w.Address as WorkshopAddress
	, P.LastEditDate , P.Name as ProductName,PD.Image, PD.Name as Pname, PS.Name as TrangThai, P.StartDate, P.EndDate , Z.Name as ZoneName
	from ProductPackage P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join Product PD on PD.Product_ID= P.Product_ID
	left join ProductPackageStatus PS on PS.ProductPackageStatus_ID= P.ProductPackageStatus_ID
	left join Workshop w on w.Workshop_ID= P.Workshop_ID
	left join ProductPackageOrder PO on PO.ProductPackageOrder_ID = P.ProductPackageOrder_ID
	left join ProductBrand PB on PB.ProductBrand_ID=P.ProductBrand_ID
	left join Quality Q on Q.Quality_ID=PD.Quality_ID
	left join Zone Z on Z.Zone_ID= P.Zone_ID
	left join Farm F on F.Farm_ID= P.Farm_ID where  1=1 and P.ProductPackageStatus_ID<>6 and PB.Location_ID=92 and P.Farm_ID = 361
GO
/****** Object:  StoredProcedure [dbo].[spGetProductReview]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<NGUYEN MINH CHAU>
-- Create date: <27/12/2020>
-- Description:	<Phan trang review san pham>
-- =============================================
 --select  CONVERT(varchar(50),Convert(date,'2010-09-20 00:11:37.933'))
-- select  CONVERT(varchar(50),Convert(date,'2010-09-20 00:11:37.933'))
 
CREATE PROCEDURE [dbo].[spGetProductReview] --1, 5,7,3051,-1,'2010-09-20 00:11:37.933','2010-12-31 00:11:37.933','Hà'
@currPage int,
@recodperpage int,
@Pagesize int,
@Product_ID int,
@Approved int,
@FromDate datetime,
@ToDate datetime,
@FullName nvarchar(400)= N''
AS

declare @sql nvarchar(4000)
set @sql = ' Where 1=1 '
if(@Product_ID > 0)
	 set @sql += ' And P.Product_ID ='+ CONVERT(varchar(50), @Product_ID)
if(@Approved <> -1)
	 set @sql += ' And PR.Approved='+ CONVERT(varchar(50), @Approved)	 
if(@FullName<>'')
	set @sql +=  ' And PR.FullName like N''%'+@FullName+'%'''

set @sql +=  ' And Convert(date,PR.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''

--IF @orderby <> '' 
--	SET @orderby = ' ORDER BY ' + @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

declare @strSql2 nvarchar(4000)
	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
		BEGIN
			EXEC spProduct_pagination @Tolal, ' + Cast(@currPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
		END ELSE
			SELECT '''' AS PhanTrang '
	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY PR.ProductReview_ID DESC) AS RowNum,
		   PR.ProductReview_ID, PR.FullName,PR.Title, cast (PR.Description as nvarchar(max)) as NoiDung, PR.Star, PR.Status , PR.CreateDate , PR.ApprovedDate, PR.Approved , PR.Type , U.UserName , P.Product_ID 
	from ProductReview PR
	left join ProductInfo P on PR.ProductInfo_ID = P.ProductInfo_ID
	left join aspnet_Users U on U.UserId= PR.ApprovedUser
' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from ProductReview PR
	left join ProductInfo P on PR.ProductInfo_ID = P.ProductInfo_ID
	left join aspnet_Users U on U.UserId= PR.ApprovedUser
' + @sql + @strSql2

+' 	SELECT Count(*) as TotalRecord from ProductReview PR
	left join ProductInfo P on PR.ProductInfo_ID = P.ProductInfo_ID
	left join aspnet_Users U on U.UserId= PR.ApprovedUser
' + @sql 

)
GO
/****** Object:  StoredProcedure [dbo].[spGetQRCodePackage_paging]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<DANG DINH DUONG>
-- Create date: <28/08/2020>
-- Description:	<Phân trang lô>
-- =============================================

 
CREATE PROCEDURE [dbo].[spGetQRCodePackage_paging] --1, 10,7,0,0,-1,0,'','2010-08-01 00:11:37.933','2021-11-30 00:11:37.933',' and P.ProductBrand_ID in (680)',' LastEditDate DESC'
@currPage int,
@recodperpage int,
@Pagesize int,
@QRCodePackage_ID int,
@ProductBrand_ID int,
@QRCodeStatus_ID int,
@QRCodePackageType_ID int,
@Department_ID int,
@Location_ID int,
@District_ID int,
@Ward_ID int,
@Product_ID int,
@ProductPackage_ID int,
@CreateBy varchar(50),
@FromDate datetime,
@ToDate datetime,
@Name nvarchar(400)= N'',
@Serial nvarchar(400)= N'',
@Where nvarchar(MAX)= N'',
@orderby nvarchar(4000) = ''
AS

declare @sql nvarchar(MAX)

set @sql = ' Where P.Active=1 '
if(@QRCodePackage_ID>0)
	set @sql +=  ' And P.QRCodePackage_ID = '+ CONVERT(varchar(50), @QRCodePackage_ID)
if(@ProductBrand_ID<>0)
	set @sql +=  ' And P.ProductBrand_ID = '+ CONVERT(varchar(50), @ProductBrand_ID)	
if(@Department_ID >0)
	set @sql +=  ' And P.ProductBrand_ID in (Select ProductBrand_ID From ProductBrand where DepartmentMan_ID ='+ CONVERT(varchar(50), @Department_ID) + ')'
if(@QRCodePackageType_ID >0)
	set @sql +=  ' And P.QRCodePackageType_ID ='+ CONVERT(varchar(50), @QRCodePackageType_ID)
if(@Location_ID >0)
	set @sql +=   ' And P.ProductBrand_ID in (Select ProductBrand_ID From ProductBrand where Location_ID ='+ CONVERT(varchar(50), @Location_ID) + ')'
if(@District_ID >0)
	set @sql +=  ' And P.ProductBrand_ID in (Select ProductBrand_ID From ProductBrand where District_ID ='+ CONVERT(varchar(50), @District_ID) + ')'
if(@Ward_ID >0)
	set @sql +=  ' And P.ProductBrand_ID in (Select ProductBrand_ID From ProductBrand where Ward_ID ='+ CONVERT(varchar(50), @Ward_ID) + ')'
if(@Product_ID <>0)
	set @sql +=  ' And P.Product_ID ='+ CONVERT(varchar(50), @Product_ID)	
if(@ProductPackage_ID <>0)
	set @sql +=  ' And P.ProductPackage_ID ='+ CONVERT(varchar(50), @ProductPackage_ID)	
if(@QRCodeStatus_ID >=0)
	set @sql +=  ' And P.QRCodeStatus_ID ='+ CONVERT(varchar(50), @QRCodeStatus_ID)	
if(@CreateBy<>'')
	set @sql +=  ' And P.CreateBy = '''+@CreateBy+''''
if(@Name<>'')
	set @sql +=  ' And (P.Name like N''%'+@Name+'%'' or P.ProductName like N''%'+@Name+'%'')'
if (@Serial <>'')
	set @sql +=  ' And ('''+@Serial+''' BETWEEN P.SerialNumberStart and P.SerialNumberEnd) '
if(@Where<>'')
	set @sql +=  @Where

set @sql +=  ' And Convert(date,P.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''

IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

declare @strSql2 nvarchar(4000)
	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
		BEGIN
			EXEC spProductPackage_pagination @Tolal, ' + Cast(@currPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
		END ELSE
			SELECT '''' AS PhanTrang '
	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY P.LastEditDate DESC) AS RowNum, 
	P.Name,P.ProductName, P.Product_ID, P.QRCodePackage_ID,P.ProductBrand_ID, P.QRCodePackageType_ID,  P.QRCodeNumber, P.SerialNumberStart, P.SerialNumberEnd , U.UserName, UE.UserName as NguoiSua, P.CreateDate, P.CreateBy, P.LastEditBy, P.LastEditDate ,PD.Image,ISNULL(PD.Name,N''#Sản phẩm chưa xác định#'') as TenSP, PS.Name as TrangThai from QRCodePackage P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join Product PD on PD.Product_ID= P.Product_ID
	left join QRCodeStatus PS on PS.QRCodeStatus_ID= P.QRCodeStatus_ID
' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby + '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from QRCodePackage P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join Product PD on PD.Product_ID= P.Product_ID
	left join QRCodeStatus PS on PS.QRCodeStatus_ID= P.QRCodeStatus_ID
' + @sql + @strSql2

+' 	SELECT Count(*) as TotalRecord from QRCodePackage P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join Product PD on PD.Product_ID= P.Product_ID
	left join QRCodeStatus PS on PS.QRCodeStatus_ID= P.QRCodeStatus_ID
' + @sql 

)
	   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY P.LastEditDate DESC) AS RowNum, 
	P.Name,P.ProductName, P.Product_ID, P.QRCodePackage_ID,P.ProductBrand_ID, P.QRCodePackageType_ID,  P.QRCodeNumber, P.SerialNumberStart, P.SerialNumberEnd , U.UserName, UE.UserName as NguoiSua, P.CreateDate, P.CreateBy, P.LastEditBy, P.LastEditDate ,PD.Image,ISNULL(PD.Name,N'#Sản phẩm chưa xác định#') as TenSP, PS.Name as TrangThai from QRCodePackage P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join Product PD on PD.Product_ID= P.Product_ID
	left join QRCodeStatus PS on PS.QRCodeStatus_ID= P.QRCodeStatus_ID
GO
/****** Object:  StoredProcedure [dbo].[spGetQRCodePackage_ReportThongKeLoMa]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<DANG DINH DUONG>
-- Create date: <23/10/2021>
-- Description:	<Phân trang lô>
-- =============================================

 
CREATE PROCEDURE [dbo].[spGetQRCodePackage_ReportThongKeLoMa] --1, 10,7,0,0,0,-1,0,0,0,0,'','2010-08-01 00:11:37.933','2021-11-30 00:11:37.933','','',' ',' P.LastEditDate DESC'
@currPage int,
@recodperpage int,
@Pagesize int,
@Product_ID int,
@ProductPackage_ID int,
@ProductBrand_ID int,
@QRCodeStatus_ID int,
@QRCodePackageType_ID int,
@DepartmentMan_ID int,
@District_ID int,
@Ward_ID int,
@CreateBy varchar(50),
@FromDate datetime,
@ToDate datetime,
@Name nvarchar(400)= N'',
@Serial nvarchar(400)= N'',
@Where nvarchar(MAX)= N'',
@orderby nvarchar(4000) = ''
AS

declare @sql nvarchar(MAX)

set @sql = ' Where P.Active=1 '
if(@Product_ID<>0)
	set @sql +=  ' And P.Product_ID = '+ CONVERT(varchar(50), @Product_ID)
if(@ProductPackage_ID<>0)
	set @sql +=  ' And P.ProductPackage_ID = '+ CONVERT(varchar(50), @ProductPackage_ID)
if(@ProductBrand_ID<>0)
	set @sql +=  ' And P.ProductBrand_ID = '+ CONVERT(varchar(50), @ProductBrand_ID)	
if(@QRCodePackageType_ID >0)
	set @sql +=  ' And P.QRCodePackageType_ID ='+ CONVERT(varchar(50), @QRCodePackageType_ID)
if(@DepartmentMan_ID>0)
	set @sql += ' and PB.DepartmentMan_ID ='+ CONVERT(varchar(50), @DepartmentMan_ID)
if(@District_ID>0)
	set @sql += ' and PB.District_ID ='+ CONVERT(varchar(50), @District_ID)
if(@Ward_ID>0)
	set @sql += ' and PB.Ward_ID ='+ CONVERT(varchar(50), @Ward_ID)
if(@QRCodeStatus_ID >=0)
	set @sql +=  ' And P.QRCodeStatus_ID ='+ CONVERT(varchar(50), @QRCodeStatus_ID)	
if(@CreateBy<>'')
	set @sql +=  ' And P.CreateBy = '''+@CreateBy+''''
if(@Name<>'')
	set @sql +=  ' And (P.Name like N''%'+@Name+'%'') or (P.ProductName like N''%'+@Name+'%'')'
if (@Serial <>'')
	set @sql +=  ' And ('''+@Serial+''' BETWEEN P.SerialNumberStart and P.SerialNumberEnd) '
if(@Where<>'')
	set @sql +=  @Where

set @sql +=  ' And Convert(date,P.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''

IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

declare @strSql2 nvarchar(4000)
	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
		BEGIN
			EXEC spProductPackage_pagination @Tolal, ' + Cast(@currPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
		END ELSE
			SELECT '''' AS PhanTrang '
	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER('+@orderby+') AS RowNum, 
	P.Name,P.ProductName, U.UserName,(CONVERT(VARCHAR(10),  P.ManufactureDate, 103) )   as NgaySX,(CONVERT(VARCHAR(10),   P.HarvestDate , 103) )as NgayThuHoach, P.QRCodeNumber, P.SerialNumberStart, P.SerialNumberEnd , P.LastEditDate  from QRCodePackage P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join ProductBrand PB on PB.ProductBrand_ID = P.ProductBrand_ID
	left join Product PD on PD.Product_ID= P.Product_ID
	left join QRCodeStatus PS on PS.QRCodeStatus_ID= P.QRCodeStatus_ID
' + @sql+'
		) 
		Select distinct * From s ' + @strSql1  + '
	
'

+' 	SELECT Count(*) as TotalRecord from QRCodePackage P
	left join aspnet_Users U on U.UserId=P.CreateBy
	left join aspnet_Users UE on UE.UserId=P.LastEditBy
	left join ProductBrand PB on PB.ProductBrand_ID = P.ProductBrand_ID
	left join Product PD on PD.Product_ID= P.Product_ID
	left join QRCodeStatus PS on PS.QRCodeStatus_ID= P.QRCodeStatus_ID
' + @sql 

)
GO
/****** Object:  StoredProcedure [dbo].[spGetQRCodeReport]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<NGUYEN MINH CHAU>
-- Create date: <01/05/2020>
-- Description:	<Phân trang lô>
-- =============================================

 --select CONVERT(varchar(50), Convert(date,'2010-12-22 10:25:19.120'))
CREATE PROCEDURE [dbo].[spGetQRCodeReport] --501,0,0,1,'2010-12-22 ','2020-12-31'

@ProductBrand_ID int,
@product_ID int,
@QRCodeStatus_ID int,
@QRCodePackageType_ID int,
@FromDate datetime,
@ToDate datetime

AS

declare @sql nvarchar(4000)

set @sql = 'where  QRP.Active = 1   '

if(@ProductBrand_ID<>0)
	set @sql +=  ' And QRP.ProductBrand_ID = '+ CONVERT(varchar(50), @ProductBrand_ID)
if(@product_ID<>0)
if(@product_ID>0)
	BEGIN
	set @sql +=  ' And QRP.Product_ID = '+ CONVERT(varchar(50), @product_ID)	
	END
ELSE
	BEGIN
	set @sql +=  ' And QRP.Product_ID<0 '	
	END	
--if(@QRCodePackageType_ID >0)
--	set @sql +=  ' And QRP.QRCodePackageType_ID ='+ CONVERT(varchar(50), @QRCodePackageType_ID)
if(@QRCodeStatus_ID >= 0)
	set @sql +=  ' And QRP.QRCodeStatus_ID ='+ CONVERT(varchar(50), @QRCodeStatus_ID)	
set @sql +=  ' And Convert(Date,QS.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''
if (@QRCodePackageType_ID = 2)
	BEGIN
		execute('
		select
	(select COUNT (QRCodeSecretContent) as NumberQRCodeSecretContent
	from QRCodeSecret QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	 ' +@sql + ' and  MONTH(QS.CreateDate)=1  ) as T1

	,(select COUNT (QRCodeSecretContent) as NumberQRCodeSecretContent
	from QRCodeSecret QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	  ' +@sql + ' and  MONTH(QS.CreateDate)=2  ) as T2


	,(select COUNT (QRCodeSecretContent) as NumberQRCodeSecretContent
	from QRCodeSecret QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	 ' +@sql + ' and  MONTH(QS.CreateDate)=3 ) as T3


	,(select COUNT (QRCodeSecretContent) as NumberQRCodeSecretContent
	from QRCodeSecret QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	 ' +@sql + ' and  MONTH(QS.CreateDate)=4 ) as T4


	,(select COUNT (QRCodeSecretContent) as NumberQRCodeSecretContent
	from QRCodeSecret QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	' +@sql + ' and  MONTH(QS.CreateDate)=5 ) as T5


	,(select COUNT (QRCodeSecretContent) as NumberQRCodeSecretContent
	from QRCodeSecret QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	' +@sql + ' and  MONTH(QS.CreateDate)=6 ) as T6


	,(select COUNT (QRCodeSecretContent) as NumberQRCodeSecretContent
	from QRCodeSecret QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	' +@sql + ' and  MONTH(QS.CreateDate)=7 ) as T7


	,(select COUNT (QRCodeSecretContent) as NumberQRCodeSecretContent
	from QRCodeSecret QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	 ' +@sql + ' and  MONTH(QS.CreateDate)=8 ) as T8


	,(select COUNT (QRCodeSecretContent) as NumberQRCodeSecretContent
	from QRCodeSecret QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	 ' +@sql + ' and  MONTH(QS.CreateDate)=9 ) as T9


	,(select COUNT (QRCodeSecretContent) as NumberQRCodeSecretContent
	from QRCodeSecret QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	 ' +@sql + ' and  MONTH(QS.CreateDate)=10 ) as T10


	,(select COUNT (QRCodeSecretContent) as NumberQRCodeSecretContent
	from QRCodeSecret QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	 ' +@sql + ' and  MONTH(QS.CreateDate)=11 ) as T11



	,(select COUNT (QRCodeSecretContent) as NumberQRCodeSecretContent
	from QRCodeSecret QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	 ' +@sql + ' and  MONTH(QS.CreateDate)=12 ) as T12'
		
	)
	END
ELSE 
	BEGIN 
	execute('
		select
	(select COUNT (QRCodePublicContent) as NumberQRCodePublicContent
	from QRCodePublic QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	 ' +@sql + ' and  MONTH(QS.CreateDate)=1  ) as T1

	,(select COUNT (QRCodePublicContent) as NumberQRCodePublicContent
	from QRCodePublic QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	  ' +@sql + ' and  MONTH(QS.CreateDate)=2  ) as T2


	,(select COUNT (QRCodePublicContent) as NumberQRCodePublicContent
	from QRCodePublic QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	 ' +@sql + ' and  MONTH(QS.CreateDate)=3 ) as T3


	,(select COUNT (QRCodePublicContent) as NumberQRCodePublicContent
	from QRCodePublic QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	 ' +@sql + ' and  MONTH(QS.CreateDate)=4 ) as T4


	,(select COUNT (QRCodePublicContent) as NumberQRCodePublicContent
	from QRCodePublic QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	' +@sql + ' and  MONTH(QS.CreateDate)=5 ) as T5


	,(select COUNT (QRCodePublicContent) as NumberQRCodePublicContent
	from QRCodePublic QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	' +@sql + ' and  MONTH(QS.CreateDate)=6 ) as T6


	,(select COUNT (QRCodePublicContent) as NumberQRCodePublicContent
	from QRCodePublic QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	' +@sql + ' and  MONTH(QS.CreateDate)=7 ) as T7


	,(select COUNT (QRCodePublicContent) as NumberQRCodePublicContent
	from QRCodePublic QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	 ' +@sql + ' and  MONTH(QS.CreateDate)=8 ) as T8


	,(select COUNT (QRCodePublicContent) as NumberQRCodePublicContent
	from QRCodePublic QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	 ' +@sql + ' and  MONTH(QS.CreateDate)=9 ) as T9


	,(select COUNT (QRCodePublicContent) as NumberQRCodePublicContent
	from QRCodePublic QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	 ' +@sql + ' and  MONTH(QS.CreateDate)=10 ) as T10


	,(select COUNT (QRCodePublicContent) as NumberQRCodePublicContent
	from QRCodePublic QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	 ' +@sql + ' and  MONTH(QS.CreateDate)=11 ) as T11



	,(select COUNT (QRCodePublicContent) as NumberQRCodePublicContent
	from QRCodePublic QS 
	left join QRCodePackage QRP on QRP.QRCodePackage_ID = QS.QRCodePackage_ID
	 ' +@sql + ' and  MONTH(QS.CreateDate)=12 ) as T12'
		
	)
	END	

GO
/****** Object:  StoredProcedure [dbo].[spGetVieo_paging]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spGetVieo_paging] --1,10,10,'','','','',''
@currentPage int,
@recodperpage int,
@PageSize int,
@Title nvarchar(400) = N'',
@StartDate datetime,
@EndDate datetime,
@Where nvarchar(400) = N'',
@orderby nvarchar(4000) = ''
AS

declare @sql nvarchar(4000)

set @sql = ' Where Active=1 '

if(@Title<>'')
		set @sql +=  ' And (Title like N''%'+@Title+'%'')'
if(@Where<>'')
	set @sql +=  @Where
set @sql += 'and Convert(date, CreateDate) between ''' + CONVERT(varchar(50),CONVERT(date,@StartDate)) + ''' and ''' + CONVERT(varchar(50),CONVERT(date,@EndDate))+''''

IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currentPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currentPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''



	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY Video_ID DESC) AS RowNum,Video_ID, Title, Image, URL, CreateDate, Active from BNN_Video ' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby+ '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from BNN_Video
' + @sql --+ @strSql2

+' 	SELECT Count(*) as TotalRecord from BNN_Video
' + @sql 
)
GO
/****** Object:  StoredProcedure [dbo].[spGetWarehouseExport]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<NGUYEN MINH CHAU>
-- Create date: <11/09/2020>
-- Description:	<Phan trang farm>
-- =============================================

CREATE PROCEDURE [dbo].[spGetWarehouseExport]  --1, 1000,7,508,2,0,'2010-08-01 00:11:37.933','2021-08-01 00:11:37.933',''


@currPage int,
@recodperpage int,
@Pagesize int,
@ProductBrand_ID int,
@ProductPackageOrder_ID int,
--@Warehouse_ID int,
--@ProductPackage_ID int,
@Material_ID int ,
@Type_ID int,
@Name nvarchar(400)= N'',
@Zone_ID int,
@Area_ID int,
@Warehouse_ID int,
@FromDate datetime,
@ToDate datetime,
@orderby nvarchar(4000) = '',
@UserId nvarchar(100)


AS
 declare @sql nvarchar(4000)
set @sql = ''
if(@ProductBrand_ID>0)
	set @sql +=  ' And WE.ProductBrand_ID = '+ CONVERT(varchar(50), @ProductBrand_ID)
if(@ProductPackageOrder_ID>0)
	set @sql +=  ' And WE.ProductPackageOrder_ID = '+ CONVERT(varchar(50), @ProductPackageOrder_ID)	
if(@Name<>'')
	set @sql +=  ' And WE.Name like N''%'+@Name+'%'''
IF(@Zone_ID>0)
	set @sql += ' And W.Zone_ID = '+ CONVERT(VARCHAR(50), @Zone_ID)
IF(@Area_ID>0)
	set @sql += ' And W.Area_ID = '+ CONVERT(VARCHAR(50), @Area_ID)
IF(@Warehouse_ID>0)
	set @sql += ' And W.Warehouse_ID = '+ CONVERT(VARCHAR(50), @Warehouse_ID)
if(@UserId<>'')
	set @sql +=  ' And WE.CreateBy ='''+@UserId+''''
--if(@Warehouse_ID>0)
--	set @sql +=  ' And WE.Warehouse_ID = '+ CONVERT(varchar(50), @Warehouse_ID)
--if(@ProductPackage_ID>0)
--	set @sql +=  ' And WE.ProductPackage_ID = '+ CONVERT(varchar(50), @ProductPackage_ID)	
 if(@Material_ID>0)
   set @sql +=  ' and WE.WarehouseExport_ID in (Select WarehouseExport_ID from WarehouseExportMaterial where WarehouseExport_ID = WE.WarehouseExport_ID and Material_ID = '+ CONVERT(varchar(50), @Material_ID)+')'


 if(@Type_ID >0)
   set @sql += ' And W.Type = ' + CONVERT(VARCHAR(50), @Type_ID)
set @sql +=  ' And Convert(date,WE.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''			
IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

declare @strSql2 nvarchar(4000)
	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
		BEGIN
			EXEC spProduct_pagination @Tolal, ' + Cast(@currPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
		END ELSE
			SELECT '''' AS PhanTrang '
	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY WE.CreateDate DESC) AS RowNum, WE.WarehouseExport_ID,WE.Name,WE.Amount,WE.Exporter,WE.Importer,WE.CreateDate, PO.Name as TenLenh,WE.Comment
		   from WarehouseExport WE
		   left join ProductPackageOrder PO on PO.ProductPackageOrder_ID= WE.ProductPackageOrder_ID
			 left join Warehouse W on W.Warehouse_ID = WE.Warehouse_ID
		   where  WE.Active = 1 
	
' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby + '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*)  from WarehouseExport WE
		   left join ProductPackageOrder PO on PO.ProductPackageOrder_ID= WE.ProductPackageOrder_ID
			 left join Warehouse W on W.Warehouse_ID = WE.Warehouse_ID
		   where  WE.Active = 1 
		   
' + @sql + @strSql2

+' 	SELECT Count(*) as TotalRecord  from WarehouseExport WE
		   left join ProductPackageOrder PO on PO.ProductPackageOrder_ID= WE.ProductPackageOrder_ID
			 left join Warehouse W on W.Warehouse_ID = WE.Warehouse_ID
		   where  WE.Active = 1 

' + @sql 
)
GO
/****** Object:  StoredProcedure [dbo].[spGetWarehouseExportV2]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<NGUYEN MINH CHAU>
-- Create date: <11/09/2020>
-- Description:	<Phan trang farm>
-- =============================================

CREATE PROCEDURE [dbo].[spGetWarehouseExportV2]  --1, 1000,7,508,2,0,'2010-08-01 00:11:37.933','2021-08-01 00:11:37.933',''


@currPage int,
@recodperpage int,
@Pagesize int,
@ProductBrand_ID int,
@ProductPackageOrder_ID int,
@Why int,
@WhyPO int,
@WhyCustomer int,
--@Warehouse_ID int,
--@ProductPackage_ID int,
@Material_ID int ,
@Type_ID int,
@Name nvarchar(400)= N'',
@Zone_ID int,
@Area_ID int,
@Warehouse_ID int,
@FromDate datetime,
@ToDate datetime,
@orderby nvarchar(4000) = '',
@UserId nvarchar(100)


AS
 declare @sql nvarchar(4000)
set @sql = ''
if(@ProductBrand_ID>0)
	set @sql +=  ' And WE.ProductBrand_ID = '+ CONVERT(varchar(50), @ProductBrand_ID)
if(@ProductPackageOrder_ID>0)
	set @sql +=  ' And WE.ProductPackageOrder_ID = '+ CONVERT(varchar(50), @ProductPackageOrder_ID)
if(@Why>0)
	set @sql +=  ' And WE.Why = '+ CONVERT(varchar(50), @Why)
if(@WhyPO>0)
	set @sql +=  ' And WE.WhyPO = '+ CONVERT(varchar(50), @WhyPO)
if(@WhyCustomer>0)
	set @sql +=  ' And WE.WhyCustomer = '+ CONVERT(varchar(50), @WhyCustomer)
if(@Name<>'')
	set @sql +=  ' And WE.Name like N''%'+@Name+'%'''
IF(@Zone_ID>0)
	set @sql += ' And W.Zone_ID = '+ CONVERT(VARCHAR(50), @Zone_ID)
IF(@Area_ID>0)
	set @sql += ' And W.Area_ID = '+ CONVERT(VARCHAR(50), @Area_ID)
IF(@Warehouse_ID>0)
	set @sql += ' And W.Warehouse_ID = '+ CONVERT(VARCHAR(50), @Warehouse_ID)
if(@UserId<>'')
	set @sql +=  ' And WE.CreateBy ='''+@UserId+''''
--if(@Warehouse_ID>0)
--	set @sql +=  ' And WE.Warehouse_ID = '+ CONVERT(varchar(50), @Warehouse_ID)
--if(@ProductPackage_ID>0)
--	set @sql +=  ' And WE.ProductPackage_ID = '+ CONVERT(varchar(50), @ProductPackage_ID)	
 if(@Material_ID>0)
   set @sql +=  ' and WE.WarehouseExport_ID in (Select WarehouseExport_ID from WarehouseExportMaterial where WarehouseExport_ID = WE.WarehouseExport_ID and Material_ID = '+ CONVERT(varchar(50), @Material_ID)+')'


 if(@Type_ID >0)
   set @sql += ' And W.Type = ' + CONVERT(VARCHAR(50), @Type_ID)
set @sql +=  ' And Convert(date,WE.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''			
IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

declare @strSql2 nvarchar(4000)
	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
		BEGIN
			EXEC spProduct_pagination @Tolal, ' + Cast(@currPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
		END ELSE
			SELECT '''' AS PhanTrang '
	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY WE.CreateDate DESC) AS RowNum, WE.WarehouseExport_ID,WE.Name,WE.Amount,WE.Exporter,WE.Importer,WE.CreateDate, PO.Name as TenLenh,WE.Comment
		   from WarehouseExport WE
		   left join ProductPackageOrder PO on PO.ProductPackageOrder_ID= WE.ProductPackageOrder_ID
			 left join Warehouse W on W.Warehouse_ID = WE.Warehouse_ID
			 left join POManage PM on PM.PO_ID = WE.WhyPO
		   where  WE.Active = 1 
	
' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby + '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*)  from WarehouseExport WE
		   left join ProductPackageOrder PO on PO.ProductPackageOrder_ID= WE.ProductPackageOrder_ID
			 left join Warehouse W on W.Warehouse_ID = WE.Warehouse_ID
			 left join POManage PM on PM.PO_ID = WE.WhyPO
		   where  WE.Active = 1 
		   
' + @sql + @strSql2

+' 	SELECT Count(*) as TotalRecord  from WarehouseExport WE
		   left join ProductPackageOrder PO on PO.ProductPackageOrder_ID= WE.ProductPackageOrder_ID
			 left join Warehouse W on W.Warehouse_ID = WE.Warehouse_ID
		   where  WE.Active = 1 

' + @sql 
)
GO
/****** Object:  StoredProcedure [dbo].[spGetWarehouseImport]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<DANG DINH DUONG>
-- Create date: <11/09/2020>
-- Description:	<Phan trang farm>
-- =============================================

CREATE PROCEDURE [dbo].[spGetWarehouseImport] --1, 1000,7,501,0,'2010-08-01 00:11:37.933','2021-08-01 00:11:37.933',''


@currPage int,
@recodperpage int,
@Pagesize int,
@ProductBrand_ID int,
@Warehouse_ID int,
@Material_ID int,
@Name nvarchar(500),
@Product_ID int,
@Zone_ID int,
@Area_ID int,
@FromDate datetime,
@ToDate datetime,
@orderby nvarchar(4000) = '',
@UserId nvarchar(100)


AS
 declare @sql nvarchar(4000)
set @sql = ''
if(@ProductBrand_ID>0)
	set @sql +=  ' And WI.ProductBrand_ID = '+ CONVERT(varchar(50), @ProductBrand_ID)
if(@Warehouse_ID>0)
	set @sql +=  ' And WI.Warehouse_ID = '+ CONVERT(varchar(50), @Warehouse_ID)
if(@Material_ID>0)
	set @sql +=  ' And WI.Material_ID = '+ CONVERT(varchar(50), @Material_ID)
if(@Product_ID>0)
	set @sql += ' And WI.Product_ID = '+ CONVERT(varchar(50), @Product_ID) 
if(@Zone_ID>0)
	set @sql += ' And W.Zone_ID = '+ CONVERT(VARCHAR(50), @Zone_ID)
if(@Area_ID>0)
	set @sql += ' And W.Area_ID = '+ CONVERT(VARCHAR(50), @Area_ID)
if(@Name<>'')
	set @sql +=  ' And WI.Name like N''%'+@Name+'%'' OR WI.Code like N''%'+@Name+'%'''
if(@UserId<>'')
	set @sql +=  ' And WI.CreateBy ='''+@UserId+''''
set @sql += ' And W.Type = 1'
set @sql +=  ' And Convert(date,WI.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''				
IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby


declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

declare @strSql2 nvarchar(4000)
	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
		BEGIN
			EXEC spProduct_pagination @Tolal, ' + Cast(@currPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
		END ELSE
			SELECT '''' AS PhanTrang '
	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY WI.CREATEDATE DESC) AS RowNum, WI.*, PB.Name as ProductBrandName, W.Name as WarehouseName  from WarehouseImport WI   
left join ProductBrand PB on WI.ProductBrand_ID = PB.ProductBrand_ID 
left join Warehouse W on WI.Warehouse_ID = W.Warehouse_ID
where PB.Active<>-1 and WI.Active = 1  and W.Active=1
	
' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby + '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from WarehouseImport WI   
left join ProductBrand PB on WI.ProductBrand_ID = PB.ProductBrand_ID 
left join Warehouse W on WI.Warehouse_ID = W.Warehouse_ID

where PB.Active<>-1 and WI.Active = 1  and W.Active=1
		   
' + @sql + @strSql2

+' 	SELECT Count(*) as TotalRecord from WarehouseImport WI   
left join ProductBrand PB on WI.ProductBrand_ID = PB.ProductBrand_ID 
left join Warehouse W on WI.Warehouse_ID = W.Warehouse_ID
where PB.Active<>-1 and WI.Active = 1  and W.Active=1
' + @sql 

)
GO
/****** Object:  StoredProcedure [dbo].[spGetWarehouseImportProduct]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<DANG DINH DUONG>
-- Create date: <11/09/2020>
-- Description:	<Phan trang farm>
-- =============================================

CREATE PROCEDURE [dbo].[spGetWarehouseImportProduct]--- 1, 1000,7,1524,0,0,'',0,0,0,0,'2010-08-01 00:11:37.933','2021-08-01 00:11:37.933','',''


@currPage int,
@recodperpage int,
@Pagesize int,
@ProductBrand_ID int,
@Warehouse_ID int,
@Material_ID int,
@Name nvarchar(500),
@Product_ID int,
@Zone_ID int,
@Area_ID int,
@ProductPackage_ID int,
@FromDate datetime,
@ToDate datetime,
@orderby nvarchar(4000) = '',
@UserId nvarchar(100)


AS
 declare @sql nvarchar(4000)
set @sql = ''
if(@ProductBrand_ID>0)
	set @sql +=  ' And WI.ProductBrand_ID = '+ CONVERT(varchar(50), @ProductBrand_ID)
if(@Warehouse_ID>0)
	set @sql +=  ' And WI.Warehouse_ID = '+ CONVERT(varchar(50), @Warehouse_ID)
if(@Material_ID>0)
	set @sql +=  ' And WI.Material_ID = '+ CONVERT(varchar(50), @Material_ID)
if(@Product_ID>0)
	set @sql += ' And WI.Product_ID = '+ CONVERT(varchar(50), @Product_ID) 
if(@Zone_ID>0)
	set @sql += ' And W.Zone_ID = '+ CONVERT(VARCHAR(50), @Zone_ID)
if(@Area_ID>0)
	set @sql += ' And W.Area_ID = '+ CONVERT(VARCHAR(50), @Area_ID)
if(@ProductPackage_ID >0)
  set @sql += ' and WI.WarehouseImport_ID in (Select WarehouseImport_ID from WarehouseImportProductPackage WHERE ProductPackage_ID = ''' + CONVERT(varchar(50), @ProductPackage_ID) + ''')'
if(@Name<>'')
	set @sql +=  ' And WI.Name like N''%'+@Name+'%'' OR WI.Code like N''%'+@Name+'%'''
if(@UserId<>'')
	set @sql +=  ' And WI.CreateBy ='''+@UserId+''''
set @sql += ' And W.Type = 2' 
set @sql +=  ' And Convert(date,WI.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''				
IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby


declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

declare @strSql2 nvarchar(4000)
	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
		BEGIN
			EXEC spProduct_pagination @Tolal, ' + Cast(@currPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
		END ELSE
			SELECT '''' AS PhanTrang '
	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY WI.CreateDate DESC) AS RowNum, WI.*, PB.Name as ProductBrandName, W.Name as WarehouseName  from WarehouseImport WI   
left join ProductBrand PB on WI.ProductBrand_ID = PB.ProductBrand_ID 
left join Warehouse W on WI.Warehouse_ID = W.Warehouse_ID
where PB.Active<>-1 and WI.Active = 1  and W.Active=1
	
' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby + '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from WarehouseImport WI   
left join ProductBrand PB on WI.ProductBrand_ID = PB.ProductBrand_ID 
left join Warehouse W on WI.Warehouse_ID = W.Warehouse_ID

where PB.Active<>-1 and WI.Active = 1  and W.Active=1
		   
' + @sql + @strSql2

+' 	SELECT Count(*) as TotalRecord from WarehouseImport WI   
left join ProductBrand PB on WI.ProductBrand_ID = PB.ProductBrand_ID 
left join Warehouse W on WI.Warehouse_ID = W.Warehouse_ID
where PB.Active<>-1 and WI.Active = 1  and W.Active=1
' + @sql 

)
GO
/****** Object:  StoredProcedure [dbo].[spGetWarehouseProduct_paging]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[spGetWarehouseProduct_paging] --501,0,0,1991,'2010-08-01 00:11:37.933','2021-08-01 00:11:37.933',''

@ProductBrand_ID int,
@Warehouse_ID int,
@ProductPackage_ID int,
@Product_ID int ,
@FromDate datetime,
@ToDate datetime,
@orderby nvarchar(4000) = ''

AS
declare @sql nvarchar(4000)
set @sql = ' PP.ProductPackageStatus_ID in (1,2,3)'
declare @sqlSub nvarchar(4000)
set @sqlSub = ''

if(@ProductPackage_ID>0)
	set @sql+=' And T.ProductPackage_ID = '+ CONVERT(varchar(50), @ProductPackage_ID)
	
if(@ProductBrand_ID>0)
	set @sql +=  ' And T.ProductBrand_ID = '+ CONVERT(varchar(50), @ProductBrand_ID)
if(@Warehouse_ID>0)
	set @sql +=  ' And T.Warehouse_ID = '+ CONVERT(varchar(50), @Warehouse_ID)
if(@Product_ID>0)
	set @sql +=  ' And T.Product_ID = '+ CONVERT(varchar(50), @Product_ID)	
set @sql +=  ' And Convert(date,T.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''				
IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

	execute('

select distinct PP.Name as TenLo ,(Select Name from Product where Product_ID = PP.Product_ID) as ProductName ,(Select ExpectedProductivityDescription from Product where Product_ID = PP.Product_ID) as ProductUnit,  (select ISNULL( SUM(HarvestVolume),0) from Task where TaskType_ID =3 and TaskStatus_ID =3 and ProductPackage_ID=PP.ProductPackage_ID) as TongThuHoach
,(select ISNULL( SUM(Quantity),0) from Task where TaskType_ID =6  and ProductPackage_ID=PP.ProductPackage_ID  ) as TongBanHang,
((select ISNULL( SUM(HarvestVolume),0) from Task where TaskType_ID =3 and TaskStatus_ID =3  and ProductPackage_ID=PP.ProductPackage_ID) - (select ISNULL( SUM(Quantity),0) from Task where TaskType_ID =6  and ProductPackage_ID=PP.ProductPackage_ID )) as TonKho 
from Task T 
left join ProductPackage PP on T.ProductPackage_ID = PP.ProductPackage_ID
where   
' + @sql
)
GO
/****** Object:  StoredProcedure [dbo].[spGetWarehouseProduct_pagingV2]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[spGetWarehouseProduct_pagingV2] --501,0,0,1991,'2010-08-01 00:11:37.933','2021-08-01 00:11:37.933',''

@ProductBrand_ID int,
@Warehouse_ID int,
@ProductPackage_ID int,
@Product_ID int ,
@FromDate datetime,
@ToDate datetime,
@orderby nvarchar(4000) = ''

AS
declare @sql nvarchar(4000)
set @sql = ' WI.Active = 1 and WI.WarehouseImportType_ID = 2'
declare @sqlSub nvarchar(4000)
set @sqlSub = ''


if(@ProductBrand_ID>0)
	set @sql +=  ' And WI.ProductBrand_ID = '+ CONVERT(varchar(50), @ProductBrand_ID)
if(@Warehouse_ID>0)
	set @sql +=  ' And WI.Warehouse_ID = '+ CONVERT(varchar(50), @Warehouse_ID)
if(@Product_ID>0)
	set @sql +=  ' And WI.Product_ID = '+ CONVERT(varchar(50), @Product_ID)	
set @sql +=  ' And Convert(date,WI.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''				
IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

	execute('

Select distinct WI.Code,(Select Name from Product where Product_ID = WI.Product_ID) as ProductName, W.Name as WarehouseName,
(select ISNULL( SUM(Amount),0) from WarehouseImportProductPackage where WarehouseImport_ID = WI.WarehouseImport_ID  ) as TongNhap,  (select ISNULL( SUM(Amount),0) from WarehouseExportMaterial where WarehouseImport_ID = WI.WarehouseImport_ID  ) as TongXuat, ((select ISNULL( SUM(Amount),0) from WarehouseImportProductPackage where WarehouseImport_ID = WI.WarehouseImport_ID  )- (select ISNULL( SUM(Amount),0) from WarehouseExportMaterial where WarehouseImport_ID = WI.WarehouseImport_ID  )) as TonKho,
(Select ExpectedProductivityDescription from Product where Product_ID = WI.Product_ID) as ProductUnit 
from WarehouseImport WI 
left join Warehouse  W on W.Warehouse_ID = WI.Warehouse_ID   where 
' + @sql
)


GO
/****** Object:  StoredProcedure [dbo].[spGetWarehouseProductExport]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<NGUYEN MINH CHAU>
-- Create date: <11/09/2020>
-- Description:	<Phan trang farm>
-- =============================================

CREATE PROCEDURE [dbo].[spGetWarehouseProductExport]  --1, 1000,7,508,2,0,'2010-08-01 00:11:37.933','2021-08-01 00:11:37.933',''


@currPage int,
@recodperpage int,
@Pagesize int,
@ProductBrand_ID int,
@ProductPackageOrder_ID int,
@Product_ID int,
--@Warehouse_ID int,
--@ProductPackage_ID int,
--@Material_ID int ,
@Name nvarchar(400)= N'',
@Zone_ID int,
@Area_ID int,
@Warehouse_ID int,
@ProductPackage_ID int,
@FromDate datetime,
@ToDate datetime,
@orderby nvarchar(4000) = '',
@UserId nvarchar(100)


AS
 declare @sql nvarchar(4000)
set @sql = ''
if(@ProductBrand_ID>0)
	set @sql +=  ' And WE.ProductBrand_ID = '+ CONVERT(varchar(50), @ProductBrand_ID)
if(@ProductPackageOrder_ID>0)
	set @sql +=  ' And WE.ProductPackageOrder_ID = '+ CONVERT(varchar(50), @ProductPackageOrder_ID)	
if(@Name<>'')
	set @sql +=  ' And WE.Name like N''%'+@Name+'%'''
IF(@Zone_ID>0)
	set @sql += ' And W.Zone_ID = '+ CONVERT(VARCHAR(50), @Zone_ID)
IF(@Area_ID>0)
	set @sql += ' And W.Area_ID = '+ CONVERT(VARCHAR(50), @Area_ID)
IF(@Warehouse_ID>0)
	set @sql += ' And W.Warehouse_ID = '+ CONVERT(VARCHAR(50), @Warehouse_ID)
if(@ProductPackage_ID > 0)
	set @sql += ' and WE.WarehouseExport_ID in (Select WarehouseExport_ID from WarehouseExportMaterial WHERE WarehouseImport_ID in ( Select WarehouseImport_ID from WarehouseImportProductPackage where ProductPackage_ID = ''' + CONVERT(VARCHAR(50), @ProductPackage_ID) + '''))'
if(@UserId<>'')
	set @sql +=  ' And WE.CreateBy ='''+@UserId+''''
if(@Product_ID>0)
  set @sql += ' And WE.WarehouseExport_ID in (Select WarehouseExport_ID from WarehouseExportMaterial WHERE Product_ID = ''' + + CONVERT(VARCHAR(50), @Product_ID)  + ''') '
--if(@Warehouse_ID>0)
--	set @sql +=  ' And WE.Warehouse_ID = '+ CONVERT(varchar(50), @Warehouse_ID)
--if(@ProductPackage_ID>0)
--	set @sql +=  ' And WE.ProductPackage_ID = '+ CONVERT(varchar(50), @ProductPackage_ID)	
--if(@Material_ID>0)
--	set @sql +=  ' And WE.Material_ID = '+ CONVERT(varchar(50), @Material_ID)
set @sql +=  ' And Convert(date,WE.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''			
IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

declare @strSql2 nvarchar(4000)
	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
		BEGIN
			EXEC spProduct_pagination @Tolal, ' + Cast(@currPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
		END ELSE
			SELECT '''' AS PhanTrang '
	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY WE.CreateDate DESC) AS RowNum, WE.WarehouseExport_ID,WE.Name,WE.Amount,WE.Exporter,WE.Importer,WE.CreateDate, PO.Name as TenLenh,WE.Comment,C.Name as CustomerName
		   from WarehouseExport WE
		   left join ProductPackageOrder PO on PO.ProductPackageOrder_ID= WE.ProductPackageOrder_ID
		   left join POManage PM on PM.PO_ID = WE.CodePO
		   left join Customer C on C.Customer_ID = PM.Customer_ID
			 left join Warehouse W on W.Warehouse_ID = WE.Warehouse_ID
		   where  WE.Active = 1 and W.Type= 2
	
' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby + '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*)   from WarehouseExport WE
		   left join ProductPackageOrder PO on PO.ProductPackageOrder_ID= WE.ProductPackageOrder_ID
		   left join POManage PM on PM.PO_ID = WE.CodePO
		   left join Customer C on C.Customer_ID = PM.Customer_ID
			 left join Warehouse W on W.Warehouse_ID = WE.Warehouse_ID
		   where  WE.Active = 1 and W.Type= 2
		   
' + @sql + @strSql2

+' 	SELECT Count(*) as TotalRecord   from WarehouseExport WE
		   left join ProductPackageOrder PO on PO.ProductPackageOrder_ID= WE.ProductPackageOrder_ID
		   left join POManage PM on PM.PO_ID = WE.CodePO
		   left join Customer C on C.Customer_ID = PM.Customer_ID
			 left join Warehouse W on W.Warehouse_ID = WE.Warehouse_ID
		   where  WE.Active = 1 and W.Type= 2

' + @sql 
)
GO
/****** Object:  StoredProcedure [dbo].[spGetWarehouseProductExportv2]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<NGUYEN MINH CHAU>
-- Create date: <11/09/2020>
-- Description:	<Phan trang farm>
-- =============================================

CREATE PROCEDURE [dbo].[spGetWarehouseProductExportv2]  --1, 1000,7,508,2,0,'2010-08-01 00:11:37.933','2021-08-01 00:11:37.933',''


@currPage int,
@recodperpage int,
@Pagesize int,
@ProductBrand_ID int,
@ProductPackageOrder_ID int,
@Product_ID int,
@Why int,
@WhyPO int,
@WhyProductPackage int,
@WhyCustomer int,
--@Warehouse_ID int,
--@ProductPackage_ID int,
--@Material_ID int ,
@Name nvarchar(400)= N'',
@Zone_ID int,
@Area_ID int,
@Warehouse_ID int,
@ProductPackage_ID int,
@FromDate datetime,
@ToDate datetime,
@orderby nvarchar(4000) = '',
@UserId nvarchar(100)


AS
 declare @sql nvarchar(4000)
set @sql = ''
if(@ProductBrand_ID>0)
	set @sql +=  ' And WE.ProductBrand_ID = '+ CONVERT(varchar(50), @ProductBrand_ID)
if(@ProductPackageOrder_ID>0)
	set @sql +=  ' And WE.ProductPackageOrder_ID = '+ CONVERT(varchar(50), @ProductPackageOrder_ID)	
if(@Name<>'')
	set @sql +=  ' And WE.Name like N''%'+@Name+'%'''
IF(@Zone_ID>0)
	set @sql += ' And W.Zone_ID = '+ CONVERT(VARCHAR(50), @Zone_ID)
IF(@Area_ID>0)
	set @sql += ' And W.Area_ID = '+ CONVERT(VARCHAR(50), @Area_ID)
if(@Why>0)
	set @sql +=  ' And WE.Why = '+ CONVERT(varchar(50), @Why)
if(@WhyPO>0)
	set @sql +=  ' And WE.WhyPO = '+ CONVERT(varchar(50), @WhyPO)
if(@WhyProductPackage>0)
	set @sql +=  ' And WE.WhyProductPackage = '+ CONVERT(varchar(50), @WhyProductPackage)
if(@WhyCustomer>0)
	set @sql +=  ' And WE.WhyCustomer = '+ CONVERT(varchar(50), @WhyCustomer)
IF(@Warehouse_ID>0)
	set @sql += ' And W.Warehouse_ID = '+ CONVERT(VARCHAR(50), @Warehouse_ID)
if(@ProductPackage_ID > 0)
	set @sql += ' and WE.WarehouseExport_ID in (Select WarehouseExport_ID from WarehouseExportMaterial WHERE WarehouseImport_ID in ( Select WarehouseImport_ID from WarehouseImportProductPackage where ProductPackage_ID = ''' + CONVERT(VARCHAR(50), @ProductPackage_ID) + '''))'
if(@UserId<>'')
	set @sql +=  ' And WE.CreateBy ='''+@UserId+''''
if(@Product_ID>0)
  set @sql += ' And WE.WarehouseExport_ID in (Select WarehouseExport_ID from WarehouseExportMaterial WHERE Product_ID = ''' + + CONVERT(VARCHAR(50), @Product_ID)  + ''') '
--if(@Warehouse_ID>0)
--	set @sql +=  ' And WE.Warehouse_ID = '+ CONVERT(varchar(50), @Warehouse_ID)
--if(@ProductPackage_ID>0)
--	set @sql +=  ' And WE.ProductPackage_ID = '+ CONVERT(varchar(50), @ProductPackage_ID)	
--if(@Material_ID>0)
--	set @sql +=  ' And WE.Material_ID = '+ CONVERT(varchar(50), @Material_ID)
set @sql +=  ' And Convert(date,WE.CreateDate) between ''' + CONVERT(varchar(50), Convert(date,@FromDate)) + ''' And ''' + CONVERT(varchar(50), Convert(date,@ToDate)) + ''''			
IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

declare @strSql2 nvarchar(4000)
	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
		BEGIN
			EXEC spProduct_pagination @Tolal, ' + Cast(@currPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
		END ELSE
			SELECT '''' AS PhanTrang '
	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY WE.CreateDate DESC) AS RowNum, WE.WarehouseExport_ID,WE.Name,WE.Amount,WE.Exporter,WE.Importer,WE.CreateDate,WE.WhyCustomer, PO.Name as TenLenh,WE.Comment,C.Name as CustomerName
		   from WarehouseExport WE
		   left join ProductPackageOrder PO on PO.ProductPackageOrder_ID= WE.ProductPackageOrder_ID
		   left join POManage PM on PM.PO_ID = WE.CodePO
		   left join Customer C on C.Customer_ID = PM.Customer_ID
			 left join Warehouse W on W.Warehouse_ID = WE.Warehouse_ID
		   where  WE.Active = 1 and W.Type= 2
	
' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby + '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*)   from WarehouseExport WE
		   left join ProductPackageOrder PO on PO.ProductPackageOrder_ID= WE.ProductPackageOrder_ID
		   left join POManage PM on PM.PO_ID = WE.CodePO
		   left join Customer C on C.Customer_ID = PM.Customer_ID
			 left join Warehouse W on W.Warehouse_ID = WE.Warehouse_ID
		   where  WE.Active = 1 and W.Type= 2
		   
' + @sql + @strSql2

+' 	SELECT Count(*) as TotalRecord   from WarehouseExport WE
		   left join ProductPackageOrder PO on PO.ProductPackageOrder_ID= WE.ProductPackageOrder_ID
		   left join POManage PM on PM.PO_ID = WE.CodePO
		   left join Customer C on C.Customer_ID = PM.Customer_ID
			 left join Warehouse W on W.Warehouse_ID = WE.Warehouse_ID
		   where  WE.Active = 1 and W.Type= 2

' + @sql 
)
GO
/****** Object:  StoredProcedure [dbo].[spGetWorkshop_paging]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<NGUYEN MINH CHAU>
-- Create date: <11/09/2020>
-- Description:	<Phan trang farm>
-- =============================================
CREATE PROCEDURE [dbo].[spGetWorkshop_paging]  --1, 1000,7,0,'',''


@currPage int,
@recodperpage int,
@Pagesize int,
@ProductBrand_ID int,
@Name nvarchar(400)= N'',
@orderby nvarchar(4000) = ''


AS
 declare @sql nvarchar(4000)
set @sql = ''
if(@ProductBrand_ID>0)
	set @sql +=  ' And W.ProductBrand_ID = '+ CONVERT(varchar(50), @ProductBrand_ID)
if(@Name<>'')
	set @sql +=  ' And W.Name like N''%'+@Name+'%'''
IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

declare @strSql2 nvarchar(4000)
	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
		BEGIN
			EXEC spProduct_pagination @Tolal, ' + Cast(@currPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
		END ELSE
			SELECT '''' AS PhanTrang '
	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY W.Name ASC) AS RowNum,W.Workshop_ID,W.Name, PB.Name as ProductBrandName
		   from Workshop W
		   left join ProductBrand PB on W.ProductBrand_ID = PB.ProductBrand_ID 
		   where PB.Active = 1
	
' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby + '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from Workshop W
		   left join ProductBrand PB on W.ProductBrand_ID = PB.ProductBrand_ID
		   
' + @sql + @strSql2

+' 	SELECT Count(*) as TotalRecord from Workshop W
		   left join ProductBrand PB on W.ProductBrand_ID = PB.ProductBrand_ID

' + @sql 
)
GO
/****** Object:  StoredProcedure [dbo].[spHistoryProductSold_paging]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spHistoryProductSold_paging]--1,10,10,''
@currentPage int,
@recodperPage int,
@Pagesize int,
@orderby nvarchar(400)= ''
AS
declare @sql nvarchar(4000)
set @sql = ' where Q.WarrantyStartDate is not null and Pro.Name is not null '

set @orderby=' order by Q.WarrantyStartDate  desc '
declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currentPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currentPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''


execute('
	DECLARE @Total int
	
		WITH tbl_temp AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER('+@orderby+') AS RowNum,Pro.Name as ProName,P.Name as TenDN,(CONVERT(VARCHAR(10), Q.WarrantyStartDate, 103) + '' | '' + convert(VARCHAR(8), Q.WarrantyStartDate, 14)) as Date from QRCodeSecret Q 
  left join ProductBrand P on Q.ProductBrand_ID=P.ProductBrand_ID
  left join Product Pro on Pro.Product_ID=Q.Product_ID '+@sql+'
		) 
		Select distinct * From tbl_temp '+@strSql1+'
		'
+' 	SELECT Count(*) as TotalRecord  from QRCodeSecret Q 
  left join ProductBrand P on Q.ProductBrand_ID=P.ProductBrand_ID
  left join Product Pro on Pro.Product_ID=Q.Product_ID  ' + @sql )














		 
GO
/****** Object:  StoredProcedure [dbo].[spProduct_pagging]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spProduct_pagging]-- 1,1000,1000,' and P.Product_ID in (Select Product_ID from ProductInfo where OCOP = 5)',''
	@currentPage int,
	@recodperpage int,
	@PageSize int,
	@Where nvarchar(400) = N'',
	@orderby nvarchar(4000) = ''
AS
declare @sql nvarchar(4000)
set @sql = 'Where P.Active = 1 '
IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby
if(@Where<>'')
	set @sql +=  @Where
declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currentPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currentPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''
execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY P.Product_ID DESC) AS RowNum, P.Product_ID,P.Name,P.Image,P.CreateDate, P.Active,PI.Price,P.ProductBrand_ID from Product P
		   left join ProductInfo PI on P.Product_ID = PI.Product_ID
		   ' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby+ '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from Product  P
		   left join ProductInfo PI on P.Product_ID = PI.Product_ID
' + @sql

+' 	SELECT Count(*) as TotalRecord from Product P
		   left join ProductInfo PI on P.Product_ID = PI.Product_ID
' + @sql 

+'
	SELECT Count(*) as TotalRecord1 from ProductBrand
'
)
GO
/****** Object:  StoredProcedure [dbo].[spProduct_pagination]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spProduct_pagination]
@Total int,
@currPage int ,
@PageSize int,
@rowperpage int
--,
--@Sales decimal(18,0),
--@Trangthai int,
--@Tungay datetime,
--@Denngay datetime,
--@where nvarchar(4000) = '' 
AS
BEGIN
DECLARE  @PageNumber int SET @PageNumber=1
DECLARE @i int
SET @i=1
DECLARE @TotalPage int
IF @Total%@rowperpage>0
SET @TotalPage=(@Total/@rowperpage)+1
ELSE
SET @TotalPage=@Total/@rowperpage 
DECLARE @Start int SET @Start=0
DECLARE @SQL nvarchar(4000)
SET @SQL=''
IF @currPage<=@TotalPage
	BEGIN
	 -- Xử lý trường hợp @currPage=1
	 IF @currPage=1
	 BEGIN
	  --SET @SQL=@SQL+ N'Trang '
	  SET @SQL=@SQL+ N''
	  SET @PageNumber=@PageSize
	  IF @PageNumber>@TotalPage SET @PageNumber=@TotalPage
	  SET @Start=1
	 END
	 ELSE
	 BEGIN
	  SET @SQL=@SQL+ N' <li class="page-item"><a href="Product_List?Page=1" class="page-link">Trang đầu</a></li>'
	  SET @SQL=@SQL+ ' <li class="page-item"><a class="page-link" href="Product_List?Page='+ Cast((@currPage-1) AS nvarchar(4))+N'"><</a></li>'
	  -- Xử lý trường hợp (@TotalPage-@currPage)<@PageSize/2 //?page='+ Cast((@currPage-1) AS nvarchar(4))+N'
	  IF(@TotalPage-@currPage)<@PageSize/2
		 BEGIN
		 SET @Start=(@TotalPage-@PageSize)+1
		 IF @Start<=0 SET @Start=1 
		 SET @PageNumber = @TotalPage
		 END
	  ELSE
	  BEGIN
	   IF (@currPage-(@PageSize/2))=0
	   BEGIN
		SET @Start=1
		SET @PageNumber=@currPage+(@PageSize/2)+1
		IF @TotalPage<@PageNumber
		 SET @PageNumber=@TotalPage
	   END
	   ELSE
		  BEGIN
		  SET @Start=@currPage-(@PageSize/2)
		  IF @Start<=0 SET @Start=1 
		  SET @PageNumber=@currPage+(@PageSize/2)
		  IF @TotalPage<@PageNumber
			  SET @PageNumber=@TotalPage
		  ELSE
		  IF @PageNumber <@PageSize 
			  SET @PageNumber=@PageSize
		  END
	  END
	  END 
  
	 SET @i=@Start
	 WHILE @i<=@PageNumber
	 BEGIN
	  IF @i=@currPage
	   SET @SQL=@SQL+'<li class="page-item active"><a class="page-link">
		'+Cast(Cast(@i AS int) AS nvarchar(4))+'</a></li>'
	  ELSE
	   SET @SQL=@SQL+'
		<li class="page-item"><a class="page-link" href="Product_List?Page='+Cast(@i AS nvarchar(4))+'">'
		+Cast(@i AS nvarchar(4))+'</a></li>'
		--?page='+Cast(@i AS nvarchar(4))+'
	  SET @i=@i+1 
	 END
	 IF @currPage<@TotalPage
	 BEGIN
	  SET @SQL=@SQL+ N'
	   <li class="page-item"><a class="page-link" href="Product_List?Page='+Cast((@currPage+1) AS nvarchar(4))+N'">></a></li>'
	   --?page='+Cast((@currPage+1) AS nvarchar(4))+N'
	   SET @SQL=@SQL+ N' 
		<li class="page-item"><a class="page-link" href="Product_List?Page='+cast(@TotalPage AS nvarchar(6))+N'">Trang cuối</a></li>'
		--?page='+cast(@TotalPage AS nvarchar(6))+N'
	 END
	 
	 --Hiện phân trang ở đây
	 
	 SELECT @SQL AS PhanTrang 
	 -- PRINT @SQL
	END
END
GO
/****** Object:  StoredProcedure [dbo].[spProductPackage_pagination]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spProductPackage_pagination]
@Total int,
@currPage int ,
@PageSize int,
@rowperpage int
--,
--@Sales decimal(18,0),
--@Trangthai int,
--@Tungay datetime,
--@Denngay datetime,
--@where nvarchar(4000) = '' 
AS
BEGIN
DECLARE  @PageNumber int SET @PageNumber=1
DECLARE @i int
SET @i=1
DECLARE @TotalPage int
IF @Total%@rowperpage>0
SET @TotalPage=(@Total/@rowperpage)+1
ELSE
SET @TotalPage=@Total/@rowperpage 
DECLARE @Start int SET @Start=0
DECLARE @SQL nvarchar(4000)
SET @SQL=''
IF @currPage<=@TotalPage
	BEGIN
	 -- Xử lý trường hợp @currPage=1
	 IF @currPage=1
	 BEGIN
	  --SET @SQL=@SQL+ N'Trang '
	  SET @SQL=@SQL+ N''
	  SET @PageNumber=@PageSize
	  IF @PageNumber>@TotalPage SET @PageNumber=@TotalPage
	  SET @Start=1
	 END
	 ELSE
	 BEGIN
	  SET @SQL=@SQL+ N' <li class="page-item"><a href="ProductPackage_List?Page=1" class="page-link">Trang đầu</a></li>'
	  SET @SQL=@SQL+ ' <li class="page-item"><a class="page-link" href="ProductPackage_List?Page='+ Cast((@currPage-1) AS nvarchar(4))+N'"><</a></li>'
	  -- Xử lý trường hợp (@TotalPage-@currPage)<@PageSize/2 //?page='+ Cast((@currPage-1) AS nvarchar(4))+N'
	  IF(@TotalPage-@currPage)<@PageSize/2
		 BEGIN
		 SET @Start=(@TotalPage-@PageSize)+1
		 IF @Start<=0 SET @Start=1 
		 SET @PageNumber = @TotalPage
		 END
	  ELSE
	  BEGIN
	   IF (@currPage-(@PageSize/2))=0
	   BEGIN
		SET @Start=1
		SET @PageNumber=@currPage+(@PageSize/2)+1
		IF @TotalPage<@PageNumber
		 SET @PageNumber=@TotalPage
	   END
	   ELSE
		  BEGIN
		  SET @Start=@currPage-(@PageSize/2)
		  IF @Start<=0 SET @Start=1 
		  SET @PageNumber=@currPage+(@PageSize/2)
		  IF @TotalPage<@PageNumber
			  SET @PageNumber=@TotalPage
		  ELSE
		  IF @PageNumber <@PageSize 
			  SET @PageNumber=@PageSize
		  END
	  END
	  END 
  
	 SET @i=@Start
	 WHILE @i<=@PageNumber
	 BEGIN
	  IF @i=@currPage
	   SET @SQL=@SQL+'<li class="page-item active"><a class="page-link">
		'+Cast(Cast(@i AS int) AS nvarchar(4))+'</a></li>'
	  ELSE
	   SET @SQL=@SQL+'
		<li class="page-item"><a class="page-link" href="ProductPackage_List?Page='+Cast(@i AS nvarchar(4))+'">'
		+Cast(@i AS nvarchar(4))+'</a></li>'
		--?page='+Cast(@i AS nvarchar(4))+'
	  SET @i=@i+1 
	 END
	 IF @currPage<@TotalPage
	 BEGIN
	  SET @SQL=@SQL+ N'
	   <li class="page-item"><a class="page-link" href="ProductPackage_List?Page='+Cast((@currPage+1) AS nvarchar(4))+N'">></a></li>'
	   --?page='+Cast((@currPage+1) AS nvarchar(4))+N'
	   SET @SQL=@SQL+ N' 
		<li class="page-item"><a class="page-link" href="ProductPackage_List?Page='+cast(@TotalPage AS nvarchar(6))+N'">Trang cuối</a></li>'
		--?page='+cast(@TotalPage AS nvarchar(6))+N'
	 END
	 
	 --Hiện phân trang ở đây
	 
	 SELECT @SQL AS PhanTrang 
	 -- PRINT @SQL
	END
END
GO
/****** Object:  StoredProcedure [dbo].[spSearch_GetNews_paging]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[spSearch_GetNews_paging] --1,10,10,'','2000-01-01','9999-01-01','',''
@currentPage int,
@recodperpage int,
@PageSize int,
@Title nvarchar(400) = N'',
@Where nvarchar(400) = N'',
@orderby nvarchar(4000) = ''
AS

declare @sql nvarchar(4000)

set @sql = ' Where Active=1 '

if(@Title<>'')
		set @sql +=  ' And (Title like N''%'+@Title+'%'')'
if(@Where<>'')
	set @sql +=  @Where
--set @sql += 'and Convert(date, CreateDate) between ''' + CONVERT(varchar(50),CONVERT(date,@StartDate)) + ''' and ''' + CONVERT(varchar(50),CONVERT(date,@EndDate))+''''

IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby

declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currentPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currentPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''

--declare @strSql2 nvarchar(4000)
--	SET @strSql2 = ' if(@Tolal > ' + Cast(@Pagesize AS nvarchar(4)) + ' and ' + Cast(@recodperpage AS nvarchar(4)) + ' < @Tolal)
--		BEGIN
--			EXEC spGetNews_paging2 @Tolal, ' + Cast(@currentPage AS nvarchar(4)) + ',' + Cast(@Pagesize AS nvarchar(4)) + ',' + Cast(@recodperpage AS nvarchar(4)) + '
--		END ELSE
--			SELECT '''' AS PhanTrang '

	execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY News_ID DESC) AS RowNum,News_ID, NewsCategory_ID, Title,Summary,Image,CreateDate, Active, Author,Location_ID from BNN_News ' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby+ '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from BNN_News
' + @sql --+ @strSql2

+' 	SELECT Count(*) as TotalRecord from BNN_News
' + @sql 
)
GO
/****** Object:  StoredProcedure [dbo].[spSearchProduct_pagging]    Script Date: 6/5/2022 5:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spSearchProduct_pagging] --1,1000,1000,'Juni','',''
	@currentPage int,
	@recodperpage int,
	@PageSize int,
	@Keyword nvarchar(400)=N'',
	@Where nvarchar(400) = N'',
	@orderby nvarchar(4000) = ''
AS
declare @sql nvarchar(4000)
set @sql = 'Where Active = 1'
if(@Keyword<>'')
	set @sql +=  ' And (Name like N''%'+@Keyword+'%'')'
IF @orderby <> '' 
	SET @orderby = ' ORDER BY ' + @orderby
if(@Where<>'')
	set @sql +=  @Where
declare @strSql1 nvarchar(4000)

	SET @strSql1 = ' Where RowNum Between 
		(' + Cast((@currentPage-1) AS nvarchar(4)) + ')*' + Cast((@recodperpage) AS nvarchar(4)) + '+' + Cast((1) AS nvarchar(4)) + ' 
		AND ' + Cast(@currentPage AS nvarchar(4)) + '*' + Cast(@recodperpage AS nvarchar(4)) + ''
execute('
	DECLARE @Tolal int
	
		WITH s AS
		(
		   SELECT DISTINCT ROW_NUMBER() 
		   OVER(ORDER BY Product_ID DESC) AS RowNum,Product_ID,Name,Image,CreateDate, Active,Price,ProductBrand_ID,PriceOld from Product ' + @sql+'
		) 
		Select distinct * From s ' + @strSql1 + @orderby+ '
	
	 -- Tính tổng số bản ghi
		SELECT @Tolal=Count(*) from Product
' + @sql

+' 	SELECT Count(*) as TotalRecord from Product
' + @sql 
)
