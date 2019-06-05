-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MDC_GetPriceChart] 
	-- Add the parameters for the stored procedure here
	@routesurveyid AS INT=NULL
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @rsid INT

	SELECT @rsid=FK_RouteSurveyId
	FROM
    dbo.MDC_PriceChart_New
	WHERE FK_RouteSurveyId=@routesurveyid

	IF(@routesurveyid IS NULL AND @rsid IS null)

    Begin
		SELECT       [DieselPricePerLitre]
		  ,[GasolinePricePerLitre]
		  ,[FB]
		  ,[LB]
		  ,[LMV]
	  FROM [sabdb].[dbo].[MDC_PriceChart]
	END
    ELSE IF(@rsid IS NOT NULL)
	BEGIN
		SELECT       [DieselPricePerLitre]
		  ,[GasolinePricePerLitre]
		  ,[FB]
		  ,[LB]
		  ,[LMV]
	  FROM [sabdb].[dbo].[MDC_PriceChart_New]
	  WHERE
      FK_RouteSurveyId=@rsid
	END
    ELSE IF(@rsid IS NULL)
	BEGIN
		SELECT       [DieselPricePerLitre]
		  ,[GasolinePricePerLitre]
		  ,[FB]
		  ,[LB]
		  ,[LMV]
	  FROM [sabdb].[dbo].[MDC_PriceChart]
	  
	end
END