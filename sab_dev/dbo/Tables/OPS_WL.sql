CREATE TABLE [dbo].[OPS_WL] (
    [WLId]         INT           IDENTITY (1, 1) NOT NULL,
    [SAB_ID]       NVARCHAR (50) NULL,
    [Manufacturer] NVARCHAR (20) NULL,
    [Capacity]     NVARCHAR (50) NULL,
    [Model]        NVARCHAR (20) NULL,
    [PlateNo]      NCHAR (20)    NULL,
    [CreatedDate]  DATE          NULL,
    [StatusFlag]   INT           NULL,
    CONSTRAINT [PK_OPS_WL] PRIMARY KEY CLUSTERED ([WLId] ASC)
);

