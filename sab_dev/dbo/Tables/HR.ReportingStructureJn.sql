CREATE TABLE [dbo].[HR.ReportingStructureJn] (
    [ReportingId]  INT  IDENTITY (1, 1) NOT NULL,
    [FK_EmpId]     INT  NOT NULL,
    [FK_ManagerId] INT  NOT NULL,
    [CreatedDate]  DATE NULL,
    [Status]       INT  NULL,
    CONSTRAINT [PK_ReportingStructureJn] PRIMARY KEY CLUSTERED ([ReportingId] ASC),
    CONSTRAINT [FK_HR.ReportingStructureJn_HR.Employees] FOREIGN KEY ([FK_EmpId]) REFERENCES [dbo].[HR.Employees] ([EmpId]),
    CONSTRAINT [FK_HR.ReportingStructureJn_HR.Managers] FOREIGN KEY ([FK_ManagerId]) REFERENCES [dbo].[HR.Managers] ([ManagerID])
);

