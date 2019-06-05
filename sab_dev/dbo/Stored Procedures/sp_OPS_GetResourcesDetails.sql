-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_GetResourcesDetails] 
	-- Add the parameters for the stored procedure here
	-- 0 =FB, 1=LB 2=Cranes 3=WL, 4=Oil Field Trucks 5 = Misc
	@vehiceltype AS INT, 
	-- 0 = Not required, 1=Required
	@resources AS INT=null,
	@flag AS int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- Flatbed
	IF(@vehiceltype=0 AND @resources=0 AND @flag=0)
	BEGIN
		SELECT        FlatbedId, SAB_ID
		FROM            OPS_Flatbeds
		WHERE        (StatusFlag = 0)
    
	END
	IF(@vehiceltype=0 AND @resources=1 AND @flag=0)
	BEGIN
		SELECT        OPS_FlatbedDrivers.FBDriverId, [HR.Employees].Name, OPS_FlatbedDrivers.SAB_ID
		FROM            OPS_FlatbedDrivers INNER JOIN
                         [HR.Employees] ON OPS_FlatbedDrivers.SAB_ID = [HR.Employees].SABId
		WHERE        (OPS_FlatbedDrivers.StatusFlag = 0)

    
	END
	-- Lowbed
	IF(@vehiceltype=1 AND @resources=0 AND @flag=0)
	BEGIN
		SELECT        LowbedId, Sab_Id
		FROM            OPS_Lowbeds
		WHERE        (StatusFlag = 0)
    
	END
	IF(@vehiceltype=1 AND @resources=1 AND @flag=0)
	BEGIN
		SELECT        OPS_LowbedDrivers.LBDriverId, [HR.Employees].Name, OPS_LowbedDrivers.SAB_ID
		FROM            OPS_LowbedDrivers INNER JOIN
                         [HR.Employees] ON OPS_LowbedDrivers.SAB_ID = [HR.Employees].SABId
		WHERE        (OPS_LowbedDrivers.StatusFlag = 0)

    
	END

	-- Crane
	IF(@vehiceltype=2 AND @resources=0 AND @flag=0)
	BEGIN
		SELECT        CraneId, Sab_Id
		FROM            OPS_Cranes
		WHERE        (StatusFlag = 0)
    
	END
	IF(@vehiceltype=2 AND @resources=1 AND @flag=0)
	BEGIN
		SELECT        OPS_CraneOperators.OperatorID, [HR.Employees].Name, OPS_CraneOperators.SAB_ID
		FROM            dbo.OPS_CraneOperators INNER JOIN
                         [HR.Employees] ON OPS_CraneOperators.SAB_ID = [HR.Employees].SABId
		WHERE        (OPS_CraneOperators.StatusFlag = 0) AND (OPS_CraneOperators.CertificationStatus=1)

    
	END

	-- Wheel Loaders
	IF(@vehiceltype=3 AND @resources=0 AND @flag=0)
	BEGIN
		SELECT        WLId, Sab_ID
		FROM            OPS_WL
		WHERE        (StatusFlag = 0)
    
	END
	IF(@vehiceltype=3 AND @resources=1 AND @flag=0)
	BEGIN
		SELECT        OPS_WLOperators.WLOperatorID, [HR.Employees].Name, OPS_WLOperators.SAB_ID
		FROM            dbo.OPS_WLOperators INNER JOIN
                         [HR.Employees] ON OPS_WLOperators.SAB_ID = [HR.Employees].SABId
		WHERE        (OPS_WLOperators.StatusFlag = 0) AND (OPS_WLOperators.CertificationStatus=1)

    
	END

	-- LMV
	IF(@vehiceltype=4 AND @resources=0 AND @flag=0)
	BEGIN
		SELECT        LMVId, SAB_ID
		FROM            OPS_LMV
		WHERE        (StatusFlag = 0)
    
	END
	IF(@vehiceltype=4 AND @resources=1 AND @flag=0)
	BEGIN
		SELECT        OPS_LMVDrivers.LMVDriverId, [HR.Employees].Name, OPS_LMVDrivers.SAB_ID
		FROM            dbo.OPS_LMVDrivers INNER JOIN
                         [HR.Employees] ON OPS_LMVDrivers.SAB_ID = [HR.Employees].SABId
		WHERE        (OPS_LMVDrivers.StatusFlag = 0) 

    
	END
	-- Oil Field Trucks
    IF(@vehiceltype=5 AND @resources=0 AND @flag=0)
	BEGIN
		SELECT        OFTId, SAB_ID
		FROM            OPS_OFT
		WHERE        (StatusFlag = 0)
    
	END
	IF(@vehiceltype=5 AND @resources=1 AND @flag=0)
	BEGIN
		SELECT        OPS_LowbedDrivers.LBDriverId, [HR.Employees].Name, OPS_LowbedDrivers.SAB_ID
		FROM            OPS_LowbedDrivers INNER JOIN
                         [HR.Employees] ON OPS_LowbedDrivers.SAB_ID = [HR.Employees].SABId
		WHERE        (OPS_LowbedDrivers.StatusFlag = 0)

    
	END

	--------Code to return the trucks that are already linked and that needs to be unlinked
	IF(@vehiceltype=0 AND @resources IS null AND @flag=1)
	BEGIN
		SELECT        OPS_FlatbedJn.FK_FBId AS FlatbedId, OPS_FlatbedJn.FK_FBDriverId AS DriverId, OPS_Flatbeds.SAB_ID AS FlatbedNo, OPS_FlatbedDrivers.SAB_ID AS DriverNo, 
                         [HR.Employees].Name AS DriverName
		FROM            OPS_FlatbedJn INNER JOIN
                         OPS_FlatbedDrivers ON OPS_FlatbedJn.FK_FBDriverId = OPS_FlatbedDrivers.FBDriverId INNER JOIN
                         OPS_Flatbeds ON OPS_FlatbedJn.FK_FBId = OPS_Flatbeds.FlatbedId INNER JOIN
                         [HR.Employees] ON OPS_FlatbedDrivers.SAB_ID = [HR.Employees].SABId
		WHERE        (OPS_FlatbedJn.StatusFlag = 1)
	END
	
	-- Lowbed
	IF(@vehiceltype=1 AND @resources IS null AND @flag=1)
	BEGIN
		SELECT        OPS_LowbedJn.FK_LBId AS LowbedId, OPS_LowbedJn.FK_LBDriverId AS DriverId, OPS_Lowbeds.Sab_Id AS LowbedNo, OPS_LowbedDrivers.SAB_ID AS DriverNo, 
                         [HR.Employees].Name AS DriverName
		FROM            OPS_Lowbeds INNER JOIN
                         OPS_LowbedJn ON OPS_Lowbeds.LowbedId = OPS_LowbedJn.FK_LBId INNER JOIN
                         OPS_LowbedDrivers ON OPS_LowbedJn.FK_LBDriverId = OPS_LowbedDrivers.LBDriverId INNER JOIN
                         [HR.Employees] ON OPS_LowbedDrivers.SAB_ID = [HR.Employees].SABId
		WHERE        (OPS_LowbedJn.StatusFlag = 1)
    
	END
	
	-- Crane
	IF(@vehiceltype=2 AND @resources IS null AND @flag=1)
	BEGIN
		SELECT        OPS_CraneJn.FK_CraneId AS CraneId, OPS_CraneJn.FK_OperatorId AS OperatorId, OPS_Cranes.SAB_ID AS CraneNo, OPS_CraneOperators.SAB_ID AS OperatorNo, 
                         [HR.Employees].Name AS OperatorName
		FROM            OPS_CraneOperators INNER JOIN
                         OPS_CraneJn ON OPS_CraneOperators.OperatorID = OPS_CraneJn.FK_OperatorId INNER JOIN
                         [HR.Employees] ON OPS_CraneOperators.SAB_ID = [HR.Employees].SABId INNER JOIN
                         OPS_Cranes ON OPS_CraneJn.FK_CraneId = OPS_Cranes.CraneId
						 WHERE        (OPS_CraneJn.StatusFlag = 1)
    
	END
	
	-- Wheel Loaders
	IF(@vehiceltype=3 AND @resources IS null AND @flag=1)
	BEGIN
		SELECT        OPS_WLJn.FK_WLId AS WheelLoaderId, OPS_WLJn.FK_WLOperatorId AS OperatorId, OPS_WL.SAB_ID AS WheelLoaderNo, 
                         OPS_WLOperators.SAB_ID AS OperatorNo, [HR.Employees].Name AS OperatorName
FROM            OPS_WL INNER JOIN
                         OPS_WLJn ON OPS_WL.WLId = OPS_WLJn.FK_WLId INNER JOIN
                         OPS_WLOperators ON OPS_WLJn.FK_WLOperatorId = OPS_WLOperators.WLOperatorId INNER JOIN
                         [HR.Employees] ON OPS_WLOperators.SAB_ID = [HR.Employees].SABId
WHERE        (OPS_WLJn.StatusFlag = 1)
    
	END
	

	-- LMV
	IF(@vehiceltype=4 AND @resources IS null AND @flag=1)
	BEGIN
		SELECT        OPS_LMVJn.FK_LMVID AS LMVId, OPS_LMVJn.FK_LMVDriverId AS DriverId, OPS_LMV.SAB_ID AS LMVNo, OPS_LMVDrivers.SAB_ID AS DriverNo, 
                         [HR.Employees].Name AS DriverName
FROM            OPS_LMV INNER JOIN
                         OPS_LMVJn ON OPS_LMV.LMVId = OPS_LMVJn.FK_LMVID INNER JOIN
                         OPS_LMVDrivers ON OPS_LMVJn.FK_LMVDriverId = OPS_LMVDrivers.LMVDriverId INNER JOIN
                         [HR.Employees] ON OPS_LMVDrivers.SAB_ID = [HR.Employees].SABId
WHERE        (OPS_LMVJn.StatusFlag = 1)
    
	END
	
	-- Oil Field Trucks
    IF(@vehiceltype=5 AND @resources IS null AND @flag=1)
	BEGIN
		SELECT        OPS_OFTJn.FK_OFTId AS OFTId, OPS_OFT.SAB_ID AS OFTNo, OPS_OFT.Make, OPS_OFT.PlateNo
		FROM            OPS_OFT INNER JOIN
                         OPS_OFTJn ON OPS_OFT.OFTId = OPS_OFTJn.FK_OFTId
		WHERE        (OPS_OFTJn.StatusFlag = 1)
	END
	


END