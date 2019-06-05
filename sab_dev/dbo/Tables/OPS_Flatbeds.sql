CREATE TABLE [dbo].[OPS_Flatbeds] (
    [FlatbedId]   INT           IDENTITY (1, 1) NOT NULL,
    [PlateNo]     NVARCHAR (20) NOT NULL,
    [SAB_ID]      NVARCHAR (20) NULL,
    [CreatedDate] DATE          NULL,
    [Type]        NVARCHAR (50) NULL,
    [StatusFlag]  INT           NULL,
    CONSTRAINT [PK_OPS_Flatbeds] PRIMARY KEY CLUSTERED ([FlatbedId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This status flag is used to store the following status of the trucks
0- idle and in the yard
1- On duty/Rig Move/Rentals
2- Breakdown/Maintainance
3 - Not working anymore', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OPS_Flatbeds', @level2type = N'COLUMN', @level2name = N'StatusFlag';

