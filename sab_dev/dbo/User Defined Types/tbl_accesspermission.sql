CREATE TYPE [dbo].[tbl_accesspermission] AS TABLE (
    [accessid]   INT           NULL,
    [accessrole] NVARCHAR (50) NULL,
    [module]     NVARCHAR (50) NULL,
    [permission] INT           NULL);

