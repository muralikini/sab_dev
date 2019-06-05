CREATE TABLE [dbo].[OPS_RigMoveFlatbeds] (
    [RMFBId]             INT            IDENTITY (1, 1) NOT NULL,
    [RouteSurveyId]      INT            NOT NULL,
    [FK_FBid]            INT            NOT NULL,
    [DateOfCreation]     DATE           NULL,
    [DateofMobilization] DATE           NULL,
    [DateOfRelease]      DATE           NULL,
    [StartingOdometer]   INT            NULL,
    [EndingOdoMeter]     INT            NULL,
    [Remarks]            NVARCHAR (MAX) NULL,
    [Statusflag]         INT            NULL,
    CONSTRAINT [PK_OPS_RigMoveFlatbeds] PRIMARY KEY CLUSTERED ([RMFBId] ASC),
    CONSTRAINT [FK_OPS_RigMoveFlatbeds_OPS_FlatbedJn] FOREIGN KEY ([FK_FBid]) REFERENCES [dbo].[OPS_FlatbedJn] ([FBJnId]),
    CONSTRAINT [FK_OPS_RigMoveFlatbeds_RoadSurveyDetails] FOREIGN KEY ([RouteSurveyId]) REFERENCES [dbo].[RoadSurveyDetails] ([RouteSurveyId])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Following are the status
0-Assigned but not mobilized
1-Mobilized for rig move
2-Released from this particular rig move', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OPS_RigMoveFlatbeds', @level2type = N'COLUMN', @level2name = N'Statusflag';

