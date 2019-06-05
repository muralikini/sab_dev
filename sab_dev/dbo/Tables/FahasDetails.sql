CREATE TABLE [dbo].[FahasDetails] (
    [FahasId]     INT          IDENTITY (1, 1) NOT NULL,
    [ExpiryDate]  DATE         NOT NULL,
    [ExpiryHijri] VARCHAR (50) NULL,
    CONSTRAINT [PK_FahasDetails] PRIMARY KEY CLUSTERED ([FahasId] ASC)
);

