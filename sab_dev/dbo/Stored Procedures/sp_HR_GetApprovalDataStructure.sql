-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_HR_GetApprovalDataStructure] 
	-- Add the parameters for the stored procedure here
	@datatype as nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  if(@datatype='DocumentTypes')
  begin

	  select [HR.DocumentTypes].Name
	  from [HR.DocumentTypes]

  end
  else if(@datatype = 'Managers')
  begin
		SELECT        [HR.Employees].EmpId, [HR.Managers].Department, [HR.Employees].Name
		FROM            [HR.Managers] INNER JOIN
                         [HR.Employees] ON [HR.Managers].FK_EmpId = [HR.Employees].EmpId

  end
  else if(@datatype = 'StatusTypes')
  begin
		SELECT        StatusId, Name AS StatusTypes
FROM            [HR.StatusTypes]

  end

	
END