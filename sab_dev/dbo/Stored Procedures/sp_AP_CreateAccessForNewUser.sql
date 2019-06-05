-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	This SP creates access permission for the new user in the portal
-- By default he gets acces roles as 'USER'
-- =============================================
CREATE PROCEDURE [dbo].[sp_AP_CreateAccessForNewUser] 
	-- Add the parameters for the stored procedure here
	@empid as int,
	@roles as nvarchar(50) NULL,
	@username as nvarchar(max),
	@password as nvarchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @roleid int
    -- Insert statements for procedure here
	declare @employeeid  int

	select @employeeid=FK_EmpId from [EmployeeLogin] where UserName=@username and [Password]=@password

	if(@roles is NULL)
	begin
	select @roleid= RoleId from AccessRoles where Name='USER'
	-- default role is as a 'USER'
	insert into [EmployeeLogin]
	(FK_EmpId,FK_RoleId,UserName,[Password],[Status],[DateTime])
	values(@empid,@roleid,@username,@password,1,GETDATE())
		
	end
	else
	begin
	select @roleid= RoleId from AccessRoles where Name=@roles
	-- default role is as a 'USER'
		if(@roleid is  null)
		begin
			insert into [EmployeeLogin]
			(FK_EmpId,FK_RoleId,UserName,[Password],[Status],[DateTime])
			values(@empid,1,@username,@password,1,GETDATE())
		end
		else
		begin
			update [EmployeeLogin]
			set FK_RoleId=@roleid
			where (UserName=@username and [Password]=@password and FK_EmpId=@empid)
		end
	end

	
END