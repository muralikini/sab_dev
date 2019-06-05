CREATE TABLE [dbo].[OPS_CraneJn] (
    [CraneJnId]     INT  IDENTITY (1, 1) NOT NULL,
    [FK_CraneId]    INT  NOT NULL,
    [FK_OperatorId] INT  NOT NULL,
    [StatusFlag]    INT  NOT NULL,
    [CreatedDate]   DATE NULL,
    [ModifiedDate]  DATE NULL,
    CONSTRAINT [PK_OPS_CraneJn] PRIMARY KEY CLUSTERED ([CraneJnId] ASC),
    CONSTRAINT [FK_OPS_CraneJn_OPS_CraneOperators] FOREIGN KEY ([FK_OperatorId]) REFERENCES [dbo].[OPS_CraneOperators] ([OperatorID]),
    CONSTRAINT [FK_OPS_CraneJn_OPS_Cranes1] FOREIGN KEY ([FK_CraneId]) REFERENCES [dbo].[OPS_Cranes] ([CraneId])
);

