-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_subqry_LinkLowbedWithDrivers]
	-- Add the parameters for the stored procedure here
	@lowbedid AS INT,
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

	SELECT @vehid=FK_LBId
	FROM
    dbo.OPS_LowbedJn
	WHERE
    FK_LBId=@lowbedid and StatusFlag=1

	SELECT @opid=FK_LBDriverId
	FROM
    dbo.OPS_LowbedJn
	WHERE
    FK_LBDriverId=@driverid and StatusFlag=1

    

	BEGIN TRY
		BEGIN transaction
			IF(@flag=1 AND @vehid IS NULL AND @opid IS null)
	BEGIN
			declare @lb int
			declare @dr int

			select 
			@lb =LBJnId
			from OPS_LowbedJn
			where
			FK_LBId=@lowbedid and
			FK_LBDriverId=@driverid

			if(@lb is null)
			begin
    			INSERT INTO OPS_LowbedJn
				(FK_LBId,FK_LBDriverId,StatusFlag,CreatedDate)
				VALUES
				(@lowbedid,@driverid,1,Getdate())
			end
			else
			begin

				UPDATE OPS_LowbedJn
				set statusflag =1,
					CreatedDate=getdate()
				where 
				LBJnId=@lb


			end


			UPDATE OPS_LowbedDrivers
			SET StatusFlag=1
			WHERE 
			LBDriverId=@driverid

			UPDATE OPS_Lowbeds
			SET StatusFlag=1
			WHERE
			LowbedId=@lowbedid

	END
	ELSE IF(@flag=0 AND @vehid IS NOT NULL AND @opid IS NOT NULL)
	BEGIN
		
		--DELETE FROM OPS_LowbedJn
		--WHERE
  --      FK_LBId=@lowbedid AND FK_LBDriverId=@driverid

		update OPS_LowbedJn
		set StatusFlag=0,
			ModifiedDate=getdate()
		where FK_LBId=@lowbedid and FK_LBDriverId=@driverid

		UPDATE OPS_LowbedDrivers
		SET StatusFlag=0
		WHERE 
		LBDriverId=@driverid

		UPDATE OPS_Lowbeds
		SET StatusFlag=0
		WHERE
        LowbedId=@lowbedid

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