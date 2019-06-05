-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MDC_GetRoadSurveyDetails] 
	-- Add the parameters for the stored procedure here
	@outputflag INT --1 to display all fields, -0 to display limted fields
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF(@outputflag=0) -- less fields
		BEGIN
			SELECT        RoadSurveyDetails.RouteSurveyId, Clients.Name AS Client, WellSiteDetails.WellNumber AS RigNo, WellType.WellType, 
                         RoadSurveyDetails.YardToOldDistance AS MobDistance, RoadSurveyDetails.OldToNewDistance AS RigMoveDistance, 
                         RoadSurveyDetails.NewToYardDistance AS DemobDistance, RoadSurveyDetails.XmlData, RoadSurveyDetails.InHouseRigMove
FROM            RoadSurveyDetails INNER JOIN
                         WellSiteDetails ON RoadSurveyDetails.FK_WellsiteId = WellSiteDetails.WellSiteId INNER JOIN
                         Clients ON WellSiteDetails.FK_ClientId = Clients.ClientId INNER JOIN
                         WellType ON WellSiteDetails.FK_WellTypeId = WellType.WellTypeId
WHERE        (RoadSurveyDetails.ApprovalStatus = 1) AND 
(RoadSurveyDetails.[Status] >0 
and RoadSurveyDetails.[Status]!=2
and RoadSurveyDetails.[Status]!=6 
and RoadSurveyDetails.[Status]!=10
--and RoadSurveyDetails.[Status]<100  
)
		END
      ELSE IF(@outputflag=1) --more fields
	  BEGIN
			SELECT        RoadSurveyDetails.RouteSurveyId, Clients.Name AS Client, WellSiteDetails.WellNumber AS RigNo, WellType.WellType, 
                         RoadSurveyDetails.YardToOldDistance AS MobDistance, RoadSurveyDetails.OldToNewDistance AS RigMoveDistance, 
                         RoadSurveyDetails.NewToYardDistance AS DemobDistance, RoadSurveyDetails.XmlData, RoadSurveyDetails.FK_WellsiteId, RoadSurveyDetails.SurveyDate, 
                         RoadSurveyDetails.PlannedRigMoveDate, RoadSurveyDetails.NewLocation, RoadSurveyDetails.RoughRoad, RoadSurveyDetails.BlackTop, 
                         RoadSurveyDetails.Status, RoadSurveyDetails.ApprovalStatus, RoadSurveyDetails.Remarks
			FROM            RoadSurveyDetails INNER JOIN
                         WellSiteDetails ON RoadSurveyDetails.FK_WellsiteId = WellSiteDetails.WellSiteId INNER JOIN
                         Clients ON WellSiteDetails.FK_ClientId = Clients.ClientId INNER JOIN
                         WellType ON WellSiteDetails.FK_WellTypeId = WellType.WellTypeId
			WHERE        (RoadSurveyDetails.ApprovalStatus = 1) AND 
			(RoadSurveyDetails.[Status] >0 
			and RoadSurveyDetails.[Status]!=2
			and RoadSurveyDetails.[Status]!=6 
			and RoadSurveyDetails.[Status]!=10
			--and RoadSurveyDetails.[Status]<100  
			)
			

	  END
	  ELSE IF(@outputflag=2) --for all valid route survey where status is 1 and even for approval =0
	  BEGIN
			SELECT        RoadSurveyDetails.RouteSurveyId, Clients.Name AS Client, WellSiteDetails.WellNumber AS RigNo, WellType.WellType, 
                         RoadSurveyDetails.YardToOldDistance AS MobDistance, RoadSurveyDetails.OldToNewDistance AS RigMoveDistance, 
                         RoadSurveyDetails.NewToYardDistance AS DemobDistance, RoadSurveyDetails.XmlData, RoadSurveyDetails.FK_WellsiteId, RoadSurveyDetails.SurveyDate, 
                         RoadSurveyDetails.PlannedRigMoveDate, RoadSurveyDetails.NewLocation, RoadSurveyDetails.RoughRoad, RoadSurveyDetails.BlackTop, 
                         RoadSurveyDetails.Status, RoadSurveyDetails.ApprovalStatus, RoadSurveyDetails.Remarks
			FROM            RoadSurveyDetails INNER JOIN
                         WellSiteDetails ON RoadSurveyDetails.FK_WellsiteId = WellSiteDetails.WellSiteId INNER JOIN
                         Clients ON WellSiteDetails.FK_ClientId = Clients.ClientId INNER JOIN
                         WellType ON WellSiteDetails.FK_WellTypeId = WellType.WellTypeId
			WHERE        
			(RoadSurveyDetails.[Status] >0 
			and RoadSurveyDetails.[Status]!=2
			and RoadSurveyDetails.[Status]!=6 
			and RoadSurveyDetails.[Status]!=10
			--and RoadSurveyDetails.[Status]<100  
			)
			

	  END
      
END