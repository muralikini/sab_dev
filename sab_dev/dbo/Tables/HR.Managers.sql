CREATE TABLE [dbo].[HR.Managers] (
    [ManagerID]   INT            IDENTITY (1, 1) NOT NULL,
    [FK_EmpId]    INT            NOT NULL,
    [Department]  NVARCHAR (255) NOT NULL,
    [CreatedDate] DATE           NULL,
    [Status]      INT            NULL,
    CONSTRAINT [PK_HR.Managers] PRIMARY KEY CLUSTERED ([ManagerID] ASC),
    CONSTRAINT [FK_HR.Managers_HR.Employees] FOREIGN KEY ([FK_EmpId]) REFERENCES [dbo].[HR.Employees] ([EmpId])
);

