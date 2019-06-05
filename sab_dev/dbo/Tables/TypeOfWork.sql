CREATE TABLE [dbo].[TypeOfWork] (
    [WorkTypeId] INT          IDENTITY (1, 1) NOT NULL,
    [TypeOfWork] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_TypeOfWork] PRIMARY KEY CLUSTERED ([WorkTypeId] ASC)
);

