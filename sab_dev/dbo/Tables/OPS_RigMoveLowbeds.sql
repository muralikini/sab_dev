CREATE TABLE [dbo].[OPS_RigMoveLowbeds] (
    [RMLBId]             INT            IDENTITY (1, 1) NOT NULL,
    [RouteSurveyId]      INT            NOT NULL,
    [FK_LBId]            INT            NOT NULL,
    [DateOfCreation]     DATE           NULL,
    [DateOfMobilization] DATE           NULL,
    [DateOfRelease]      DATE           NULL,
    [StartingOdometer]   INT            NULL,
    [EndingOdometer]     INT            NULL,
    [Remarks]            NVARCHAR (MAX) NULL,
    [StatusFlag]         INT            NULL,
    CONSTRAINT [PK_OPS_RigMoveLowbeds] PRIMARY KEY CLUSTERED ([RMLBId] ASC),
    CONSTRAINT [FK_OPS_RigMoveLowbeds_OPS_LowbedJn] FOREIGN KEY ([FK_LBId]) REFERENCES [dbo].[OPS_LowbedJn] ([LBJnId]),
    CONSTRAINT [FK_OPS_RigMoveLowbeds_RoadSurveyDetails] FOREIGN KEY ([RouteSurveyId]) REFERENCES [dbo].[RoadSurveyDetails] ([RouteSurveyId])
);

