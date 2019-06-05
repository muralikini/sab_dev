CREATE TABLE [dbo].[Employees_ret] (
    [EmpId]            INT           IDENTITY (1, 1) NOT NULL,
    [Firstname]        VARCHAR (50)  NOT NULL,
    [Lastname]         VARCHAR (50)  NOT NULL,
    [Email]            NVARCHAR (50) NULL,
    [Sex]              NCHAR (10)    NULL,
    [MaritalStatus]    NVARCHAR (20) NOT NULL,
    [DateOfBirth]      DATE          NOT NULL,
    [FK_NationalityId] INT           NOT NULL,
    [FK_ReligionId]    INT           NOT NULL,
    [FK_CountryId]     INT           NOT NULL,
    CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED ([EmpId] ASC),
    CONSTRAINT [FK_Employees_Countries] FOREIGN KEY ([FK_CountryId]) REFERENCES [dbo].[Countries] ([CountryId])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Basic Employee table that stores basic employee details', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Employees_ret';

