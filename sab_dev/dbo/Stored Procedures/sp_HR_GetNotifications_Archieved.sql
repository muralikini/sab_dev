-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_HR_GetNotifications_Archieved] 
	-- Add the parameters for the stored procedure here
	@empid as int,
	-- If 1, then show only active records
	-- If 0, then show all records
	@flag as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @mgrid int
	declare @department nvarchar(100)
    -- Insert statements for procedure here
	select 
	@mgrid=[HR.Managers].ManagerID,
	@department=[HR.Managers].Department from 
	[dbo].[HR.Managers]
	where [HR.Managers].FK_EmpId = @empid

	if(@mgrid is not null and @flag =1)
		--this means he is a manager
		begin
			-- Enters this condition, if he is not a HR OR Management OR Marketing head
			if(@mgrid != 5 and @mgrid != 1 and @mgrid != 6 )
				begin

				
					SELECT        [HR.ApprovalStatus].ApprovalId, [HR.ApprovalStatus].FK_UserId, [HR.DocumentTypes].Name,
					(SELECT        [HR.Managers].FK_EmpId AS ReportinManagerId
FROM            [HR.Managers] INNER JOIN
                         [HR.ReportingStructureJn] ON [HR.Managers].ManagerID = [HR.ReportingStructureJn].FK_ManagerId
WHERE        ([HR.ReportingStructureJn].FK_EmpId = [HR.ApprovalStatus].FK_UserId)) AS ReportinManagerId,
					[HR.ApprovalStatus].ReportingManagerApproval,
					(select FK_EmpId from [HR.Managers] where Department='HR ADMINISTRATION') as HRmanagerId, 
                         [HR.ApprovalStatus].HRManagerApproval, 
						 (select FK_EmpId from [HR.Managers] where Department='MANAGEMENT') as ManagementId,
						 [HR.ApprovalStatus].ManagementApproval, [HR.ApprovalStatus].ArchiveStatus, [HR.ApprovalStatus].Data
FROM            [HR.ApprovalStatus] INNER JOIN
                         [HR.ReportingStructureJn] ON [HR.ApprovalStatus].FK_UserId = [HR.ReportingStructureJn].FK_EmpId INNER JOIN
                         [HR.Managers] ON [HR.ReportingStructureJn].FK_ManagerId = [HR.Managers].ManagerID INNER JOIN
                         [HR.DocumentTypes] ON [HR.ApprovalStatus].FK_DocumentId = [HR.DocumentTypes].DocumentId
WHERE        (([HR.ApprovalStatus].ArchiveStatus = 0) AND ([HR.Managers].FK_EmpId = @empid) AND ([HR.ApprovalStatus].ReportingManagerApproval IS NULL))
OR (([HR.ApprovalStatus].FK_UserId =@empid) AND ([HR.ApprovalStatus].ArchiveStatus = 0) AND ([HR.Managers].FK_EmpId = @empid) AND ([HR.ApprovalStatus].ReportingManagerApproval IS NULL))

				end
				-- Right Now HR and IT managers are same, need to change this if there are any changes in the roles
				-- Enters this condition if he is a HR Manager
			if(@mgrid = 5  )
			    begin

				SELECT        [HR.ApprovalStatus].ApprovalId, [HR.ApprovalStatus].FK_UserId, [HR.DocumentTypes].Name, [HR.Managers_1].FK_EmpId AS ReportingManagerId, 
                         [HR.ApprovalStatus].ReportingManagerApproval,
                             (SELECT        FK_EmpId
                               FROM            [HR.Managers]
                               WHERE        (Department = 'HR ADMINISTRATION')) AS HRmanagerId, [HR.ApprovalStatus].HRManagerApproval,
                             (SELECT        FK_EmpId
                               FROM            [HR.Managers] AS [HR.Managers_2]
                               WHERE        (Department = 'MANAGEMENT')) AS ManagementId, [HR.ApprovalStatus].ManagementApproval, [HR.ApprovalStatus].ArchiveStatus, 
                         [HR.ApprovalStatus].Data
FROM            [HR.ReportingStructureJn] INNER JOIN
                         [HR.Managers] AS [HR.Managers_1] ON [HR.ReportingStructureJn].FK_ManagerId = [HR.Managers_1].ManagerID INNER JOIN
                         [HR.ApprovalStatus] INNER JOIN
                         [HR.DocumentTypes] ON [HR.ApprovalStatus].FK_DocumentId = [HR.DocumentTypes].DocumentId ON 
                         [HR.ReportingStructureJn].FK_EmpId = [HR.ApprovalStatus].FK_UserId
WHERE       ( ([HR.ApprovalStatus].ArchiveStatus = 0) AND ([HR.ApprovalStatus].ReportingManagerApproval IS NOT NULL) AND ([HR.ApprovalStatus].HRManagerApproval IS NULL))
OR ( ([dbo].[HR.ApprovalStatus].FK_UserId=(SELECT FK_EmpId  FROM [HR.Managers] WHERE (Department = 'HR ADMINISTRATION')))AND ([HR.ApprovalStatus].ArchiveStatus = 0) AND ([HR.ApprovalStatus].ReportingManagerApproval IS  NULL) AND ([HR.ApprovalStatus].HRManagerApproval IS NULL))
			end
			-- Right now both Management & Marketing Managers are same, need to change this if there are any changes in the role
			-- Enters this conditions if he is a Management Representative
			if( @mgrid=6 )
			    begin

					SELECT        [HR.ApprovalStatus].ApprovalId, [HR.ApprovalStatus].FK_UserId, [HR.DocumentTypes].Name, [HR.Managers].FK_EmpId AS ReportingManagerId, 
                         [HR.ApprovalStatus].ReportingManagerApproval, 
						 (SELECT        FK_EmpId
                               FROM            [HR.Managers]
                               WHERE        (Department = 'HR ADMINISTRATION')) AS HRmanagerId,
						 [HR.ApprovalStatus].HRManagerApproval,
						 (SELECT        FK_EmpId
                               FROM            [HR.Managers] AS [HR.Managers_2]
                               WHERE        (Department = 'MANAGEMENT')) AS ManagementId,
						  [HR.ApprovalStatus].ManagementApproval, 
                         [HR.ApprovalStatus].ArchiveStatus, [HR.ApprovalStatus].Data
FROM            [HR.Managers] INNER JOIN
                         [HR.ReportingStructureJn] ON [HR.Managers].ManagerID = [HR.ReportingStructureJn].FK_ManagerId INNER JOIN
                         [HR.ApprovalStatus] INNER JOIN
                         [HR.DocumentTypes] ON [HR.ApprovalStatus].FK_DocumentId = [HR.DocumentTypes].DocumentId ON 
                         [HR.ReportingStructureJn].FK_EmpId = [HR.ApprovalStatus].FK_UserId
WHERE        ([HR.ApprovalStatus].ArchiveStatus = 0) AND ([HR.ApprovalStatus].ReportingManagerApproval = 2) AND ([HR.ApprovalStatus].HRManagerApproval = 2) AND 
                         ([HR.ApprovalStatus].ManagementApproval IS NULL)
				
				end
			

	   end
	   -- Enters this condition if he is a Normal Employee
		else if(@mgrid is null and @flag=1)
		begin
			SELECT        [HR.ApprovalStatus].ApprovalId, [HR.ApprovalStatus].FK_UserId, [HR.DocumentTypes].Name, 

			(SELECT        [HR.Managers].FK_EmpId AS ReportingManagerId
FROM            [HR.ReportingStructureJn] INNER JOIN
                         [HR.Managers] ON [HR.ReportingStructureJn].FK_ManagerId = [HR.Managers].ManagerID
WHERE        ([HR.ReportingStructureJn].FK_EmpId = @empid)) as ReportingManagerId,

			[HR.ApprovalStatus].ReportingManagerApproval, 
			(select FK_EmpId from [HR.Managers] where Department='HR ADMINISTRATION') as HRmanagerId, 
                         [HR.ApprovalStatus].HRManagerApproval, 
						 (select FK_EmpId from [HR.Managers] where Department='MANAGEMENT') as ManagementId,
						 [HR.ApprovalStatus].ManagementApproval, [HR.ApprovalStatus].Data, [HR.ApprovalStatus].ArchiveStatus, 
                         [HR.ApprovalStatus].CreatedDate
FROM            [HR.ApprovalStatus] INNER JOIN
                         [HR.DocumentTypes] ON [HR.ApprovalStatus].FK_DocumentId = [HR.DocumentTypes].DocumentId
WHERE        ([HR.ApprovalStatus].ArchiveStatus = 0) AND ([HR.ApprovalStatus].FK_UserId = @empid)
		end
	else if(@mgrid is not null and @flag =0)
		--this means he is a manager
		begin
			-- Enters this condition, if he is not a HR OR Management OR Marketing head
			if(@mgrid != 5 and @mgrid != 1 and @mgrid != 6  )
				begin

					SELECT        [HR.ApprovalStatus].ApprovalId, [HR.ApprovalStatus].FK_UserId, [HR.DocumentTypes].Name, 
					@empid as ReportingManagerId,
					[HR.ApprovalStatus].ReportingManagerApproval, 
					(select FK_EmpId from [HR.Managers] where Department='HR ADMINISTRATION') as HRmanagerId,
					 [HR.ApprovalStatus].HRManagerApproval, 
					(select FK_EmpId from [HR.Managers] where Department='MANAGEMENT') as ManagementId,						 
						 [HR.ApprovalStatus].ManagementApproval, [HR.ApprovalStatus].ArchiveStatus, [HR.ApprovalStatus].Data
FROM            [HR.ApprovalStatus] INNER JOIN
                         [HR.ReportingStructureJn] ON [HR.ApprovalStatus].FK_UserId = [HR.ReportingStructureJn].FK_EmpId INNER JOIN
                         [HR.Managers] ON [HR.ReportingStructureJn].FK_ManagerId = [HR.Managers].ManagerID INNER JOIN
                         [HR.DocumentTypes] ON [HR.ApprovalStatus].FK_DocumentId = [HR.DocumentTypes].DocumentId
WHERE        ([HR.Managers].FK_EmpId = @empid) AND ([HR.ApprovalStatus].ArchiveStatus = 0 OR
                         [HR.ApprovalStatus].ArchiveStatus = 1)
				end
				-- Right Now HR and IT managers are same, need to change this if there are any changes in the roles
				-- Enters this condition if he is a HR Manager
			if(@mgrid = 5  )
			    begin

					SELECT        [HR.ApprovalStatus].ApprovalId, [HR.ApprovalStatus].FK_UserId, [HR.DocumentTypes].Name, [HR.Managers].FK_EmpId AS ReportingManagerId, 
                         [HR.ApprovalStatus].ReportingManagerApproval,
                             (SELECT        FK_EmpId
                               FROM            [HR.Managers]
                               WHERE        (Department = 'HR ADMINISTRATION')) AS HRmanagerId, [HR.ApprovalStatus].HRManagerApproval,
                             (SELECT        FK_EmpId
                               FROM            [HR.Managers]
                               WHERE        (Department = 'MANAGEMENT')) AS ManagementId, [HR.ApprovalStatus].ManagementApproval, [HR.ApprovalStatus].ArchiveStatus, 
                         [HR.ApprovalStatus].Data
FROM            [HR.Managers] INNER JOIN
                         [HR.ReportingStructureJn] ON [HR.Managers].ManagerID = [HR.ReportingStructureJn].FK_ManagerId INNER JOIN
                         [HR.ApprovalStatus] INNER JOIN
                         [HR.DocumentTypes] ON [HR.ApprovalStatus].FK_DocumentId = [HR.DocumentTypes].DocumentId ON 
                         [HR.ReportingStructureJn].FK_EmpId = [HR.ApprovalStatus].FK_UserId
			end
			-- Right now both Management & Marketing Managers are same, need to change this if there are any changes in the role
			-- Enters this conditions if he is a Management Representative
			if( @mgrid=6 )
			    begin
					SELECT        [HR.ApprovalStatus].ApprovalId, [HR.ApprovalStatus].FK_UserId, [HR.DocumentTypes].Name, [HR.Managers].FK_EmpId AS ReportingManagerId, 
                         [HR.ApprovalStatus].ReportingManagerApproval, 
						 (SELECT        FK_EmpId
                               FROM            [HR.Managers]
                               WHERE        (Department = 'HR ADMINISTRATION')) AS HRmanagerId,
						 [HR.ApprovalStatus].HRManagerApproval,
						 (SELECT        FK_EmpId
                               FROM            [HR.Managers]
                               WHERE        (Department = 'MANAGEMENT')) AS ManagementId, 
						 [HR.ApprovalStatus].ManagementApproval, 
                         [HR.ApprovalStatus].ArchiveStatus, [HR.ApprovalStatus].Data
FROM            [HR.Managers] INNER JOIN
                         [HR.ReportingStructureJn] ON [HR.Managers].ManagerID = [HR.ReportingStructureJn].FK_ManagerId INNER JOIN
                         [HR.ApprovalStatus] INNER JOIN
                         [HR.DocumentTypes] ON [HR.ApprovalStatus].FK_DocumentId = [HR.DocumentTypes].DocumentId ON 
                         [HR.ReportingStructureJn].FK_EmpId = [HR.ApprovalStatus].FK_UserId
				
				end
			

	   end
	   -- Enters this condition if he is a Normal Employee
	else if(@mgrid is null and @flag=0)
		begin
			SELECT        [HR.ApprovalStatus].ApprovalId, [HR.ApprovalStatus].FK_UserId, [HR.DocumentTypes].Name,
                             (SELECT        [HR.Managers].FK_EmpId AS ReportingManagerId
                               FROM            [HR.ReportingStructureJn] INNER JOIN
                                                         [HR.Managers] ON [HR.ReportingStructureJn].FK_ManagerId = [HR.Managers].ManagerID
                               WHERE        ([HR.ReportingStructureJn].FK_EmpId = @empid)) AS ReportingManagerId, [HR.ApprovalStatus].ReportingManagerApproval,
                             (SELECT        FK_EmpId
                               FROM            [HR.Managers] AS [HR.Managers_2]
                               WHERE        (Department = 'HR ADMINISTRATION')) AS HRmanagerId, [HR.ApprovalStatus].HRManagerApproval,
                             (SELECT        FK_EmpId
                               FROM            [HR.Managers] AS [HR.Managers_1]
                               WHERE        (Department = 'MANAGEMENT')) AS ManagementId, [HR.ApprovalStatus].ManagementApproval, [HR.ApprovalStatus].Data, 
                         [HR.ApprovalStatus].ArchiveStatus, [HR.ApprovalStatus].CreatedDate
FROM            [HR.ApprovalStatus] INNER JOIN
                         [HR.DocumentTypes] ON [HR.ApprovalStatus].FK_DocumentId = [HR.DocumentTypes].DocumentId
WHERE        ([HR.ApprovalStatus].FK_UserId = @empid)
		end

END