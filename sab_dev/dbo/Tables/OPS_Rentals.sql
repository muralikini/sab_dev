CREATE TABLE [dbo].[OPS_Rentals] (
    [RentalsId]       INT            IDENTITY (1, 1) NOT NULL,
    [FK_RentalTypeId] INT            NULL,
    [Name]            NVARCHAR (50)  NOT NULL,
    [Owner]           NVARCHAR (50)  NULL,
    [PlateNo]         NVARCHAR (500) NULL,
    [VehicleId]       NVARCHAR (20)  NULL,
    [CreatedDate]     DATE           NULL,
    [StatusFlag]      INT            NULL,
    CONSTRAINT [PK_OPS_Rentals] PRIMARY KEY CLUSTERED ([RentalsId] ASC),
    CONSTRAINT [FK_OPS_Rentals_OPS_RentalTypes] FOREIGN KEY ([FK_RentalTypeId]) REFERENCES [dbo].[OPS_RentalTypes] ([RentalTypeId])
);

