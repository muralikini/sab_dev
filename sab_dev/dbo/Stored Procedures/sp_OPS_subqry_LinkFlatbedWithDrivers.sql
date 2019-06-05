-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_subqry_LinkFlatbedWithDrivers]
	-- Add the parameters for the stored procedure here
	@flatbedid AS INT,
	@driverid AS INT,
	@flag AS int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @retval INT
	
	DECLARE @vehid INT
	DECLARE @opid INT

	SELECT @vehid= FK_FBId
	FROM
    dbo.OPS_FlatbedJn
	WHERE FK_FBId=@flatbedid and StatusFlag=1

	SELECT @opid= FK_FBDriverId
	FROM
    dbo.OPS_FlatbedJn
	WHERE FK_FBDriverId=@driverid and StatusFlag=1

	BEGIN TRY
		BEGIN transaction
			IF(@flag=1 AND @vehid IS NULL AND @opid IS null)
	BEGIN

			declare @fb int
			declare @dr int

			select 
			@fb =FBJnId
			from OPS_FlatbedJn
			where
			FK_FBId=@flatbedid and
			FK_FBDriverId=@driverid

			if(@fb is null)
			begin
    			INSERT INTO OPS_FlatbedJn
				(FK_FBId,FK_FbDriverId,StatusFlag,CreatedDate)
				VALUES
				(@flatbedid,@driverid,1,Getdate())
			end
			else
			begin
				UPDATE OPS_FlatbedJn
				set statusflag =1,
				CreatedDate=getdate()
				where 
				FBJnId=@fb

			end


			UPDATE OPS_FlatbedDrivers
			SET StatusFlag=1
			WHERE 
			FBDriverId=@driverid

			UPDATE OPS_Flatbeds
			SET StatusFlag=1
			WHERE
			FlatbedId=@flatbedid

	END
	ELSE IF(@flag=0 AND @vehid IS NOT NULL AND @opid IS NOT NULL)
	BEGIN
		
		--DELETE FROM OPS_FlatbedJn
		--WHERE
  --      FK_FBId=@flatbedid AND FK_FBDriverId=@driverid

		update OPS_FlatbedJn
		set StatusFlag=0,
			ModifiedDate=getdate()
		where FK_FBId=@flatbedid and FK_FbDriverId=@driverid

		UPDATE OPS_FlatbedDrivers
		SET StatusFlag=0
		WHERE 
		FBDriverId=@driverid

		UPDATE OPS_Flatbeds
		SET StatusFlag=0
		WHERE
        FlatbedId=@flatbedid

	END
    
		COMMIT TRANSACTION
		SET @retval=1
	END TRY
    BEGIN CATCH
		ROLLBACK TRANSACTION
        SET @retval=0
	END catch

	 


    
END
RETURN @retval