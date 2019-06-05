-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_HR_CreateNewUser]
	@sabid nvarchar(50),
	@name nvarchar(100),
	@country nvarchar(50),
	@department nvarchar(50),
	@category nvarchar(50),
	@grade nvarchar(50),
	@designation nvarchar(50),
	@religion nvarchar(50),
	@nationality nvarchar(50),
	@sex nvarchar(50),
	@maritalstatus nvarchar(50),
	@dob date,
	@doj date,
	@passport nvarchar(50),
	@password nvarchar(50)=null,
	@repassword nvarchar(50)=null,
	@role nvarchar(50)=null

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    declare @retval int
	declare @empid int
	declare @roleid int
	select @empid=EmpId from [HR.Employees]
	where
	SABId=@sabid

	if(@empid is not null)
	begin
		set @retval=2 -- this ID already exists
	end
	else
	begin
		begin try
			begin transaction
			
			insert into [HR.Employees]
			(SABId,Name,Country,Department,Category,Grade,Designation,Religion,Nationality,Sex,MaritalStatus,DOB,DOJ,PassportNo,[Status])
			values
			(@sabid,@name,@country,@department,@category,@grade,@designation,@religion,@nationality,@sex,@maritalstatus,@dob,@doj,@passport,1)

			select @empid=EmpId from [HR.Employees]
			where
			SABId=@sabid

			if(@password is not null and @repassword is not null and @role is not null)
			begin
				select @roleid=RoleId from AccessRoles where [Name]=@role

				if(@roleid is not null)
				begin

					insert into EmployeeLogin
					(FK_EmpId,FK_RoleId,UserName,[Password],[Status],[DateTime])
					values
					(@empid,@roleid,@sabid,@password,1,getdate())
				end
				else
				begin
					set @retval=2 --- Role Does not exist
				end
			end
			
			set @retval=1
			commit transaction

		end try

		begin catch
			rollback transaction
			set @retval =0 -- transaction failed
		end catch
	end
END
return @retval