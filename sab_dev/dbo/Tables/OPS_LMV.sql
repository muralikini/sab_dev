CREATE TABLE [dbo].[OPS_LMV] (
    [LMVId]       INT           IDENTITY (1, 1) NOT NULL,
    [SAB_ID]      NVARCHAR (20) NULL,
    [PlateNo]     NVARCHAR (20) NULL,
    [Make]        NVARCHAR (20) NULL,
    [CreatedDate] DATE          NULL,
    [StatusFlag]  INT           NULL,
    CONSTRAINT [PK_OPS_LMV] PRIMARY KEY CLUSTERED ([LMVId] ASC)
);

