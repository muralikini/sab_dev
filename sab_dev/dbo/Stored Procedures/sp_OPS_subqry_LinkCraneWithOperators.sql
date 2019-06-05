-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_subqry_LinkCraneWithOperators]
	-- Add the parameters for the stored procedure here
	@craneid AS INT,
	@operatorid AS INT,
	@flag AS int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @retval INT

	DECLARE @vehid INT
	DECLARE @opid INT

	SELECT @vehid=FK_CraneId
	FROM
    dbo.OPS_CraneJn
	WHERE
    FK_CraneId=@craneid and StatusFlag=1

	SELECT @opid=FK_OperatorId
	FROM
    dbo.OPS_CraneJn
	WHERE
    FK_OperatorId=@operatorid and StatusFlag=1
	

	BEGIN TRY
		BEGIN transaction
			IF(@flag=1 AND @vehid IS NULL AND @opid IS null)
	BEGIN
			declare @cr int
			

			select 
			@cr =CraneJnId
			from OPS_CraneJn
			where
			FK_CraneId=@craneid and
			FK_OperatorId=@operatorid

			if(@cr is null)
			begin
    			INSERT INTO OPS_CraneJn
				(FK_CraneId,FK_OperatorId,StatusFlag,CreatedDate)
				VALUES
				(@craneid,@operatorid,1,getdate())
			end
			else
			begin
				update OPS_CraneJn
				set
				StatusFlag=1,
				CreatedDate=getdate()
				where CraneJnId=@cr

			end

			UPDATE OPS_CraneOperators
			SET StatusFlag=1
			WHERE 
			OperatorId=@operatorid

			UPDATE OPS_Cranes
			SET StatusFlag=1
			WHERE
			CraneId=@craneid

	END
	ELSE IF(@flag=0 AND @vehid IS NOT NULL AND @opid IS NOT NULL)
	BEGIN
		
		--DELETE FROM OPS_CraneJn
		--WHERE
  --      FK_CraneId=@craneid AND FK_OperatorId=@operatorid

		update OPS_CraneJn
				set
				StatusFlag=0,
				ModifiedDate=getdate()
				where
			FK_CraneId=@craneid and
			FK_OperatorId=@operatorid

		UPDATE OPS_CraneOperators
		SET StatusFlag=0
		WHERE 
		OperatorId=@operatorid

		UPDATE OPS_Cranes
		SET StatusFlag=0
		WHERE
        CraneId=@craneid

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