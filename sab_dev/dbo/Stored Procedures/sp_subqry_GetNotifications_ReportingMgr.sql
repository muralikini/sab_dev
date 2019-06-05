-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	This is a sub stored procedure to be called when the emp id is that of a reporting manager
-- but the reporting manager is not a HR or anyone from Management
-- =============================================
CREATE PROCEDURE [dbo].[sp_subqry_GetNotifications_ReportingMgr]
	-- Add the parameters for the stored procedure here
	@empid INT,
	@flag INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF(@flag=1)
		BEGIN
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
			OR (([HR.ApprovalStatus].FK_UserId =@empid) AND ([HR.ApprovalStatus].ArchiveStatus = 0) AND ([HR.ApprovalStatus].ReportingManagerApproval IS NULL))
		end
   ELSE IF(@flag=0)
	   BEGIN
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
			WHERE        ([HR.Managers].FK_EmpId = @empid AND ([HR.ApprovalStatus].ReportingManagerApproval IS NOT NULL)) 
			OR (([HR.ApprovalStatus].FK_UserId =@empid))

   
	   END
   
END