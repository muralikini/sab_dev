CREATE TABLE [dbo].[Categories] (
    [CategoryId] INT          IDENTITY (1, 1) NOT NULL,
    [Name]       VARCHAR (50) NOT NULL,
    [Status]     INT          NOT NULL,
    [TimeStamp]  DATETIME     NULL,
    CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([CategoryId] ASC)
);

