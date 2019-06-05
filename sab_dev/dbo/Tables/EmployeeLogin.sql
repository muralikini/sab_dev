CREATE TABLE [dbo].[EmployeeLogin] (
    [LoginId]   INT            IDENTITY (1, 1) NOT NULL,
    [FK_EmpId]  INT            NOT NULL,
    [FK_RoleId] INT            NOT NULL,
    [UserName]  NVARCHAR (50)  NOT NULL,
    [Password]  NVARCHAR (50)  NOT NULL,
    [Status]    INT            NOT NULL,
    [DateTime]  DATETIME       NULL,
    [FCMToken]  NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_EmployeeLogin] PRIMARY KEY CLUSTERED ([LoginId] ASC),
    CONSTRAINT [FK_EmployeeLogin_AccessRoles] FOREIGN KEY ([FK_RoleId]) REFERENCES [dbo].[AccessRoles] ([RoleId]),
    CONSTRAINT [FK_EmployeeLogin_HR.Employees] FOREIGN KEY ([FK_EmpId]) REFERENCES [dbo].[HR.Employees] ([EmpId])
);

