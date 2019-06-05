-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_GetManPowerInRigMove]
	-- Add the parameters for the stored procedure here
	@routesurveyid INT,
	@manpowertype int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if(@manpowertype<6)
	begin

		SELECT        OPS_RigMoveManpower.RMManpowerId,OPS_RigMoveManpower.FK_ManpowerId,  [HR.Employees].Name
		FROM            OPS_RigMoveManpower INNER JOIN
							 OPS_Manpower ON OPS_RigMoveManpower.FK_ManpowerId = OPS_Manpower.ManPowerId INNER JOIN
							 [HR.Employees] ON OPS_Manpower.SAB_ID = [HR.Employees].SABId
		WHERE        (OPS_RigMoveManpower.StatusFlag = 1) AND 
		OPS_RigMoveManpower.FK_RouteSurveyId=@routesurveyid and
		OPS_Manpower.ManPowerType =
		CASE

		WHEN @manpowertype=1 THEN 'CONVOY'
		WHEN @manpowertype=2 THEN 'RIGGER'
		WHEN @manpowertype=3 THEN 'SAFETY'
		WHEN @manpowertype=4 THEN 'SUPPORT'
		WHEN @manpowertype=5 THEN 'TRUCKPUSHER'
		end
	end
	else if(@manpowertype=6)
	begin

		SELECT        OPS_RigMoveManpower.RMManpowerId, OPS_RigMoveManpower.FK_CraneOperatorId, [HR.Employees].Name, OPS_RigMoveManpower.FK_ManpowerId
FROM            OPS_RigMoveManpower INNER JOIN
                         OPS_CraneOperators ON OPS_RigMoveManpower.FK_CraneOperatorId = OPS_CraneOperators.OperatorID INNER JOIN
                         [HR.Employees] ON OPS_CraneOperators.SAB_ID = [HR.Employees].SABId
WHERE        (OPS_CraneOperators.StatusFlag = 2) AND (OPS_RigMoveManpower.FK_RouteSurveyId = @routesurveyid) AND (OPS_RigMoveManpower.FK_ManpowerId IS NULL) 
                         AND (OPS_RigMoveManpower.FK_CraneOperatorId IS NOT NULL) and (OPS_RigMoveManpower.FK_FBDriverId is NULL) and (OPS_RigMoveManpower.FK_LBDriverId is NULL)
						 and OPS_RigMoveManpower.StatusFlag=1

	end
	else if(@manpowertype=7)
	begin

			SELECT        OPS_RigMoveManpower.RMManpowerId, OPS_RigMoveManpower.FK_WLOperatorId, [HR.Employees].Name
			FROM            OPS_RigMoveManpower INNER JOIN
                         OPS_WLOperators ON OPS_RigMoveManpower.FK_WLOperatorId = OPS_WLOperators.WLOperatorId INNER JOIN
                         [HR.Employees] ON OPS_WLOperators.SAB_ID = [HR.Employees].SABId
			WHERE        (OPS_WLOperators.StatusFlag = 2) AND (OPS_RigMoveManpower.FK_ManpowerId IS NULL) AND (NOT (OPS_RigMoveManpower.FK_WLOperatorId IS NULL)) AND 
                         (OPS_RigMoveManpower.FK_RouteSurveyId = @routesurveyid)and (OPS_RigMoveManpower.FK_FBDriverId is NULL) and (OPS_RigMoveManpower.FK_LBDriverId is NULL)
						 AND (OPS_RigMoveManpower.FK_RouteSurveyId = @routesurveyid) and OPS_RigMoveManpower.StatusFlag=1

	end
	else if(@manpowertype=8)
	begin

			SELECT        OPS_RigMoveManpower.RMManpowerId, OPS_RigMoveManpower.FK_FBDriverId, [HR.Employees].Name
FROM            OPS_RigMoveManpower INNER JOIN
                         OPS_FlatbedDrivers ON OPS_RigMoveManpower.FK_FBDriverId = OPS_FlatbedDrivers.FBDriverId INNER JOIN
                         [HR.Employees] ON OPS_FlatbedDrivers.SAB_ID = [HR.Employees].SABId
WHERE        (OPS_FlatbedDrivers.StatusFlag = 2) AND (OPS_RigMoveManpower.FK_WLOperatorId IS NULL) AND (OPS_RigMoveManpower.FK_RouteSurveyId = @routesurveyid) 
                         AND (OPS_RigMoveManpower.FK_CraneOperatorId IS NULL) AND (OPS_RigMoveManpower.FK_ManpowerId IS NULL) AND 
                         (OPS_RigMoveManpower.FK_LBDriverId IS NULL) AND (OPS_RigMoveManpower.FK_FBDriverId IS NOT NULL) and OPS_RigMoveManpower.StatusFlag=1

	end
	else if(@manpowertype=9)
	begin

			SELECT        OPS_RigMoveManpower.RMManpowerId, OPS_RigMoveManpower.FK_LBDriverId, [HR.Employees].Name
FROM            OPS_RigMoveManpower INNER JOIN
                         OPS_LowbedDrivers ON OPS_RigMoveManpower.FK_LBDriverId = OPS_LowbedDrivers.LBDriverId INNER JOIN
                         [HR.Employees] ON OPS_LowbedDrivers.SAB_ID = [HR.Employees].SABId
WHERE        (OPS_RigMoveManpower.FK_WLOperatorId IS NULL) AND (OPS_RigMoveManpower.FK_CraneOperatorId IS NULL) AND 
                         (OPS_RigMoveManpower.FK_ManpowerId IS NULL) AND (OPS_RigMoveManpower.FK_FBDriverId IS NULL) AND 
                         (OPS_RigMoveManpower.FK_RouteSurveyId = @routesurveyid) AND (OPS_LowbedDrivers.StatusFlag = 2) AND 
                         (OPS_RigMoveManpower.FK_LBDriverId IS NOT NULL) and OPS_RigMoveManpower.StatusFlag=1
	end
    
END