CREATE TABLE [dbo].[OPS_RentalTypes] (
    [RentalTypeId]    INT            IDENTITY (1, 1) NOT NULL,
    [TypeDescription] NVARCHAR (MAX) NOT NULL,
    [CreatedDate]     DATE           NULL,
    [StatusFlag]      INT            NULL,
    CONSTRAINT [PK_OPS_RentalTypes] PRIMARY KEY CLUSTERED ([RentalTypeId] ASC)
);

