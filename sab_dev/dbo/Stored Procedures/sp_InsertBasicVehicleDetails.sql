-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertBasicVehicleDetails] 
	-- Add the parameters for the stored procedure here
	@vehicleid int,
	@vehiceltype varchar(50),
	@vehiclecategory varchar(50),
	@manufacturer varchar(50),
	@insurancedate date,
	@insurancehijry varchar(50),
	@estemaradate date,
	@estemarahijry varchar(50),
	@tasreehdate date,
	@tasreehijry varchar(50),
	@meezandate date,
	@meezanhijry varchar(50),
	@fahasdate date,
	@fahashijry varchar(50),
	@aramcodate date,
	@aramcohijry varchar(50)


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @vehid int
	declare @vehtypeid int
	declare @categoryid int
	declare @insuranceid int
	declare @estemaraid int
	declare @tasreehid int
	declare @meezanid int
	declare @fahasid int
	declare @aramcoid int

	declare @regval int

	--if(@vehiceltype is not null)
	--begin

	--	select @vehtypeid=VehicleTypeId from VehicleTypes where Type=@vehiceltype
	--	if(@vehtypeid is NULL)
	--	begin

	--	insert into VehicleTypes
	--	([Type],[TimeStamp])
	--	values (@vehiceltype,getdate())

	--	select @vehtypeid=VehicleTypeId from VehicleTypes where Type=UPPER(@vehiceltype)

	--	end


	--end

	if(@vehiclecategory is not null)
	begin

		select @categoryid=CategoryId from VehiclesCategory where Name=@vehiclecategory
		if(@categoryid is NULL)
		begin

		insert into VehiclesCategory
		(Name,Manufacturer)
		values ((@vehiclecategory),@manufacturer)

		select @categoryid=CategoryId from VehiclesCategory where Name=upper(@vehiclecategory)

		end


	end

	if(@insurancedate is not null)
	begin

		select @insuranceid=InsuranceId from Vehicleinsurance where ExpiryDate=@insurancedate and ExpiryHijri=@insurancehijry
		if(@insuranceid is NULL)
		begin

		insert into Vehicleinsurance
		(ExpiryDate,ExpiryHijri)
		values (@insurancedate,@insurancehijry)

		select @insuranceid=InsuranceId from Vehicleinsurance where ExpiryDate=@insurancedate and ExpiryHijri=@insurancehijry

		end


	end

	if(@estemaradate is not null)
	begin

		select @estemaraid= EstemaraId from VehicleEstemara where ExpiryDate=@estemaradate and ExpiryHijri=@estemarahijry
		if(@estemaraid is NULL)
		begin

		insert into VehicleEstemara
		(ExpiryDate,ExpiryHijri)
		values (@estemaradate,@estemarahijry)

		select @estemaraid= EstemaraId from VehicleEstemara where ExpiryDate=@estemaradate and ExpiryHijri=@estemarahijry

		end


	end

	if(@tasreehdate is not null)
	begin

		select @tasreehid= TasreehId from TasreehDetails where ExpiryDate=@tasreehdate and ExpiryHijri=@tasreehijry
		if(@tasreehid is NULL)
		begin

		insert into TasreehDetails
		(ExpiryDate,ExpiryHijri)
		values (@tasreehdate,@tasreehijry)

		select @tasreehid= TasreehId from TasreehDetails where ExpiryDate=@tasreehdate and ExpiryHijri=@tasreehijry

		end


	end

	if(@meezandate is not null)
	begin

		select @meezanid= MeezanDetailsId from MeezanDetails where ExpiryDate=@meezandate and ExpiryHijri=@meezanhijry
		if(@meezanid is NULL)
		begin

		insert into MeezanDetails
		(ExpiryDate,ExpiryHijri)
		values (@meezandate,@meezanhijry)

		select @meezanid= MeezanDetailsId from MeezanDetails where ExpiryDate=@meezandate and ExpiryHijri=@meezanhijry

		end


	end

	if(@fahasdate is not null)
	begin

		select @fahasid= FahasId from FahasDetails where ExpiryDate=@fahasdate and ExpiryHijri=@fahashijry
		if(@fahasid is NULL)
		begin

		insert into FahasDetails
		(ExpiryDate,ExpiryHijri)
		values (@fahasdate,@fahashijry)

		select @fahasid= FahasId from FahasDetails where ExpiryDate=@fahasdate and ExpiryHijri=@fahashijry

		end


	end

	--if(@aramcodate is not null)
	--begin

	--	select @aramcoid= AramcoInspectionId from AramcoInspectionDetails where ExpiryDate=@aramcodate and ExpiryHijri=@aramcohijry
	--	if(@aramcoid is NULL)
	--	begin

	--	insert into AramcoInspectionDetails
	--	(ExpiryDate,ExpiryHijri)
	--	values (@aramcodate,@aramcohijry)

	--	select @aramcoid= AramcoInspectionId from AramcoInspectionDetails where ExpiryDate=@aramcodate and ExpiryHijri=@aramcohijry

	--	end


	--end
	if(@vehicleid is not null)
	begin
	INSERT INTO [dbo].[VehicleJunction]
           ([FK_VehicleId]
           ,[FK_InsuranceId]
           --,[FK_VehicleTypeId]
           ,[FK_VehicleCategoryId]
           ,[FK_MeezanDetailsId]
           ,[FK_FahasDetailsId]
           ,[Fk_EstemaraId]
           ,[FK_TasreehId])
		  --[FK_AramcoExpiryId])
     VALUES
           (@vehicleid,
		   @insuranceid,
		  -- @vehtypeid,
		   @categoryid,
		    @meezanid,
			 @fahasid,
		   @estemaraid,
		   @tasreehid)
		   -- @aramcoid)

			select @vehid=[VehicleJunctionId] from VehicleJunction
			where
			([FK_InsuranceId]=@insuranceid and
			[FK_VehicleTypeId]=@vehtypeid and
			[FK_VehicleCategoryId]=@categoryid and
			[FK_MeezanDetailsId]=@meezanid and
			[FK_FahasDetailsId]=@fahasid and
			[Fk_EstemaraId]=@estemaraid and
			[FK_TasreehId]=@tasreehid and
			[FK_AramcoExpiryId]=@aramcoid)
end

			if(@vehid is not null)
				set @regval= 1
			else
				set @regval=  0

    end
	
return @regval