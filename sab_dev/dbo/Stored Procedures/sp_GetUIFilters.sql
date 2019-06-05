-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Gets the different filters that are required for the UI 
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUIFilters]
	-- Add the parameters for the stored procedure here
	-- 1 department
	-- 2 Country
	-- 3 Category
	-- 4 Grade
	-- 5 Designation
	-- 6 Religion
	-- 7 Nationality
	-- 8 Sex
	-- 9 Marital Status
	-- 10 Access Roles
	-- 11 Module Names
	@parameter int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if(@parameter=1)
		begin	
			select distinct Department from [HR.Employees] order by Department
		end
	if(@parameter=2)
		begin	
			select distinct Country from [HR.Employees] order by Country
		end
	if(@parameter=3)
		begin	
			select distinct Category from [HR.Employees] order by Category
		end
	if(@parameter=4)
		begin	
			select distinct Grade from [HR.Employees] order by Grade
		end
	if(@parameter=5)
		begin	
			select distinct Designation from [HR.Employees] order by Designation
		end
	if(@parameter=6)
		begin	
			select distinct Religion from [HR.Employees] order by Religion
		end
	if(@parameter=7)
		begin	
			select distinct Nationality from [HR.Employees] order by Nationality
		end
	if(@parameter=8)
		begin	
			select distinct Sex from [HR.Employees] order by Sex
		end
	if(@parameter=9)
		begin	
			select distinct [MaritalStatus] from [HR.Employees] order by [MaritalStatus]
		end
	if(@parameter=10)
		begin	
			select distinct [Name] from AccessRoles order by [Name]
		end
	if(@parameter=11)
		begin	
			select distinct ModuleName from Modules order by ModuleName
		end


    
END