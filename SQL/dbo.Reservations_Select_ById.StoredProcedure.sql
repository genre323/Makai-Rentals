USE [Makai]
GO
/****** Object:  StoredProcedure [dbo].[Reservations_Select_ById]    Script Date: 3/23/2023 4:44:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Gonzalez, Gerardo
-- Create date: 25FEB23
-- Description:	Select Reservation by Reservation Id
--				
-- Code Reviewer: Starks, Thomas

-- MODIFIED BY: author
-- MODIFIED DATE:25FEB23
-- Code Reviewer:
-- Note:
-- =============================================

CREATE proc [dbo].[Reservations_Select_ById]
									@Id int


AS

/* -- TEST CODE --

DECLARE @Id int = 2

EXECUTE dbo.Reservations_Select_ById
								    @Id


*/

BEGIN

SELECT r.[Id]
      ,r.[ProductId]
      ,r.[DateCheckIn]
      ,r.[RentalTime]
      ,r.[ChargeId]
      ,r.[StatusId]
	  ,st.[Name]
      ,u.Id as UserId
	  ,u.[FirstName]
	  ,u.[LastName]
	  ,u.[Mi]
	  ,u.[AvatarUrl]
      ,r.[DateCreated]
      ,r.[DateModified]
  FROM [dbo].[Reservations] as r INNER JOIN [dbo].[Users] as u
  ON r.UserId = u.Id INNER JOIN [dbo].[StatusTypes] as st
  ON r.StatusId = st.Id
  WHERE r.Id = @Id

END


GO
