USE [Makai]
GO
/****** Object:  StoredProcedure [dbo].[Stands_SelectAllV2]    Script Date: 3/23/2023 4:44:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Stands_SelectAllV2]

AS

-- =============================================
-- Author: Gonzalez, Gerardo
-- Create date: 03-21-2023
-- Description: Select Stand Locations with location information joined (Addresses) 
-- as well as only selecting active/available stands.
-- Code Reviewer:

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:
-- =============================================

-- Execute dbo.Stands_SelectAllV2

BEGIN


		SELECT  s.Id
			,s.StandStatusId
				,sst.Name AS StandStatus
			,s.StandTypeId
				,st.Name AS StandType
			,s.PartnerId
				,p.Name AS PartnerName
				,p.Logo AS PartnerLogo
				,p.BusinessPhone AS PartnerPhone
				,p.SiteUrl AS PartnerSiteUrl
				,p.CreatedBy
					,uc.FirstName
					,uc.LastName
					,uc.Mi
					,uc.AvatarUrl
				,p.DateCreated
				,p.DateModified
				,p.IsActive
			,s.IsPrivate
			,s.IsReservable
			,s.LocationId
				,l.LocationTypeId
					,lt.Name
				,l.LineOne
				,l.LineTwo
				,l.City
				,l.Zip
				,l.StateId
					,sta.Name
					,sta.Code
				,l.Latitude
				,l.Longitude
				,l.IsDeleted
			,s.DateOpened
			,p.CreatedBy
				,uc.FirstName
				,uc.LastName
				,uc.Mi
				,uc.AvatarUrl
			,p.ModifiedBy
				,um.FirstName
				,um.LastName
				,um.Mi
				,um.AvatarUrl
	FROM [dbo].[Stands] AS s
	INNER JOIN [dbo].[Partners] AS p
	ON s.PartnerId = p.Id
	INNER JOIN [dbo].[Users] AS uc
	ON uc.Id = p.CreatedBy
	INNER JOIN [dbo].[Users] AS um
	ON um.Id = p.ModifiedBy
	INNER JOIN [dbo].[StandStatusType] AS sst
	ON s.StandStatusId = sst.Id
	INNER JOIN [dbo].[StandTypes] AS st
	ON s.StandTypeId = st.Id
    INNER JOIN dbo.Locations AS l 
	ON l.Id = s.LocationId
	INNER JOIN dbo.States AS sta
	ON l.StateId = sta.Id
	INNER JOIN dbo.LocationTypes AS lt
	ON l.LocationTypeId = lt.Id
	WHERE s.StandStatusId = 1

	ORDER BY s.Id

 

 END


GO
