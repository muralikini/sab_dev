-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_HR_UpdateReportingStructure]
	-- Add the parameters for the stored procedure here
	@empid as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @department nvarchar(500)
	declare @managerId int
	declare @reportingStatus int
    -- Insert statements for procedure here

	select @reportingStatus=ReportingId from [dbo].[HR.ReportingStructureJn]
	where FK_EmpId=@empid

	if(@reportingStatus is null)

			begin

				select @department= Department from [HR.Employees]
				where [HR.Employees].EmpId=@empid

				select @managerId=ManagerID from [HR.Managers]
				where Department like @department

				if(@department is not null and @managerId is not null)
				begin

					insert into [dbo].[HR.ReportingStructureJn]
					(FK_EmpId,FK_ManagerId,CreatedDate,[Status])
					values(@empid,@managerId,getdate(),1)

				end

			end

END