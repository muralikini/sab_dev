-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateSignature]
	-- Add the parameters for the stored procedure here
	@empid int,
	@signature nvarchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @signatureid int
	declare @retval int
	select @signatureid=SignatureID from EmployeeSignatures where FK_EmpId=@empid

	begin try
		begin transaction
			if(@signatureid is null)
			begin -- If the signature does not exist then create a new record
				insert into EmployeeSignatures
				(FK_EmpId,[Signature],CreatedDate,StatusFlag)
				values
				(@empid,@signature,getdate(),1)
				set @retval =1
			end
			else if(@signatureid is not null) -- If the signature already exisits then update that record with new signature
			begin
				update EmployeeSignatures
				set [Signature]=@signature
				where SignatureID=@signatureid

				set @retval=1
			end
		commit transaction
	end try
	begin catch
		rollback transaction
		set @retval =0
	end catch
   
END
return @retval