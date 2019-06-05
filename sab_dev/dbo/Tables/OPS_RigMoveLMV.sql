CREATE TABLE [dbo].[OPS_RigMoveLMV] (
    [RMLMVId]            INT            IDENTITY (1, 1) NOT NULL,
    [FK_RouteSurveyId]   INT            NOT NULL,
    [FK_LMVJnId]         INT            NOT NULL,
    [CreatedDate]        DATE           NULL,
    [DateOfMobilization] DATE           NULL,
    [DateOfRelease]      DATE           NULL,
    [StartingOdometer]   INT            NULL,
    [EndingOdometer]     INT            NULL,
    [Remarks]            NVARCHAR (MAX) NULL,
    [StatusFlag]         INT            NULL,
    CONSTRAINT [PK_OPS_RigMoveLMV] PRIMARY KEY CLUSTERED ([RMLMVId] ASC),
    CONSTRAINT [FK_OPS_RigMoveLMV_OPS_LMVJn] FOREIGN KEY ([FK_LMVJnId]) REFERENCES [dbo].[OPS_LMVJn] ([LMVJn]),
    CONSTRAINT [FK_OPS_RigMoveLMV_RoadSurveyDetails] FOREIGN KEY ([FK_RouteSurveyId]) REFERENCES [dbo].[RoadSurveyDetails] ([RouteSurveyId])
);

