-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_HR_UpdateApprovalDataStructure] 
	-- Add the parameters for the stored procedure here
	@datatype as nvarchar(50),
	@documentype as nvarchar(50)=null,
	@updatetype as int,
	@empid as int=null,
	@department as nvarchar(50)=null
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   --Update the Managers table, this needs to be used when there is a change in the department Manager
   --Need to have a client that should be callling this SP
	if(@datatype = 'Managers' and @empid is not null and @department is not null)
	begin

		declare @mid int

		select @mid=[HR.Managers].ManagerID
		from [HR.Managers]
		where [HR.Managers].Department=@department

		if(@mid is not null and @updatetype=2)
			begin
					update [HR.Managers]
					set FK_EmpId=@empid
					where Department=@department
		end
		else if(@mid is null and @updatetype=1)
		begin
			insert into [HR.Managers]
			(FK_EmpId,Department,CreatedDate,[Status])
			values
			(@empid,@department,getdate(),1)

		end

	end
	-- Update the Document Types table
	if(@datatype='DocumentTypes')
	begin

			declare @docid int

		  select @docid=[HR.DocumentTypes].DocumentId
		  from [HR.DocumentTypes]
		  where UPPER([HR.DocumentTypes].Name)=UPPER(@documentype)

		  if(@docid is null and @updatetype=1)
		  begin
			insert into [HR.DocumentTypes]
			(Name,CreatedDate,[Status])
			values
			(@documentype,getdate(),1)

		  end
		  -- This is to delete the document, where instead of removing we set the status as 0 
		  else if(@docid is not null and @updatetype=3)
		  begin
			update [HR.DocumentTypes]
			set [HR.DocumentTypes].Status=0
			 where UPPER([HR.DocumentTypes].Name)=UPPER(@documentype)

		  end

	end
	-- Update Status Types
	if(@datatype = 'StatusTypes')
	begin
		declare @statid int

		select @statid=StatusId
		from [HR.StatusTypes]
		where upper(Name)=upper(@documentype)

		if(@statid is  null and @updatetype=1)
		begin
			insert into [HR.StatusTypes]
			(Name)
			values
			(@documentype)
			
		end
		else if(@statid is not null and @updatetype=3)
		begin
			delete from [HR.StatusTypes]
			where Name=@documentype
			
		end


	end

END