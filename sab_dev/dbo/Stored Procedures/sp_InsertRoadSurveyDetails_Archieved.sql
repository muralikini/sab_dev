-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertRoadSurveyDetails_Archieved]
	-- Add the parameters for the stored procedure here
	@client varchar(50),
	@rigno varchar(50),
	@surveydate date,
	@plannedrigmovedate date,
	@newlocation varchar(50),
	@yardtoold int,
	@oldtonew int,
	@newtoyard int,
	@roughroad int,
	@blacktop int,
	@approvalstatus int,
	@remarks varchar(50),
	@insertorupdate int,
	@xmldata XML=null
	--@rigmovestatus int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--declare @rigid int
	declare @wellsiteid int
	declare @retVal int

	declare @routesurveyid int

    -- Insert statements for procedure here
	--SELECT    @rigid=RigDetails.RigId
	--FROM            Clients INNER JOIN
 --                        RigDetails ON Clients.ClientId = RigDetails.FK_ClientId
	--WHERE        (Clients.Name = @client) AND (RigDetails.RigNo = @rigno)

	
	begin TRY
    

			SELECT @wellsiteid= WellSiteDetails.WellSiteId
		FROM            WellSiteDetails INNER JOIN
								 Clients ON WellSiteDetails.FK_ClientId = Clients.ClientId
		WHERE        (WellSiteDetails.WellNumber = @rigno)

		IF(@insertorupdate=1)
			BEGIN
	
		IF(@wellsiteid is not null)
			BEGIN
				SELECT        @routesurveyid=RouteSurveyId
				FROM            RoadSurveyDetails
				WHERE        (FK_WellSiteId = @wellsiteid) 
				--AND (SurveyDate = @surveydate) AND (PlannedRigMoveDate = @plannedrigmovedate) AND (YardToOldDistance =@yardtoold) AND (OldToNewDistance = @oldtonew) AND (NewToYardDistance = @newtoyard) AND (RoughRoad = @roughroad) AND 
								 --(BlackTop = @blacktop)
		
				if(@routesurveyid is not null)
				begin 
				-- This data already exists in the database
				set @retVal =3

				end
				else if(@routesurveyid is null and (@surveydate is null or @plannedrigmovedate is null or @yardtoold is null or @oldtonew is null or @newtoyard is null or  @roughroad is null ))
				begin
					-- Mandatory data missing
					set @retVal =6
			end

		else if(@routesurveyid is null)
			begin

			insert into RoadSurveyDetails
			(FK_WellSiteId,SurveyDate,PlannedRigMoveDate,NewLocation,YardToOldDistance,OldToNewDistance,NewToYardDistance,RoughRoad,BlackTop,[Status],ApprovalStatus,Remarks,[TimeStamp],XmlData)
			values(@wellsiteid,@surveydate,@plannedrigmovedate,@newlocation,@yardtoold,@oldtonew,@newtoyard,@roughroad,@blacktop,1,@approvalstatus,@remarks,getdate(),@xmldata)

			SELECT        @routesurveyid=RouteSurveyId
			FROM            RoadSurveyDetails
			WHERE        (FK_WellSiteId = @wellsiteid) AND (SurveyDate = @surveydate) AND (PlannedRigMoveDate = @plannedrigmovedate) AND (YardToOldDistance =@yardtoold) AND (OldToNewDistance = @oldtonew) AND (NewToYardDistance = @newtoyard) AND (RoughRoad = @roughroad) AND 
                         (BlackTop = @blacktop)
		
			if(@routesurveyid is not null)
			begin 
			-- record inserted successfully
			set @retVal =1

			end
		else
			begin
			-- Failed to insert record
			set @retVal=4

		

			end


		end

	end

	else
		begin
		-- The client or the rig no does not exist
			set @retVal = 2

		end
	end
		ELSE if(@insertorupdate=0)
			BEGIN
		SELECT        @routesurveyid=RouteSurveyId
			FROM            RoadSurveyDetails
			WHERE        (FK_WellSiteId = @wellsiteid) AND (SurveyDate = @surveydate) AND (PlannedRigMoveDate = @plannedrigmovedate) AND (YardToOldDistance =@yardtoold) AND (OldToNewDistance = @oldtonew) AND (NewToYardDistance = @newtoyard) AND (RoughRoad = @roughroad) AND 
							 (BlackTop = @blacktop)
		if(@routesurveyid is not null and (@surveydate is not null or @plannedrigmovedate is not null or @yardtoold is not null or @oldtonew is not null or @newtoyard is not null or  @roughroad is not null ))
		begin
			update RoadSurveyDetails
			set 
			--FK_RigMoveStatusId=@rigmovestatus,
			SurveyDate = @surveydate,
			PlannedRigMoveDate = @plannedrigmovedate,
			NewLocation=@newlocation,
			YardToOldDistance =@yardtoold,
			OldToNewDistance = @oldtonew,
			NewToYardDistance = @newtoyard,
			RoughRoad = @roughroad,
			BlackTop = @blacktop,
			ApprovalStatus=@approvalstatus,
			Remarks=@remarks,
			XmlData=@xmldata
			where
			RouteSurveyId=@routesurveyid
		end
	 else if (@routesurveyid is  null and (@surveydate is  null or @plannedrigmovedate is  null or @yardtoold is  null or @oldtonew is  null or @newtoyard is  null or  @roughroad is  null ))
	 begin
	 -- Mandatory fields missing, Failed to update
		set @retVal=7
	 end
	else
	begin
	-- Cannot update since the record does not exist
	 set @retVal =5
	end

	END
   
    end TRY
	
    
	begin catch
		-- Error in trasaction
		set @retVal=0
		
        		
	end catch

end
return @retVal