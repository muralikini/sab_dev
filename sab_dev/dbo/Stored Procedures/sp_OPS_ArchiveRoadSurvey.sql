-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_ArchiveRoadSurvey] 
	-- Add the parameters for the stored procedure here
	@routesurveyid INT,
	@status INT

	--Archive status = 0, not approved, Archive Status =1 Approved
	-- Status =0, cancelled
	-- status =1, Approved
	-- Status = 2, Rig move in progress
	-- Status =3, Rig Released
	-- Status =4, Rig Move Abandoned
	-- Status =5, Rig Move Completed
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @retval INT
	BEGIN TRY
			BEGIN TRANSACTION
			UPDATE dbo.RoadSurveyDetails
				SET [Status]=@status
			WHERE RouteSurveyId=@routesurveyid
			COMMIT TRANSACTION
            SET @retval=1
	END TRY
    BEGIN CATCH
    
		ROLLBACK transaction
		SET @retval=0
	END catch
		
	
END
RETURN @retval