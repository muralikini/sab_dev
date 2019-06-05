CREATE TABLE [dbo].[AramcoInspectionDetails] (
    [AramcoInspectionId] INT          NOT NULL,
    [ExpiryDate]         DATE         NOT NULL,
    [ExpiryHijri]        VARCHAR (50) NULL,
    CONSTRAINT [PK_AramcoInspectionDetails] PRIMARY KEY CLUSTERED ([AramcoInspectionId] ASC)
);

