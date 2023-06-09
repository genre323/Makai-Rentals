USE [Makai]
GO
/****** Object:  StoredProcedure [dbo].[Reservations_Select_ByCreatedBy]    Script Date: 3/23/2023 4:44:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Gonzalez, Gerardo
-- Create date: 25FEB23
-- Description:	Select reservations by creator (CreatedBy/UserId)
--				in order of latest first.
-- Code Reviewer: Starks, Thomas

-- MODIFIED BY: author
-- MODIFIED DATE:25FEB23
-- Code Reviewer:
-- Note:
-- =============================================

CREATE proc [dbo].[Reservations_Select_ByCreatedBy]
									@PageIndex int
								   ,@PageSize int
								   ,@UserId int
AS

/* -- TEST CODE --

DECLARE @PageIndex int = 0
	   ,@PageSize int = 10
	   ,@UserId int = 32

EXECUTE [dbo].[Reservations_Select_ByCreatedBy]
									@PageIndex
								   ,@PageSize
								   ,@UserId



*/

BEGIN

DECLARE @offset int = @PageIndex * @PageSize

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
	  ,TotalCount = COUNT(1) OVER()
  FROM [dbo].[Reservations] as r INNER JOIN [dbo].[Users] as u
  ON r.UserId = u.Id INNER JOIN [dbo].[StatusTypes] as st
  ON r.StatusId = st.Id
  WHERE r.UserId = @UserId
  ORDER BY [DateCreated] DESC 
  OFFSET @offset ROWS
  FETCH NEXT @PageSize ROWS ONLY

END
GO
