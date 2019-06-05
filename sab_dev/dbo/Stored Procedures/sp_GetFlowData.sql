-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_GetFlowData 
	-- Add the parameters for the stored procedure here
	@empid as int,
	@datatype as nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  if(@datatype='DocumentTypes' and @empid is null)
  begin

	  select [HR.DocumentTypes].Name
	  from [HR.DocumentTypes]

  end
  else if(@empid is not null and @datatype = 'Managers')
  begin
		SELECT        [HR.Employees].EmpId, [HR.Managers].Department, [HR.Employees].Name
		FROM            [HR.Managers] INNER JOIN
                         [HR.Employees] ON [HR.Managers].FK_EmpId = [HR.Employees].EmpId

  end

	
END