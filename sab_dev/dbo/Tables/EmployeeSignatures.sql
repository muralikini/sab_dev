CREATE TABLE [dbo].[EmployeeSignatures] (
    [SignatureID] INT            IDENTITY (1, 1) NOT NULL,
    [FK_EmpId]    INT            NOT NULL,
    [Signature]   NVARCHAR (MAX) NULL,
    [CreatedDate] DATE           NULL,
    [StatusFlag]  INT            NULL,
    CONSTRAINT [PK_EmployeeSignatures] PRIMARY KEY CLUSTERED ([SignatureID] ASC),
    CONSTRAINT [FK_EmployeeSignatures_HR.Employees] FOREIGN KEY ([FK_EmpId]) REFERENCES [dbo].[HR.Employees] ([EmpId])
);

