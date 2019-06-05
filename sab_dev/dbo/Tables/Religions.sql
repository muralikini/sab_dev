CREATE TABLE [dbo].[Religions] (
    [ReligionId] INT          IDENTITY (1, 1) NOT NULL,
    [Name]       VARCHAR (50) NOT NULL,
    [TimeStamp]  DATETIME     NULL,
    CONSTRAINT [PK_Religions] PRIMARY KEY CLUSTERED ([ReligionId] ASC)
);

