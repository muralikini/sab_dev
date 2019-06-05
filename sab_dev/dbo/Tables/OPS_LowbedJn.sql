CREATE TABLE [dbo].[OPS_LowbedJn] (
    [LBJnId]        INT  IDENTITY (1, 1) NOT NULL,
    [FK_LBId]       INT  NOT NULL,
    [FK_LBDriverId] INT  NOT NULL,
    [StatusFlag]    INT  NULL,
    [CreatedDate]   DATE NULL,
    [ModifiedDate]  DATE NULL,
    CONSTRAINT [PK_OPS_LowbedJn] PRIMARY KEY CLUSTERED ([LBJnId] ASC),
    CONSTRAINT [FK_OPS_LowbedJn_OPS_LowbedDrivers] FOREIGN KEY ([FK_LBDriverId]) REFERENCES [dbo].[OPS_LowbedDrivers] ([LBDriverId]),
    CONSTRAINT [FK_OPS_LowbedJn_OPS_Lowbeds] FOREIGN KEY ([FK_LBId]) REFERENCES [dbo].[OPS_Lowbeds] ([LowbedId])
);

