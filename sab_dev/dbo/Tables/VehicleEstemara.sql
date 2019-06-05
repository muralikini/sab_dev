CREATE TABLE [dbo].[VehicleEstemara] (
    [EstemaraId]  INT          IDENTITY (1, 1) NOT NULL,
    [ExpiryDate]  DATE         NOT NULL,
    [ExpiryHijri] VARCHAR (50) NULL,
    CONSTRAINT [PK_VehicleEstemara] PRIMARY KEY CLUSTERED ([EstemaraId] ASC)
);

