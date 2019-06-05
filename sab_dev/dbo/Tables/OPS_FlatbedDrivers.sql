CREATE TABLE [dbo].[OPS_FlatbedDrivers] (
    [FBDriverId]     INT  IDENTITY (1, 1) NOT NULL,
    [SAB_ID]         INT  NOT NULL,
    [DateOfCreation] DATE NULL,
    [StatusFlag]     INT  NULL,
    CONSTRAINT [PK_OPS_FlatbedDrivers] PRIMARY KEY CLUSTERED ([FBDriverId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This status flag contains the following Information of the drivers
0 - Idle and in the yard
1 - On duty/Rinmove/Rental
2 - Sick
3 - Vacation
4 - Exit
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OPS_FlatbedDrivers', @level2type = N'COLUMN', @level2name = N'StatusFlag';

