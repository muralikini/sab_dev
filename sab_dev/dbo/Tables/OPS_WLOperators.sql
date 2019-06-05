CREATE TABLE [dbo].[OPS_WLOperators] (
    [WLOperatorId]        INT  IDENTITY (1, 1) NOT NULL,
    [SAB_ID]              INT  NULL,
    [CertificationStatus] INT  NOT NULL,
    [CreationDate]        DATE NULL,
    [StatusFlag]          INT  NULL,
    CONSTRAINT [PK_OPS_WLOperators] PRIMARY KEY CLUSTERED ([WLOperatorId] ASC)
);

