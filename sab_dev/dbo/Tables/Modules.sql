CREATE TABLE [dbo].[Modules] (
    [ModuleID]    INT           IDENTITY (1, 1) NOT NULL,
    [ModuleName]  NVARCHAR (50) NOT NULL,
    [CreatedDate] DATE          NULL,
    CONSTRAINT [PK_Modules] PRIMARY KEY CLUSTERED ([ModuleID] ASC)
);

