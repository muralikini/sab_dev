CREATE TABLE [dbo].[PassportDetails] (
    [PassportId] INT          IDENTITY (1, 1) NOT NULL,
    [FK_EmpId]   INT          NOT NULL,
    [Number]     VARCHAR (50) NOT NULL,
    [IssueDate]  DATE         NOT NULL,
    [ExpiryDate] DATE         NOT NULL,
    [Status]     INT          NULL,
    [TimeStamp]  DATETIME     NULL,
    CONSTRAINT [PK_PassportDetails] PRIMARY KEY CLUSTERED ([PassportId] ASC)
);

