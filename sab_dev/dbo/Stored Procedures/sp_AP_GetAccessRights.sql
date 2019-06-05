-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AP_GetAccessRights] 
	-- Add the parameters for the stored procedure here
	@username as nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        AccessRoles.Name AS Role, Modules.ModuleName, AccessPermissions.Permission
FROM            AccessPermissions INNER JOIN
                         AccessRoles ON AccessPermissions.FK_RoleId = AccessRoles.RoleId INNER JOIN
                         Modules ON AccessPermissions.FK_Module = Modules.ModuleID INNER JOIN
                         EmployeeLogin ON AccessRoles.RoleId = EmployeeLogin.FK_RoleId
WHERE        (EmployeeLogin.UserName = @username)
END