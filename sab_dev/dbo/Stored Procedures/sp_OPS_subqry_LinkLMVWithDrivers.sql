-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_subqry_LinkLMVWithDrivers]
	-- Add the parameters for the stored procedure here
	@lmvid AS INT,
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

	SELECT @vehid= FK_LMVID
	FROM
    dbo.OPS_LMVJn
	WHERE FK_LMVID=@lmvid and StatusFlag=1

	SELECT @opid=FK_LMVDriverId
	FROM
    dbo.OPS_LMVJn
	WHERE FK_LMVDriverId=@driverid and StatusFlag=1
	
	

	BEGIN TRY
		BEGIN transaction
			IF(@flag=1 AND @vehid IS NULL AND @opid IS null)
	BEGIN
		
			declare @lid int

			select @lid=LMVJn
			from
			OPS_LMVJn
			where
			FK_LMVId=@lmvid and
			FK_LMVDriverId=@driverid
			
			if(@lid is null)
			begin
    			INSERT INTO OPS_LMVJn
				(FK_LMVId,FK_LMVDriverId,StatusFlag,CreatedDate)
				VALUES
				(@lmvid,@driverid,1,getdate())
			end
			else
			begin
				update OPS_LMVJn
				set StatusFlag=1,
					CreatedDate=getdate()
				where
				FK_LMVId=@lmvid and
				FK_LMVDriverId=@driverid

			end

			UPDATE OPS_LMVDrivers
			SET StatusFlag=1
			WHERE 
			LMVDriverId=@driverid

			UPDATE OPS_LMV
			SET StatusFlag=1
			WHERE
			LMVId=@lmvid

	END
	ELSE IF(@flag=0 AND @vehid IS NOT NULL AND @opid IS NOT NULL)
	BEGIN
		
		--DELETE FROM OPS_LMVJn
		--WHERE
  --      FK_LMVId=@lmvid AND FK_LMVDriverId=@driverid

		update OPS_LMVJn
		set StatusFlag=0,
		ModifiedDate=getdate()
		where
		FK_LMVId=@lmvid and
		FK_LMVDriverId=@driverid

		UPDATE OPS_LMVDrivers
		SET StatusFlag=0
		WHERE 
		LMVDriverId=@driverid

		UPDATE OPS_LMV
		SET StatusFlag=0
		WHERE
        LMVId=@lmvid

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