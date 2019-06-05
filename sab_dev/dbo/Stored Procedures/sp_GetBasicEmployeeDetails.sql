-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetBasicEmployeeDetails]
	-- Add the parameters for the stored procedure here
	@username varchar(50),
	@password varchar(50)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        [HR.Employees].EmpId, [HR.Employees].Name AS FirstName, [HR.Employees].Email, [HR.Employees].Sex, [HR.Employees].MaritalStatus, 
                         [HR.Employees].DOB AS DateOfBirth, [HR.Employees].Nationality, [HR.Employees].Religion, [HR.Employees].Country
FROM            [HR.Employees] INNER JOIN
                         EmployeeLogin ON [HR.Employees].EmpId = EmployeeLogin.FK_EmpId
WHERE        (EmployeeLogin.UserName = @username) AND (EmployeeLogin.Password = @password)
END