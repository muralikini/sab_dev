-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetClientAndRigDetails]
	-- Add the parameters for the stored procedure here
	@clientorrig int,
	@clientname varchar(50) NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- If it is 1 then get all client details
	if(@clientorrig=1 and @clientname is null )
	begin
		
		select Name from Clients
	end
	--if it is 3 get the well types
	else if(@clientorrig=3 and @clientname is null )
	begin
		
		select WellType from WellType
	end
	else if(@clientorrig=2 and @clientname is not null )
	begin
	
		
		--SELECT        RigDetails.RigNo
		--FROM            RigDetails INNER JOIN
		--					 Clients ON RigDetails.FK_ClientId = Clients.ClientId
		--WHERE        (Clients.Name = @clientname)

		SELECT        WellSiteDetails.WellNumber AS RigNo
FROM            Clients INNER JOIN
                         WellSiteDetails ON Clients.ClientId = WellSiteDetails.FK_ClientId INNER JOIN
                         WellType ON WellSiteDetails.FK_WellTypeId = WellType.WellTypeId
WHERE        (Clients.Name = @clientname)
	end

	END