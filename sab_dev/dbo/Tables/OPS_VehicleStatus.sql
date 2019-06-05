CREATE TABLE [dbo].[OPS_VehicleStatus] (
    [VehicleStatusId] INT        IDENTITY (1, 1) NOT NULL,
    [VehicleStatus]   NCHAR (25) NOT NULL,
    [CreatedDate]     DATE       NULL,
    [StatusFlag]      INT        NULL,
    CONSTRAINT [PK_OPS_VehicleStatus] PRIMARY KEY CLUSTERED ([VehicleStatusId] ASC)
);

