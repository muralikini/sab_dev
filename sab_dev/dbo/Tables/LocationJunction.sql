CREATE TABLE [dbo].[LocationJunction] (
    [LocationJnId] INT          IDENTITY (1, 1) NOT NULL,
    [FK_RigId]     INT          NULL,
    [FK_EmpId]     INT          NULL,
    [FK_VehicleId] INT          NULL,
    [Remarks]      VARCHAR (50) NULL,
    [TimeStamp]    DATE         NULL,
    CONSTRAINT [PK_LocationJunction] PRIMARY KEY CLUSTERED ([LocationJnId] ASC),
    CONSTRAINT [FK_LocationJunction_LocationDetails] FOREIGN KEY ([FK_RigId]) REFERENCES [dbo].[LocationDetails] ([RigId]),
    CONSTRAINT [FK_LocationJunction_VehicleMaster] FOREIGN KEY ([FK_VehicleId]) REFERENCES [dbo].[VehicleMaster] ([VehicleMasterId])
);

