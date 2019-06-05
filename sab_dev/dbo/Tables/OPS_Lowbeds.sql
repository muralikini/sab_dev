CREATE TABLE [dbo].[OPS_Lowbeds] (
    [LowbedId]    INT           IDENTITY (1, 1) NOT NULL,
    [PlateNo]     NVARCHAR (50) NOT NULL,
    [Sab_Id]      NVARCHAR (50) NOT NULL,
    [Type]        NVARCHAR (50) NULL,
    [CreatedDate] DATE          NULL,
    [StatusFlag]  INT           NULL,
    CONSTRAINT [PK_OPS_Lowbeds] PRIMARY KEY CLUSTERED ([LowbedId] ASC)
);

