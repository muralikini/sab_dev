CREATE TABLE [dbo].[VehicleTypes] (
    [VehicleTypeId] INT           NOT NULL,
    [Type]          NVARCHAR (50) NULL,
    [TimeStamp]     DATE          NULL,
    CONSTRAINT [PK_VehicleTypes] PRIMARY KEY CLUSTERED ([VehicleTypeId] ASC)
);

