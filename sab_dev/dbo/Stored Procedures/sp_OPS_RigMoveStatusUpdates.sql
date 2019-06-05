-- =============================================
-- Author:		Muralidhar Kini
-- Create date: 2019/02/19
-- Description:	This SP updates the status of the rig move.
-- This updates both the 'RiG Move Status Table' as well as the 'Road Survey Table'
-- Daily Load updates are also tracked here
-- We can use this SP either to insert new records or to modify a previous update
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_RigMoveStatusUpdates]
	-- Add the parameters for the stored procedure here
	@routesurveyid int, -- route survey id
	@status nvarchar(max), -- rig move status
	@updatedate date,	-- date on which this update is provided
	@oldlocationloads int=nul, -- totalloads moved out of old location
	@newlocationloads int=null, -- total loads moved into new location
	@remarks nvarchar(max)=null, -- remarks, observations or comments if any
	@rmstatusid int=null, -- this is used while updating a particular record 
	@updatetype int -- Update type, insert new record or Update previous record, 1 for insert new record and 2 for update existing record

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @retval int
	declare @rmstatus int

	select 
	@rmstatus=RMStatusId
	From
	RigMoveStatus
	where [Description]=@status

	if(@rmstatus is not null and @updatetype=1 and @rmstatusid is null)
	begin
		BEGIN TRY
			BEGIN TRANSACTION
			
				insert into OPS_RigMoveUpdates
				(FK_RouteSurveyId,FK_RigMoveStatus,UpdateDate,OldLocationLoads,NewLocationLoads,Remarks,StatusFlag,CreatedDate)
				values
				(@routesurveyid,@rmstatus,@updatedate,@oldlocationloads,@newlocationloads,@remarks,1,getdate())

				update  RoadSurveyDetails
				set [Status]=@rmstatus,
				ModifiedDate=getdate()
				where 
				RouteSurveyId=@routesurveyid


			COMMIT TRANSACTION
			SET @retval=1
		END TRY
		BEGIn CATCH
			ROLLBACK TRANSACTION
			set @retval=0
		END CATCH
	end

	if(@rmstatus is not null and @updatetype=0 and @rmstatusid is not null)
	begin
	begin try
		begin transaction
			update OPS_RigMoveUpdates
			set
			--FK_RigMoveStatus=@status,
			--UpdateDate=@updatedate,
			OldLocationLoads=@oldlocationloads,
			NewLocationLoads=@newlocationloads,
			Remarks=@remarks,
			ModifiedDate=getdate()
			where
			FK_RouteSurveyId=@routesurveyid and RMUpdateId=@rmstatusid

			--update  RoadSurveyDetails
			--	set [Status]=@rmstatus,
			--	ModifiedDate=getdate()
			--	where 
			--	RouteSurveyId=@routesurveyid

		commit transaction
		set @retval=1 -- transaction successful
	end try
	begin catch
		rollback transaction
		set @retval=0 -- transaction failed
	end catch

	end
    
END
return @retval