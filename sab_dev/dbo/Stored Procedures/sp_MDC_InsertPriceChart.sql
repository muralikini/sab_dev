-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MDC_InsertPriceChart]
	-- Add the parameters for the stored procedure here
	@routesurveyid as INT,
	@dieselprice AS float,
	@gasolineprice AS float,
	@fb AS FLOAT,
	@lb AS FLOAT,
	@lmv AS FLOAT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @rsid AS INT
	DECLARE @diesel AS FLOAT
    DECLARE @gasoline AS FLOAT
    DECLARE @fbprice AS FLOAT
    DECLARE @lbprice AS FLOAT
    DECLARE @lmvprice AS FLOAT

	DECLARE @retval INT

	BEGIN TRY
		BEGIN TRANSACTION
			SELECT @rsid=FK_RouteSurveyId FROM 
			dbo.MDC_PriceChart_New
			WHERE 
			FK_RouteSurveyId=@routesurveyid

			SELECT 
			@diesel=DieselPricePerLitre,
			@gasoline=GasolinePricePerLitre,
			@fbprice=FB,
			@lbprice=LB,
			@lmvprice=LMV
			FROM dbo.MDC_PriceChart
			

			IF(@rsid IS NULL) -- there are no records, then insert a new record
				BEGIN
				--If all values are 0 then insert default values, else insert the entered values
				IF(@dieselprice=0 AND @gasolineprice=0 AND @fb=0 AND @lb=0 AND @lmv=0)
				BEGIN

				INSERT INTO dbo.MDC_PriceChart_New
				(
					FK_RouteSurveyId,
				    DieselPricePerLitre,
				    GasolinePricePerLitre,
				    FB,
				    LB,
				    LMV,
					CreatedDate,
					StatusFlag
				)
				VALUES
				(  @routesurveyid,
					 @diesel, -- DieselPricePerLitre - float
				    @gasoline, -- GasolinePricePerLitre - float
				    @fbprice, -- FB - float
				    @lbprice, -- LB - float
				    @lmvprice, -- LMV - float
					GETDATE(),
					1
				)
            
				END
				ELSE
				BEGIN
							INSERT INTO dbo.MDC_PriceChart_New
				(
				FK_RouteSurveyId,
				    DieselPricePerLitre,
				    GasolinePricePerLitre,
				    FB,
				    LB,
				    LMV,
					CreatedDate,
					StatusFlag
				)
				VALUES
				(@routesurveyid, 
				  @dieselprice, -- DieselPricePerLitre - float
				    @gasolineprice, -- GasolinePricePerLitre - float
				    @fb, -- FB - float
				    @lb, -- LB - float
				    @lmv, -- LMV - float
					GETDATE(),
					1
				)

				END

				END 
			ELSE
				BEGIN
			IF(@dieselprice=0 AND @gasolineprice=0 AND @fb=0 AND @lb=0 AND @lmv=0)
				BEGIN

					UPDATE dbo.MDC_PriceChart_New
				
				   SET DieselPricePerLitre=@diesel,
						GasolinePricePerLitre=@gasoline,
						FB=@fbprice,
						LB=@lbprice,
						LMV=@lmvprice
				   WHERE FK_RouteSurveyId=@routesurveyid
					
				
				
            
				END
				ELSE
				BEGIN
					UPDATE dbo.MDC_PriceChart_New
				
				   SET DieselPricePerLitre=@dieselprice,
						GasolinePricePerLitre=@gasolineprice,
						FB=@fb,
						LB=@lb,
						LMV=@lmv
				   WHERE FK_RouteSurveyId=@routesurveyid

				END

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