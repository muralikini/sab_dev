CREATE TABLE [dbo].[OPS_WLJn] (
    [WLJnId]          INT  IDENTITY (1, 1) NOT NULL,
    [FK_WLId]         INT  NOT NULL,
    [FK_WLOperatorId] INT  NOT NULL,
    [StatusFlag]      INT  NULL,
    [CreatedDate]     DATE NULL,
    [ModifiedDate]    DATE NULL,
    CONSTRAINT [PK_OPS_WLJn] PRIMARY KEY CLUSTERED ([WLJnId] ASC),
    CONSTRAINT [FK_OPS_WLJn_OPS_WL] FOREIGN KEY ([FK_WLId]) REFERENCES [dbo].[OPS_WL] ([WLId]),
    CONSTRAINT [FK_OPS_WLJn_OPS_WLOperators] FOREIGN KEY ([FK_WLOperatorId]) REFERENCES [dbo].[OPS_WLOperators] ([WLOperatorId])
);

