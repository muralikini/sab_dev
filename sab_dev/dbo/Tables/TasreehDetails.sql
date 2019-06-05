CREATE TABLE [dbo].[TasreehDetails] (
    [TasreehId]   INT          IDENTITY (1, 1) NOT NULL,
    [ExpiryDate]  DATE         NOT NULL,
    [ExpiryHijri] VARCHAR (50) NULL,
    CONSTRAINT [PK_TasreehDetails] PRIMARY KEY CLUSTERED ([TasreehId] ASC)
);

