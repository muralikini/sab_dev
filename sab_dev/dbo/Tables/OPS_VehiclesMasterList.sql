CREATE TABLE [dbo].[OPS_VehiclesMasterList] (
    [MasterListId]   INT            IDENTITY (1, 1) NOT NULL,
    [PlateNo]        NVARCHAR (50)  NOT NULL,
    [Sab_Id]         NVARCHAR (50)  NOT NULL,
    [SequenceNo]     NVARCHAR (50)  NULL,
    [Brandname]      NVARCHAR (100) NULL,
    [Model]          NVARCHAR (50)  NULL,
    [Inceptiondate]  DATETIME       NULL,
    [IstemaraExpiry] DATETIME       NULL,
    [BodyType]       NVARCHAR (50)  NULL,
    [ChasisNumber]   NVARCHAR (100) NULL,
    [Company]        NVARCHAR (100) NULL,
    [CreatedDate]    DATETIME       NULL,
    [StatusFlag]     NVARCHAR (50)  NULL,
    CONSTRAINT [PK_OPS_VehiclesMasterList] PRIMARY KEY CLUSTERED ([MasterListId] ASC)
);

