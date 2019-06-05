CREATE TABLE [dbo].[HR.ApprovalStatus] (
    [ApprovalId]               INT  IDENTITY (1, 1) NOT NULL,
    [FK_DocumentId]            INT  NOT NULL,
    [FK_UserId]                INT  NOT NULL,
    [ReportingManagerApproval] INT  NULL,
    [HRManagerApproval]        INT  NULL,
    [ManagementApproval]       INT  NULL,
    [Status]                   INT  NULL,
    [CreatedDate]              DATE NULL,
    [FinalApprovalDate]        DATE NULL,
    [ArchiveStatus]            INT  NULL,
    [Data]                     XML  NULL,
    CONSTRAINT [PK_HR.ApprovalStatus] PRIMARY KEY CLUSTERED ([ApprovalId] ASC),
    CONSTRAINT [FK_HR.ApprovalStatus_HR.DocumentTypes] FOREIGN KEY ([FK_DocumentId]) REFERENCES [dbo].[HR.DocumentTypes] ([DocumentId]),
    CONSTRAINT [FK_HR.ApprovalStatus_HR.Employees] FOREIGN KEY ([FK_UserId]) REFERENCES [dbo].[HR.Employees] ([EmpId])
);

