-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_HR_UpdateApprovalStatus] 
	-- Add the parameters for the stored procedure here
	@documenttype as nvarchar(255),
	@empid as int,
	@managerapproval as int = null,
	@hrmanagerapproval as int =null,
	@managementapproval as int = null,
	@xmldata as xml=null
	--@returnvalue as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
--Final Status values
--1	PENDING
--2	APPROVED
--3	CANCELLED
--4	REJECTED
--5	CLOSED

	SET NOCOUNT ON;
	declare @did int
	declare @userid int
	declare @currentstatus int
	declare @returnvalue int

	select @did=DocumentId from [HR.DocumentTypes] where [HR.DocumentTypes].Name =@documenttype
	select @currentstatus=[Status] from [dbo].[HR.ApprovalStatus] where FK_UserId=@empid and [HR.ApprovalStatus].ArchiveStatus=0 and FK_DocumentId=@did

	set @returnvalue=1
	
    -- Insert statements for procedure here
	if(@managerapproval is null and @hrmanagerapproval is null and @managementapproval is null and @currentstatus is null)
	begin
		-- When there is a fresh application raised by the employee
				insert into [dbo].[HR.ApprovalStatus]
				(FK_DocumentId,FK_UserId,ReportingManagerApproval,HRManagerApproval,ManagementApproval,[Status],CreatedDate,ArchiveStatus,[Data])
				values(@did,@empid,null,null,null,1,Getdate(),0,@xmldata)

				select * from
				[dbo].[HR.ApprovalStatus]
				where FK_DocumentId=@did and FK_UserId=@empid
	end
	else if(@managerapproval is not null and @hrmanagerapproval is null and @managementapproval is null and @currentstatus is not null)
	begin

		if(@managerapproval =2)
		begin
						update [dbo].[HR.ApprovalStatus]
						set [HR.ApprovalStatus].ReportingManagerApproval=@managerapproval
						where FK_UserId=@empid and  FK_DocumentId=@did
		end
		else if(@managerapproval=4)
		begin
					update [dbo].[HR.ApprovalStatus]
						set [HR.ApprovalStatus].ReportingManagerApproval=@managerapproval,
						[HR.ApprovalStatus].[Status]=@managerapproval,
						[HR.ApprovalStatus].[ArchiveStatus]=1
						where FK_UserId=@empid and  FK_DocumentId=@did
		end

				
	end
	else if(@managerapproval is  null and @hrmanagerapproval is not null and @managementapproval is null and @currentstatus is not null)
			begin
					if(@hrmanagerapproval=2)
						begin
							update [dbo].[HR.ApprovalStatus]
							set [HR.ApprovalStatus].HRManagerApproval=@hrmanagerapproval
							where FK_UserId=@empid and FK_DocumentId=@did
						end
					else if(@hrmanagerapproval=4)
						begin
							update [dbo].[HR.ApprovalStatus]
							set [HR.ApprovalStatus].HRManagerApproval=@hrmanagerapproval,
							[HR.ApprovalStatus].[Status]=1,
							[HR.ApprovalStatus].[ArchiveStatus]=1
							where FK_UserId=@empid and FK_DocumentId=@did
						end


						
			end
	else if(@managerapproval is  null and @hrmanagerapproval is  null and @managementapproval is not null and @currentstatus is not null)
			begin

			if(@managementapproval=2)
			begin 
						update [dbo].[HR.ApprovalStatus]
						set [HR.ApprovalStatus].ManagementApproval=@managementapproval,
						[HR.ApprovalStatus].FinalApprovalDate=GETDATE(),
						[HR.ApprovalStatus].[Status]=2,
						[HR.ApprovalStatus].ArchiveStatus=1
						where FK_UserId=@empid and FK_DocumentId=@did
			end
			else if(@managementapproval=4)
			begin
						update [dbo].[HR.ApprovalStatus]
						set [HR.ApprovalStatus].ManagementApproval=@managementapproval,
						[HR.ApprovalStatus].[Status]=4,
						[HR.ApprovalStatus].ArchiveStatus=1
						where FK_UserId=@empid and FK_DocumentId=@did
			end

						
			end
	else if(@managerapproval is null and @hrmanagerapproval is null and @managementapproval is null and @currentstatus is not null)
			begin

				set @returnvalue=0

			end
END

RETURN @returnvalue