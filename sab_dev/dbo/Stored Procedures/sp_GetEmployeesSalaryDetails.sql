-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetEmployeesSalaryDetails]
	-- Add the parameters for the stored procedure here
	@empid int null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@empid is not null)
	begin
		SELECT        [HR.Employees].SABId AS OfficeID, [HR.Employees].Name AS FirstName, [HR.SalaryDetails].Basic, [HR.SalaryDetails].HRA, [HR.SalaryDetails].DA, 
                         [HR.SalaryDetails].Conveyance, [HR.SalaryDetails].FoodAllowance, [HR.SalaryDetails].FixedOT, [HR.SalaryDetails].Others, [HR.SalaryDetails].Gross, 
                         [HR.IncrementHistory].IncrementDate, [HR.IncrementHistory].IncrementAmount, [HR.BankDetails].BankName, [HR.BankDetails].CustomerNo AS BankCustomerNo, 
                         [HR.BankDetails].AccountNo
FROM            [HR.Employees] INNER JOIN
                         [HR.BankDetails] ON [HR.Employees].EmpId = [HR.BankDetails].FK_EmpId INNER JOIN
                         [HR.SalaryDetails] ON [HR.Employees].EmpId = [HR.SalaryDetails].FK_EmpId INNER JOIN
                         [HR.IncrementHistory] ON [HR.SalaryDetails].SalaryId = [HR.IncrementHistory].FK_SalaryId
WHERE        ([HR.Employees].EmpId = @empid)
	end
	else
	begin

		SELECT        [HR.Employees].SABId AS OfficeID, [HR.Employees].Name AS FirstName, [HR.SalaryDetails].Basic, [HR.SalaryDetails].HRA, [HR.SalaryDetails].DA, 
                         [HR.SalaryDetails].Conveyance, [HR.SalaryDetails].FoodAllowance, [HR.SalaryDetails].FixedOT, [HR.SalaryDetails].Others, [HR.SalaryDetails].Gross, 
                         [HR.IncrementHistory].IncrementDate, [HR.IncrementHistory].IncrementAmount, [HR.BankDetails].BankName, [HR.BankDetails].CustomerNo AS BankCustomerNo, 
                         [HR.BankDetails].AccountNo
FROM            [HR.Employees] INNER JOIN
                         [HR.BankDetails] ON [HR.Employees].EmpId = [HR.BankDetails].FK_EmpId INNER JOIN
                         [HR.SalaryDetails] ON [HR.Employees].EmpId = [HR.SalaryDetails].FK_EmpId INNER JOIN
                         [HR.IncrementHistory] ON [HR.SalaryDetails].SalaryId = [HR.IncrementHistory].FK_SalaryId
						 order by [HR.Employees].SABId

	end
END