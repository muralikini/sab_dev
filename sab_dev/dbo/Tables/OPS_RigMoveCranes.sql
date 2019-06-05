CREATE TABLE [dbo].[OPS_RigMoveCranes] (
    [RMCraneId]          INT            IDENTITY (1, 1) NOT NULL,
    [FK_RouteSurveyId]   INT            NOT NULL,
    [FK_CraneJnId]       INT            NOT NULL,
    [DateOfCreation]     DATE           NULL,
    [DateOfMobilization] DATE           NULL,
    [DateOfRelease]      DATE           NULL,
    [StartingOdometer]   INT            NULL,
    [EndingOdometer]     INT            NULL,
    [Remarks]            NVARCHAR (MAX) NULL,
    [StatusFlag]         INT            NULL,
    CONSTRAINT [PK_OPS_RigMoveCranes] PRIMARY KEY CLUSTERED ([RMCraneId] ASC),
    CONSTRAINT [FK_OPS_RigMoveCranes_OPS_CraneJn] FOREIGN KEY ([FK_CraneJnId]) REFERENCES [dbo].[OPS_CraneJn] ([CraneJnId]),
    CONSTRAINT [FK_OPS_RigMoveCranes_RoadSurveyDetails] FOREIGN KEY ([FK_RouteSurveyId]) REFERENCES [dbo].[RoadSurveyDetails] ([RouteSurveyId])
);

