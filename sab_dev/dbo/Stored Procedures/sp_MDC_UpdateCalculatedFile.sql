-- =============================================
-- Author:		Muralidhar Kini
-- Create date: 04-02-2019
-- Description:
--	SP used to update the mob demob calculator file
--  
-- =============================================
CREATE PROCEDURE sp_MDC_UpdateCalculatedFile
	-- Add the parameters for the stored procedure here
	@routesurveyid INT,
	@xmlfile XML
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @recount int
	DECLARE @retval INT

	SET @retval=0

	SELECT @recount=COUNT(*) FROM 
	dbo.RoadSurveyDetails WHERE 
	RouteSurveyId=@routesurveyid

	IF(@recount=1)
	BEGIN
    
		DECLARE @mdcfileid INT
		
		SELECT @mdcfileid=MDCFileId FROM
        MDC_CalculatedFile
		WHERE FK_RoutesurveyId=@routesurveyid

	
		BEGIN TRY
			BEGIN TRANSACTION
			IF(@mdcfileid IS NOT NULL)
			BEGIN
				-- Update the XML 
				UPDATE MDC_CalculatedFile
				SET MDCFile=@xmlfile
				WHERE FK_Routesurveyid=@routesurveyid
            
			END
            ELSE
            BEGIN
			-- insert a new record
				INSERT INTO
				MDC_CalculatedFile
				(FK_Routesurveyid,MDCFile,CreatedDate,StatusFlag)
				VALUES
                (@routesurveyid,@xmlfile,GETDATE(),1)
			end


			COMMIT TRANSACTION
			SET @retval=1
		END TRY
		BEGIN CATCH
				ROLLBACK TRANSACTION
				SET @retval=0
		END CATCH

	end
    
	
END
RETURN @retval