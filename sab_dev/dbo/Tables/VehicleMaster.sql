CREATE TABLE [dbo].[VehicleMaster] (
    [VehicleMasterId] INT          IDENTITY (1, 1) NOT NULL,
    [VehicleCode]     VARCHAR (50) NULL,
    [Make]            VARCHAR (50) NULL,
    [Capacity]        VARCHAR (50) NULL,
    [Model]           VARCHAR (50) NULL,
    [NumberPlate]     VARCHAR (50) NULL,
    [Year]            VARCHAR (50) NULL,
    [SerialNo]        VARCHAR (50) NULL,
    [VehicleColour]   VARCHAR (25) NULL,
    [Estemarah]       DATE         NULL,
    [Fahas]           DATE         NULL,
    [Meezan]          DATE         NULL,
    [Insurance]       DATE         NULL,
    CONSTRAINT [PK_VehicleMaster] PRIMARY KEY CLUSTERED ([VehicleMasterId] ASC)
);

