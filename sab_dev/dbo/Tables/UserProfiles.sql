CREATE TABLE [dbo].[UserProfiles] (
    [ProfileId]   INT            IDENTITY (1, 1) NOT NULL,
    [FK_EmpId]    INT            NOT NULL,
    [Name]        NVARCHAR (100) NULL,
    [Email]       NVARCHAR (50)  NULL,
    [PhoneNumber] NVARCHAR (25)  NULL,
    [Designation] NVARCHAR (50)  NULL,
    [Nationality] NVARCHAR (50)  NULL,
    [Image]       NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_UserProfiles] PRIMARY KEY CLUSTERED ([ProfileId] ASC),
    CONSTRAINT [FK_UserProfiles_HR.Employees] FOREIGN KEY ([FK_EmpId]) REFERENCES [dbo].[HR.Employees] ([EmpId])
);

