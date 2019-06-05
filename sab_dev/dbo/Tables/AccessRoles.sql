CREATE TABLE [dbo].[AccessRoles] (
    [RoleId]      INT        IDENTITY (1, 1) NOT NULL,
    [Name]        NCHAR (50) NOT NULL,
    [CreatedDate] DATE       NULL,
    CONSTRAINT [PK_AccessRoles] PRIMARY KEY CLUSTERED ([RoleId] ASC)
);

