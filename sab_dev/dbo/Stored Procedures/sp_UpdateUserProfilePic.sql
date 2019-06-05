-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_UpdateUserProfilePic
	-- Add the parameters for the stored procedure here
	@empid as int,
	@pic as nvarchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @retstatus int
	declare @emp int
	BEGIN TRY
		BEGIN Transaction
			select @emp=ProfileId 
			from
			UserProfiles
			where FK_EmpId = @empid

			if(@emp is not null)
			begin
				update UserProfiles
				set [Image]=@pic
				where FK_EmpId = @empid

				set @retstatus=1 -- Update successful
			end
			else
			begin
				set @retstatus=0 --The employee record does not exist in the profile
			end
			

		commit transaction

	END TRY
	Begin catch

		rollback transaction
		set @retstatus=2 -- Updation failed 
	end catch

   
END
return @retstatus