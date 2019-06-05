-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_subqry_CreateAccessPermissions]
	-- Add the parameters for the stored procedure here
	@role nvarchar(50),
	@module nvarchar(50),
	@permission int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @retval int
	declare @roleid int
	declare @moduleid int
	declare @accessid int


	select @roleid=RoleId from AccessRoles where [Name]=@role
	select @moduleid=[ModuleID] from Modules where ModuleName=@module

	select @accessid=AccessPermissionId from AccessPermissions
	where
	FK_RoleId=@roleid and FK_Module=@moduleid

	
	begin
		begin try
			begin transaction
			if(@accessid is null)
				begin
				insert into AccessPermissions
				(FK_RoleId,FK_Module,Permission,CreatedDate)
				values
				(@roleid,@moduleid,@permission,getdate())	
				set @retval=1 -- transaction successful
				end
			else
				begin
					update AccessPermissions
					set Permission = @permission
					where
					FK_RoleId=@roleid and
					FK_Module=@moduleid

					set @retval=1
				
				end
			commit transaction
		end try

		begin catch
			rollback transaction
			set @retval=0 -- transaction failed
		end catch
	end
	
    
END
return @retval