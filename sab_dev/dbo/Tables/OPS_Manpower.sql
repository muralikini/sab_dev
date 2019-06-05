CREATE TABLE [dbo].[OPS_Manpower] (
    [ManPowerId]          INT           IDENTITY (1, 1) NOT NULL,
    [SAB_ID]              INT           NOT NULL,
    [ManPowerType]        NVARCHAR (50) NULL,
    [CertificationStatus] INT           NULL,
    [CreatedDate]         DATE          NULL,
    [StatusFlag]          INT           NULL,
    CONSTRAINT [PK_OPS_Manpower] PRIMARY KEY CLUSTERED ([ManPowerId] ASC)
);

