CREATE TABLE [dbo].[MDC_Junction] (
    [MDC_JunctionId]      INT           IDENTITY (1, 1) NOT NULL,
    [FK_RouteSurveyId]    INT           NOT NULL,
    [FK_LoadDetailsId]    INT           NOT NULL,
    [FK_VehicleDetailsId] INT           NOT NULL,
    [FK_RentalVehiclesId] INT           NOT NULL,
    [RigMovers]           NVARCHAR (50) NULL,
    CONSTRAINT [PK_MDC_Junction] PRIMARY KEY CLUSTERED ([MDC_JunctionId] ASC),
    CONSTRAINT [FK_MDC_Junction_MDC_LoadDetails] FOREIGN KEY ([FK_LoadDetailsId]) REFERENCES [dbo].[MDC_LoadDetails] ([MDC_ID]),
    CONSTRAINT [FK_MDC_Junction_MDC_RentalVehicleDetails] FOREIGN KEY ([FK_RentalVehiclesId]) REFERENCES [dbo].[MDC_RentalVehicleDetails] ([MDC_RentalDetailsID]),
    CONSTRAINT [FK_MDC_Junction_MDC_VehicleDetails] FOREIGN KEY ([FK_VehicleDetailsId]) REFERENCES [dbo].[MDC_VehicleDetails] ([MDC_VehilcleDetailsId])
);

