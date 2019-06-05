-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_LinkResources]
	-- Add the parameters for the stored procedure here
	@resourcetype INT,
	@resourceid INT,
	@operatorid INT=null,
	@flag INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @retval INT
	SET @retval =0
	BEGIN TRY
		--BEGIN TRANSACTION

			IF(@resourcetype=0)
			BEGIN
				EXEC @retval=[dbo].[sp_OPS_subqry_LinkFlatbedWithDrivers]
				@resourceid,
				@operatorid,
				@flag
			END
			ELSE IF(@resourcetype=1)
			BEGIN
				EXEC @retval=[dbo].[sp_OPS_subqry_LinkLowbedWithDrivers]
				@resourceid,
				@operatorid,
				@flag
			END
			ELSE IF(@resourcetype=2)
			BEGIN
				EXEC @retval=[dbo].[sp_OPS_subqry_LinkCraneWithOperators]
				@resourceid,
				@operatorid,
				@flag
			END
			ELSE IF(@resourcetype=3)
			BEGIN
				EXEC @retval=[dbo].[sp_OPS_subqry_LinkWLWithOperators]
				@resourceid,
				@operatorid,
				@flag
			END
			ELSE IF(@resourcetype=4)
			BEGIN
				EXEC @retval=[dbo].[sp_OPS_subqry_LinkLMVWithDrivers]
				@resourceid,
				@operatorid,
				@flag
			END  
			ELSE IF(@resourcetype=5)
			BEGIN
				EXEC @retval=[dbo].[sp_OPS_subqry_LinkOFTWithDrivers]
				@resourceid,
				@operatorid,
				@flag
			END  
		--COMMIT transaction
	END TRY
    BEGIN CATCH
		--ROLLBACK transaction
		RETURN @retval
	END catch
   
END
RETURN @retval