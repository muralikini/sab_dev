-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_AddNewClient] 
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

	if((@name is null or @name =' ') and (@location is null or @address is null or @zipcode is null))
	begin

	--Name Location address zipcode cannot be null or empty
		set @retval=1
	end
	else if(@name is null or @name = ' ')
	begin

	--Client name is mandatory, it cannot be null
		set @retval=2
	end
	else if(@clientId is null)
	begin
			insert into Clients
			(Name, Location,[Address],ZIPCode,Active,[TimeStamp])
			values(@name,@location,@address,@zipcode,1,GETDATE())
			--New client created successfully
			set @retval=0

	end
	else if(@clientId is not null)
	begin

	-- client already exists in database
		set @retval=3
	end
	

	
END
RETURN @retval