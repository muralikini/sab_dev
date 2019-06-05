-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_subqry_LinkWLWithOperators]
	-- Add the parameters for the stored procedure here
	@wlid AS INT,
	@operatorid AS INT,
	@flag AS int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @retval INT
	
	DECLARE @validwl INT
	DECLARE @validop INT

	SELECT @validwl=FK_WLId
	FROM dbo.OPS_WLJn
	WHERE FK_WLId=@wlid and StatusFlag=1

	SELECT @validop=FK_WLOperatorId
	FROM dbo.OPS_WLJn
	WHERE FK_WLOperatorId=@operatorid and StatusFlag=1


	BEGIN TRY
		BEGIN transaction
			IF(@flag=1 AND @validwl IS NULL AND @validop IS null)
	BEGIN
			declare @wl int

			select @wl=WLJnId
			from
			OPS_WLJn
			where
			FK_WLId=@wlid and
			FK_WLOperatorId=@operatorid

			if(@wl is null)
			begin
    			INSERT INTO OPS_WLJn
				(FK_WLId,FK_WLOperatorId,StatusFlag,CreatedDate)
				VALUES
				(@wlid,@operatorid,1,getdate())
			end
			else
			begin
				update OPS_WLJn
				set
				StatusFlag=1,
				CreatedDate=getdate()
				where
				FK_WLId=@wlid and
				FK_WLOperatorId=@operatorid

			end

			UPDATE OPS_WLOperators
			SET StatusFlag=1
			WHERE 
			WLOperatorId=@operatorid

			UPDATE OPS_WL
			SET StatusFlag=1
			WHERE
			WLId=@wlid

	END
	ELSE IF(@flag=0 AND @validwl IS NOT NULL AND @validop IS NOT NULL)
	BEGIN
		
		--DELETE FROM OPS_WLJn
		--WHERE
  --      FK_WLId=@wlid AND FK_WLOperatorId=@operatorid

				update OPS_WLJn
				set
				StatusFlag=0,
				ModifiedDate=getdate()
				where
				FK_WLId=@wlid and
				FK_WLOperatorId=@operatorid

		UPDATE OPS_WLOperators
		SET StatusFlag=0
		WHERE 
		WLOperatorId=@operatorid

		UPDATE OPS_WL
		SET StatusFlag=0
		WHERE
        WLId=@wlid

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