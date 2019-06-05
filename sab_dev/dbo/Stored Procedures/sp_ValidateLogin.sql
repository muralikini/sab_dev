-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ValidateLogin] 
	-- Add the parameters for the stored procedure here
	@username varchar(50),
	@password varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @loginid1 varchar(50)
	declare @loginid2 varchar(50)
	declare @retVal int

	select  @loginid1=LoginId from [EmployeeLogin] where UserName=@username
	select @loginid2=LoginId from [EmployeeLogin] where UserName=@username and [Password]=@password

	if(@loginid1 is NULL)
	begin
		-- User name does not exist
		set @retVal=999
		end
    else if(@loginid1 is NOT NULL and @loginid2 is NULL)
	begin
		-- User Name is valid but password is invalid
		set @retVal =998
		end

	else if(@loginid1 is NOT NULL and @loginid2 is not null)
	begin
		-- both user name and password are valid, return the access role
		select @retVal= FK_RoleId from [EmployeeLogin] where UserName=@username and [Password]=@password
		end

END
return @retVal