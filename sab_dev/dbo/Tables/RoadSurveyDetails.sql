CREATE TABLE [dbo].[RoadSurveyDetails] (
    [RouteSurveyId]      INT           IDENTITY (1, 1) NOT NULL,
    [FK_WellsiteId]      INT           NOT NULL,
    [SurveyDate]         DATE          NULL,
    [PlannedRigMoveDate] DATE          NULL,
    [NewLocation]        VARCHAR (50)  NULL,
    [YardToOldDistance]  NCHAR (10)    NULL,
    [OldToNewDistance]   INT           NULL,
    [NewToYardDistance]  INT           NULL,
    [RoughRoad]          INT           NULL,
    [BlackTop]           INT           NULL,
    [InHouseRigMove]     INT           NULL,
    [Status]             INT           NULL,
    [ApprovalStatus]     INT           NULL,
    [Remarks]            VARCHAR (MAX) NULL,
    [XmlData]            XML           NULL,
    [TimeStamp]          DATE          NULL,
    [ModifiedDate]       DATE          NULL,
    CONSTRAINT [PK_RoadSurveyDetails] PRIMARY KEY CLUSTERED ([RouteSurveyId] ASC),
    CONSTRAINT [FK_RoadSurveyDetails_WellSiteDetails] FOREIGN KEY ([FK_WellsiteId]) REFERENCES [dbo].[WellSiteDetails] ([WellSiteId])
);

