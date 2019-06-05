CREATE TABLE [dbo].[Designations] (
    [DesignationId] INT          IDENTITY (1, 1) NOT NULL,
    [Name]          VARCHAR (50) NOT NULL,
    [TimeStamp]     DATETIME     NULL,
    CONSTRAINT [PK_Designations] PRIMARY KEY CLUSTERED ([DesignationId] ASC)
);

