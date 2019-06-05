CREATE TABLE [dbo].[OPS_CraneOperators] (
    [OperatorID]          INT  NOT NULL,
    [SAB_ID]              INT  NOT NULL,
    [CertificationStatus] INT  NOT NULL,
    [DateOfCreation]      DATE NULL,
    [StatusFlag]          INT  NULL,
    CONSTRAINT [PK_OPS_CraneOperators] PRIMARY KEY CLUSTERED ([OperatorID] ASC)
);

