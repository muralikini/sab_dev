CREATE TABLE [dbo].[MDC_VehicleDetails] (
    [MDC_VehilcleDetailsId] INT      IDENTITY (1, 1) NOT NULL,
    [FK_RouteSurveyId]      INT      NOT NULL,
    [Flatbed]               INT      NOT NULL,
    [Lowbed]                INT      NOT NULL,
    [LBwithLoad]            INT      NOT NULL,
    [LMV]                   INT      NOT NULL,
    [DateOfCreation]        DATETIME NULL,
    [StatusFlag]            INT      NULL,
    CONSTRAINT [PK_MDC_VehicleDetails] PRIMARY KEY CLUSTERED ([MDC_VehilcleDetailsId] ASC),
    CONSTRAINT [FK_MDC_VehicleDetails_RoadSurveyDetails] FOREIGN KEY ([FK_RouteSurveyId]) REFERENCES [dbo].[RoadSurveyDetails] ([RouteSurveyId])
);

