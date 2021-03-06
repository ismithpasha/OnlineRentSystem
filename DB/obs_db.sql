USE [OnlineBookingDb]
GO
/****** Object:  Table [dbo].[Bookings]    Script Date: 1/14/2019 7:36:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Bookings](
	[BookingId] [bigint] NULL,
	[RentId] [bigint] NULL,
	[UserId] [bigint] NULL,
	[RequestTime] [datetime] NULL,
	[BookingStatus] [varchar](20) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Rents]    Script Date: 1/14/2019 7:36:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Rents](
	[RentId] [bigint] NOT NULL,
	[OwnerId] [bigint] NULL,
	[RentTitle] [varchar](200) NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[Fare] [decimal](18, 2) NOT NULL,
	[Description] [varchar](999) NULL,
	[PostedOn] [datetime] NULL,
	[RentStatus] [varchar](50) NULL,
 CONSTRAINT [PK_Rents] PRIMARY KEY CLUSTERED 
(
	[RentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserAddress]    Script Date: 1/14/2019 7:36:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserAddress](
	[AddressId] [bigint] NOT NULL,
	[UserId] [bigint] NOT NULL,
	[AddressTitle] [varchar](100) NOT NULL,
	[StreetAddress] [varchar](100) NOT NULL,
	[City] [varchar](70) NOT NULL,
	[PostCode] [varchar](20) NULL,
	[Country] [varchar](50) NULL,
	[AddressStatus] [varchar](20) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserInfo]    Script Date: 1/14/2019 7:36:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserInfo](
	[UserId] [bigint] NOT NULL,
	[FirstName] [varchar](40) NOT NULL,
	[LastName] [varchar](40) NULL,
	[NickName] [varchar](40) NULL,
	[BirthDate] [date] NULL,
	[Gender] [varchar](10) NULL,
	[Email] [varchar](90) NOT NULL,
	[Password] [varchar](max) NOT NULL,
	[Phone] [varchar](20) NULL,
	[UserType] [varchar](20) NULL,
	[UserStatus] [varchar](20) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[sp_Booking_Confirm_Cancel]    Script Date: 1/14/2019 7:36:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_Booking_Confirm_Cancel]

	@BookingAction bigint,
	@BookingId bigint,
    @RentId bigint,
    @UserId bigint,
    @BookingStatus varchar(20),
	@msg_code VARCHAR(5) OUT,
	@MSG VARCHAR(200) OUT

AS

BEGIN

IF (@BookingAction=0)

     BEGIN 
	UPDATE [dbo].[Bookings]
	   SET [BookingStatus] = @BookingStatus
	 WHERE [BookingId] = @BookingId;

	 UPDATE [dbo].[Rents]
	   SET [RentStatus] = 'confirmed'
	    WHERE [RentId] = @RentId;
		SET @msg_code='Y'
		SET @MSG='Booking Confirmed Successfully'
		
	 END 
ELSE IF (@BookingAction=1)

     BEGIN 
	UPDATE [dbo].[Bookings]
	   SET [BookingStatus] = @BookingStatus
	 WHERE [BookingId] = @BookingId
		SET @msg_code='Y'
		SET @MSG='Booking Successfully Rejected'
		
	 END 
ELSE IF (@BookingAction=2)

     BEGIN 
	UPDATE [dbo].[Bookings]
	   SET [BookingStatus] = 'P'
	 WHERE [RentId] = @RentId;

	  UPDATE [dbo].[Rents]
	   SET [RentStatus] = 'Y'
	    WHERE [RentId] = @RentId;

		SET @msg_code='Y'
		SET @MSG='Booking Successfully Rejected'
		
	 END 

ELSE
 BEGIN 

 UPDATE [dbo].[Bookings]
	   SET [BookingStatus] = @BookingStatus
	 WHERE [BookingId] = @BookingId
		 SET @msg_code='Y'
		 SET @MSG='Booking Successfully Updated'
		  return;
		 END 
END






GO
/****** Object:  StoredProcedure [dbo].[sp_Booking_Insert_Update]    Script Date: 1/14/2019 7:36:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_Booking_Insert_Update]

	@BookingId bigint,
    @RentId bigint,
    @UserId bigint,
    @BookingStatus varchar(20),
	@msg_code VARCHAR(5) OUT,
	@MSG VARCHAR(200) OUT

AS

BEGIN

IF (@BookingId=0)

     BEGIN 
	 	declare @id int 
	SELECT @id= ISNULL(MAX(BookingId),1000)+1 FROM Bookings
	 INSERT INTO [dbo].[Bookings]
           ([BookingId]
           ,[RentId]
           ,[UserId]
           ,[RequestTime]
           ,[BookingStatus])
     VALUES
           (@id,
           @RentId,
           @UserId,
           getdate(),
           @BookingStatus);

		SET @msg_code='Y'
		SET @MSG='Booking Successfully Initiated'
		
	 END 
ELSE IF (@BookingId=1)

     BEGIN 
	 DELETE FROM [dbo].[Bookings]
		WHERE [RentId]=@RentId and [UserId]=@UserId
		SET @msg_code='Y'
		SET @MSG='Booking Successfully Cancled'
		
	 END 

ELSE
 BEGIN 

 UPDATE [dbo].[Bookings]
	   SET [BookingStatus] = @BookingStatus
	 WHERE [BookingId] = @BookingId
		 SET @msg_code='Y'
		 SET @MSG='Booking Successfully Updated'
		  return;
		 END 
END






GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Booking_Details]    Script Date: 1/14/2019 7:36:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_Get_Booking_Details]

@BookingId bigint
AS

	BEGIN 
		SELECT [Rents].[RentId]
		,[Bookings].BookingId
		,[Bookings].UserId
		  ,[OwnerId]
		  ,[RentTitle]
		  ,[Address]
		  ,[Fare]
		  ,[Description]
		  ,[PostedOn]
		  ,[RentStatus]
		  ,[FirstName]
		  ,[LastName]
		  ,[NickName]
		  ,[Email]
		  ,[Phone]
		  ,[Bookings].BookingStatus

	  FROM [dbo].[Rents] INNER JOIN [dbo].[Bookings] ON ([Rents].[RentId]=[Bookings].[RentId] and [Bookings].[BookingId]=@BookingId ) ,[dbo].[UserInfo] WHERE [UserInfo].UserId=[Bookings].UserId and [UserStatus]='Y' 
			
	  order by [PostedOn]

	END

GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Booking_List_by_Id]    Script Date: 1/14/2019 7:36:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_Get_Booking_List_by_Id]

@UserId bigint
AS
	BEGIN 
		SELECT [BookingId]
		  ,[Rents].[RentId]
		  ,[OwnerId]
		  ,[RentTitle]
		  ,[Address]
		  ,[Fare]
		  ,[Description]
		  ,[PostedOn]
		  ,[RentStatus]
		  ,[FirstName]
		  ,[LastName]
		  ,[NickName]
		  ,[Email]
		  ,[Phone]
		  ,[Bookings].RequestTime
		  ,[Bookings].BookingStatus
	  FROM [dbo].[UserInfo],[dbo].[Rents] INNER JOIN [dbo].[Bookings] ON [Rents].[RentId]=[Bookings].[RentId]  WHERE Bookings.UserId = @UserId and [UserInfo].UserId=[Rents].OwnerId and [UserStatus]='Y' and [RentStatus]<>'removed'
	  order by [PostedOn] desc

	END

GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Booking_User_List_by_Id]    Script Date: 1/14/2019 7:36:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_Get_Booking_User_List_by_Id]

@OwnerId bigint
AS
	BEGIN 
		SELECT [BookingId]
		  ,[Rents].[RentId]
		  ,[Bookings].[UserId]
		  ,[RentTitle]
		  ,[Address]
		  ,[Fare]
		  ,[Description]
		  ,[PostedOn]
		  ,[RentStatus]
		  ,[FirstName]
		  ,[LastName]
		  ,[NickName]
		  ,[Email]
		  ,[Phone]
		  ,[Bookings].RequestTime
		  ,[Bookings].BookingStatus
	  FROM [dbo].[UserInfo],[dbo].[Rents] INNER JOIN [dbo].[Bookings] ON [Rents].[RentId]=[Bookings].[RentId]  WHERE [Rents].OwnerId=@OwnerId and [UserInfo].UserId=[Bookings].UserId and [UserStatus]='Y' and [RentStatus]<>'removed'
	  order by [PostedOn] desc

	END

GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Rent_Details]    Script Date: 1/14/2019 7:36:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_Get_Rent_Details]

@RentId bigint,
@UserId bigint
AS

	BEGIN 
		SELECT [Rents].[RentId]
		  ,[OwnerId]
		  ,[RentTitle]
		  ,[Address]
		  ,[Fare]
		  ,[Description]
		  ,[PostedOn]
		  ,[RentStatus]
		  ,[FirstName]
		  ,[LastName]
		  ,[NickName]
		  ,[Email]
		  ,[Phone]
		  ,[Bookings].BookingStatus

	  FROM [dbo].[Rents] LEFT JOIN [dbo].[Bookings] ON ([Rents].[RentId]=[Bookings].[RentId] and [Bookings].[UserId]=@UserId) ,[dbo].[UserInfo] WHERE [UserInfo].UserId=[Rents].OwnerId and [UserStatus]='Y' and [Rents].[RentId]=@RentId 
			
	  order by [PostedOn]

	END

GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Rent_List]    Script Date: 1/14/2019 7:36:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_Get_Rent_List]

AS

	BEGIN 
		SELECT [RentId]
		  ,[OwnerId]
		  ,[RentTitle]
		  ,[Address]
		  ,[Fare]
		  ,[Description]
		  ,[PostedOn]
		  ,[RentStatus]
		  ,[FirstName]
		  ,[LastName]
		  ,[NickName]
		  ,[Email]
		  ,[Phone]
	  FROM [dbo].[UserInfo],[dbo].[Rents] WHERE [UserInfo].UserId=[Rents].OwnerId and [UserStatus]='Y' and [RentStatus]='Y'
	  order by [PostedOn] desc

	END

GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Rent_List_by_Id]    Script Date: 1/14/2019 7:36:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_Get_Rent_List_by_Id]

@OwnerId bigint
AS
	BEGIN 
		SELECT [RentId]
		  ,[OwnerId]
		  ,[RentTitle]
		  ,[Address]
		  ,[Fare]
		  ,[Description]
		  ,[PostedOn]
		  ,[RentStatus]
		  ,[FirstName]
		  ,[LastName]
		  ,[NickName]
		  ,[Email]
		  ,[Phone]
	  FROM [dbo].[UserInfo],[dbo].[Rents] WHERE  [Rents].OwnerId = @OwnerId and [UserInfo].UserId=[Rents].OwnerId and [UserStatus]='Y' and [RentStatus]<>'removed'
	  order by [PostedOn] desc

	END

GO
/****** Object:  StoredProcedure [dbo].[sp_Get_User_Addreess]    Script Date: 1/14/2019 7:36:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_Get_User_Addreess]
			
			@UserId bigint, 
			@msg_code VARCHAR(5) OUT,
			@MSG VARCHAR(200) OUT

AS

BEGIN 
	SELECT [AddressId]
      ,[UserId]
      ,[AddressTitle]
      ,[StreetAddress]
      ,[City]
      ,[PostCode]
      ,[Country]
      ,[AddressStatus]
  FROM [dbo].[UserAddress] WHERE UserId=@UserId AND AddressStatus='Y'

END

GO
/****** Object:  StoredProcedure [dbo].[sp_Get_User_Info]    Script Date: 1/14/2019 7:36:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_Get_User_Info]
			
			@UserId varchar(90)

AS
/*
BEGIN
IF EXISTS( SELECT * FROM UserInfo WHERE Email=@Email)
*/	BEGIN 
		SELECT [UserId]
		  ,[FirstName]
		  ,[LastName]
		  ,[NickName]
		  ,[BirthDate]
		  ,[Gender]
		  ,[Email]
		  ,[Phone]
		  ,[UserType]
		  ,[UserStatus]
	  FROM [dbo].[UserInfo] WHERE [UserId]=@UserId

	END
/*ELSE
	BEGIN 
	SET @msg_code='N'
	SET @MSG='Invalid user'
	END
END
*/
GO
/****** Object:  StoredProcedure [dbo].[sp_Rent_Delete]    Script Date: 1/14/2019 7:36:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_Rent_Delete]

	@RentId bigint, 
	@msg_code VARCHAR(5) OUT,
	@MSG VARCHAR(200) OUT

AS

BEGIN

	 UPDATE [dbo].[Rents]
	   SET [RentStatus] = 'removed'
	 WHERE [RentId] = @RentId
		 SET @msg_code='Y'
		 SET @MSG='Successfully Deleted'
		  return;
	
END






GO
/****** Object:  StoredProcedure [dbo].[sp_Rent_Insert_Update]    Script Date: 1/14/2019 7:36:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_Rent_Insert_Update]

	@RentId bigint, 
    @OwnerId bigint, 
    @RentTitle varchar(200), 
    @Address varchar(200), 
    @Fare decimal(18,2), 
    @Description varchar(500), 
    @RentStatus varchar(50),
	@msg_code VARCHAR(5) OUT,
	@MSG VARCHAR(200) OUT

AS

BEGIN

IF (@RentId=0)

     BEGIN 
	 	declare @id int 
	SELECT @id= ISNULL(MAX(RentId),1000)+1 FROM Rents
	 INSERT INTO [dbo].[Rents]
           ([RentId]
           ,[OwnerId]
           ,[RentTitle]
           ,[Address]
           ,[Fare]
           ,[Description]
		   ,[PostedOn]
           ,[RentStatus])
     VALUES
           (@id
           ,@OwnerId 
           ,@RentTitle 
           ,@Address 
           ,@Fare
           ,@Description
		   ,getdate()
           ,'Y');
		SET @msg_code='Y'
		SET @MSG='Add successfully posted'
		return;
	 END 
ELSE
 BEGIN 
	 UPDATE [dbo].[Rents]
	   SET [RentTitle] = @RentTitle
		  ,[Address] = @Address
		  ,[Fare] = @Fare
		  ,[Description] = @Description
		  ,[RentStatus] = @RentStatus
	 WHERE [RentId] = @RentId
		 SET @msg_code='Y'
		 SET @MSG='Successfully Updated'
		  return;
	END 
END






GO
/****** Object:  StoredProcedure [dbo].[sp_User_Address_Insert_Update]    Script Date: 1/14/2019 7:36:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_User_Address_Insert_Update]
			@AddressId bigint,
           @UserId bigint,
           @AddressTitle varchar(100),
           @StreetAddress varchar(100),
           @City varchar(70),
           @PostCode varchar(20),
           @Country varchar(50),
           @AddressStatus varchar(20),
			@msg_code VARCHAR(5) OUT,
			@MSG VARCHAR(200) OUT

AS

BEGIN

IF (@AddressId=0)
BEGIN

	declare @id bigint 
	SELECT @id= ISNULL(MAX(AddressId),100)+1 FROM UserAddress
	 INSERT INTO [dbo].[UserAddress]
           ([AddressId]
           ,[UserId]
           ,[AddressTitle]
           ,[StreetAddress]
           ,[City]
           ,[PostCode]
           ,[Country]
           ,[AddressStatus])
     VALUES
           (@id
           ,@UserId
           ,@AddressTitle
           ,@StreetAddress
           ,@City 
           ,@PostCode 
           ,@Country 
           ,@AddressStatus )
		SET @msg_code='Y'
		SET @MSG='Address successfully added.'
		
  END
ELSE
		BEGIN 

		UPDATE [dbo].[UserAddress]
		   SET [AddressTitle] = @AddressTitle
			  ,[StreetAddress] = @StreetAddress
			  ,[City] = @City
			  ,[PostCode] = @PostCode
			  ,[Country] = @Country
			  ,[AddressStatus] = @AddressStatus
		 WHERE AddressId=@AddressId
		 SET @msg_code='Y'
		 SET @MSG='Address successfully updated.'
		  return;
		 END 
END






GO
/****** Object:  StoredProcedure [dbo].[sp_User_Login]    Script Date: 1/14/2019 7:36:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_User_Login]

	@Email varchar(90), 
	@Password varchar(max)

AS

BEGIN

SELECT [UserId]
      ,[FirstName]
      ,[LastName]
      ,[NickName]
      ,[BirthDate]
      ,[Gender]
      ,[Email]
      ,[Phone]
      ,[UserType]
      ,[UserStatus]
  FROM [dbo].[UserInfo]
WHERE [Email]=@Email AND [Password]=@Password

END






GO
/****** Object:  StoredProcedure [dbo].[sp_User_Sign_Up_Update]    Script Date: 1/14/2019 7:36:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_User_Sign_Up_Update]

	@UserId bigint, 
	@FirstName varchar(40), 
	@LastName varchar(40), 
	@NickName varchar(40), 
	@BirthDate date, 
	@Gender varchar(40), 
	@Email varchar(90), 
	@Password varchar(max), 
	@Phone varchar(20), 
	@UserType varchar(20),
	@UserStatus varchar(20),
	@msg_code VARCHAR(5) OUT,
	@MSG VARCHAR(200) OUT

AS

BEGIN

IF (@UserId=0)
BEGIN

	IF EXISTS( SELECT * FROM UserInfo WHERE Email=@Email)
		 BEGIN 
		 SET @msg_code='N'
		 SET @MSG='Sorry, an account already registered with this email.'
		 return;
		 END 
	ELSE  IF EXISTS( SELECT * FROM UserInfo WHERE Phone=@Phone)
		 BEGIN 
		 SET @msg_code='N'
		 SET @MSG='Sorry, an account already registered with this phone no.'
		  return;
		 END 
		  
	ELSE
     BEGIN 
	 	declare @id int 
	SELECT @id= ISNULL(MAX(UserId),1000)+1 FROM UserInfo
	 INSERT INTO [dbo].[UserInfo]
         ([UserId]
           ,[FirstName]
           ,[LastName]
           ,[NickName]
           ,[BirthDate]
           ,[Gender]
           ,[Email]
           ,[Password]
           ,[Phone]
           ,[UserType]
           ,[UserStatus])
     VALUES
           (@id
           ,@FirstName
           ,@LastName
           ,@NickName
           ,@BirthDate 
		   ,@Gender
           ,@Email
           ,@Password
           ,@Phone
		   ,@UserType
           ,@UserStatus);
		SET @msg_code='Y'
		SET @MSG='User successfully registered'
		
	 END 
  END
ELSE
 BEGIN 
 UPDATE [dbo].[UserInfo]
   SET [FirstName] = @FirstName
      ,[LastName] = @LastName
      ,[NickName] = @NickName
      ,[BirthDate] = @BirthDate
      ,[Gender] = @Gender
      ,[Email] = @Email
      
      ,[Phone] = @Phone
	  WHERE [UserId]=@UserId
		 SET @msg_code='Y'
		 SET @MSG='Successfully Updated'
		  return;
		 END 
END






GO
