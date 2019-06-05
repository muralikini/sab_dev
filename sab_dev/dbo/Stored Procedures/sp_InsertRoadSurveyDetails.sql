-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertRoadSurveyDetails]
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
	@inhouserigmove INT,
	@approvalstatus int,
	@remarks varchar(50),
	@insertorupdate int,
	@xmldata XML=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @wellsiteid int
	declare @retVal int
	declare @routesurveyid INT
    SET @retVal=400

	 if(@routesurveyid is null and (@surveydate is null or @plannedrigmovedate is null or @yardtoold is null or @oldtonew is null or @newtoyard is null or  @roughroad is null ))
				begin
					-- Mandatory data missing, cannot proceed further
					set @retVal =6
				END

	IF(@retVal!=6)
	begin
    -- Insert statements for procedure here
		SELECT @wellsiteid= WellSiteDetails.WellSiteId
		FROM            WellSiteDetails INNER JOIN
		Clients ON WellSiteDetails.FK_ClientId = Clients.ClientId
		WHERE        (WellSiteDetails.WellNumber = @rigno)
	-- If wellsite id is null then both the insert or update operation is not possible
	IF(@insertorupdate=1 AND @wellsiteid IS NOT null)
	BEGIN
	-- Check whether there exists already an active entry for the same well site number
	-- Logically there should be only one entry per well number
	-- Worst case, the existing road survey first be cancelled and a new one should be created
		SELECT   @routesurveyid=RouteSurveyId
		FROM            RoadSurveyDetails
		WHERE        (FK_WellsiteId = @wellsiteid) AND (Status = 1)

		IF(@routesurveyid IS NOT NULL)-- then there already exists an active route survey, so cannot insert the record
			BEGIN
        
					SET @retVal=2 -- Cannot insert, active Data Already exists in the database
		
			END
		ELSE IF (@routesurveyid is NULL)
			BEGIN

					--PRINT 'calling inserting records'
					EXEC @retVal=
					[dbo].[sp_subqry_InsertRoadSurveyDetails]
					@wellsiteid,
					@surveydate ,
					@plannedrigmovedate ,
					@newlocation ,
					@yardtoold ,
					@oldtonew ,
					@newtoyard ,
					@roughroad ,
					@blacktop ,
					@inhouserigmove,
					@approvalstatus ,
					@remarks		,
					@xmldata 

								

			END
        
        
    
	END
    ELSE IF(@insertorupdate=0 AND @wellsiteid IS NOT null)
	BEGIN
			SELECT   @routesurveyid=RouteSurveyId
		FROM            RoadSurveyDetails
		WHERE        (FK_WellsiteId = @wellsiteid) AND (Status = 1)

		IF(@routesurveyid IS NOT NULL)
		BEGIN
        
			EXEC @retVal=
			[dbo].[sp_subqry_UpdateRoadSurveyDetails]
			@routesurveyid,
			@surveydate ,
			@plannedrigmovedate ,
			@newlocation ,
			@yardtoold ,
			@oldtonew ,
			@newtoyard ,
			@roughroad ,
			@blacktop ,
			@inhouserigmove,
			@approvalstatus ,
			@remarks ,
			@xmldata 

			

		END
        ELSE IF(@routesurveyid IS NULL)
		BEGIN
			SET @retVal=3--Cannot update since the record does not exit in the table
		END

	END
   END
    
	
END
RETURN @retVal