-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_GetManPowerFilters]
--0 to get all distinct types of designations
--1 to get all CONVOY types
--2 to get all RiGGER
--3 to get all SAFETY
--4 to get all SUPPORT
--5 to get all TRUCKPUSHER

	@filtertype INT,
	@filtervalue INT=null
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	declare @manpowertype table
	(ManPowerType  nvarchar(50))

	IF(@filtertype>0 and @filtertype<6 AND @filtervalue IS null)
	BEGIN
		SELECT        OPS_Manpower.ManPowerId, OPS_Manpower.SAB_ID, [HR.Employees].Name, OPS_Manpower.StatusFlag
		FROM            OPS_Manpower INNER JOIN
                         [HR.Employees] ON OPS_Manpower.SAB_ID = [HR.Employees].SABId
		WHERE        (OPS_Manpower.StatusFlag = 1) AND
        OPS_Manpower.ManPowerType = 
		CASE
			WHEN @filtertype=1 THEN  'CONVOY'
			WHEN @filtertype=2 THEN  'RIGGER'
			WHEN @filtertype=3 THEN  'SAFETY'
			WHEN @filtertype=4 THEN  'SUPPORT'
			WHEN @filtertype=5 THEN  'TRUCKPUSHER'
		END;

	END

	if(@filtertype=6 and @filtervalue is null)
		begin

			SELECT        OPS_CraneOperators.OperatorID as ManpowerId, 'CRANE OPERATOR' as ManPowerType, [HR.Employees].Name
			FROM            OPS_CraneOperators INNER JOIN
							 [HR.Employees] ON OPS_CraneOperators.SAB_ID = [HR.Employees].SABId
			WHERE        (OPS_CraneOperators.StatusFlag = 0)


		end
	if(@filtertype=7 and @filtervalue is null)
		begin

			SELECT        OPS_WLOperators.WLOperatorId as ManpowerId,'WL OPERATOR' AS ManPowerType, [HR.Employees].Name 
			FROM            [HR.Employees] INNER JOIN
							 OPS_WLOperators ON [HR.Employees].SABId = OPS_WLOperators.SAB_ID
			WHERE        (OPS_WLOperators.StatusFlag = 0)


		end
	if(@filtertype=8 and @filtervalue is null)
		begin

			SELECT        OPS_FlatbedDrivers.FBDriverId AS ManpowerId, 'Flatbed Driver' AS ManPowerType, [HR.Employees].Name
			FROM            [HR.Employees] INNER JOIN
                         OPS_FlatbedDrivers ON [HR.Employees].SABId = OPS_FlatbedDrivers.SAB_ID
			WHERE        (OPS_FlatbedDrivers.StatusFlag = 0)


		end
    if(@filtertype=9 and @filtervalue is null)
		begin

			SELECT        OPS_LowbedDrivers.LBDriverId AS ManpowerId, 'Lowbed Driver' AS ManPowerType, [HR.Employees].Name
			FROM            [HR.Employees] INNER JOIN
                         OPS_LowbedDrivers ON [HR.Employees].SABId = OPS_LowbedDrivers.SAB_ID
			WHERE        (OPS_LowbedDrivers.StatusFlag = 0)


		end

	IF(@filtertype=0 AND @filtervalue IS null)
	BEGIN
		insert into @manpowertype
		SELECT DISTINCT ManPowerType FROM OPS_manPower

		insert into @manpowertype
		values('CRANE OPERATOR')

		insert into @manpowertype
		values('WL OPERATOR')

		insert into @manpowertype
		values('FB DRIVER')

		insert into @manpowertype
		values('LB DRIVER')

		select * from @manpowertype

	END

	
    
	
	IF(@filtertype>0 AND @filtervalue IS NOT NULL)
	BEGIN

		    
		SELECT        OPS_RigMoveManpower.RMManpowerId, OPS_RigMoveManpower.FK_RouteSurveyId, OPS_RigMoveManpower.FK_ManpowerId, [HR.Employees].Name
		FROM            OPS_RigMoveManpower INNER JOIN
                         OPS_Manpower ON OPS_RigMoveManpower.FK_ManpowerId = OPS_Manpower.ManPowerId INNER JOIN
                         [HR.Employees] ON OPS_Manpower.SAB_ID = [HR.Employees].SABId
		WHERE          (OPS_RigMoveManpower.StatusFlag = 1) AND
        OPS_Manpower.ManPowerType = 
		CASE
			WHEN @filtervalue=1 THEN  'CONVOY'
			WHEN @filtervalue=2 THEN  'RIGGER'
			WHEN @filtervalue=3 THEN  'SAFETY'
			WHEN @filtervalue=4 THEN  'SUPPORT'
			WHEN @filtervalue=5 THEN  'TRUCKPUSHER'
		END;

		

	END
    
 

   
END