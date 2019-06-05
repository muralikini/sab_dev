-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertSalaryDetails]
	-- Add the parameters for the stored procedure here
	@empid int,
	@basic float,
	@hra float,
	@da float,
	@conveyance float,
	@food float,
	@fixedot float,
	@other float,
	@remarks varchar(max),
	@bankname varchar(max),
	@customerno varchar(50)= null,
	@accountno varchar(50)= null,
	@incrementdate date= null,
	@incrementamount float= null,
	@incremarks varchar(max)= null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @retval int
	declare @temp int
	declare @salid int
	declare @id int

  SELECT     @id=  EmpId
  FROM            [HR.Employees]
  WHERE        (SABId = @empid)

	select @temp = SalaryId from [HR.SalaryDetails] where FK_EmpId=@id
	
	if(@temp is null)
	begin
		
		insert into [HR.SalaryDetails]
		(FK_EmpId,[Basic],HRA,DA,Conveyance,FoodAllowance,FixedOT,Others,Remarks,Gross,[TimeStamp])
		values(@id,@basic,@hra,@da,@conveyance,@food,@fixedot,@other,@remarks,
		(@basic+@hra+@da+@conveyance+@food+@fixedot+@other),
		getdate())

		if(@bankname is not null )
		begin
			insert into [HR.BankDetails]
			(FK_EmpId,BankName,CustomerNo,AccountNo,[TimeStamp])
			values(@id,@bankname,@customerno,@accountno,getdate())

		end
		select @salid=SalaryId from [HR.SalaryDetails] where FK_EmpId=@id

		if(@incrementdate is not null and @incrementamount is not null)
		begin

			insert into [HR.IncrementHistory]
			(FK_SalaryId,IncrementDate,IncrementAmount,Remarks,[TimeStamp])
			values(@salid,@incrementdate,@incrementamount,@incremarks,getdate())

		end

		-- Inserted record successfully
		set @retval=1
	end
	else
	begin
	   -- This data already exists in the database
		set @retval=2

	end 
   
END
return @retval