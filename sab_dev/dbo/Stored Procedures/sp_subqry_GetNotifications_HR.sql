-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_subqry_GetNotifications_HR] 
	-- Add the parameters for the stored procedure here
	@empid INT,
	@flag INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF(@flag =1)
		BEGIN
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
			OR ( ([dbo].[HR.ApprovalStatus].FK_UserId=(SELECT FK_EmpId  FROM [HR.Managers] WHERE (Department = 'HR ADMINISTRATION')))AND ([HR.ApprovalStatus].ArchiveStatus = 0) AND ([HR.ApprovalStatus].ReportingManagerApproval IS  NULL))
		END
	ELSE IF (@flag=0)
	BEGIN
    
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
						 WHERE       ( (([HR.ApprovalStatus].ArchiveStatus = 0) OR ([HR.ApprovalStatus].ArchiveStatus = 1)) AND [dbo].[HR.ApprovalStatus].HRManagerApproval IS NOT null)
			OR ( ([dbo].[HR.ApprovalStatus].FK_UserId=(SELECT FK_EmpId  FROM [HR.Managers] WHERE (Department = 'HR ADMINISTRATION'))))
	END
    
        
	
END