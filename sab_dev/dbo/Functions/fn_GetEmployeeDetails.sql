-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION fn_GetEmployeeDetails 
(
	-- Add the parameters for the function here
	@empid as int
)
RETURNS TABLE
AS
RETURN(

select * from [HR.Employees]
where
[HR.Employees].EmpId=@empid



)