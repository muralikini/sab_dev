-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_MDC_GetMobDemobStats 
	-- Add the parameters for the stored procedure here
	@routesurveyid AS INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here 
	DECLARE 
	@loadid INT,
	@rentalid INT,
	@vehicleid INT,
	@addonid int

	SELECT @addonid=MDC_AddOnCostId FROM MDC_AddonCost WHERE FK_RouteSurveyId=@routesurveyid
	SELECT @loadid=MDC_ID FROM dbo.MDC_LoadDetails WHERE FK_RouteSurveyId=@routesurveyid
	SELECT @rentalid=MDC_RentalDetailsID FROM dbo.MDC_RentalVehicleDetails WHERE FK_RouteSurveyId=@routesurveyid
	SELECT @vehicleid=MDC_VehilcleDetailsId FROM dbo.MDC_VehicleDetails WHERE FK_RouteSurveyId=@routesurveyid

	IF(@addonid IS NOT NULL AND @loadid IS NOT NULL AND @rentalid IS NOT NULL AND @vehicleid IS NOT NULL)
	BEGIN

		SELECT        FoodDays, FoodRate, ExtraMobLoadedLB, ExtraDemobLoadedLB, Manpower, Maintainance
FROM            MDC_AddOnCost WHERE FK_RouteSurveyId=@routesurveyid
		SELECT        TotalLoads, Loaded1SideTrip, Empty1SideTrip
FROM            MDC_LoadDetails WHERE FK_RouteSurveyId=@routesurveyid
		SELECT        Flatbed, Lowbed, LBwithLoad, LMV
FROM            MDC_RentalVehicleDetails WHERE FK_RouteSurveyId=@routesurveyid
		SELECT        Flatbed, Lowbed, LBwithLoad, LMV
FROM            MDC_VehicleDetails WHERE FK_RouteSurveyId=@routesurveyid

    
	end
	
END