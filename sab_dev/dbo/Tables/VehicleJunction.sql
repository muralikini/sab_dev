CREATE TABLE [dbo].[VehicleJunction] (
    [VehicleJunctionId]    INT IDENTITY (1, 1) NOT NULL,
    [FK_VehicleId]         INT NULL,
    [FK_InsuranceId]       INT NULL,
    [FK_VehicleTypeId]     INT NULL,
    [FK_VehicleCategoryId] INT NULL,
    [FK_MeezanDetailsId]   INT NULL,
    [FK_FahasDetailsId]    INT NULL,
    [Fk_EstemaraId]        INT NULL,
    [FK_TasreehId]         INT NULL,
    [FK_AramcoExpiryId]    INT NULL,
    CONSTRAINT [PK_VehicleJunction] PRIMARY KEY CLUSTERED ([VehicleJunctionId] ASC),
    CONSTRAINT [FK_VehicleJunction_AramcoInspectionDetails] FOREIGN KEY ([FK_AramcoExpiryId]) REFERENCES [dbo].[AramcoInspectionDetails] ([AramcoInspectionId]),
    CONSTRAINT [FK_VehicleJunction_FahasDetails] FOREIGN KEY ([FK_FahasDetailsId]) REFERENCES [dbo].[FahasDetails] ([FahasId]),
    CONSTRAINT [FK_VehicleJunction_MeezanDetails] FOREIGN KEY ([FK_MeezanDetailsId]) REFERENCES [dbo].[MeezanDetails] ([MeezanDetailsId]),
    CONSTRAINT [FK_VehicleJunction_TasreehDetails] FOREIGN KEY ([FK_TasreehId]) REFERENCES [dbo].[TasreehDetails] ([TasreehId]),
    CONSTRAINT [FK_VehicleJunction_VehicleDetails] FOREIGN KEY ([FK_VehicleId]) REFERENCES [dbo].[VehicleDetails] ([VehicleId]),
    CONSTRAINT [FK_VehicleJunction_VehicleEstemara] FOREIGN KEY ([Fk_EstemaraId]) REFERENCES [dbo].[VehicleEstemara] ([EstemaraId]),
    CONSTRAINT [FK_VehicleJunction_VehicleInsurance] FOREIGN KEY ([FK_InsuranceId]) REFERENCES [dbo].[VehicleInsurance] ([InsuranceId]),
    CONSTRAINT [FK_VehicleJunction_VehiclesCategory] FOREIGN KEY ([FK_VehicleCategoryId]) REFERENCES [dbo].[VehiclesCategory] ([CategoryId]),
    CONSTRAINT [FK_VehicleJunction_VehicleTypes] FOREIGN KEY ([FK_VehicleTypeId]) REFERENCES [dbo].[VehicleTypes] ([VehicleTypeId])
);

