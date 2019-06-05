CREATE TABLE [dbo].[OPS_LowbedDrivers] (
    [LBDriverId]     INT  IDENTITY (1, 1) NOT NULL,
    [SAB_ID]         INT  NOT NULL,
    [DateOfCreation] DATE NULL,
    [StatusFlag]     INT  NULL,
    CONSTRAINT [PK_OPS_LowbedDrivers] PRIMARY KEY CLUSTERED ([LBDriverId] ASC)
);

