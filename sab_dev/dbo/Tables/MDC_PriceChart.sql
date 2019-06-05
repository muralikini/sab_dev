CREATE TABLE [dbo].[MDC_PriceChart] (
    [PriceListId]           INT        IDENTITY (1, 1) NOT NULL,
    [DieselPricePerLitre]   FLOAT (53) NULL,
    [GasolinePricePerLitre] FLOAT (53) NULL,
    [FB]                    FLOAT (53) NULL,
    [LB]                    FLOAT (53) NULL,
    [LMV]                   FLOAT (53) NULL,
    CONSTRAINT [PK_MDC_PriceChart] PRIMARY KEY CLUSTERED ([PriceListId] ASC)
);

