USE [Makai]
GO
/****** Object:  StoredProcedure [dbo].[Reservations_Insert]    Script Date: 3/23/2023 4:44:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Gonzalez, Gerardo
-- Create date: 24FEB23
-- Description:	Insert into dbo.Reservations table
--				Output Id of new record
-- Code Reviewer: Starks, Thomas

-- MODIFIED BY: author
-- MODIFIED DATE:24FEB23
-- Code Reviewer:
-- Note:
-- =============================================

CREATE proc [dbo].[Reservations_Insert]
						@ProductId int
					   ,@DateCheckIn datetime2(7)
					   ,@RentalTime int
					   ,@ChargeId nvarchar(200)
					   ,@StatusId int
					   ,@UserId int
					   ,@Id int OUTPUT
AS

/* -- TEST CODE --

DECLARE @Id int = 0

DECLARE  @ProductId int = 4
		,@DateCheckIn datetime2(7) = '2/28/23'
		,@RentalTime int = 1400
		,@ChargeId nvarchar(200) = 'testcharge'
		,@StatusId int = 1
		,@UserId int = 12
		
EXECUTE dbo.Reservations_Insert 
							@ProductId
						   ,@DateCheckIn
						   ,@RentalTime
						   ,@ChargeId
						   ,@StatusId
						   ,@UserId
						   ,@Id OUTPUT

SELECT * 
FROM dbo.Reservations

*/

BEGIN

DECLARE @datNow datetime2(7) = getutcdate()

INSERT INTO [dbo].[Reservations]
           ([ProductId]
           ,[DateCheckIn]
           ,[RentalTime]
           ,[ChargeId]
           ,[StatusId]
		   ,[UserId]
           ,[DateCreated])

     VALUES
            (@ProductId
			,@DateCheckIn
			,@RentalTime
			,@ChargeId
			,@StatusId
			,@UserId
			,@datNow)

	 SET	 @Id = SCOPE_IDENTITY()

END




GO
