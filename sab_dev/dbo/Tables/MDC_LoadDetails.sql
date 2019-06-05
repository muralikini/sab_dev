CREATE TABLE [dbo].[MDC_LoadDetails] (
    [MDC_ID]           INT      IDENTITY (1, 1) NOT NULL,
    [FK_RouteSurveyId] INT      NOT NULL,
    [TotalLoads]       INT      NOT NULL,
    [Loaded1SideTrip]  INT      NOT NULL,
    [Empty1SideTrip]   INT      NOT NULL,
    [DateOfCreation]   DATETIME NULL,
    [Statusflag]       INT      NULL,
    CONSTRAINT [PK_MDC_LoadDetails] PRIMARY KEY CLUSTERED ([MDC_ID] ASC),
    CONSTRAINT [FK_MDC_LoadDetails_RoadSurveyDetails] FOREIGN KEY ([FK_RouteSurveyId]) REFERENCES [dbo].[RoadSurveyDetails] ([RouteSurveyId])
);

