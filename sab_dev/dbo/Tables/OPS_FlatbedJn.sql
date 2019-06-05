CREATE TABLE [dbo].[OPS_FlatbedJn] (
    [FBJnId]        INT  IDENTITY (1, 1) NOT NULL,
    [FK_FBId]       INT  NOT NULL,
    [FK_FBDriverId] INT  NOT NULL,
    [StatusFlag]    INT  NULL,
    [CreatedDate]   DATE NULL,
    [ModifiedDate]  DATE NULL,
    CONSTRAINT [PK_FlatbedJn] PRIMARY KEY CLUSTERED ([FBJnId] ASC),
    CONSTRAINT [FK_OPS_FlatbedJn_OPS_FlatbedDrivers1] FOREIGN KEY ([FK_FBDriverId]) REFERENCES [dbo].[OPS_FlatbedDrivers] ([FBDriverId]),
    CONSTRAINT [FK_OPS_FlatbedJn_OPS_Flatbeds] FOREIGN KEY ([FK_FBId]) REFERENCES [dbo].[OPS_Flatbeds] ([FlatbedId])
);

