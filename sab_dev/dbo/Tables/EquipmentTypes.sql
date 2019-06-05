CREATE TABLE [dbo].[EquipmentTypes] (
    [EquipmentTypeId] INT           IDENTITY (1, 1) NOT NULL,
    [Type]            VARCHAR (50)  NOT NULL,
    [Remarks]         VARCHAR (MAX) NULL,
    CONSTRAINT [PK_EquipmentTypes] PRIMARY KEY CLUSTERED ([EquipmentTypeId] ASC)
);

