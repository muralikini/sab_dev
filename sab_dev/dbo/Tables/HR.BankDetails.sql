CREATE TABLE [dbo].[HR.BankDetails] (
    [BankAccountId] INT          IDENTITY (1, 1) NOT NULL,
    [FK_EmpId]      INT          NOT NULL,
    [BankName]      VARCHAR (50) NULL,
    [CustomerNo]    VARCHAR (50) NULL,
    [AccountNo]     VARCHAR (50) NULL,
    [TimeStamp]     DATE         NULL,
    CONSTRAINT [PK_BankDetails] PRIMARY KEY CLUSTERED ([BankAccountId] ASC),
    CONSTRAINT [FK_BankDetails_HR.Employees] FOREIGN KEY ([FK_EmpId]) REFERENCES [dbo].[HR.Employees] ([EmpId])
);

