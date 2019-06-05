-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_MDC_ResetMobDemobCalculations
	-- Add the parameters for the stored procedure here
	@routesurvey int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM dbo.MDC_AddOnCost WHERE FK_RouteSurveyId=@routesurvey
	DELETE FROM dbo.MDC_LoadDetails WHERE FK_RouteSurveyId=@routesurvey
	DELETE FROM dbo.MDC_RentalVehicleDetails WHERE FK_RouteSurveyId=@routesurvey
	DELETE FROM dbo.MDC_VehicleDetails WHERE FK_RouteSurveyId=@routesurvey
END