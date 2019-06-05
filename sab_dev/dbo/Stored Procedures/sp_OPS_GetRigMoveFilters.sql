-- =============================================
-- Author:		Muralidhar Kini	
-- Create date: 19-2-2019
-- Description:	To get different filter data that involves routesurvey and the dependent modules
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_GetRigMoveFilters]
	-- Add the parameters for the stored procedure here
	@routesurveyid int,
	@filtertype int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   if(@filtertype=1)
   begin
		select * from 
		RoadSurveyDetails
		where 
		RouteSurveyId=@routesurveyid

   end

   if(@filtertype=2)
   begin
		SELECT        OPS_RigMoveUpdates.RMUpdateId, OPS_RigMoveUpdates.FK_RigMoveStatus, RigMoveStatus.RigMoveStatusId, RigMoveStatus.Description, 
                         OPS_RigMoveUpdates.UpdateDate, OPS_RigMoveUpdates.OldLocationLoads, OPS_RigMoveUpdates.NewLocationLoads, OPS_RigMoveUpdates.Remarks
FROM            OPS_RigMoveUpdates INNER JOIN
                         RigMoveStatus ON OPS_RigMoveUpdates.FK_RigMoveStatus = RigMoveStatus.RMStatusId
WHERE        (OPS_RigMoveUpdates.FK_RouteSurveyId = @routesurveyid)
ORDER BY OPS_RigMoveUpdates.UpdateDate
   end
END