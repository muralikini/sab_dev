-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_subqry_UpdateRigMoveLowbeds]
	@routesurveyid AS INT,
	@lbid AS INT,
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
	
	--SELECT @fid=RMLBId
	--FROM OPS_RigMoveLowbeds
	--WHERE RouteSurveyId=@routesurveyid AND StatusFlag=1 AND FK_LBId=@lbid

	SELECT @fid=RMLBId,
	@rsid=RouteSurveyId
	FROM OPS_RigMoveLowbeds
	WHERE StatusFlag=1 AND FK_LBId=@lbid
    
	IF(@flag=1 AND @fid IS null) -- Adding FB to the fleet
		BEGIN
        --insert new flatbed into rig move fleet
			INSERT INTO OPS_RigMoveLowbeds
			(RouteSurveyId,FK_LBId,DateofCreation,DateOfMobilization,DateOfRelease,StartingOdometer,EndingOdometer,Remarks,Statusflag)
			VALUES
			(@routesurveyid,@lbid,GETDATE(),@dateofmob,@dateofrelease,@startodo,@endodo,@remarks,1)
			SET @retval=1

			UPDATE OPS_LowbedJn
			SET StatusFlag=2
			WHERE LBJnId=@lbid
		END
    ELSE IF(@flag=0 AND @fid IS NOT null and @rsid=@routesurveyid) -- Removing the FB from the fleet
    BEGIN
		UPDATE OPS_RigMoveLowbeds
		SET DateOfMobilization=@dateofmob,
			DateOfRelease=@dateofrelease,
			StartingOdometer=@startodo,
			EndingOdoMeter=@endodo,
			Remarks=@remarks,
			Statusflag=0
		WHERE
        RouteSurveyId=@routesurveyid AND FK_LbId=@lbid

		UPDATE OPS_LowbedJn
			SET StatusFlag=1
			WHERE LBJnId=@lbid

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