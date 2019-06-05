CREATE TABLE [dbo].[OPS_RigMoveWL] (
    [RMWLId]             INT            IDENTITY (1, 1) NOT NULL,
    [FK_RouteSurveyId]   INT            NOT NULL,
    [FK_WLJnId]          INT            NOT NULL,
    [DateOfCreation]     DATE           NULL,
    [DateOfMobilization] DATE           NULL,
    [DateOfRelease]      DATE           NULL,
    [StartingOdometer]   INT            NULL,
    [EndingOdometer]     INT            NULL,
    [Remarks]            NVARCHAR (MAX) NULL,
    [StatusFlag]         INT            NULL,
    CONSTRAINT [PK_OPS_RigMoveWL] PRIMARY KEY CLUSTERED ([RMWLId] ASC),
    CONSTRAINT [FK_OPS_RigMoveWL_OPS_WLJn] FOREIGN KEY ([FK_WLJnId]) REFERENCES [dbo].[OPS_WLJn] ([WLJnId]),
    CONSTRAINT [FK_OPS_RigMoveWL_RoadSurveyDetails] FOREIGN KEY ([FK_RouteSurveyId]) REFERENCES [dbo].[RoadSurveyDetails] ([RouteSurveyId])
);

