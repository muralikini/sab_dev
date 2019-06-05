-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_subqry_UpdateRigMoveManpower]
	@routesurveyid AS INT,
	@manpowertype as int,
	@fbid AS INT,
	@dateofmob AS DATE=NULL,
	@dateofrelease AS DATE =NULL,
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
	
	--SELECT @fid=RMManpowerId
	--FROM OPS_RigMoveManpower
	--WHERE FK_RouteSurveyId=@routesurveyid AND StatusFlag=1 AND 
	--(FK_ManPowerId=@fbid or FK_CraneOperatorId=@fbid or FK_WLOperatorId=@fbid or FK_FBDriverId=@fbid or FK_LBDriverId=@fbid)

	if(@manpowertype<6)
	begin
		--SELECT @fid=RMManpowerId
		--FROM OPS_RigMoveManpower
		--WHERE FK_RouteSurveyId=@routesurveyid AND StatusFlag=1 AND 
		--(FK_ManPowerId=@fbid)

		SELECT @fid=RMManpowerId,
		@rsid=FK_RouteSurveyId
		FROM OPS_RigMoveManpower
		WHERE 
		--FK_RouteSurveyId=@routesurveyid AND 
		StatusFlag=1 AND 
		(FK_ManPowerId=@fbid)

	end
	else if(@manpowertype=6)
	begin
		SELECT @fid=RMManpowerId,
		@rsid=FK_RouteSurveyId
		FROM OPS_RigMoveManpower
		WHERE 
		--FK_RouteSurveyId=@routesurveyid AND 
		StatusFlag=1 AND 
		FK_CraneOperatorId=@fbid

	end
	else if(@manpowertype=7)
	begin
		SELECT @fid=RMManpowerId,
		@rsid=FK_RouteSurveyId
		FROM OPS_RigMoveManpower
		WHERE 
		--FK_RouteSurveyId=@routesurveyid AND 
		StatusFlag=1 AND 
		FK_WLOperatorId=@fbid

	end
	else if(@manpowertype=8)
	begin
		SELECT @fid=RMManpowerId,
		@rsid=FK_RouteSurveyId
		FROM OPS_RigMoveManpower
		WHERE 
		--FK_RouteSurveyId=@routesurveyid AND 
		StatusFlag=1 AND 
		FK_FBDriverId=@fbid

	end
	else if(@manpowertype=9)
	begin
		SELECT @fid=RMManpowerId,
		@rsid=FK_RouteSurveyId
		FROM OPS_RigMoveManpower
		WHERE 
		--FK_RouteSurveyId=@routesurveyid AND 
		StatusFlag=1 AND 
		FK_LBDriverId=@fbid

	end


    
	IF(@flag=1 AND @fid IS null) -- Adding manpower to the fleet
		BEGIN
        --insert new flatbed into rig move fleet

		if(@manpowertype<6)
			begin
					INSERT INTO OPS_RigMoveManpower
					(FK_RouteSurveyId,FK_ManpowerId,DateOfMob,DateOfDeMob,CreatedDate,Statusflag)
					VALUES
					(@routesurveyid,@fbid,@dateofmob,@dateofrelease,GETDATE(),1)
					SET @retval=1

					UPDATE Ops_Manpower
					SET StatusFlag=2
					WHERE ManPowerId=@fbid
			end
		else if(@manpowertype=6)
		begin
					INSERT INTO OPS_RigMoveManpower
					(FK_RouteSurveyId,FK_CraneOperatorId,DateOfMob,DateOfDeMob,CreatedDate,Statusflag)
					VALUES
					(@routesurveyid,@fbid,@dateofmob,@dateofrelease,GETDATE(),1)
					SET @retval=1

					UPDATE OPS_CraneOperators
					SET StatusFlag=2
					WHERE OperatorID=@fbid
		end
		else if(@manpowertype=7)
		begin
					INSERT INTO OPS_RigMoveManpower
					(FK_RouteSurveyId,FK_WLOperatorId,DateOfMob,DateOfDeMob,CreatedDate,Statusflag)
					VALUES
					(@routesurveyid,@fbid,@dateofmob,@dateofrelease,GETDATE(),1)
					SET @retval=1

					UPDATE OPS_WLOperators
					SET StatusFlag=2
					WHERE WLOperatorId=@fbid
		end
		else if(@manpowertype=8)
		begin
					INSERT INTO OPS_RigMoveManpower
					(FK_RouteSurveyId,FK_FBDriverId,DateOfMob,DateOfDeMob,CreatedDate,Statusflag)
					VALUES
					(@routesurveyid,@fbid,@dateofmob,@dateofrelease,GETDATE(),1)
					SET @retval=1

					UPDATE OPS_FlatbedDrivers
					SET StatusFlag=2
					WHERE FBDriverId=@fbid
		end
		else if(@manpowertype=9)
		begin
					INSERT INTO OPS_RigMoveManpower
					(FK_RouteSurveyId,FK_LBDriverId,DateOfMob,DateOfDeMob,CreatedDate,Statusflag)
					VALUES
					(@routesurveyid,@fbid,@dateofmob,@dateofrelease,GETDATE(),1)
					SET @retval=1

					UPDATE OPS_LowbedDrivers
					SET StatusFlag=2
					WHERE LBDriverId=@fbid
		end
		END
    IF(@flag=0 AND @fid IS NOT null and @rsid=@routesurveyid) -- Removing the FB from the fleet
    BEGIN
	if(@manpowertype<6)
	begin
		UPDATE OPS_RigMoveManpower
		SET DateOfMob=@dateofmob,
			DateOfDeMob=@dateofrelease,
			Statusflag=0
		WHERE
        FK_RouteSurveyId=@routesurveyid AND FK_ManpowerId=@fbid

		UPDATE Ops_Manpower
			SET StatusFlag=1
			WHERE ManPowerId=@fbid
	end
	else if(@manpowertype=6)
	begin
		UPDATE OPS_RigMoveManpower
		SET DateOfMob=@dateofmob,
			DateOfDeMob=@dateofrelease,
			Statusflag=0
		WHERE
        FK_RouteSurveyId=@routesurveyid AND FK_CraneOperatorId=@fbid

		update OPS_CraneOperators
		set StatusFlag=0
		where OperatorID=@fbid

	end
	else if(@manpowertype=7)
	begin
		UPDATE OPS_RigMoveManpower
		SET DateOfMob=@dateofmob,
			DateOfDeMob=@dateofrelease,
			Statusflag=0
		WHERE
        FK_RouteSurveyId=@routesurveyid AND FK_WLOperatorId=@fbid

		update OPS_WLOperators
		set StatusFlag=0
		where WLOperatorId=@fbid

	end
	else if(@manpowertype=8)
	begin
		UPDATE OPS_RigMoveManpower
		SET DateOfMob=@dateofmob,
			DateOfDeMob=@dateofrelease,
			Statusflag=0
		WHERE
        FK_RouteSurveyId=@routesurveyid AND FK_FBDriverId=@fbid

		update OPS_FlatbedDrivers
		set StatusFlag=0
		where FbDriverId=@fbid

	end
	else if(@manpowertype=9)
	begin
		UPDATE OPS_RigMoveManpower
		SET DateOfMob=@dateofmob,
			DateOfDeMob=@dateofrelease,
			Statusflag=0
		WHERE
        FK_RouteSurveyId=@routesurveyid AND FK_LBDriverId=@fbid

		update OPS_LowbedDrivers
		set StatusFlag=0
		where LBDriverId=@fbid

	end

		SET @retval=1
	END
	IF(@flag=1 AND @fid IS NOT null)
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