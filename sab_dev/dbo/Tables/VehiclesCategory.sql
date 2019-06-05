CREATE TABLE [dbo].[VehiclesCategory] (
    [CategoryId]   INT            IDENTITY (1, 1) NOT NULL,
    [Name]         NVARCHAR (50)  NULL,
    [Manufacturer] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_VehiclesCategory] PRIMARY KEY CLUSTERED ([CategoryId] ASC)
);

