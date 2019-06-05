CREATE TABLE [dbo].[OPS_RigMoveManpower] (
    [RMManpowerId]       INT  IDENTITY (1, 1) NOT NULL,
    [FK_RouteSurveyId]   INT  NOT NULL,
    [FK_ManpowerId]      INT  NULL,
    [FK_CraneOperatorId] INT  NULL,
    [FK_WLOperatorId]    INT  NULL,
    [FK_FBDriverId]      INT  NULL,
    [FK_LBDriverId]      INT  NULL,
    [DateOfMob]          DATE NULL,
    [DateOfDeMob]        DATE NULL,
    [CreatedDate]        DATE NULL,
    [StatusFlag]         INT  NULL,
    CONSTRAINT [PK_OPS_RigMoveManpower] PRIMARY KEY CLUSTERED ([RMManpowerId] ASC),
    CONSTRAINT [FK_OPS_RigMoveManpower_OPS_CraneOperators] FOREIGN KEY ([FK_CraneOperatorId]) REFERENCES [dbo].[OPS_CraneOperators] ([OperatorID]),
    CONSTRAINT [FK_OPS_RigMoveManpower_OPS_FlatbedDrivers] FOREIGN KEY ([FK_FBDriverId]) REFERENCES [dbo].[OPS_FlatbedDrivers] ([FBDriverId]),
    CONSTRAINT [FK_OPS_RigMoveManpower_OPS_LowbedDrivers1] FOREIGN KEY ([FK_LBDriverId]) REFERENCES [dbo].[OPS_LowbedDrivers] ([LBDriverId]),
    CONSTRAINT [FK_OPS_RigMoveManpower_OPS_Manpower] FOREIGN KEY ([FK_ManpowerId]) REFERENCES [dbo].[OPS_Manpower] ([ManPowerId]),
    CONSTRAINT [FK_OPS_RigMoveManpower_OPS_WLOperators] FOREIGN KEY ([FK_WLOperatorId]) REFERENCES [dbo].[OPS_WLOperators] ([WLOperatorId]),
    CONSTRAINT [FK_OPS_RigMoveManpower_RoadSurveyDetails] FOREIGN KEY ([FK_RouteSurveyId]) REFERENCES [dbo].[RoadSurveyDetails] ([RouteSurveyId])
);

