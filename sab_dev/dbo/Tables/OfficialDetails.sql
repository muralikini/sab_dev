CREATE TABLE [dbo].[OfficialDetails] (
    [OfficialId]       INT            IDENTITY (1, 1) NOT NULL,
    [FK_EmpId]         INT            NOT NULL,
    [OfficeId]         NCHAR (10)     NOT NULL,
    [ContactNo]        NCHAR (20)     NULL,
    [PresentAddress]   NVARCHAR (MAX) NULL,
    [Location]         NVARCHAR (50)  NULL,
    [Sponsor]          NCHAR (50)     NOT NULL,
    [DateOfJoining]    DATE           NOT NULL,
    [DateOfExit]       DATE           NULL,
    [Iqama]            NVARCHAR (50)  NULL,
    [IqamaExpiryDate]  DATE           NULL,
    [Designation]      NVARCHAR (255) NULL,
    [FK_CategoryId]    INT            NOT NULL,
    [FK_GradeId]       INT            NOT NULL,
    [FK_DepartmentId]  INT            NOT NULL,
    [FK_DesignationId] INT            NOT NULL,
    [Status]           INT            NULL,
    [TimeStamp]        DATETIME       NULL,
    CONSTRAINT [PK_OfficialDetails] PRIMARY KEY CLUSTERED ([OfficialId] ASC)
);

