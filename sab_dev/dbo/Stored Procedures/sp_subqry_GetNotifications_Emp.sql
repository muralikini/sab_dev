-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_subqry_GetNotifications_Emp]
	-- Add the parameters for the stored procedure here
	@empid INT ,
	@flag INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF(@flag=1)
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
	END
    ELSE IF(@flag=0)
	BEGIN
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

	END
END