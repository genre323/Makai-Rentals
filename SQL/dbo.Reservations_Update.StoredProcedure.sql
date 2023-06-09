USE [Makai]
GO
/****** Object:  StoredProcedure [dbo].[Reservations_Update]    Script Date: 3/23/2023 4:44:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Gonzalez, Gerardo
-- Create date: 25FEB23
-- Description:	Update rows in Reservations table
-- Code Reviewer: Starks, Thomas

-- MODIFIED BY: author
-- MODIFIED DATE:25FEB23
-- Code Reviewer:
-- Note:
-- =============================================

CREATE proc [dbo].[Reservations_Update]
							@ProductId int
						   ,@DateCheckIn datetime2(7)
						   ,@RentalTime int
						   ,@ChargeId nvarchar(200)
						   ,@StatusId int
						   ,@UserId int
						   ,@Id int

AS

/* -- TEST CODE --

DECLARE @Id int = 9

DECLARE  @ProductId int = 4
		,@DateCheckIn datetime2(7) = '2/28/23' 
		,@RentalTime int = 1300
		,@ChargeId nvarchar(200) = 'TestCharge'
		,@StatusId int = 1 
		,@UserId int = 12
		
EXECUTE dbo.Reservations_Update
							@ProductId
						   ,@DateCheckIn
						   ,@RentalTime
						   ,@ChargeId
						   ,@StatusId
						   ,@UserId
						   ,@Id

SELECT * 
FROM dbo.Reservations
WHERE Id = @Id

*/

BEGIN

DECLARE @datMod datetime2(7) = GETUTCDATE()

UPDATE [dbo].[Reservations]
   SET [ProductId] = @ProductId
      ,[DateCheckIn] = @DateCheckIn
      ,[RentalTime] = @RentalTime
      ,[ChargeId] = @ChargeId
      ,[StatusId] = @StatusId
      ,[UserId] = @UserId
      ,[DateModified] = @datMod
 WHERE Id = @Id

 END


GO
