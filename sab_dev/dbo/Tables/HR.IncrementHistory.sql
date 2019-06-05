CREATE TABLE [dbo].[HR.IncrementHistory] (
    [IncrementId]     INT           IDENTITY (1, 1) NOT NULL,
    [FK_SalaryId]     INT           NOT NULL,
    [IncrementDate]   DATE          NULL,
    [IncrementAmount] FLOAT (53)    NULL,
    [Remarks]         VARCHAR (MAX) NULL,
    [TimeStamp]       DATE          NULL,
    CONSTRAINT [PK_IncrementHistory] PRIMARY KEY CLUSTERED ([IncrementId] ASC)
);

