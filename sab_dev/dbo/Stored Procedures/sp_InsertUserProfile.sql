-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertUserProfile] 
	-- Add the parameters for the stored procedure here
	@empid as int,
	@name as varchar(100)=NULL,
	@email as varchar(50) = NULL,
	@phonenumber as nvarchar(25) = null,
	@designation as nvarchar(50) = null,
	@nationality as nvarchar(50) = null,
	@imagepath as nvarchar(max) = null

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @employeeid int

	

	select @employeeid=FK_Empid from UserProfiles
	where FK_EmpId=@empid

	if(@employeeid is not null)
	begin 

		UPDATE       UserProfiles
SET                Name = @name, Email = @email, PhoneNumber = @phonenumber, Designation = @designation, Nationality = @nationality
WHERE        (FK_EmpId = @empid)

	end
	else
	begin
		insert into UserProfiles
		(FK_EmpId,Name,Email,PhoneNumber,Designation,Nationality)
		values
		(@empid,@name,@email,@phonenumber,@designation,@nationality)
	end
END