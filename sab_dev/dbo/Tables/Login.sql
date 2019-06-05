CREATE TABLE [dbo].[Login] (
    [LoginId]   INT            IDENTITY (1, 1) NOT NULL,
    [FK_EmpId]  INT            NOT NULL,
    [FK_RoleId] INT            NOT NULL,
    [UserName]  VARCHAR (50)   NOT NULL,
    [Password]  VARCHAR (50)   NOT NULL,
    [Status]    INT            NOT NULL,
    [DateTime]  DATETIME       NULL,
    [FCMToken]  NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_Login] PRIMARY KEY CLUSTERED ([LoginId] ASC),
    CONSTRAINT [FK_Login_AccessRoles] FOREIGN KEY ([FK_RoleId]) REFERENCES [dbo].[AccessRoles] ([RoleId])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Login Table that stores the login credentials', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Login';

