CREATE TABLE [dbo].[AccessPermissions] (
    [AccessPermissionId] INT  IDENTITY (1, 1) NOT NULL,
    [FK_RoleId]          INT  NOT NULL,
    [FK_Module]          INT  NOT NULL,
    [Permission]         INT  NOT NULL,
    [CreatedDate]        DATE NULL,
    CONSTRAINT [PK_AccessPermissions] PRIMARY KEY CLUSTERED ([AccessPermissionId] ASC),
    CONSTRAINT [FK_AccessPermissions_AccessRoles] FOREIGN KEY ([FK_RoleId]) REFERENCES [dbo].[AccessRoles] ([RoleId]),
    CONSTRAINT [FK_AccessPermissions_Modules] FOREIGN KEY ([FK_Module]) REFERENCES [dbo].[Modules] ([ModuleID])
);

