﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_subqry_UpdateRigMoveWL]
	@routesurveyid AS INT,
	@wlid AS INT,
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

	SELECT @fid=@wlid,
			@rsid=FK_RouteSurveyId
	FROM OPS_RigMoveWL
	WHERE 
	--FK_RouteSurveyId=@routesurveyid AND 
	StatusFlag=1 AND FK_WLJnId=@wlid
    
	IF(@flag=1 AND @fid IS null) -- Adding FB to the fleet
		BEGIN
        --insert new flatbed into rig move fleet
			INSERT INTO OPS_RigMoveWL
			(FK_RouteSurveyId,FK_WLJnId,DateofCreation,DateOfMobilization,DateOfRelease,StartingOdometer,EndingOdometer,Remarks,Statusflag)
			VALUES
			(@routesurveyid,@wlid,GETDATE(),@dateofmob,@dateofrelease,@startodo,@endodo,@remarks,1)
			SET @retval=1

			UPDATE dbo.OPS_WLJn
			SET StatusFlag=2
			WHERE WLJnId=@wlid
		END
    ELSE IF(@flag=0 AND @fid IS NOT null and @rsid=@routesurveyid ) -- Removing the FB from the fleet
    BEGIN
		UPDATE dbo.OPS_RigMoveWL
		SET DateOfMobilization=@dateofmob,
			DateOfRelease=@dateofrelease,
			StartingOdometer=@startodo,
			EndingOdoMeter=@endodo,
			Remarks=@remarks,
			Statusflag=0
		WHERE
        FK_RouteSurveyId=@routesurveyid AND FK_WLJnId=@wlid

		UPDATE dbo.OPS_WLJn
			SET StatusFlag=1
			WHERE WLJnId=@wlid

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