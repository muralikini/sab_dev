-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MDC_UpdateLoadAndCostDetails]
	-- Add the parameters for the stored procedure here
	@routesurveyid as int,
	@totalloads as int,
	@loaded1sidetrip as int,
	@empty1sidetrip as int,
	@fooddays as int,
	@foodrate as int,
	@extramobloadedlb as int,
	@extrademobloadedlb as int,
	@manpower AS INT,
	@maintainance as float
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @returnstatus int
    -- Insert statements for procedure here
	-- Update 

	DECLARE @loadid INT
	DECLARE @costid INT
	DECLARE @flag INT

	SELECT @loadid=dbo.MDC_LoadDetails.MDC_ID
	FROM dbo.MDC_LoadDetails
	WHERE FK_RouteSurveyId=@routesurveyid

	SELECT @costid=MDC_AddOnCostId
	FROM dbo.MDC_AddOnCost
	WHERE FK_RouteSurveyId=@routesurveyid

	IF(@loadid IS NULL AND @costid IS NULL)
		SET @flag=0
	ELSE
		SET @flag=1


	if(@flag=1)
	begin
		BEGIN try
			begin transaction
				update MDC_LoadDetails
				set
				TotalLoads=@totalloads,
				Loaded1SideTrip=@loaded1sidetrip,
				Empty1SideTrip=@empty1sidetrip
				where FK_RouteSurveyId=@routesurveyid


				update MDC_AddOnCost
				set
				FoodDays = @fooddays,
				FoodRate = @foodrate,
				ExtraMobLoadedLB=@extramobloadedlb,
				ExtraDemobLoadedLB =@extrademobloadedlb,
				Manpower=@manpower,
				Maintainance=@maintainance
				where FK_RouteSurveyId=@routesurveyid

				set @returnstatus=1
			commit transaction
		end try
		begin catch
			set @returnstatus =0
			rollback transaction
		end catch
	end
	-- Insert Data
	else if(@flag=0)
	begin
	begin try
				BEGIN TRANSACTION
				insert MDC_LoadDetails
				(FK_RouteSurveyId,TotalLoads,Loaded1SideTrip,Empty1SideTrip,DateOfCreation,Statusflag)
				values (@routesurveyid,@totalloads,@loaded1sidetrip,@empty1sidetrip,GETDATE(),1)
				
				insert MDC_AddOnCost
				(FK_RouteSurveyId,FoodDays,FoodRate,ExtraMobLoadedLB,ExtraDemobLoadedLB,Manpower,Maintainance,DateOfCreation,StatusFlag) 
				values(@routesurveyid,@fooddays, @foodrate,@extramobloadedlb,@extrademobloadedlb,@manpower,@maintainance,Getdate(),1)

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