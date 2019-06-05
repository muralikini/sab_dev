CREATE TABLE [dbo].[LocationDetails] (
    [RigId]           INT           IDENTITY (1, 1) NOT NULL,
    [FK_ClientId]     INT           NOT NULL,
    [FK_WellTypeId]   INT           NOT NULL,
    [RigNo]           VARCHAR (50)  NULL,
    [Active]          NCHAR (10)    NULL,
    [CurrentLocation] VARCHAR (100) NULL,
    [Remarks]         VARCHAR (MAX) NULL,
    [TimeStamp]       DATETIME      NULL,
    CONSTRAINT [PK_RigDetails] PRIMARY KEY CLUSTERED ([RigId] ASC)
);

