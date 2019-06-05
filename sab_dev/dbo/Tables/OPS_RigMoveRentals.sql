CREATE TABLE [dbo].[OPS_RigMoveRentals] (
    [RMRentalsId]        INT            IDENTITY (1, 1) NOT NULL,
    [FK_RouteSurveyId]   INT            NOT NULL,
    [FK_RentalsId]       INT            NOT NULL,
    [DateOfCreation]     DATE           NULL,
    [DateOfMobilization] DATE           NULL,
    [DateOfRelease]      DATE           NULL,
    [StartingOdometer]   INT            NULL,
    [EndingOdometer]     INT            NULL,
    [Remarks]            NVARCHAR (MAX) NULL,
    [StatusFlag]         INT            NULL,
    CONSTRAINT [PK_OPS_RigMoveRentals] PRIMARY KEY CLUSTERED ([RMRentalsId] ASC),
    CONSTRAINT [FK_OPS_RigMoveRentals_OPS_Rentals] FOREIGN KEY ([FK_RentalsId]) REFERENCES [dbo].[OPS_Rentals] ([RentalsId]),
    CONSTRAINT [FK_OPS_RigMoveRentals_RoadSurveyDetails] FOREIGN KEY ([FK_RouteSurveyId]) REFERENCES [dbo].[RoadSurveyDetails] ([RouteSurveyId])
);

