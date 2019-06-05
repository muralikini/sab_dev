-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Gets database information like table, table parameters, SP, SP parameters, Functions, Function parameters
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetDBInfo] 
	-- Add the parameters for the stored procedure here
	@parameter int,
	@objectname nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- 1  and oject name is null, Get all table Names available in this database
	-- 1 and object name is not null get the column details of the specific table mentioned
	-- 2 Get all the names of the stored procedures in the database
	-- 2 and objectname gets all the parameters of the stored procedure
	-- 3 Gets all the functions in the database
    -- Insert statements for procedure here
	declare @retval int
	
	if(@parameter=1 and @objectname is null)
	begin
		select TABLE_NAME from sabdb.INFORMATION_SCHEMA.TABLES order by TABLE_NAME
	end

	if(@parameter=1 and @objectname is not null)
	begin
		select Column_name,ORDINAL_POSITION,IS_NULLABLE from sabdb.INFORMATION_SCHEMA.columns where table_name = @objectname
		ORDER BY ORDINAL_POSITION
	end
	
	if(@parameter=2 and @objectname is null)
	begin
		select ROUTINE_NAME
		from sabdb.information_schema.routines 
		where routine_type = 'PROCEDURE'
	end
	if(@parameter=3)
	begin
		select ROUTINE_NAME
		from sabdb.information_schema.routines 
		where routine_type = 'FUNCTION'
	end
	if(@parameter=2 and  @objectname is not null)
	begin
		SELECT name,system_type_id,max_length,is_nullable
		FROM sys.parameters  
		WHERE object_id = object_id(@objectname)

	end
END
return @retval