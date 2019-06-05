-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[sp_AP_CreateNewAccessRolesAndPermission]
	-- Add the parameters for the stored procedure here
	@role nvarchar(max),
	@hrmodule int,
	@financemodule int,
	@operation int,
	@workshop int,
	@safety int,
	@warehouse int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @roleid int

	select @roleid=RoleId from AccessRoles where Name=@role

	if(@roleid is null)
	begin
		
		insert into AccessRoles
		(Name,CreatedDate)
		values(UPPER(@role),GETDATE())

		select @roleid=RoleId from AccessRoles where Name=@role

		insert into AccessPermissions
		(FK_RoleId,FK_Module,Permission,CreatedDate)
		values(@roleid,1,@hrmodule,GEtDATE())

		insert into AccessPermissions
		(FK_RoleId,FK_Module,Permission,CreatedDate)
		values(@roleid,2,@hrmodule,GEtDATE())

		insert into AccessPermissions
		(FK_RoleId,FK_Module,Permission,CreatedDate)
		values(@roleid,3,@hrmodule,GEtDATE())

		insert into AccessPermissions
		(FK_RoleId,FK_Module,Permission,CreatedDate)
		values(@roleid,4,@hrmodule,GEtDATE())

		insert into AccessPermissions
		(FK_RoleId,FK_Module,Permission,CreatedDate)
		values(@roleid,5,@hrmodule,GEtDATE())

		insert into AccessPermissions
		(FK_RoleId,FK_Module,Permission,CreatedDate)
		values(@roleid,6,@hrmodule,GEtDATE())


	end

END