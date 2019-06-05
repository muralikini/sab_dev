-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_subqry_GetNotifications_Management]
	-- Add the parameters for the stored procedure here
	@empid  INT,
	@flag  INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF(@flag=1)
	BEGIN
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
                         ([HR.ApprovalStatus].ManagementApproval IS NULL) OR([HR.ApprovalStatus].FK_UserId=@empid)
	END
	ELSE IF(@flag=0)
	BEGIN
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
						 WHERE[dbo].[HR.ApprovalStatus].ManagementApproval IS NOT NULL
						 

	end
    
END