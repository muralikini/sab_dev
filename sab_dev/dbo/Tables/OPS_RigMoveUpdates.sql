CREATE TABLE [dbo].[OPS_RigMoveUpdates] (
    [RMUpdateId]       INT            IDENTITY (1, 1) NOT NULL,
    [FK_RouteSurveyId] INT            NOT NULL,
    [FK_RigMoveStatus] INT            NOT NULL,
    [UpdateDate]       DATE           NOT NULL,
    [OldLocationLoads] INT            NOT NULL,
    [NewLocationLoads] INT            NULL,
    [Remarks]          NVARCHAR (MAX) NULL,
    [StatusFlag]       INT            NULL,
    [CreatedDate]      DATE           NULL,
    [ModifiedDate]     DATE           NULL,
    CONSTRAINT [PK_OPS_RigMoveUpdates_n] PRIMARY KEY CLUSTERED ([RMUpdateId] ASC),
    CONSTRAINT [FK_OPS_RigMoveUpdates_RigMoveStatus1] FOREIGN KEY ([FK_RigMoveStatus]) REFERENCES [dbo].[RigMoveStatus] ([RMStatusId]),
    CONSTRAINT [FK_OPS_RigMoveUpdates_RoadSurveyDetails] FOREIGN KEY ([FK_RouteSurveyId]) REFERENCES [dbo].[RoadSurveyDetails] ([RouteSurveyId])
);

