-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetRigMoveVehicleDetails]
	-- Add the parameters for the stored procedure here
	@routesurveyid INT,
	@flagtype INT -- 0 what customer asked for, 1 What is added in the fleet, 2- detailed fleet description
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF(@flagtype=0)
	begin

    SELECT        RoadSurveyDetails.RouteSurveyId, MDC_RentalVehicleDetails.LMV AS RentalsLMV, MDC_RentalVehicleDetails.LBwithLoad AS RentalsLBWithLoad, 
                         MDC_RentalVehicleDetails.Lowbed AS RentalsLB, MDC_RentalVehicleDetails.Flatbed AS RentalsFB, MDC_VehicleDetails.Flatbed AS SAB_FB, 
                         MDC_VehicleDetails.Lowbed AS SAB_LB, MDC_VehicleDetails.LBwithLoad AS SAB_LBwithLoad, MDC_VehicleDetails.LMV AS SAB_LMV
FROM            RoadSurveyDetails INNER JOIN
                         MDC_VehicleDetails ON RoadSurveyDetails.RouteSurveyId = MDC_VehicleDetails.FK_RouteSurveyId INNER JOIN
                         MDC_RentalVehicleDetails ON RoadSurveyDetails.RouteSurveyId = MDC_RentalVehicleDetails.FK_RouteSurveyId
WHERE        (RoadSurveyDetails.Status = 1) AND (RoadSurveyDetails.RouteSurveyId=@routesurveyid)
END
ELSE IF(@flagtype=1)
BEGIN

DECLARE @mytable table
(SAB_FBCount int,
SAB_LBCount INT,
SAB_CranesCount INT,
SAB_WLCount INT,
SAB_LMVCount INT,
SAB_OFTCount int)

DECLARE @fb INT,
@lb INT,
@cr INT,
@wl INT,
@lmv INT,
@oft int

SELECT @fb=COUNT(*)  FROM dbo.OPS_RigMoveFlatbeds
WHERE RouteSurveyId=@routesurveyid AND Statusflag=1

SELECT @lb=COUNT(*)  FROM dbo.OPS_RigMoveLowbeds
WHERE RouteSurveyId=@routesurveyid AND Statusflag=1

SELECT @cr=COUNT(*)  FROM dbo.OPS_RigMoveCranes
WHERE FK_RouteSurveyId=@routesurveyid AND Statusflag=1

SELECT @wl=COUNT(*)  FROM dbo.OPS_RigMoveWL
WHERE FK_RouteSurveyId=@routesurveyid AND Statusflag=1

SELECT @lmv=COUNT(*)  FROM dbo.OPS_RigMoveLMV
WHERE FK_RouteSurveyId=@routesurveyid AND Statusflag=1

SELECT @oft=COUNT(*)  FROM dbo.OPS_RigMoveOFT
WHERE FK_RouteSurveyId=@routesurveyid AND Statusflag=1

INSERT INTO @mytable
(
    SAB_FBCount,
    SAB_LBCount,
    SAB_CranesCount,
    SAB_WLCount,
    SAB_LMVCount,
    SAB_OFTCount
)
VALUES
(   @fb, -- SAB_FBCount - int
    @lb, -- SAB_LBCount - int
    @cr, -- SAB_CranesCount - int
    @wl, -- SAB_WLCount - int
    @lmv, -- SAB_LMVCount - int
    @oft  -- SAB_OFTCount - int
    )

	SELECT * FROM @mytable

END
ELSE IF(@flagtype=2)
BEGIN

DECLARE @statstable TABLE
(
ClientName NVARCHAR(MAX),
WellNumber NVARCHAR(MAX),
ResourceType NVARCHAR(MAX),
EmployeeId NVARCHAR(MAX),
EmployeeName NVARCHAR(MAX),
DateOfMob DATE,
DateOfDemob DATE,
StartingOdo INT,
EndingOdo INT,
Remarks NVARCHAR(MAX)

)
DECLARE	@ClientName NVARCHAR(MAX),
		@WellNumber NVARCHAR(MAX),
		 @ResourceType NVARCHAR(max),
		@EmployeeId NVARCHAR(MAX),
		@EmployeeName NVARCHAR(MAX),
		@DateOfMob DATE=NULL,
		@DateOfDemob DATE=NULL,
		@StartingOdo INT=NULL,
		@EndingOdo INT=NULL,
		@Remarks NVARCHAR(MAX)=NULL

INSERT INTO @statstable
SELECT DISTINCT 
                         Clients.Name AS ClientName, WellSiteDetails.WellNumber, 'Flatbed' , [HR.Employees].SABId, [HR.Employees].Name, 
                         OPS_RigMoveFlatbeds.DateofMobilization, OPS_RigMoveFlatbeds.DateOfRelease, OPS_RigMoveFlatbeds.StartingOdometer, 
                         OPS_RigMoveFlatbeds.EndingOdoMeter, OPS_RigMoveFlatbeds.Remarks
FROM            OPS_RigMoveFlatbeds INNER JOIN
                         OPS_FlatbedJn ON OPS_RigMoveFlatbeds.FK_FBid = OPS_FlatbedJn.FBJnId INNER JOIN
                         OPS_Flatbeds ON OPS_FlatbedJn.FK_FBId = OPS_Flatbeds.FlatbedId INNER JOIN
                         OPS_FlatbedDrivers ON OPS_FlatbedJn.FK_FBDriverId = OPS_FlatbedDrivers.FBDriverId INNER JOIN
                         [HR.Employees] ON OPS_FlatbedDrivers.SAB_ID = [HR.Employees].SABId INNER JOIN
                         RoadSurveyDetails ON OPS_RigMoveFlatbeds.RouteSurveyId = RoadSurveyDetails.RouteSurveyId INNER JOIN
                         WellSiteDetails ON RoadSurveyDetails.FK_WellsiteId = WellSiteDetails.WellSiteId INNER JOIN
                         Clients ON WellSiteDetails.FK_ClientId = Clients.ClientId
WHERE        (OPS_RigMoveFlatbeds.RouteSurveyId = @routesurveyid)


INSERT INTO @statstable
SELECT DISTINCT 
                         Clients.Name AS ClientName, WellSiteDetails.WellNumber, 'Lowbed', [HR.Employees].SABId, [HR.Employees].Name, OPS_RigMoveLowbeds.DateOfMobilization, 
                         OPS_RigMoveLowbeds.DateOfRelease, OPS_RigMoveLowbeds.StartingOdometer, OPS_RigMoveLowbeds.EndingOdometer, OPS_RigMoveLowbeds.Remarks
FROM            OPS_RigMoveLowbeds INNER JOIN
                         OPS_LowbedJn ON OPS_RigMoveLowbeds.FK_LBId = OPS_LowbedJn.LBJnId INNER JOIN
                         OPS_LowbedDrivers ON OPS_LowbedJn.FK_LBDriverId = OPS_LowbedDrivers.LBDriverId INNER JOIN
                         OPS_Lowbeds ON OPS_LowbedJn.FK_LBId = OPS_Lowbeds.LowbedId INNER JOIN
                         [HR.Employees] ON OPS_LowbedDrivers.SAB_ID = [HR.Employees].SABId INNER JOIN
                         RoadSurveyDetails ON OPS_RigMoveLowbeds.RouteSurveyId = RoadSurveyDetails.RouteSurveyId INNER JOIN
                         WellSiteDetails ON RoadSurveyDetails.FK_WellsiteId = WellSiteDetails.WellSiteId INNER JOIN
                         Clients ON WellSiteDetails.FK_ClientId = Clients.ClientId
WHERE        (OPS_RigMoveLowbeds.RouteSurveyId = @routesurveyid)


INSERT INTO @statstable
SELECT     distinct   
 Clients.Name, WellSiteDetails.WellNumber, 'Cranes', [HR.Employees].SABId, [HR.Employees].Name, OPS_RigMoveCranes.DateOfMobilization, 
                         OPS_RigMoveCranes.DateOfRelease, OPS_RigMoveCranes.StartingOdometer, OPS_RigMoveCranes.EndingOdometer, OPS_RigMoveCranes.Remarks
FROM            OPS_RigMoveCranes INNER JOIN
                         OPS_CraneJn ON OPS_RigMoveCranes.FK_CraneJnId = OPS_CraneJn.CraneJnId INNER JOIN
                         OPS_CraneOperators ON OPS_CraneJn.FK_OperatorId = OPS_CraneOperators.OperatorID INNER JOIN
                         OPS_Cranes ON OPS_CraneJn.CraneJnId = OPS_Cranes.CraneId INNER JOIN
                         [HR.Employees] ON OPS_CraneOperators.SAB_ID = [HR.Employees].SABId INNER JOIN
						 RoadSurveyDetails ON OPS_RigMoveCranes.FK_RouteSurveyId = RoadSurveyDetails.RouteSurveyId INNER JOIN
                         WellSiteDetails ON RoadSurveyDetails.FK_WellsiteId = WellSiteDetails.WellSiteId INNER JOIN
                         Clients ON WellSiteDetails.FK_ClientId = Clients.ClientId
WHERE        (OPS_RigMoveCranes.FK_RouteSurveyId = @routesurveyid)

INSERT INTO @statstable
SELECT      distinct   
 Clients.Name , WellSiteDetails.WellNumber, 'Wheel Loader', [HR.Employees].SABId, [HR.Employees].Name, OPS_RigMoveWL.DateOfMobilization, 
                         OPS_RigMoveWL.DateOfRelease, OPS_RigMoveWL.StartingOdometer, OPS_RigMoveWL.EndingOdometer, OPS_RigMoveWL.Remarks
FROM            OPS_RigMoveWL INNER JOIN
                         OPS_WLJn ON OPS_RigMoveWL.FK_WLJnId = OPS_WLJn.WLJnId INNER JOIN
                         OPS_WL ON OPS_WLJn.FK_WLId = OPS_WL.WLId INNER JOIN
                         OPS_WLOperators ON OPS_WLJn.FK_WLOperatorId = OPS_WLOperators.WLOperatorId INNER JOIN
                         [HR.Employees] ON OPS_WLOperators.SAB_ID = [HR.Employees].SABId INNER JOIN
						 RoadSurveyDetails ON OPS_RigMoveWL.FK_RouteSurveyId = RoadSurveyDetails.RouteSurveyId INNER JOIN
                         WellSiteDetails ON RoadSurveyDetails.FK_WellsiteId = WellSiteDetails.WellSiteId INNER JOIN
                         Clients ON WellSiteDetails.FK_ClientId = Clients.ClientId
WHERE        (OPS_RigMoveWL.FK_RouteSurveyId = @routesurveyid)

INSERT INTO @statstable
SELECT      distinct   
 Clients.Name , WellSiteDetails.WellNumber, 'LMV', [HR.Employees].SABId, [HR.Employees].Name, OPS_RigMoveLMV.DateOfMobilization, 
                         OPS_RigMoveLMV.DateOfRelease, OPS_RigMoveLMV.StartingOdometer, OPS_RigMoveLMV.EndingOdometer, OPS_RigMoveLMV.Remarks
FROM            OPS_RigMoveLMV INNER JOIN
                         OPS_LMVJn ON OPS_RigMoveLMV.FK_LMVJnId = OPS_LMVJn.LMVJn INNER JOIN
                         OPS_LMV ON OPS_LMVJn.FK_LMVID = OPS_LMV.LMVId INNER JOIN
                         OPS_LMVDrivers ON OPS_LMVJn.FK_LMVDriverId = OPS_LMVDrivers.LMVDriverId INNER JOIN
                         [HR.Employees] ON OPS_LMVDrivers.SAB_ID = [HR.Employees].SABId INNER JOIN
						 RoadSurveyDetails ON OPS_RigMoveLMV.FK_RouteSurveyId = RoadSurveyDetails.RouteSurveyId INNER JOIN
                         WellSiteDetails ON RoadSurveyDetails.FK_WellsiteId = WellSiteDetails.WellSiteId INNER JOIN
                         Clients ON WellSiteDetails.FK_ClientId = Clients.ClientId
WHERE        (OPS_RigMoveLMV.FK_RouteSurveyId = @routesurveyid)


INSERT INTO @statstable
SELECT DISTINCT 
                         Clients.Name, WellSiteDetails.WellNumber, 'Oil Field Truck' AS Expr1, OPS_OFTJn.FK_OFTId, OPS_OFT.SAB_ID, OPS_RigMoveOFT.DateOfMobilization, 
                         OPS_RigMoveOFT.DateOfRelease, OPS_RigMoveOFT.StartingOdometer, OPS_RigMoveOFT.EndingOdometer, OPS_RigMoveOFT.Remarks
FROM            OPS_RigMoveOFT INNER JOIN
                         RoadSurveyDetails ON OPS_RigMoveOFT.FK_RouteSurveyId = RoadSurveyDetails.RouteSurveyId INNER JOIN
                         WellSiteDetails ON RoadSurveyDetails.FK_WellsiteId = WellSiteDetails.WellSiteId INNER JOIN
                         Clients ON WellSiteDetails.FK_ClientId = Clients.ClientId INNER JOIN
                         OPS_OFTJn ON OPS_RigMoveOFT.FK_OFTJnId = OPS_OFTJn.OFTJnId INNER JOIN
                         OPS_OFT ON OPS_OFTJn.FK_OFTId = OPS_OFT.OFTId
WHERE        
       (OPS_RigMoveOFT.FK_RouteSurveyId = @routesurveyid)

INSERT INTO @statstable
SELECT DISTINCT 
                         Clients.Name, WellSiteDetails.WellNumber, OPS_RentalTypes.TypeDescription, '',OPS_Rentals.Name AS Expr1, OPS_RigMoveRentals.DateOfMobilization, 
                         OPS_RigMoveRentals.DateOfRelease, OPS_RigMoveRentals.StartingOdometer, OPS_RigMoveRentals.EndingOdometer, OPS_RigMoveRentals.Remarks 
                         
FROM            OPS_RigMoveRentals INNER JOIN
                         RoadSurveyDetails ON OPS_RigMoveRentals.FK_RouteSurveyId = RoadSurveyDetails.RouteSurveyId INNER JOIN
                         WellSiteDetails ON RoadSurveyDetails.FK_WellsiteId = WellSiteDetails.WellSiteId INNER JOIN
                         Clients ON WellSiteDetails.FK_ClientId = Clients.ClientId INNER JOIN
                         OPS_Rentals ON OPS_RigMoveRentals.FK_RentalsId = OPS_Rentals.RentalsId INNER JOIN
                         OPS_RentalTypes ON OPS_Rentals.FK_RentalTypeId = OPS_RentalTypes.RentalTypeId
WHERE        (OPS_RigMoveRentals.FK_RouteSurveyId = @routesurveyid)

INSERT INTO @statstable
SELECT    distinct    Clients.Name AS ClientName, WellSiteDetails.WellNumber,OPS_Manpower.ManPowerType, [HR.Employees].SABId,[HR.Employees].Name, OPS_RigMoveManpower.DateOfMob, 
                         OPS_RigMoveManpower.DateOfDeMob ,NULL,NULL,null
FROM            OPS_RigMoveManpower INNER JOIN
                         RoadSurveyDetails ON OPS_RigMoveManpower.FK_RouteSurveyId = RoadSurveyDetails.RouteSurveyId INNER JOIN
                         WellSiteDetails ON RoadSurveyDetails.FK_WellsiteId = WellSiteDetails.WellSiteId INNER JOIN
                         Clients ON WellSiteDetails.FK_ClientId = Clients.ClientId INNER JOIN
                         OPS_Manpower ON OPS_RigMoveManpower.FK_ManpowerId = OPS_Manpower.ManPowerId INNER JOIN
                         [HR.Employees] ON OPS_Manpower.SAB_ID = [HR.Employees].SABId
						 WHERE OPS_RigMoveManpower.FK_RouteSurveyId=@routesurveyid
INSERT INTO @statstable
SELECT DISTINCT 
                         Clients.Name AS ClientName, WellSiteDetails.WellNumber, 'Lowbed Drivers',[HR.Employees].SABId, [HR.Employees].Name, OPS_RigMoveManpower.DateOfMob, 
                         OPS_RigMoveManpower.DateOfDeMob, NULL AS Expr1, NULL AS Expr2, NULL AS Expr3
FROM            OPS_RigMoveManpower INNER JOIN
                         RoadSurveyDetails ON OPS_RigMoveManpower.FK_RouteSurveyId = RoadSurveyDetails.RouteSurveyId INNER JOIN
                         WellSiteDetails ON RoadSurveyDetails.FK_WellsiteId = WellSiteDetails.WellSiteId INNER JOIN
                         Clients ON WellSiteDetails.FK_ClientId = Clients.ClientId INNER JOIN
                         OPS_LowbedDrivers ON OPS_RigMoveManpower.FK_LBDriverId = OPS_LowbedDrivers.LBDriverId INNER JOIN
                         [HR.Employees] ON OPS_LowbedDrivers.SAB_ID = [HR.Employees].SABId
WHERE        (OPS_RigMoveManpower.FK_RouteSurveyId = @routesurveyid)
INSERT INTO @statstable
SELECT DISTINCT 
                         Clients.Name AS ClientName, WellSiteDetails.WellNumber, 'Flatbed Drivers',[HR.Employees].SABId, [HR.Employees].Name, OPS_RigMoveManpower.DateOfMob, 
                         OPS_RigMoveManpower.DateOfDeMob, NULL AS Expr1, NULL AS Expr2, NULL AS Expr3
FROM            OPS_RigMoveManpower INNER JOIN
                         RoadSurveyDetails ON OPS_RigMoveManpower.FK_RouteSurveyId = RoadSurveyDetails.RouteSurveyId INNER JOIN
                         WellSiteDetails ON RoadSurveyDetails.FK_WellsiteId = WellSiteDetails.WellSiteId INNER JOIN
                         Clients ON WellSiteDetails.FK_ClientId = Clients.ClientId INNER JOIN
                         OPS_FlatbedDrivers ON OPS_RigMoveManpower.FK_FBDriverId = OPS_FlatbedDrivers.FBDriverId INNER JOIN
                         [HR.Employees] ON OPS_FlatbedDrivers.SAB_ID = [HR.Employees].SABId
WHERE        (OPS_RigMoveManpower.FK_RouteSurveyId = @routesurveyid)


	SELECT * FROM @statstable

END
END