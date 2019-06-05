CREATE TABLE [dbo].[RigMoveStatus] (
    [RMStatusId]      INT          IDENTITY (1, 1) NOT NULL,
    [RigMoveStatusId] INT          NOT NULL,
    [Description]     VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_RigMoveStatus] PRIMARY KEY CLUSTERED ([RMStatusId] ASC)
);

