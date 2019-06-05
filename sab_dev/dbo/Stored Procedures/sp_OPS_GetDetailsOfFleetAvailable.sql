-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_GetDetailsOfFleetAvailable]
	-- Add the parameters for the stored procedure here
	@vehicletype AS int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF(@vehicletype=0) -- Vehicle type is FLATBED
	begin

			SELECT       OPS_FlatbedJn.FBJnId, OPS_FlatbedJn.FK_FBId, OPS_FlatbedJn.FK_FBDriverId, OPS_FlatbedDrivers.SAB_ID, OPS_Flatbeds.PlateNo, 
						 OPS_Flatbeds.SAB_ID AS FlatbedId, [HR.Employees].Name
		    FROM         OPS_FlatbedJn INNER JOIN
						 OPS_Flatbeds ON OPS_FlatbedJn.FK_FBId = OPS_Flatbeds.FlatbedId INNER JOIN
						 OPS_FlatbedDrivers ON OPS_FlatbedJn.FK_FBDriverId = OPS_FlatbedDrivers.FBDriverId INNER JOIN
						 [HR.Employees] ON OPS_FlatbedDrivers.SAB_ID = [HR.Employees].SABId
		    WHERE        (OPS_FlatbedJn.StatusFlag = 1)
	END
	else if(@vehicletype=1)
	begin
			SELECT        OPS_LowbedJn.LBJnId, OPS_LowbedJn.FK_LBId, OPS_LowbedJn.FK_LBDriverId, [HR.Employees].SABId, OPS_Lowbeds.PlateNo, OPS_Lowbeds.Sab_Id AS LowbedId, [HR.Employees].Name
FROM            OPS_LowbedJn INNER JOIN
                         OPS_Lowbeds ON OPS_LowbedJn.FK_LBId = OPS_Lowbeds.LowbedId INNER JOIN
                         OPS_LowbedDrivers ON OPS_LowbedJn.FK_LBDriverId = OPS_LowbedDrivers.LBDriverId INNER JOIN
                         [HR.Employees] ON OPS_LowbedDrivers.SAB_ID = [HR.Employees].SABId
WHERE        (OPS_LowbedJn.StatusFlag = 1)

	END
    else if(@vehicletype=2)
	begin

	SELECT        OPS_CraneJn.CraneJnId, OPS_CraneJn.FK_CraneId, OPS_Cranes.PlateNo, OPS_Cranes.SAB_ID AS CraneId
	FROM            OPS_CraneJn INNER JOIN
                         OPS_Cranes ON OPS_CraneJn.FK_CraneId = OPS_Cranes.CraneId
	WHERE        (OPS_CraneJn.StatusFlag = 1)


--			SELECT        OPS_CraneJn.CraneJnId, OPS_CraneJn.FK_CraneId, OPS_CraneJn.FK_OperatorId, OPS_Cranes.PlateNo, OPS_Cranes.SAB_ID AS CraneId, 
--                         [HR.Employees].Name
--FROM            OPS_CraneOperators INNER JOIN
--                         OPS_CraneJn ON OPS_CraneOperators.OperatorID = OPS_CraneJn.FK_OperatorId INNER JOIN
--                         [HR.Employees] ON OPS_CraneOperators.SAB_ID = [HR.Employees].SABId INNER JOIN
--                         OPS_Cranes ON OPS_CraneJn.FK_CraneId = OPS_Cranes.CraneId
--WHERE        (OPS_CraneJn.StatusFlag = 1)

	END
     else if(@vehicletype=3)
	begin
			SELECT        OPS_WLJn.WLJnId, OPS_WLJn.FK_WLId, OPS_WLJn.FK_WLOperatorId, OPS_WL.PlateNo, OPS_WL.SAB_ID AS WLId, [HR.Employees].Name
FROM            OPS_WLJn INNER JOIN
                         OPS_WL ON OPS_WLJn.FK_WLId = OPS_WL.WLId INNER JOIN
                         OPS_WLOperators ON OPS_WLJn.FK_WLOperatorId = OPS_WLOperators.WLOperatorId INNER JOIN
                         [HR.Employees] ON OPS_WLOperators.SAB_ID = [HR.Employees].SABId
WHERE        (OPS_WLJn.StatusFlag = 1)

	END
    else if(@vehicletype=4)
	begin
			SELECT        OPS_LMVJn.LMVJn, OPS_LMVJn.FK_LMVID, OPS_LMVJn.FK_LMVDriverId, OPS_LMV.PlateNo, OPS_LMV.SAB_ID AS LMVId, [HR.Employees].Name, 
                         [HR.Employees].SABId
FROM            OPS_LMV INNER JOIN
                         OPS_LMVJn ON OPS_LMV.LMVId = OPS_LMVJn.FK_LMVID INNER JOIN
                         OPS_LMVDrivers ON OPS_LMVJn.FK_LMVDriverId = OPS_LMVDrivers.LMVDriverId INNER JOIN
                         [HR.Employees] ON OPS_LMVDrivers.SAB_ID = [HR.Employees].SABId
WHERE        (OPS_LMVJn.StatusFlag = 1)

	END
    else if(@vehicletype=5)
	begin
			SELECT        OPS_OFTJn.OFTJnId, OPS_OFTJn.FK_OFTId, OPS_OFTJn.FK_OFTDriverId, OPS_OFT.PlateNo, OPS_OFT.SAB_ID AS OFTId, OPS_OFTJn.StatusFlag
FROM            OPS_OFTJn INNER JOIN
                         OPS_OFT ON OPS_OFTJn.FK_OFTId = OPS_OFT.OFTId
WHERE        (OPS_OFTJn.StatusFlag = 1)

	END
    else if(@vehicletype=6)
	begin
			SELECT        OPS_Rentals.RentalsId, OPS_RentalTypes.TypeDescription AS RentalsType, OPS_Rentals.Name, OPS_Rentals.Owner, OPS_Rentals.PlateNo, 
                         OPS_Rentals.VehicleId
FROM            OPS_Rentals INNER JOIN
                         OPS_RentalTypes ON OPS_Rentals.FK_RentalTypeId = OPS_RentalTypes.RentalTypeId
WHERE        (OPS_Rentals.StatusFlag = 1)

	end
END