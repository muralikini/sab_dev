CREATE TABLE [dbo].[Clients] (
    [ClientId]  INT           IDENTITY (1, 1) NOT NULL,
    [Name]      VARCHAR (100) NOT NULL,
    [Location]  VARCHAR (50)  NULL,
    [Address]   VARCHAR (MAX) NULL,
    [ZIPCode]   VARCHAR (50)  NULL,
    [Active]    INT           NULL,
    [TimeStamp] DATETIME      NULL,
    CONSTRAINT [PK_Clients] PRIMARY KEY CLUSTERED ([ClientId] ASC)
);

