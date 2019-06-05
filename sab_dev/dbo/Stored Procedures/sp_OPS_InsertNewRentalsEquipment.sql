-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_InsertNewRentalsEquipment]
	-- Add the parameters for the stored procedure here
	@type NVARCHAR(50),
	@plate NVARCHAR(50)=NULL,
	@driver NVARCHAR(50)=NULL,
	@owner NVARCHAR(50)=NULL,
	@vehicleid nvarchar(50)=NULL
	

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @retval INT
	DECLARE @rentalid INT
	declare @rentaltype int

	select @rentaltype=RentalTypeId
	from OPS_RentalTypes
	where
	TypeDescription=@type

	SELECT @rentalid=Rentalsid FROM OPS_Rentals
	WHERE
    [FK_RentalTypeId]=@rentaltype AND
    [PlateNo]=@plate AND
    [Name]=@driver AND
    [Owner]=@owner AND
    [VehicleId]=@vehicleid and
	[StatusFlag]=1

	BEGIN try
	BEGIN transaction
	IF(@rentalid IS NULL)
	begin
		INSERT INTO OPS_Rentals
		([FK_RentalTypeId],PlateNo,Name,[Owner],VehicleId,CreatedDate,StatusFlag)
		VALUES
		(@rentaltype,@plate,@driver,@owner,@vehicleid,GETDATE(),1)
	END
    ELSE
    BEGIN
		SET @retval=0
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