CREATE TABLE [dbo].[VehicleInsurance] (
    [InsuranceId] INT          IDENTITY (1, 1) NOT NULL,
    [ExpiryDate]  DATE         NOT NULL,
    [ExpiryHijri] VARCHAR (50) NULL,
    CONSTRAINT [PK_VehicleInsurance] PRIMARY KEY CLUSTERED ([InsuranceId] ASC)
);

