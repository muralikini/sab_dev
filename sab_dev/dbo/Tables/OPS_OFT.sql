CREATE TABLE [dbo].[OPS_OFT] (
    [OFTId]       INT           IDENTITY (1, 1) NOT NULL,
    [SAB_ID]      NVARCHAR (20) NOT NULL,
    [Make]        NVARCHAR (50) NULL,
    [PlateNo]     NVARCHAR (50) NULL,
    [CreatedDate] DATE          NULL,
    [StatusFlag]  INT           NULL,
    CONSTRAINT [PK_OPS_OFT] PRIMARY KEY CLUSTERED ([OFTId] ASC)
);

