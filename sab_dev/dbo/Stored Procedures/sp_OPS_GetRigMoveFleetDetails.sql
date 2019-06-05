-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_OPS_GetRigMoveFleetDetails
	-- Add the parameters for the stored procedure here
	@vehicletype AS INT
as	
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    IF(@vehicletype=0)
	BEGIN
		SELECT        OPS_FlatbedJn.FBJnId, OPS_FlatbedJn.FK_FBId, OPS_FlatbedJn.FK_FBDriverId, [HR.Employees].Name, OPS_Flatbeds.SAB_ID AS FlatbedId
		FROM            OPS_FlatbedJn INNER JOIN
                         OPS_Flatbeds ON OPS_FlatbedJn.FK_FBId = OPS_Flatbeds.FlatbedId INNER JOIN
                         OPS_FlatbedDrivers ON OPS_FlatbedJn.FK_FBDriverId = OPS_FlatbedDrivers.FBDriverId INNER JOIN
                         [HR.Employees] ON OPS_FlatbedDrivers.SAB_ID = [HR.Employees].SABId
		WHERE        (OPS_FlatbedJn.StatusFlag = 1)

	end
END