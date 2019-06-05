-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[sp_OPS_UpdateClient] 
	-- Add the parameters for the stored procedure here
	@name varchar(max),
	@location varchar(max)=NULL,
	@address varchar(max)=NULL,
	@zipcode varchar(max)=NULL
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @clientId int

	declare @retval int

	select @clientId=ClientId from Clients where Name=@name

	if(@clientId is not null)
	begin
		update Clients
		set
		[Location]=@location,
		[Address]=@address,
		[ZIPCode]=@zipcode
		where
		Name like @name
		--Client updated successfully
		set @retval=0
	end
	else if(@clientId is null)
	begin
	--This client does not exist
		set @retval=1
	end
	
	
END
RETURN @retval