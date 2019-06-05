-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MDC_MobDemobCalculator] 
	-- Add the parameters for the stored procedure here
	@routesurveyid as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @fbwithoutload_mob int
	declare @lbwithoutload_mob int
	declare @lbwithoad_mob int
	declare @lmv_mob int
	declare @sabfbwithoutload_mob int
	declare @sablbwithoutload_mob int
	declare @sablbwithoad_mob int
	declare @sablmv_mob int


    -- Insert statements for procedure here

	DECLARE @retMobCalculations TABLE   
(  
    FBWithoutLoad_MOB float  NOT NULL,  
    LBWithoutLoad_MOB float NOT NULL,  
    LBWithLoad_MOB float NOT NULL,  
    LMV_MOB float NOT NULL,
	All_Total float NOT NULL,
	SABFBWithoutLoad_MOB float  NOT NULL,  
    SABLBWithoutLoad_MOB float NOT NULL,  
    SABLBWithLoad_MOB float NOT NULL,  
    SABLMV_MOB float NOT NULL,
	SAB_Total float NOT NULL
     
)


DEClare @retDeMobCalculations TABLE   
(  
    FBWithoutLoad_DM float  NOT NULL,  
    LBWithoutLoad_DM float NOT NULL,  
    LBWithLoad_DM float NOT NULL,  
    LMV_DM float NOT NULL,
	ALL_Total float NOT NULL,
	SABFBWithoutLoad_DM float  NOT NULL,  
    SABLBWithoutLoad_DM float NOT NULL,  
    SABLBWithLoad_DM float NOT NULL,  
    SABLMV_DM float NOT NULL,
	SAB_Total float NOT NULL
     
)

declare @retCalculations TABLE   
(  
    FB_RM float  NOT NULL,  
    LB_RM float NOT NULL,  
    LMV_RM float NOT NULL,  
    Food_RM float  NULL,
	Total float NOT NULL
	
     
)
	INSERT @retMobCalculations SELECT 
	*
	from
	[dbo].[fn_CalculateMobAmount](@routesurveyid)

	SELECT * FROM @retMobCalculations

	INSERT @retDeMobCalculations SELECT * 
	from
	[dbo].[fn_CalculateDeMobAmount](@routesurveyid)

	SELECT * FROM @retDeMobCalculations

	INSERT @retCalculations SELECT * 
	from
	[dbo].[fn_CalculateRigMoveAmount](@routesurveyid)

	SELECT * FROM @retCalculations

END