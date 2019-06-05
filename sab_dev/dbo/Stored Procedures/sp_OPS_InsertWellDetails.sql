-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_InsertWellDetails]
	-- Add the parameters for the stored procedure here
	@clientname varchar(max)=NULL,
	@welltype varchar(max),
	@wellno varchar(100)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- return =0, insert failed
	-- return =1, insert successful
	-- return =2, well number already exists
	-- return =3, this record already exists


	SET NOCOUNT ON;
	declare @retstatus int
	declare @clientid int
	declare @welltypeid int
	declare @wellsiteid int
	declare @wellnoid int


	select @clientid=ClientId from Clients where Name = @clientname
	select @welltypeid=WellTypeId from WellType where WellType=@welltype

	select @wellnoid= WellSiteId from WellSiteDetails where WellNumber=@wellno

	if(@wellnoid is not null)
	begin
		return 2
	end

	select @wellsiteid=WellSiteId 
	from 
	WellSiteDetails
	where
	FK_ClientId=@clientid and
	FK_WellTypeId=@welltypeid and 
	WellNumber=@wellno

	if(@wellsiteid is not null)
	begin
		return 3
	end

	begin try
		begin transaction
			--Case: when the client and wlltype exists and the well no does not
			if(@wellsiteid is null and @clientid is not null and @welltypeid is not null)
			begin
			
				insert into WellSiteDetails
				(FK_ClientId,FK_WellTypeId,WellNumber,[CreatedDate],[Status])
				values(@clientid,@welltypeid,@wellno,getdate(),1)
	
			end
			else if(@clientname is null and @wellno is null)
				begin
					declare @welid int

					select @welid=WellTypeId
					from
					WellType
					where [WellType]=@welltype

					if(@welid is null)
					begin
						insert into WellType
						(WellType)
						values(@welltype)
					end
				end
		
		commit transaction
		set @retstatus=1
	end try
	begin catch

		rollback transaction
		set @retstatus=0
	end catch


END
RETURN @retstatus