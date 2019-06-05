-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_subqry_UpdateRigMoveFlatbeds]
	@routesurveyid AS INT,
	@fbid AS INT,
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
	declare @gid int
	declare @rsid int
	---Check whether the resource is already allocated to any other rig moves
	--SELECT @fid=RMFBId
	--FROM OPS_RigMoveFlatbeds
	--WHERE RouteSurveyId=@routesurveyid AND StatusFlag=1 AND FK_FBid=@fbid

	SELECT @fid=RMFBId,
	@rsid=RouteSurveyId
	FROM OPS_RigMoveFlatbeds
	WHERE  FK_FBid=@fbid and StatusFlag=1
    
	IF(@flag=1 AND @fid IS null) -- Adding FB to the fleet
		BEGIN
        --insert new flatbed into rig move fleet
			INSERT INTO OPS_RigMoveFlatbeds
			(RouteSurveyId,FK_FBid,DateofCreation,DateofMobilization,DateOfRelease,StartingOdometer,EndingOdometer,Remarks,Statusflag)
			VALUES
			(@routesurveyid,@fbid,GETDATE(),@dateofmob,@dateofrelease,@startodo,@endodo,@remarks,1)
			SET @retval=1

			UPDATE Ops_FlatbedJn
			SET StatusFlag=2
			WHERE FbJnId=@fbid
		END
    ELSE IF(@flag=0 AND @fid IS NOT null and @rsid=@routesurveyid) -- Removing the FB from the fleet
    BEGIN
		UPDATE OPS_RigMoveFlatbeds
		SET DateofMobilization=@dateofmob,
			DateOfRelease=@dateofrelease,
			StartingOdometer=@startodo,
			EndingOdoMeter=@endodo,
			Remarks=@remarks,
			Statusflag=0
		WHERE
        RouteSurveyId=@routesurveyid AND FK_FbId=@fbid

		UPDATE Ops_FlatbedJn
			SET StatusFlag=1
			WHERE FbJnId=@fbid

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