-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_OPS_DeleteRoadSurveyDetails
	-- Add the parameters for the stored procedure here
	@routesurveyid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @retval int
begin try
	begin transaction
		delete from MDC_AddOnCost where FK_RouteSurveyId=@routesurveyid
		delete from MDC_CalculatedFile where FK_RouteSurveyId=@routesurveyid
		delete from MDC_Junction where FK_RouteSurveyId=@routesurveyid
		delete from MDC_LoadDetails where FK_RouteSurveyId=@routesurveyid
		delete from MDC_PriceChart_New where FK_RouteSurveyId=@routesurveyid
		delete from MDC_RentalVehicleDetails where FK_RouteSurveyId=@routesurveyid
		delete from MDC_VehicleDetails where FK_RouteSurveyId=@routesurveyid

		delete from OPS_RigMoveCranes where FK_RouteSurveyId=@routesurveyid
		delete from OPS_RigMoveFlatbeds where RouteSurveyId=@routesurveyid
		delete from OPS_RigMoveLMV where FK_RouteSurveyId=@routesurveyid
		delete from OPS_RigMoveLowbeds where RouteSurveyId=@routesurveyid
		delete from OPS_RigMoveManpower where FK_RouteSurveyId=@routesurveyid
		delete from OPS_RigMoveOFT where FK_RouteSurveyId=@routesurveyid
		delete from OPS_RigMoveRentals where FK_RouteSurveyId=@routesurveyid
		delete from OPS_RigMoveUpdates where FK_RouteSurveyId=@routesurveyid
		delete from OPS_RigMoveWL where FK_RouteSurveyId=@routesurveyid
		delete from OPS_RigMoveCranes where FK_RouteSurveyId=@routesurveyid
		delete from RoadSurveyDetails where RouteSurveyId=@routesurveyid
	commit transaction
	set @retval=1
end try
begin catch
	rollback transaction
	set @retval=0
end catch


END
return @retval