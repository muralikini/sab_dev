-- =============================================
-- Author:		Muralidhar Kini
-- Create date: 2019/02/19
-- Description:	This SP updates the status of the rig move.
-- This updates both the 'RiG Move Status Table' as well as the 'Road Survey Table'
-- Daily Load updates are also tracked here
-- We can use this SP either to insert new records or to modify a previous update
-- =============================================
CREATE PROCEDURE sp_OPS_UpdateRigMoveStatus
	-- Add the parameters for the stored procedure here
	@routesurveyid int,
	@status nvarchar(max),
	@updatedate date,
	@oldlocationloads int=nul,
	@newlocationloads int=null,
	@remarks nvarchar(max)=null

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @retval int
	declare @rmstatus int

	select 
	@rmstatus=RigMoveStatusId
	From
	RigMoveStatus
	where [Description]=@status

	if(@rmstatus is not null)
	begin
		BEGIN TRY
			BEGIN TRANSACTION

				


			COMMIT TRANSACTION
			SET @retval=1
		END TRY
		BEGIn CATCH
			ROLLBACK TRANSACTION
			set @retval=0
		END CATCH
	end
    
END
return @retval