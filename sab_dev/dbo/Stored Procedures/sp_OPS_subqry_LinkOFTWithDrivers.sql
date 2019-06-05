-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_subqry_LinkOFTWithDrivers]
	-- Add the parameters for the stored procedure here
	@oftid AS INT,
	@driverid AS INT=null,
	@flag AS int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @retval INT
	DECLARE @validid INT

	SELECT @validid=OFTJnId
	FROM
    dbo.OPS_OFTJn
	WHERE FK_OFTId=@oftid and StatusFlag =1

	BEGIN TRY
		BEGIN transaction
			IF(@flag=1 AND @validid IS null)
				BEGIN

						declare @id int
						SELECT @validid=OFTJnId
						FROM
						dbo.OPS_OFTJn
						WHERE FK_OFTId=@oftid 

						if(@id is null)
						begin
    						INSERT INTO OPS_OFTJn
							(FK_OFTId,FK_OFTDriverId,StatusFlag,CreatedDate)
							VALUES
							(@oftid,@driverid,1,getdate())
						end
						else
						begin
							update OPS_OFTJn
							set
							StatusFlag=1,
							CreatedDate=getdate()
							WHERE FK_OFTId=@oftid 


						end

						IF (@driverid IS NOT NULL)
						begin
							UPDATE OPS_LowbedDrivers
							SET StatusFlag=1
							WHERE 
							LBDriverId=@driverid
							end

							UPDATE OPS_OFT
							SET StatusFlag=1
							WHERE
							OFTId=@oftid

							update OPS_OFTJn
							set FK_OFTDriverId=@driverid
							WHERE FK_OFTId=@oftid 

				END
				ELSE IF(@flag=0 AND @validid IS NOT null)
				BEGIN
		
					--DELETE FROM OPS_OFTJn
					--WHERE
					--FK_OFTId=@oftid 

					update OPS_OFTJn
							set
							StatusFlag=0,
							ModifiedDate=getdate()
							WHERE FK_OFTId=@oftid 

					IF(@driverid IS NOT NULL)
					begin
						UPDATE OPS_LowbedDrivers
						SET StatusFlag=0
						WHERE 
						LBDriverId=@driverid
						end

						UPDATE OPS_OFT
						SET StatusFlag=0
						WHERE
						OFTId=@oftid

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