-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_HR_CancelRequestForm] 
	-- Add the parameters for the stored procedure here
	-- Approval Id needs to be provided as input
	@approvalid as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	declare @returnstatus int

	begin try
		begin transaction

			update [dbo].[HR.ApprovalStatus]
			set ArchiveStatus=1
			where ApprovalId=@approvalid
		
		commit transaction
		set @returnstatus =1 -- Returns 1, if updation is successful
	end try
	begin catch
		rollback transaction
		set @returnstatus =0  -- Returns 0, if unsuccessful and rollback the transaction
	end catch
END
return @returnstatus