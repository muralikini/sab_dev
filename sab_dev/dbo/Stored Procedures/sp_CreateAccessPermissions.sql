-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_CreateAccessPermissions]
	-- Add the parameters for the stored procedure here
	@permissions as tbl_accesspermission READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @tempaccess as [dbo].[tbl_accesspermission]
	
	insert into @tempaccess (accessid,accessrole,module,permission)
	select * from @permissions

Declare @Id int
declare @retstat int
begin try
While exists (Select * From @tempaccess)
Begin
	
    Select Top 1 @Id = accessid From @tempaccess
	declare @role nvarchar(50)
	declare @module nvarchar(50)
	declare @perm int
	declare @retstatus int

	select @role=[@tempaccess].[accessrole] from @tempaccess where accessid=@Id
	select @module=[@tempaccess].[module] from @tempaccess where accessid=@Id
	select @perm=[@tempaccess].[permission] from @tempaccess where accessid=@Id

	EXEC @retstatus=sp_subqry_CreateAccessPermissions @role,@module,@perm
    --Do some processing here
    Delete @tempaccess Where accessid = @Id
	set @retstat=@retstatus
End

end try
begin catch
	set @retstat = 3
end catch

END
return @retstat