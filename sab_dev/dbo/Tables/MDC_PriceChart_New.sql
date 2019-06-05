CREATE TABLE [dbo].[MDC_PriceChart_New] (
    [MDC_PriceChartId]      INT        IDENTITY (1, 1) NOT NULL,
    [FK_RouteSurveyId]      INT        NOT NULL,
    [DieselPricePerLitre]   FLOAT (53) NULL,
    [GasolinePricePerLitre] FLOAT (53) NULL,
    [FB]                    FLOAT (53) NULL,
    [LB]                    FLOAT (53) NULL,
    [LMV]                   FLOAT (53) NULL,
    [CreatedDate]           DATE       NULL,
    [StatusFlag]            INT        NOT NULL,
    CONSTRAINT [PK_MDC_PriceChart_New] PRIMARY KEY CLUSTERED ([MDC_PriceChartId] ASC)
);

