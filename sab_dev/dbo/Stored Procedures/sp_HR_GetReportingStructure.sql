-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_HR_GetReportingStructure] 
	-- Add the parameters for the stored procedure here
	@empid as int
		
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @reporting TABLE 
	(EmpId int,
	Employee nvarchar(255),
	ManagerId int,
	Manager nvarchar(255))

	declare @reportingto int
	declare @mgrId int
	declare @employeename nvarchar(255)
	declare @manager nvarchar(255)

	select @reportingto=FK_ManagerId 
	from [dbo].[HR.ReportingStructureJn] 
	where FK_EmpId = @empid

	select @employeename=[dbo].[HR.Employees].Name
	from [dbo].[HR.Employees]
	where EmpId = @empid

	select @mgrId=FK_EmpId 
	from [dbo].[HR.Managers]
	where ManagerID=@reportingto

	select @manager=[dbo].[HR.Employees].Name
	from [dbo].[HR.Employees]
	where EmpId = @mgrId

	insert @reporting values(@empid,@employeename,@mgrId,@manager)

	select * from @reporting

	
	


END