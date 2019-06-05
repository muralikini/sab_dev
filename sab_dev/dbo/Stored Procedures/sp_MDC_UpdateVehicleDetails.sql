-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MDC_UpdateVehicleDetails] 
	-- Add the parameters for the stored procedure here
	@routesurveyid as int,
	@totalfb as int,
	@totallb as int,
	@totallbwithload as int,
	@lmv as int,
	@rentalfb as int,
	@rentallb as int,
	@rentallbwithload as int,
	@rentallmv as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @returnstatus int
    -- Insert statements for procedure here

	DECLARE @rentalId INT
	DECLARE @vehicleId INT
	DECLARE @flag int

	SELECT @vehicleId=MDC_VehilcleDetailsId
	FROM dbo.MDC_VehicleDetails
	WHERE FK_RouteSurveyId=@routesurveyid

	SELECT @rentalId=MDC_RentalVehicleDetails.MDC_RentalDetailsID
	FROM dbo.MDC_RentalVehicleDetails
	WHERE FK_RouteSurveyId=@routesurveyid

	IF(@vehicleId IS NULL AND @rentalId IS NULL)
		SET @flag=0
	ELSE
		SET @flag=1

	if(@flag=1)
	begin
	Begin try

	
		begin transaction
			
			update MDC_VehicleDetails
			set Flatbed=@totalfb,
				Lowbed=@totallb,
				LBwithLoad=@totallbwithload,
				LMV = @lmv
			where
				FK_RouteSurveyId = @routesurveyid


			update MDC_RentalVehicleDetails
			set Flatbed=@rentalFB,
				Lowbed=@rentallb,
				LBwithLoad=@rentallbwithload,
				LMV = @rentallmv
			where
				FK_RouteSurveyId = @routesurveyid
				
				
				set @returnstatus=1

		commit transaction

			
	end try
	begin catch

		set @returnstatus=0
		rollback transaction
		
	end catch
	end
	else if(@flag=0)
	begin
	Begin try

	
		begin transaction
			
			insert into MDC_VehicleDetails
			(FK_RouteSurveyId,Flatbed,Lowbed,LBwithLoad,LMV,DateOfCreation,StatusFlag)
			values(@routesurveyid,@totalfb,@totallb,@totallbwithload,@lmv,getdate(),1)


			insert into MDC_RentalVehicleDetails
			(FK_RouteSurveyId,Flatbed,Lowbed,LBwithLoad,LMV,DateOfCreation,StatusFlag)
			values(@routesurveyid,@rentalFB,@rentallb,@rentallbwithload,@rentallmv,getdate(),1)
							
			set @returnstatus=1

		commit transaction

			
	end try
	begin catch

		set @returnstatus=0
		rollback transaction
		
	end catch
	end
END
return @returnstatus