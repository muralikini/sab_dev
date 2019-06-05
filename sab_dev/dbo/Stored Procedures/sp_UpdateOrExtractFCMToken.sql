-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateOrExtractFCMToken]
	-- Add the parameters for the stored procedure here
	--Employee Id
	@empid as int,
	--Token details
	@fcmtoken as nvarchar(max)=null,
	-- Update or Insert flag
	@flag as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @id  int
	declare @retvalue int
	-- if the @flag value is 1, then update
	-- if the @flag value is 2, then extract
	select @id=[EmployeeLogin].LoginId from [EmployeeLogin]
	where FK_Empid = @empid

	if(@flag=1)
		begin
			set @retvalue =1
		

			if(@id is not null)
			begin
				update [EmployeeLogin]
				set FCMToken=@fcmtoken
				where FK_Empid = @empid

			end
			else
			begin
				set @retvalue=0
			end
	end
	else if(@flag=2)
	begin
		if(@id is not null)
			begin
				select FCMToken from [EmployeeLogin]
				where FK_Empid = @empid

			end
			else
			begin
				set @retvalue=0
			end
	

	end

END