CREATE TABLE [dbo].[MDC_CalculatedFile] (
    [MDCFileId]        INT  IDENTITY (1, 1) NOT NULL,
    [FK_RoutesurveyId] INT  NOT NULL,
    [MDCFile]          XML  NULL,
    [CreatedDate]      DATE NULL,
    [StatusFlag]       INT  NULL,
    CONSTRAINT [PK_MDC_CalculatedFile] PRIMARY KEY CLUSTERED ([MDCFileId] ASC),
    CONSTRAINT [FK_MDC_CalculatedFile_RoadSurveyDetails] FOREIGN KEY ([FK_RoutesurveyId]) REFERENCES [dbo].[RoadSurveyDetails] ([RouteSurveyId])
);

