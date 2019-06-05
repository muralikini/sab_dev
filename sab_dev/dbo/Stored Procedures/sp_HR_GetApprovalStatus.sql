-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_HR_GetApprovalStatus]
	-- Add the parameters for the stored procedure here
	@empid as int=null,
	@documenttype as nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @temptable table
	(empid int,
	reportingmanagerid int,
	managername nvarchar(255),
	managerapproval nvarchar(50),
	hrmanagerid int,
	hrmanagername nvarchar(255),
	hrapproval nvarchar(50),
	gmid int,
	gmname nvarchar(50),
	gmapproval nvarchar(50),
	finalstatus nvarchar(50),
	xmldata xml
	)

    declare @mgrid int
	declare @mname nvarchar(255)
	declare @mapproval nvarchar(50)

	declare @hid int
	declare @hname nvarchar(255)
	declare @happroval nvarchar(50)

	declare @gid int
	declare @gname nvarchar(50)
	declare @gapproval nvarchar(50)

	declare @fstatus nvarchar(50)

	declare @docid int

	declare @approvalid int

	declare @xmldata xml

	select @docid=[HR.DocumentTypes].DocumentId
	from [HR.DocumentTypes]
	where [HR.DocumentTypes].Name=@documenttype


	select @approvalid=ApprovalId from
	[HR.ApprovalStatus]
	where [HR.ApprovalStatus].FK_DocumentId=@docid and FK_UserId=@empid and ArchiveStatus=0

	

	if(@approvalid is not null and @empid is not null and @documenttype is not null)

	begin
  
			SELECT        @mgrid=[HR.Employees].EmpId, 
						 @mname=[HR.Employees].Name

			FROM            [HR.ReportingStructureJn] INNER JOIN
								 [HR.Managers] ON [HR.ReportingStructureJn].FK_ManagerId = [HR.Managers].ManagerID INNER JOIN
								 [HR.Employees] ON [HR.Managers].FK_EmpId = [HR.Employees].EmpId
			WHERE        ([HR.ReportingStructureJn].FK_EmpId = @empid) 

			select @mapproval=ReportingManagerApproval,
				   @happroval=HRManagerApproval,
				   @gapproval=ManagementApproval,
				   @xmldata =Data
			from [dbo].[HR.ApprovalStatus]
			where FK_UserId=@empid and ArchiveStatus=0 and ([HR.ApprovalStatus].FK_DocumentId=@docid)

			
	

			if(@mapproval is NULL)
				set @mapproval='PENDING'
			else if(@mapproval=2)
				set @mapproval ='APPROVED'
			else if(@mapproval=4)
				set @mapproval ='REJECTED'

			if(@happroval is NULL)
				set @happroval='PENDING'
			else if(@happroval=2)
				set @happroval ='APPROVED'
			else if(@happroval=4)
				set @happroval ='REJECTED'

			if(@gapproval is NULL)
				set @gapproval='PENDING'
			else if(@gapproval=2)
				set @gapproval ='APPROVED'
			else if(@gapproval=4)
				set @gapproval ='REJECTED'



			SELECT        @hid=[HR.Employees].EmpId, 
						  @hname=[HR.Employees].Name
			FROM            [HR.Managers] INNER JOIN
								 [HR.Employees] ON [HR.Managers].FK_EmpId = [HR.Employees].EmpId
			WHERE        ([HR.Managers].Department = N'HR ADMINISTRATION')

			SELECT        @gid=[HR.Employees].EmpId, 
						  @gname=[HR.Employees].Name
			FROM            [HR.Managers] INNER JOIN
							[HR.Employees] ON [HR.Managers].FK_EmpId = [HR.Employees].EmpId
			WHERE        ([HR.Managers].Department = N'MANAGEMENT')

			set @fstatus=0

			insert @temptable values
			(@empid,@mgrid,@mname,@mapproval,
			@hid,@hname,@happroval,
			@gid,@gname,@gapproval,@fstatus,@xmldata)

			select * from @temptable
	end

	else if(@approvalid is  null and @empid is not null and @documenttype is not null)
	begin

		select * from @temptable

	end
	else if( @empid is not null and @documenttype is not null)
	begin

	select * from [HR.ApprovalStatus] where [HR.ApprovalStatus].[ArchiveStatus]=0

	end

   	
END