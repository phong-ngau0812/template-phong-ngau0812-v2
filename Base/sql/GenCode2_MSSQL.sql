
---	CuongLM Create 2008.11.14

----------------------------------------------------------
-- All rights reserved.
----------------------------------------------------------

USE [GenCode2]
GO

----------------------------------------------------------
-- Stored procedures for the 'User' table.
----------------------------------------------------------

-- Drop the 'User_GetAll' procedure if it already exists.
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'User_GetAll') AND type='P')
	DROP PROCEDURE [User_GetAll]
GO

-- Gets all records from the 'User' table.
CREATE PROCEDURE [User_GetAll]
AS
	SELECT [User_ID], [UserName], [Password], [FullName], [Avatar], [Address], [Email], [Phone], [Position], [CreateDate], [ModifyDate], [CreateBy], [ModifyBy], [Status], [Sort], [BirthDay], [Gender]
	FROM [dbo].[User]
GO

-- Drop the 'User_GetPageAdHoc' procedure if it already exists.
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'User_GetPageAdHoc') AND type='P')
	DROP PROCEDURE [User_GetPageAdHoc]
GO

-- Gets a page of records from the 'User' table, filtered by an ad-hoc where clause and ordered by an ad-hoc order by.	
-- Works by selecting the rows into a temp table with an identity column and then selecting the 
-- appropriate rows using the assigned identity values as row numbers.
-- Not the world's most efficient stored proc but very flexible and more efficient than pulling the entire table over the network
-- to the web server
-- @where : any valid where clause for the table (i.e. 'lastname like ''sm%''')
-- @orderby : any valid order by clause for the table (i.e. 'lastname Asc, firstname Asc')
-- @startIndex : the index of the first row desired, 1-based.  A value of 1 gives the first n rows (where n is defined by length).
-- @length : the number of rows per page (the number of rows to return).  
-- @rows : an output parameter that tells how many total rows were in the filtered resultset.  Useful to determining total number of pages.
CREATE PROCEDURE [User_GetPageAdHoc]
	@where nvarchar(4000) = '',
	@orderby nvarchar(255) = '',
	@startIndex int,
	@length int,
	@rows int output
AS

	IF @where <> ''
		SET @where = ' WHERE ' + @where 

	IF @orderby <> '' 
		SET @orderby = ' ORDER BY ' + @orderby

	IF @startIndex > 1
	BEGIN /* not starting from top so need to insert into a temp table to offset properly */		
		DECLARE @Start int, @End int

		BEGIN TRANSACTION GetDataSet

		SET @Start = @startIndex

		SET @End = (@Start + @length - 1)
		IF @@ERROR <> 0
		GOTO ErrorHandler
	
		CREATE TABLE #TemporaryTable
		(
			Row int IDENTITY(1,1) PRIMARY KEY,
						[User_ID] Int		,
					[UserName] nvarchar(200)		,
					[Password] nvarchar(200)		,
					[FullName] nvarchar(500)		,
					[Avatar] nvarchar(500)		,
					[Address] nvarchar(500)		,
					[Email] nvarchar(50)		,
					[Phone] nvarchar(50)		,
					[Position] nvarchar(500)		,
					[CreateDate] datetime		,
					[ModifyDate] datetime		,
					[CreateBy] Int		,
					[ModifyBy] Int		,
					[Status] Int		,
					[Sort] Int		,
					[BirthDay] datetime		,
					[Gender] Int		
		)
		IF @@ERROR <> 0
			GOTO ErrorHandler

		/* Special case if getting the first row.
		   This performance optimization uses the TOP operator to limit the number of rows we add to the temp table.
		   It assumes that users often page through the grid without filtering.
		   There's no point in adding all the rows to the temp table if we're only getting the, say 20th to 30th of 10,000.
		   We can just add the first 30 and grab from that. */
		DECLARE @total varchar(10)
		SET @total = convert(varchar, @startIndex + @length)
		EXECUTE('INSERT INTO #TemporaryTable
			SELECT TOP ' + @total + ' [User_ID], [UserName], [Password], [FullName], [Avatar], [Address], [Email], [Phone], [Position], [CreateDate], [ModifyDate], [CreateBy], [ModifyBy], [Status], [Sort], [BirthDay], [Gender]
		FROM [dbo].[User]' +	
		@where +
		@orderby)
		
		CREATE TABLE #TempRows(rows int)
		
		EXECUTE('INSERT INTO #TempRows
			SELECT  count(*) FROM [dbo].[User]' + @where)

		SELECT @rows = rows FROM #TempRows

		DROP TABLE #TempRows	

		IF @@ERROR <> 0
			GOTO ErrorHandler

		SELECT 	[User_ID], [UserName], [Password], [FullName], [Avatar], [Address], [Email], [Phone], [Position], [CreateDate], [ModifyDate], [CreateBy], [ModifyBy], [Status], [Sort], [BirthDay], [Gender] 
		FROM #TemporaryTable
		WHERE (Row >= @Start) AND (Row <= @End)	

		IF @@ERROR <> 0
			GOTO ErrorHandler


		DROP TABLE #TemporaryTable

		COMMIT TRANSACTION GetDataSet
	END /* startindex > 1  */
	ELSE
	BEGIN
		IF @where <> '' 
		BEGIN
			/* Special case if getting the first row with a filter.
			   This performance optimization uses the TOP operator but must use a temp table hack to get the row count */		
			EXECUTE('SELECT TOP ' + @length + ' [User_ID], [UserName], [Password], [FullName], [Avatar], [Address], [Email], [Phone], [Position], [CreateDate], [ModifyDate], [CreateBy], [ModifyBy], [Status], [Sort], [BirthDay], [Gender]
				FROM [dbo].[User]' +	
				@where +
				@orderby)

			CREATE TABLE #TempRows2(rows int)

			EXECUTE('INSERT INTO #TempRows2
				SELECT  count(*) FROM [dbo].[User]' + @where)

			SELECT @rows = rows FROM #TempRows2

			DROP TABLE #TempRows2
		END /* @where not blank */
		ELSE
		BEGIN
			/* Special case if no where clause and getting from the first row. 
			   This performance optimization is useful because the default view in the datagrid is to show the rows unfiltered 
			   starting at the first row.  In this case there's no point in using a temp table at all since the TOP operator will do the
			    trick all by itself */
			execute('SELECT TOP ' + @length + ' [User_ID], [UserName], [Password], [FullName], [Avatar], [Address], [Email], [Phone], [Position], [CreateDate], [ModifyDate], [CreateBy], [ModifyBy], [Status], [Sort], [BirthDay], [Gender]
				FROM [dbo].[User]' +	
				@orderby)
			SELECT @rows = count(*) FROM [dbo].[User]
		END /* @where blank */
	END /* starting from top  */


	RETURN 0

	ErrorHandler:
	ROLLBACK TRANSACTION GetDataSet
	RETURN @@ERROR
GO


-- Drop the 'User_GetAdHoc' procedure if it already exists.
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'User_GetAdHoc') AND type='P')
	DROP PROCEDURE [User_GetAdHoc]
GO

-- Gets records from the 'User' table, filtered by an ad-hoc where clause and ordered by an ad-hoc order by.	
-- @where : any valid where clause for the table (i.e. 'lastname like ''sm%''')
-- @orderby : any valid order by clause for the table (i.e. 'lastname Asc, firstname Asc')
CREATE PROCEDURE [User_GetAdHoc]
	@where nvarchar(4000) = '',
	@orderby nvarchar(255) = ''
AS
	IF @where <> '' 
		SET @where = ' WHERE ' + @where 

	IF @orderby <> '' 
		SET @orderby = ' ORDER BY ' + @orderby

	execute('SELECT [User_ID], [UserName], [Password], [FullName], [Avatar], [Address], [Email], [Phone], [Position], [CreateDate], [ModifyDate], [CreateBy], [ModifyBy], [Status], [Sort], [BirthDay], [Gender]
		FROM [dbo].[User]' +	
		@where +
		@orderby)
GO

-- Drop the 'User_GetByPrimaryKey' procedure if it already exists.
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'User_GetByPrimaryKey') AND type='P')
	DROP PROCEDURE [User_GetByPrimaryKey]
GO

-- Gets a record from the 'User' table using the primary key value.
CREATE PROCEDURE [User_GetByPrimaryKey]
	@User_ID Int
AS
	SELECT [User_ID], [UserName], [Password], [FullName], [Avatar], [Address], [Email], [Phone], [Position], [CreateDate], [ModifyDate], [CreateBy], [ModifyBy], [Status], [Sort], [BirthDay], [Gender] 
	FROM [dbo].[User] WHERE
		[User_ID] = @User_ID
GO

-- Drop the 'User_Insert' procedure if it already exists.
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'User_Insert') AND type='P')
	DROP PROCEDURE [User_Insert]
GO

-- Inserts a new record into the 'User' table.
CREATE PROCEDURE [User_Insert]
	@UserName nvarchar(200),
	@Password nvarchar(200),
	@FullName nvarchar(500),
	@Avatar nvarchar(500),
	@Address nvarchar(500),
	@Email nvarchar(50),
	@Phone nvarchar(50),
	@Position nvarchar(500),
	@CreateDate datetime,
	@ModifyDate datetime,
	@CreateBy Int,
	@ModifyBy Int,
	@Status Int,
	@Sort Int,
	@BirthDay datetime,
	@Gender Int
AS
	INSERT INTO [dbo].[User]
	(
		[UserName],
		[Password],
		[FullName],
		[Avatar],
		[Address],
		[Email],
		[Phone],
		[Position],
		[CreateDate],
		[ModifyDate],
		[CreateBy],
		[ModifyBy],
		[Status],
		[Sort],
		[BirthDay],
		[Gender]
	)
	VALUES
	(
		@UserName,
		@Password,
		@FullName,
		@Avatar,
		@Address,
		@Email,
		@Phone,
		@Position,
		@CreateDate,
		@ModifyDate,
		@CreateBy,
		@ModifyBy,
		@Status,
		@Sort,
		@BirthDay,
		@Gender
	)
	SELECT @@IDENTITY
GO

-- Drop the 'User_Update' procedure if it already exists.
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'User_Update') AND type='P')
	DROP PROCEDURE [User_Update]
GO

-- Updates a record in the 'User' table.
CREATE PROCEDURE [User_Update]
	-- The rest of writeable parameters
	@UserName nvarchar(200),
	@Password nvarchar(200),
	@FullName nvarchar(500),
	@Avatar nvarchar(500),
	@Address nvarchar(500),
	@Email nvarchar(50),
	@Phone nvarchar(50),
	@Position nvarchar(500),
	@CreateDate datetime,
	@ModifyDate datetime,
	@CreateBy Int,
	@ModifyBy Int,
	@Status Int,
	@Sort Int,
	@BirthDay datetime,
	@Gender Int,
	-- Primary key parameters
	@User_ID Int
AS
	UPDATE [dbo].[User] SET
		[UserName] = @UserName,
		[Password] = @Password,
		[FullName] = @FullName,
		[Avatar] = @Avatar,
		[Address] = @Address,
		[Email] = @Email,
		[Phone] = @Phone,
		[Position] = @Position,
		[CreateDate] = @CreateDate,
		[ModifyDate] = @ModifyDate,
		[CreateBy] = @CreateBy,
		[ModifyBy] = @ModifyBy,
		[Status] = @Status,
		[Sort] = @Sort,
		[BirthDay] = @BirthDay,
		[Gender] = @Gender
	WHERE
		[User_ID] = @User_ID
GO
-- Drop the 'User_Save' procedure if it already exists.
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'User_Save') AND type='P')
	DROP PROCEDURE [User_Save]
GO

-- Insert or updates a new record in the 'User' table.
CREATE PROCEDURE [User_Save]
	-- The rest of writeable parameters
	@UserName nvarchar(200),
	@Password nvarchar(200),
	@FullName nvarchar(500),
	@Avatar nvarchar(500),
	@Address nvarchar(500),
	@Email nvarchar(50),
	@Phone nvarchar(50),
	@Position nvarchar(500),
	@CreateDate datetime,
	@ModifyDate datetime,
	@CreateBy Int,
	@ModifyBy Int,
	@Status Int,
	@Sort Int,
	@BirthDay datetime,
	@Gender Int,
	-- Primary key parameters
	@User_ID Int
AS
	declare @rowCount int

	SELECT @rowCount = count(*) FROM [dbo].[User] Where 
	[User_ID] = @User_ID 
	
		
	IF (@rowCount < 1)
	BEGIN
		INSERT INTO [dbo].[User]
		(
			[UserName],
			[Password],
			[FullName],
			[Avatar],
			[Address],
			[Email],
			[Phone],
			[Position],
			[CreateDate],
			[ModifyDate],
			[CreateBy],
			[ModifyBy],
			[Status],
			[Sort],
			[BirthDay],
			[Gender]
		)
		VALUES
		(
			@UserName,
			@Password,
			@FullName,
			@Avatar,
			@Address,
			@Email,
			@Phone,
			@Position,
			@CreateDate,
			@ModifyDate,
			@CreateBy,
			@ModifyBy,
			@Status,
			@Sort,
			@BirthDay,
			@Gender
		)
		SELECT @@IDENTITY
	END
	ELSE
	BEGIN
		UPDATE [dbo].[User] SET
			[UserName] = @UserName,
			[Password] = @Password,
			[FullName] = @FullName,
			[Avatar] = @Avatar,
			[Address] = @Address,
			[Email] = @Email,
			[Phone] = @Phone,
			[Position] = @Position,
			[CreateDate] = @CreateDate,
			[ModifyDate] = @ModifyDate,
			[CreateBy] = @CreateBy,
			[ModifyBy] = @ModifyBy,
			[Status] = @Status,
			[Sort] = @Sort,
			[BirthDay] = @BirthDay,
			[Gender] = @Gender
		WHERE
			[User_ID] = @User_ID
		SELECT @User_ID
	END
GO

-- Drop the 'User_DeleteByPrimaryKey' procedure if it already exists.
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'User_DeleteByPrimaryKey') AND type='P')
	DROP PROCEDURE [User_DeleteByPrimaryKey]
GO

-- Deletes a record from the 'User' table using the primary key value.
CREATE PROCEDURE [User_DeleteByPrimaryKey]
	@User_ID Int
AS
	DELETE FROM [dbo].[User] WHERE
		[User_ID] = @User_ID
GO

-- Drop the 'User_DeleteAll' procedure if it already exists.
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'User_DeleteAll') AND type='P')
	DROP PROCEDURE [User_DeleteAll]
GO

-- Deletes all records from the 'User' table.
CREATE PROCEDURE [User_DeleteAll]
AS
	DELETE FROM [dbo].[User]
GO

-- Drop the 'User_DeleteAdHoc' procedure if it already exists.
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'User_DeleteAdHoc') AND type='P')
	DROP PROCEDURE [User_DeleteAdHoc]
GO

-- Deletes records from the 'User' table that match the supplied where clause.
CREATE PROCEDURE [User_DeleteAdHoc]
	@where nvarchar(4000) = ''
AS
	IF @where <> '' 
		SET @where = ' WHERE ' + @where 

	execute('DELETE
		FROM [dbo].[User]' +	
		@where)	
GO

