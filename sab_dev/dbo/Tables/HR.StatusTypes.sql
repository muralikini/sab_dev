CREATE TABLE [dbo].[HR.StatusTypes] (
    [StatusId] INT            IDENTITY (1, 1) NOT NULL,
    [Name]     NVARCHAR (255) NOT NULL,
    CONSTRAINT [PK_HR.StatusTypes] PRIMARY KEY CLUSTERED ([StatusId] ASC)
);

