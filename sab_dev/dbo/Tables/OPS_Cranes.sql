CREATE TABLE [dbo].[OPS_Cranes] (
    [CraneId]     INT           IDENTITY (1, 1) NOT NULL,
    [SAB_ID]      NVARCHAR (50) NULL,
    [Brand]       NVARCHAR (50) NULL,
    [Weight]      NVARCHAR (20) NULL,
    [Type]        NVARCHAR (50) NULL,
    [Class]       NVARCHAR (20) NULL,
    [PlateNo]     NVARCHAR (50) NULL,
    [CreatedDate] DATE          NULL,
    [StatusFlag]  INT           NULL,
    CONSTRAINT [PK_OPS_Cranes] PRIMARY KEY CLUSTERED ([CraneId] ASC)
);

