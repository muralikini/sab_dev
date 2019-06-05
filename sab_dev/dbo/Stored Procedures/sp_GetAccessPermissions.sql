-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetAccessPermissions] 
	-- Add the parameters for the stored procedure here
	@role nvarchar(max)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   if(@role is null)
	   begin
			SELECT        AccessPermissions.AccessPermissionId, AccessRoles.Name, Modules.ModuleName, AccessPermissions.Permission
FROM            AccessPermissions INNER JOIN
                         Modules ON AccessPermissions.FK_Module = Modules.ModuleID INNER JOIN
                         AccessRoles ON AccessPermissions.FK_RoleId = AccessRoles.RoleId
ORDER BY AccessRoles.Name
	   end
	else if(@role is not null)
	begin
		SELECT        AccessPermissions.AccessPermissionId, AccessRoles.Name, Modules.ModuleName, AccessPermissions.Permission
FROM            AccessPermissions INNER JOIN
                         Modules ON AccessPermissions.FK_Module = Modules.ModuleID INNER JOIN
                         AccessRoles ON AccessPermissions.FK_RoleId = AccessRoles.RoleId
WHERE        (AccessRoles.Name = @role)
ORDER BY AccessRoles.Name
	end
END