-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetEmployeeFields]
	-- Add the parameters for the stored procedure here
	@nationality int NULL,
	@religion int NULL,
	@category int NULL,
	@grade int NULL,
	@department int NULL,
	@designation int NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Insert statements for procedure here
	if(@nationality = 1 and @religion is NULL and @category is null and @grade is null and @department is null and @designation is null)
	begin
		select Distinct Nationality from 
		[HR.Employees]
		order by Nationality
	end
	else if(@nationality is null and @religion=1 and @category is null and @grade is null and @department is null and @designation is null)
	begin
		select Distinct Religion from 
		[HR.Employees]
		order by Religion
	end
	else if(@nationality is null and @religion is null and @category =1 and @grade is null and @department is null and @designation is null)
	begin
		select Distinct Category from 
		[HR.Employees]
		order by Category
	end
	else if(@nationality is null and @religion is null and @category is null and @grade=1 and @department is null and @designation is null)
	begin
		select Distinct Grade from 
		[HR.Employees]
		order by Grade
	end
	else if(@nationality is null and @religion is null and @category is null and @grade is null and @department=1 and @designation is null)
	begin
		select Distinct Department from 
		[HR.Employees]
		order by Department
		
	end
	else if(@nationality is null and @religion is null and @category is null and @grade is null and @department is null and @designation=1)
	begin
		select Distinct Designation from 
		[HR.Employees]
		order by Designation
	end
END