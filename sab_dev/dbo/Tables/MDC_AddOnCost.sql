CREATE TABLE [dbo].[MDC_AddOnCost] (
    [MDC_AddOnCostId]    INT        IDENTITY (1, 1) NOT NULL,
    [FK_RouteSurveyId]   INT        NOT NULL,
    [FoodDays]           INT        NOT NULL,
    [FoodRate]           FLOAT (53) NOT NULL,
    [ExtraMobLoadedLB]   INT        NOT NULL,
    [ExtraDemobLoadedLB] INT        NOT NULL,
    [Manpower]           INT        NULL,
    [Maintainance]       FLOAT (53) NULL,
    [DateOfCreation]     DATETIME   NULL,
    [StatusFlag]         INT        NULL,
    CONSTRAINT [PK_MDC_AddOnCost] PRIMARY KEY CLUSTERED ([MDC_AddOnCostId] ASC),
    CONSTRAINT [FK_MDC_AddOnCost_RoadSurveyDetails] FOREIGN KEY ([FK_RouteSurveyId]) REFERENCES [dbo].[RoadSurveyDetails] ([RouteSurveyId])
);

