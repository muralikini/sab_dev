-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_subqry_UpdateRoadSurveyDetails] 
	-- Add the parameters for the stored procedure here
	@routesurveyid INT,
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
	@xmldata XML=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @retstatus INT
    -- Insert statements for procedure here
	BEGIN TRY

		BEGIN TRANSACTION

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
			InHouseRigMove=@inhouserigmove,
			ApprovalStatus=@approvalstatus,
			Remarks=@remarks,
			XmlData=@xmldata
			where
			RouteSurveyId=@routesurveyid
        
		COMMIT TRANSACTION
        set @retstatus=1
    
	END TRY
    
	BEGIN CATCH
		ROLLBACK TRANSACTION
        set @retstatus=0
	END CATCH
    
	
END
RETURN @retstatus