-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_CreateNewObjects
	-- Add the parameters for the stored procedure here
	@objectname varchar(50),
	@data nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @retval int

    begin try
		begin transaction
			if(@objectname='ROLE')
			begin
				declare @roleid int
				select @roleid=RoleId from AccessRoles where [Name]=@data
				if(@roleid is null)
					begin
						insert into AccessRoles
						([Name],CreatedDate)
						values
						(@data,getdate())
						set @retval=1 -- New role inserted successfully

					end
				else
					begin
						set @retval=0
					end
			end
			
		commit transaction
	end try
	begin catch
			rollback transaction
			set @retval=0
	end catch
END