CREATE TABLE [dbo].[OPS_LightVehicles] (
    [LightVehicleId] INT           IDENTITY (1, 1) NOT NULL,
    [PlateNo]        NVARCHAR (50) NULL,
    [Sab_Id]         NVARCHAR (50) NULL,
    [Type]           NVARCHAR (50) NULL,
    [CreatedDate]    DATE          NULL,
    [StatusFlag]     INT           NULL,
    CONSTRAINT [PK_OPS_LightVehicles] PRIMARY KEY CLUSTERED ([LightVehicleId] ASC)
);

