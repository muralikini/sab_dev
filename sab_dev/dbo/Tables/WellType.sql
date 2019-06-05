CREATE TABLE [dbo].[WellType] (
    [WellTypeId] INT          IDENTITY (1, 1) NOT NULL,
    [WellType]   VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_WellType] PRIMARY KEY CLUSTERED ([WellTypeId] ASC)
);

