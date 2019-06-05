CREATE TABLE [dbo].[HR.DocumentTypes] (
    [DocumentId]  INT            IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (255) NOT NULL,
    [CreatedDate] DATE           NULL,
    [Status]      INT            NULL,
    CONSTRAINT [PK_HR.DocumentTypes] PRIMARY KEY CLUSTERED ([DocumentId] ASC)
);

