USE [Makai]
GO
/****** Object:  StoredProcedure [dbo].[Reservations_Update_StatusByProductId]    Script Date: 3/23/2023 4:44:28 PM ******/
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
-- Note:
-- =============================================

CREATE proc [dbo].[Reservations_Update_StatusByProductId]
							@ProductId int
						   ,@StatusId int



AS

/* -- TEST CODE --



DECLARE  @ProductId int = 3
		,@StatusId int = 1

		
EXECUTE dbo.Reservations_Update_StatusByProductId
										@ProductId
									   ,@StatusId
						   

SELECT * 
FROM dbo.Reservations as r
WHERE r.ProductId = @ProductId

*/

BEGIN

DECLARE @datMod datetime2(7) = GETUTCDATE()

UPDATE [dbo].[Reservations]
   SET [StatusId] = @StatusId
      ,[DateModified] = @datMod
 FROM dbo.Reservations as r
 WHERE r.ProductId = @ProductId

 END


GO
