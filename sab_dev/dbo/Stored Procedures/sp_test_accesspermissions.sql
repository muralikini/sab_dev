-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_test_accesspermissions 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @retstat int
    -- Insert statements for procedure here
	declare @tempaccess as [dbo].[tbl_accesspermission]

	insert into @tempaccess
	(accessid,accessrole,module,permission)
	values
	(133,'ADMIN','IT',7)

	EXEC @retstat=[dbo].[sp_CreateAccessPermissions] @tempaccess

	

END
return @retstat