CREATE TABLE [dbo].[WellSiteDetails] (
    [WellSiteId]    INT           IDENTITY (1, 1) NOT NULL,
    [FK_ClientId]   INT           NOT NULL,
    [FK_WellTypeId] INT           NOT NULL,
    [WellNumber]    NVARCHAR (50) NOT NULL,
    [CreatedDate]   DATE          NULL,
    [Status]        INT           NULL,
    CONSTRAINT [PK_WellSiteDetails] PRIMARY KEY CLUSTERED ([WellSiteId] ASC),
    CONSTRAINT [FK_WellSiteDetails_Clients] FOREIGN KEY ([FK_ClientId]) REFERENCES [dbo].[Clients] ([ClientId]),
    CONSTRAINT [FK_WellSiteDetails_WellType] FOREIGN KEY ([FK_WellTypeId]) REFERENCES [dbo].[WellType] ([WellTypeId])
);

