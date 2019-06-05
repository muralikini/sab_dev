CREATE TABLE [dbo].[Grades] (
    [GradeId]   INT          IDENTITY (1, 1) NOT NULL,
    [Name]      VARCHAR (50) NOT NULL,
    [Status]    INT          NOT NULL,
    [TimeStamp] DATETIME     NULL,
    CONSTRAINT [PK_Grades] PRIMARY KEY CLUSTERED ([GradeId] ASC)
);

