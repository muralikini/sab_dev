-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_subqry_InsertRoadSurveyDetails]
	-- Add the parameters for the stored procedure here
	@wellsiteid INT,
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
	@xmldata XML=null
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @retstatus INT
    -- Insert statements for procedure here
	BEGIN TRY
		BEGIN TRANSACTION
					--PRINT 'Begining to insert records'
					INSERT into RoadSurveyDetails
					(FK_WellSiteId,SurveyDate,PlannedRigMoveDate,NewLocation,YardToOldDistance,OldToNewDistance,NewToYardDistance,RoughRoad,BlackTop,InHouseRigMove,[Status],ApprovalStatus,Remarks,[TimeStamp],XmlData)
					values(@wellsiteid,@surveydate,@plannedrigmovedate,@newlocation,@yardtoold,@oldtonew,@newtoyard,@roughroad,@blacktop,@inhouserigmove,1,@approvalstatus,@remarks,getdate(),@xmldata)
										
		COMMIT TRANSACTION
        SET @retstatus =1   
		--PRINT 'Successfully inserted records' 
	END TRY
    BEGIN CATCH

			ROLLBACK TRANSACTION
         SET @retstatus =0   
		 --PRINT 'Error inserting records' 
	END CATCH
    
END
RETURN @retstatus