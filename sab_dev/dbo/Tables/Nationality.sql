CREATE TABLE [dbo].[Nationality] (
    [NationalityId] INT          IDENTITY (1, 1) NOT NULL,
    [Name]          VARCHAR (50) NOT NULL,
    [TimeStamp]     DATETIME     NULL,
    CONSTRAINT [PK_Nationality] PRIMARY KEY CLUSTERED ([NationalityId] ASC)
);

