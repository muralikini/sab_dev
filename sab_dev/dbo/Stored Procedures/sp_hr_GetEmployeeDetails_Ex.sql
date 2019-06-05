-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_hr_GetEmployeeDetails_Ex]
	-- Add the parameters for the stored procedure here
	@username varchar(50)=NULL,
	@password varchar(50)=NULL,
	@empid varchar(50)=NULL
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@username is not null and @password is not null and @empid is null)
	begin
	SELECT        [HR.Employees].EmpId, [HR.Employees].SABId, [HR.Employees].Name AS Firstname, [HR.Employees].Email, [HR.Employees].Sex, [HR.Employees].MaritalStatus, 
                         [HR.Employees].DOB AS DateOfBirth, [HR.Employees].Nationality, [HR.Employees].Religion, [HR.Employees].Department, [HR.Employees].Designation, 
                         [HR.Employees].Category, [HR.Employees].Grade, [HR.Employees].PhoneNo AS ContactNo, [HR.Employees].Country, [HR.Employees].DOJ AS DateOfJoining, 
                         [HR.Employees].DOE, [HR.Employees].DOC, [HR.Employees].PassportNo, [HR.Employees].PassportIssueDate, [HR.Employees].PassportExpiryDate, 
                         [HR.Employees].IqamaNo, [HR.Employees].IqamaExpiryDate
FROM            [HR.Employees] INNER JOIN
                         EmployeeLogin ON [HR.Employees].EmpId = EmployeeLogin.FK_EmpId INNER JOIN
                         AccessRoles ON EmployeeLogin.FK_RoleId = AccessRoles.RoleId
WHERE        (EmployeeLogin.UserName = @username) AND (EmployeeLogin.Password = @password)

	end
	else if(@username is null and @password is null and @empid is not null)
	begin
	SELECT        [HR.Employees].EmpId, [HR.Employees].SABId, [HR.Employees].Name AS Firstname, [HR.Employees].Email, [HR.Employees].Sex, [HR.Employees].MaritalStatus, 
                         [HR.Employees].DOB AS DateOfBirth, [HR.Employees].Nationality, [HR.Employees].Religion, [HR.Employees].Department, [HR.Employees].Designation, 
                         [HR.Employees].Category, [HR.Employees].Grade, [HR.Employees].PhoneNo AS ContactNo, [HR.Employees].Country, [HR.Employees].DOJ AS DateOfJoining, 
                         [HR.Employees].DOE, [HR.Employees].DOC, [HR.Employees].PassportNo, [HR.Employees].PassportIssueDate, [HR.Employees].PassportExpiryDate, 
                         [HR.Employees].IqamaNo, [HR.Employees].IqamaExpiryDate
FROM            [HR.Employees] INNER JOIN
                         EmployeeLogin ON [HR.Employees].EmpId = EmployeeLogin.FK_EmpId INNER JOIN
                         AccessRoles ON EmployeeLogin.FK_RoleId = AccessRoles.RoleId
WHERE        ([HR.Employees].EmpId = @empid)

	end
END