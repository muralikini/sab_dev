CREATE TABLE [dbo].[OPS_OFTJn] (
    [OFTJnId]        INT  IDENTITY (1, 1) NOT NULL,
    [FK_OFTId]       INT  NOT NULL,
    [FK_OFTDriverId] INT  NULL,
    [StatusFlag]     INT  NULL,
    [CreatedDate]    DATE NULL,
    [ModifiedDate]   DATE NULL,
    CONSTRAINT [PK_OPS_OFTJn] PRIMARY KEY CLUSTERED ([OFTJnId] ASC),
    CONSTRAINT [FK_OPS_OFTJn_OPS_LowbedDrivers1] FOREIGN KEY ([FK_OFTDriverId]) REFERENCES [dbo].[OPS_LowbedDrivers] ([LBDriverId]),
    CONSTRAINT [FK_OPS_OFTJn_OPS_OFT1] FOREIGN KEY ([FK_OFTId]) REFERENCES [dbo].[OPS_OFT] ([OFTId])
);

