CREATE TABLE [dbo].[EquipmentSpecifications] (
    [EquipmentSpecId] INT          IDENTITY (1, 1) NOT NULL,
    [Make]            VARCHAR (50) NULL,
    [Model]           VARCHAR (50) NULL,
    [Capacity]        VARCHAR (50) NULL,
    CONSTRAINT [PK_EquipmentSpecifications] PRIMARY KEY CLUSTERED ([EquipmentSpecId] ASC)
);

