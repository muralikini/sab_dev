-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_GetFleetStats]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Declare @MyTableVar table
     (Description nvarchar(max),
      Count int)

	  declare @count int
    -- Insert statements for procedure here
	------- Lowbed stats
	select @count=count(*) from OPS_Lowbeds
	insert @MyTableVar 	values 	('Total Lowbeds Available',@count)

	select @count=count(*)   from OPS_Lowbeds where StatusFlag=0
	insert @MyTableVar 	values 	('Total LowBeds Idle',@count)

	select @count=count(*)   from OPS_LowbedDrivers
	insert @MyTableVar 	values 	('Total LowBed Drivers Available',@count)
	

	select @count=count(*)   from OPS_LowbedDrivers where StatusFlag=0
	insert @MyTableVar 	values 	('Total LowBed Drivers Idle',@count)

	select @count=count(*) from OPS_RigMoveLowbeds where StatusFlag=1
	insert @MyTableVar 	values 	('Total LowBed in RigMove',@count)

	select @count=count(*) from OPS_LowbedJn 
	insert @MyTableVar 	values 	('Total Lowbeds available for RigMove',@count)
	---Flatbed Stats
	select @count=count(*)  from OPS_Flatbeds
	insert @MyTableVar 	values 	('Total FlatBeds Available',@count)

	select @count=count(*)   from OPS_Flatbeds where StatusFlag=0
	insert @MyTableVar 	values 	('Total Flat Beds Idle',@count)

	select @count=count(*)   from OPS_FlatbedDrivers
	insert @MyTableVar 	values 	('Total FlatBed Drivers Available',@count)

	select @count=count(*)   from OPS_FlatbedDrivers where StatusFlag=0
	insert @MyTableVar 	values 	('Total FlatBed Drivers Idle',@count)

	select @count=count(*) from OPS_RigMoveFlatbeds where StatusFlag=1
	insert @MyTableVar 	values 	('Total Flatbed in Rigmove',@count)

	select @count=count(*) from OPS_FlatbedJn 
	insert @MyTableVar 	values 	('Total Flatbeds available for RigMove',@count)

	---Crane Stats
	select @count=count(*)  from dbo.OPS_Cranes
	insert @MyTableVar 	values 	('Total Cranes Available',@count)

	select @count=count(*)   from OPS_Cranes where StatusFlag=0
	insert @MyTableVar 	values 	('Total Cranes Idle',@count)

	select @count=count(*)   from dbo.OPS_CraneOperators
	insert @MyTableVar 	values 	('Total Crane Operators Available',@count)

	select @count=count(*)   from dbo.OPS_CraneOperators where StatusFlag=0 AND dbo.OPS_CraneOperators.CertificationStatus=1
	insert @MyTableVar 	values 	('Total Crane Operators Idle',@count)

	select @count=count(*)   from dbo.OPS_CraneOperators where StatusFlag=0 AND dbo.OPS_CraneOperators.CertificationStatus=0
	insert @MyTableVar 	values 	('Total Crane Operators whose Certificates have expired',@count)

	select @count=count(*) from OPS_Cranes where StatusFlag=1
	insert @MyTableVar 	values 	('Total Cranes in Rigmove',@count)

	select @count=count(*) from dbo.OPS_CraneJn 
	insert @MyTableVar 	values 	('Total Cranes available for RigMove',@count)

	---Wheel Loader Stats
	select @count=count(*)  from dbo.OPS_WL
	insert @MyTableVar 	values 	('Total Wheel Loaders Available',@count)

	select @count=count(*)   from OPS_WL where StatusFlag=0
	insert @MyTableVar 	values 	('Total Wheel Loaders Idle',@count)

	select @count=count(*)   from dbo.OPS_WLOperators
	insert @MyTableVar 	values 	('Total Wheel Loader Operators Available',@count)

	select @count=count(*)   from dbo.OPS_WLOperators where StatusFlag=0 AND dbo.OPS_WLOperators.CertificationStatus=1
	insert @MyTableVar 	values 	('Total Wheel Loader Operators Idle',@count)

	select @count=count(*)   from dbo.OPS_WLOperators where StatusFlag=0 AND dbo.OPS_WLOperators.CertificationStatus=0
	insert @MyTableVar 	values 	('Total Wheel Loader Operators whose Certificates have expired',@count)

	select @count=count(*) from OPS_WL where StatusFlag=1
	insert @MyTableVar 	values 	('Total Wheel Loaders in Rigmove',@count)

	select @count=count(*) from dbo.OPS_WLJn 
	insert @MyTableVar 	values 	('Total Wheel Loaders available for RigMove',@count)

	---LMV Stats
	select @count=count(*)  from dbo.OPS_LMV
	insert @MyTableVar 	values 	('Total LMV Available',@count)

	select @count=count(*)   from OPS_LMV where StatusFlag=0
	insert @MyTableVar 	values 	('Total LMV Idle',@count)

	select @count=count(*)   from dbo.OPS_LMVDrivers
	insert @MyTableVar 	values 	('Total LMV Drivers Available',@count)

	select @count=count(*)   from dbo.OPS_LMVDrivers where StatusFlag=0 
	insert @MyTableVar 	values 	('Total LMV Drivers Idle',@count)

	
	select @count=count(*) from OPS_LMV where StatusFlag=1
	insert @MyTableVar 	values 	('Total LMV in Rigmove',@count)

	select @count=count(*) from dbo.OPS_LMVJn 
	insert @MyTableVar 	values 	('Total LMV available for RigMove',@count)

	---Oil Field Trucks
	select @count=count(*)  from dbo.OPS_OFT
	insert @MyTableVar 	values 	('Total Oil Field Trucks Available',@count)

	select @count=count(*)   from OPS_OFT where StatusFlag=0
	insert @MyTableVar 	values 	('Total Oil Field Trucks Idle',@count)

		
	select @count=count(*) from OPS_OFT where StatusFlag=1
	insert @MyTableVar 	values 	('Total Oil Field Trucks in Rigmove',@count)

	---Rental Trucks Stats
	select @count=count(*)  from dbo.OPS_Rentals WHERE StatusFlag>=1
	insert @MyTableVar 	values 	('Total Rentals Available',@count)

	select @count=count(*)   from OPS_Rentals where StatusFlag=1
	insert @MyTableVar 	values 	('Total Rentals Idle',@count)

	select @count=count(*)   from OPS_Rentals where StatusFlag=2
	insert @MyTableVar 	values 	('Total Rentals in Rig Move',@count)

	

	select * from @MyTableVar
END