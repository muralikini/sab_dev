CREATE TABLE [dbo].[HR.SalaryDetails] (
    [SalaryId]      INT           IDENTITY (1, 1) NOT NULL,
    [FK_EmpId]      INT           NOT NULL,
    [Basic]         FLOAT (53)    NOT NULL,
    [HRA]           FLOAT (53)    NULL,
    [DA]            FLOAT (53)    NULL,
    [Conveyance]    FLOAT (53)    NULL,
    [FoodAllowance] FLOAT (53)    NULL,
    [FixedOT]       FLOAT (53)    NULL,
    [Others]        FLOAT (53)    NULL,
    [Remarks]       VARCHAR (MAX) NULL,
    [Gross]         FLOAT (53)    NULL,
    [TimeStamp]     DATE          NULL,
    CONSTRAINT [PK_SalaryDetails] PRIMARY KEY CLUSTERED ([SalaryId] ASC),
    CONSTRAINT [FK_SalaryDetails_HR.Employees] FOREIGN KEY ([FK_EmpId]) REFERENCES [dbo].[HR.Employees] ([EmpId])
);

