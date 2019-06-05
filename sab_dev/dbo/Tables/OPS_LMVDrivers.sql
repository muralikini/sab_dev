CREATE TABLE [dbo].[OPS_LMVDrivers] (
    [LMVDriverId] INT           IDENTITY (1, 1) NOT NULL,
    [SAB_ID]      NVARCHAR (20) NOT NULL,
    [CreatedDate] DATE          NULL,
    [StatusFlag]  INT           NULL,
    CONSTRAINT [PK_OPS_LMVDrivers] PRIMARY KEY CLUSTERED ([LMVDriverId] ASC)
);

