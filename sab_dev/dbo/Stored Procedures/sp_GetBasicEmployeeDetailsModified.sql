-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetBasicEmployeeDetailsModified]
	-- Add the parameters for the stored procedure here
	@username varchar(50),
	@password varchar(50),
	@empid varchar(50)=NULL
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@username is not null and @password is not null and @empid is null)
	begin
		SELECT        [HR.Employees].EmpId, [HR.Employees].Name, [HR.Employees].Email, [HR.Employees].Sex, [HR.Employees].MaritalStatus, [HR.Employees].DOB AS DateOfBirth, 
                         [HR.Employees].Nationality, [HR.Employees].Religion, [HR.Employees].Country
FROM            EmployeeLogin INNER JOIN
                         [HR.Employees] ON EmployeeLogin.FK_EmpId = [HR.Employees].EmpId
WHERE        (EmployeeLogin.UserName = @username) AND (EmployeeLogin.Password = @password)
end
else if(@username is  null and @password is  null and @empid is not null)
begin

		SELECT        EmpId, Firstname, Email, Sex, MaritalStatus, DateOfBirth, Nationality, Religion, Department, Designation, Category, Grade, ContactNo, DateOfJoining, PassportNo, 
                         PassportExpiryDate, IqamaNo, IqamaExpiryDate
FROM            FullEmployeeDetails
WHERE        (EmpId = @empid)
end
END