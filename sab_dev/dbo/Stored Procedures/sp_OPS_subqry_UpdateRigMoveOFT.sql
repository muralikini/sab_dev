-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_subqry_UpdateRigMoveOFT]
	@routesurveyid AS INT,
	@oftid AS INT,
	@dateofmob AS DATE=NULL,
	@dateofrelease AS DATE =NULL,
	@startodo AS INT=NULL,
	@endodo AS INT=NULL,
	@remarks AS NVARCHAR(MAX)=NULL,
	@flag AS int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @retval INT
	BEGIN TRY
    BEGIN TRANSACTION
	DECLARE @fid INT
	declare @rsid int
	
	SELECT @fid=RMOFTId,
	@rsid=FK_RouteSurveyId
	FROM OPS_RigMoveOFT
	WHERE 
	--FK_RouteSurveyId=@routesurveyid AND 
	StatusFlag=1 AND FK_OFTJnId=@oftid
    
	IF(@flag=1 AND @fid IS null) -- Adding FB to the fleet
		BEGIN
        --insert new flatbed into rig move fleet
			INSERT INTO OPS_RigMoveOFT
			(FK_RouteSurveyId,FK_OFTJnId,DateofCreation,DateOfMobilization,DateOfRelease,StartingOdometer,EndingOdometer,Remarks,Statusflag)
			VALUES
			(@routesurveyid,@oftid,GETDATE(),@dateofmob,@dateofrelease,@startodo,@endodo,@remarks,1)
			SET @retval=1

			UPDATE OPS_OFTJn
			SET StatusFlag=2
			WHERE OFTJnId=@oftid
		END
    ELSE IF(@flag=0 AND @fid IS NOT null and @rsid=@routesurveyid) -- Removing the FB from the fleet
    BEGIN
		UPDATE OPS_RigMoveOFT
		SET DateOfMobilization=@dateofmob,
			DateOfRelease=@dateofrelease,
			StartingOdometer=@startodo,
			EndingOdoMeter=@endodo,
			Remarks=@remarks,
			Statusflag=0
		WHERE
        FK_RouteSurveyId=@routesurveyid AND FK_OFTJnId=@oftid

		UPDATE OPS_OFTJn
			SET StatusFlag=1
			WHERE OFTJnId=@oftid

		SET @retval=1
	END
	ELSE IF(@flag=1 AND @fid IS NOT null)
    BEGIN
		SET @retval=2 --record already exists, cannot add this record

	END

	COMMIT TRANSACTION
    
	END TRY

    BEGIN CATCH
		ROLLBACK TRANSACTION
		SET @retval=0
    END CATCH
    
    
END
RETURN @retval