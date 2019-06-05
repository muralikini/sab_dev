CREATE TABLE [dbo].[MeezanDetails] (
    [MeezanDetailsId] INT          IDENTITY (1, 1) NOT NULL,
    [ExpiryDate]      DATE         NULL,
    [ExpiryHijri]     VARCHAR (50) NULL,
    CONSTRAINT [PK_MeezanDetails] PRIMARY KEY CLUSTERED ([MeezanDetailsId] ASC)
);

