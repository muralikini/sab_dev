CREATE TABLE [dbo].[OPS_RigMoveOFT] (
    [RMOFTId]            INT            IDENTITY (1, 1) NOT NULL,
    [FK_RouteSurveyId]   INT            NOT NULL,
    [FK_OFTJnId]         INT            NOT NULL,
    [DateOfCreation]     DATE           NULL,
    [DateOfMobilization] DATE           NULL,
    [DateOfRelease]      DATE           NULL,
    [StartingOdometer]   INT            NULL,
    [EndingOdometer]     INT            NULL,
    [Remarks]            NVARCHAR (MAX) NULL,
    [StatusFlag]         INT            NULL,
    CONSTRAINT [PK_OPS_RigMoveOFT] PRIMARY KEY CLUSTERED ([RMOFTId] ASC),
    CONSTRAINT [FK_OPS_RigMoveOFT_OPS_OFTJn] FOREIGN KEY ([FK_OFTJnId]) REFERENCES [dbo].[OPS_OFTJn] ([OFTJnId]),
    CONSTRAINT [FK_OPS_RigMoveOFT_RoadSurveyDetails] FOREIGN KEY ([FK_RouteSurveyId]) REFERENCES [dbo].[RoadSurveyDetails] ([RouteSurveyId])
);

