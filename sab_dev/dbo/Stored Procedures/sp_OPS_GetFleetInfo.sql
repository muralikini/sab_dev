-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_OPS_GetFleetInfo
	-- Add the parameters for the stored procedure here
	@type int,
	@resource int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if(@type =0 and @resource =0)
	begin
		SELECT        SAB_ID, PlateNo, StatusFlag
		FROM            OPS_Flatbeds
	end
	else if(@type =0 and @resource =1)
	begin
		SELECT        'Flatbed Drivers' as Designation,OPS_FlatbedDrivers.SAB_ID, [HR.Employees].Name, OPS_FlatbedDrivers.StatusFlag
		FROM            OPS_FlatbedDrivers INNER JOIN
                         [HR.Employees] ON OPS_FlatbedDrivers.SAB_ID = [HR.Employees].SABId
	end
	if(@type =1 and @resource =0)
	begin
		SELECT        Sab_Id, PlateNo, StatusFlag
		FROM            OPS_Lowbeds
	end
	else if(@type =1 and @resource =1)
	begin
		SELECT        'Lowbed Drivers' as Designation,OPS_LowbedDrivers.SAB_ID, [HR.Employees].Name, OPS_LowbedDrivers.StatusFlag
		FROM            OPS_LowbedDrivers INNER JOIN
                         [HR.Employees] ON OPS_LowbedDrivers.SAB_ID = [HR.Employees].SABId
	end
	if(@type =2 and @resource =0)
	begin
		SELECT        SAB_ID, PlateNo, StatusFlag
		FROM            OPS_Cranes
	end
	else if(@type =2 and @resource =1)
	begin
		SELECT        'Crane Operators' as Designation,OPS_CraneOperators.SAB_ID, [HR.Employees].Name, OPS_CraneOperators.StatusFlag
		FROM            OPS_CraneOperators INNER JOIN
                         [HR.Employees] ON OPS_CraneOperators.SAB_ID = [HR.Employees].SABId
	end
	if(@type =3 and @resource =0)
	begin
		SELECT        SAB_ID, PlateNo, StatusFlag
		FROM            OPS_WL
	end
	else if(@type =3 and @resource =1)
	begin
		SELECT        'WL Operators' as Designation,OPS_WLOperators.SAB_ID, OPS_WLOperators.StatusFlag, OPS_WLOperators.CertificationStatus, [HR.Employees].Name
		FROM            OPS_WLOperators INNER JOIN
                         [HR.Employees] ON OPS_WLOperators.SAB_ID = [HR.Employees].SABId
	end
	if(@type =4 and @resource =0)
	begin
		SELECT        SAB_ID, PlateNo, StatusFlag
		FROM            OPS_LMV
	end
	else if(@type =4 and @resource =1)
	begin
		SELECT        'LMV Operators' as Designation,OPS_LMVDrivers.SAB_ID, [HR.Employees].Name, OPS_LMVDrivers.StatusFlag
		FROM            OPS_LMVDrivers INNER JOIN
                         [HR.Employees] ON OPS_LMVDrivers.SAB_ID = [HR.Employees].SABId
	end
	if(@type =5 and @resource =0)
	begin
		SELECT        SAB_ID, PlateNo, StatusFlag
		FROM            OPS_OFT
	end
	if(@type =6 and @resource =0)
	begin
		SELECT        Name, PlateNo, StatusFlag
		FROM            OPS_Rentals
	end
	if(@type =7 and @resource =1)
	begin
		SELECT        'Manpower' as Designation, OPS_Manpower.ManPowerType, [HR.Employees].Name, OPS_Manpower.SAB_ID, OPS_Manpower.StatusFlag
		FROM            OPS_Manpower INNER JOIN
                         [HR.Employees] ON OPS_Manpower.SAB_ID = [HR.Employees].SABId
		ORDER BY OPS_Manpower.ManPowerType
	end
	
END