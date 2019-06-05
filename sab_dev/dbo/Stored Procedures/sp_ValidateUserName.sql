-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ValidateUserName]
	-- Add the parameters for the stored procedure here
	@username varchar(50)
	--@returnval int OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @loginid int
	declare @returnval int

	select @loginid=[LoginId] from [EmployeeLogin] where UserName=@username
	if(@loginid is not null)
	begin
		set @returnval=1
	end
	else
	begin
		set @returnval=0
	end
END
RETURN @returnval