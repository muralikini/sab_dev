-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetOfficialDetails]
	-- Add the parameters for the stored procedure here
	@empid int NULL,
	@designation varchar(50)=NULL,
	@department varchar(50)=NULL,
	@grade varchar(50)=NULL,
	@category varchar(50)=NULL

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@empid is null and @designation is null and @department is null and @grade is null and @category is null)
	begin
		SELECT        EmpId, SABId AS OfficeId, Name AS Firstname, PhoneNo AS ContactNo, Email, Country, Department, Category, Grade, Designation, Nationality, DOB, DOJ, 
                         PassportNo, PassportExpiryDate, IqamaNo, IqamaExpiryDate
FROM            [HR.Employees]
	end
	else if(@empid is not null and @designation is null and @department is null and @grade is null and @category is null)
	begin
		SELECT        EmpId, SABId AS OfficeId, Name AS Firstname, PhoneNo AS ContactNo, Email, Country, Department, Category, Grade, Designation, Nationality, DOB, DOJ, 
                         PassportNo, PassportExpiryDate, IqamaNo, IqamaExpiryDate
FROM            [HR.Employees]
WHERE        ([HR.Employees].EmpId = @empid)
	end
	else if (@empid is null and @designation is not null and @department is null and @grade is null and @category is null)
	begin
		SELECT        EmpId, SABId AS OfficeId, Name AS Firstname, PhoneNo AS ContactNo, Email, Country, Department, Category, Grade, Designation, Nationality, DOB, DOJ, 
                         PassportNo, PassportExpiryDate, IqamaNo, IqamaExpiryDate
FROM            [HR.Employees]
WHERE        ([HR.Employees].Designation = @designation)
	end
	else if(@empid is null and @designation is null and @department is not null and @grade is null and @category is null)
	begin
		SELECT        EmpId, SABId AS OfficeId, Name AS Firstname, PhoneNo AS ContactNo, Email, Country, Department, Category, Grade, Designation, Nationality, DOB, DOJ, 
                         PassportNo, PassportExpiryDate, IqamaNo, IqamaExpiryDate
FROM            [HR.Employees]
WHERE        ([HR.Employees].Department = @department)
	end
	else if (@empid is null and @designation is null and @department is null and @grade is not null and @category is null)
	begin
	SELECT        EmpId, SABId AS OfficeId, Name AS Firstname, PhoneNo AS ContactNo, Email, Country, Department, Category, Grade, Designation, Nationality, DOB, DOJ, 
                         PassportNo, PassportExpiryDate, IqamaNo, IqamaExpiryDate
FROM            [HR.Employees]
WHERE        ([HR.Employees].Grade= @grade)
	end
	else if (@empid is null and @designation is null and @department is null and @grade is null and @category is not null)
	begin
	SELECT        EmpId, SABId AS OfficeId, Name AS Firstname, PhoneNo AS ContactNo, Email, Country, Department, Category, Grade, Designation, Nationality, DOB, DOJ, 
                         PassportNo, PassportExpiryDate, IqamaNo, IqamaExpiryDate
FROM            [HR.Employees]
WHERE        ([HR.Employees].Category = @category)
	end

END