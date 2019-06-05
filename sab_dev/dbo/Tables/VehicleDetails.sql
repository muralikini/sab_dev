CREATE TABLE [dbo].[VehicleDetails] (
    [VehicleId]       INT            IDENTITY (1, 1) NOT NULL,
    [FK_EmpId]        INT            NOT NULL,
    [Code]            NVARCHAR (50)  NULL,
    [ManufactureDate] DATE           NULL,
    [RegistrationNo]  NVARCHAR (50)  NULL,
    [ChasisNo]        NVARCHAR (50)  NULL,
    [PlateNo]         NVARCHAR (50)  NULL,
    [VehicleStatus]   VARCHAR (50)   NULL,
    [Remarks]         NVARCHAR (MAX) NULL,
    [TimeStamp]       DATETIME       NULL,
    CONSTRAINT [PK_VehicleDetails] PRIMARY KEY CLUSTERED ([VehicleId] ASC),
    CONSTRAINT [FK_VehicleDetails_Employees] FOREIGN KEY ([FK_EmpId]) REFERENCES [dbo].[Employees_ret] ([EmpId])
);

