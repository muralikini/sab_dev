-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_CalculateDeMobAmount]
(
	-- Add the parameters for the function here
	@routesurveyid int
	

)
RETURNS @retMobCalculations TABLE   
(  
    FBWithoutLoad_DM Decimal(10,5)  NOT NULL,  
    LBWithoutLoad_DM Decimal(10,5) NOT NULL,  
    LBWithLoad_DM Decimal(10,5) NOT NULL,  
    LMV_DM Decimal(10,5) NOT NULL,
	ALL_Total Decimal(10,5) NOT NULL,
	SABFBWithoutLoad_DM Decimal(10,5)  NOT NULL,  
    SABLBWithoutLoad_DM Decimal(10,5) NOT NULL,  
    SABLBWithLoad_DM Decimal(10,5) NOT NULL,  
    SABLMV_DM Decimal(10,5) NOT NULL,
	SAB_Total Decimal(10,5) NOT NULL
     
)
AS
BEGIN


	declare @fb int
	declare @lb int
	declare @lbwithload int
	declare @lmv int

	declare @loadedlbmob int
	declare @loadedlbdemob int

	select 
	@fb=Flatbed,
	@lb=Lowbed,
	@lbwithload=LBwithLoad,
	@lmv=LMV
	from [dbo].[MDC_VehicleDetails]
	where FK_RouteSurveyId=@routesurveyid

	select 
	@loadedlbmob=ExtraMobLoadedLB,
	@loadedlbdemob=ExtraDemobLoadedLB
	from MDC_AddOnCost
	where FK_RouteSurveyId=@routesurveyid

	-- Declare the return variable here
	declare @mobdistance int
	declare @rigmovedistance int
	declare @demobdistance int

	declare @dieselcost Decimal(10,5)
	declare @gasolinecost Decimal(10,5)
	declare @FBfactor Decimal(10,5)
	declare @LBfactor Decimal(10,5)
	declare @lmvfactor Decimal(10,5)

	select 
	@dieselcost=DieselPricePerLitre,
	@gasolinecost = GasolinePricePerLitre,
	@FBfactor = FB,
	@LBfactor=LB,
	@lmvfactor=LMV
	from
	MDC_PriceChart_New
	WHERE FK_RouteSurveyId =@routesurveyid

	select 
	@mobdistance =YardToOldDistance,
	@rigmovedistance = OldToNewDistance,
	@demobdistance=NewToYardDistance

	from RoadSurveyDetails
	where RouteSurveyId=@routesurveyid

	declare @fbcost Decimal(10,5)
	declare @lbcost Decimal(10,5)
	declare @lbwoload Decimal(10,5)
	declare @lmvcost Decimal(10,5)

	declare @sabfb int
	declare @sablb int
	declare @sablbwoload int
	declare @sablmvcost int

	select 
	@sabfb=Flatbed,
	@sablb=Lowbed,
	@sablbwoload=LBwithLoad,
	@sablmvcost=LMV
	from [dbo].[MDC_RentalVehicleDetails]
	where FK_RouteSurveyId=@routesurveyid

	set @sabfb=@fb-@sabfb
	set @sablb=@lb-@sablb
	set @sablbwoload=@lbwithload-@sablbwoload
	set @sablmvcost=@lmv-@sablmvcost

	declare @sabfbcost Decimal(10,5)
	declare @sablbcost Decimal(10,5)
	declare @sab_lbwoload Decimal(10,5)
	declare @sab_lmvcost Decimal(10,5)

	set @fbcost=ROUND(@demobdistance*@fb*@FBfactor*@dieselcost,0,0)
	set @lbcost=ROUND(@demobdistance*@lb*@LBfactor*@dieselcost,0,0)
	set @lbwoload=ROUND(((@demobdistance*@lbwithload*@LBfactor*@dieselcost)+(@loadedlbdemob*@lbwithload)),0,0)
	set @lmvcost=ROUND((@demobdistance*@lmv*@lmvfactor*@gasolinecost),0,0)

	set @sabfbcost=ROUND(@demobdistance*@sabfb*@FBfactor*@dieselcost,0,0)
	set @sablbcost=ROUND(@demobdistance*@sablb*@LBfactor*@dieselcost,0,0)
	set @sab_lbwoload=ROUND(((@demobdistance*@sablbwoload*@LBfactor*@dieselcost)+(@loadedlbdemob*@sablbwoload)),0,0)
	set @sab_lmvcost=ROUND((@demobdistance*@sablmvcost*@lmvfactor*@gasolinecost),0,0)
-- Row 1
	insert into @retMobCalculations
	(FBWithoutLoad_DM,LBWithoutLoad_DM,LBWithLoad_DM,LMV_DM,ALL_Total,
	SABFBWithoutLoad_DM,  
    SABLBWithoutLoad_DM,  
    SABLBWithLoad_DM ,  
    SABLMV_DM ,
	SAB_Total)
	values (@fbcost,@lbcost,@lbwoload,@lmvcost,(@fbcost+@lbcost+@lbwoload+@lmvcost),
	@sabfbcost,@sablbcost,@sab_lbwoload,@sab_lmvcost,(@sabfbcost+@sablbcost+@sab_lbwoload+@sab_lmvcost))


	----------------------------------------------------------------------------------------------
	------Test Code
	--set @fbcost=ROUND(@fbcost/@fb,0)
	--set @lbcost=ROUND(@lbcost/@lb,0)
	--set @lbwoload=ROUND(@lbwoload/@lbwithload,0)
	--set @lmvcost=ROUND(@lmvcost/@lmv,0)

	--insert into @retMobCalculations
	--(FBWithoutLoad_DM,LBWithoutLoad_DM,LBWithLoad_DM,LMV_DM,ALL_Total,
	--SABFBWithoutLoad_DM,  
 --   SABLBWithoutLoad_DM,  
 --   SABLBWithLoad_DM ,  
 --   SABLMV_DM,SAB_Total )
	--values (@fbcost,@lbcost,@lbwoload,@lmvcost,(@fbcost/@fb+@lbcost/@lb+@lbwoload/@lbwithload+@lmvcost/@lmv),
	--0,0,0,0,0)



	---------------------------------------------------------------------------------------------------
	set @fbcost=(ROUND((@fbcost/@fb),0))*@fb
	set @lbcost=(ROUND((@lbcost/@lb),0))*@lb
	set @lbwoload=(ROUND((@lbwoload/@lbwithload),0))*@lbwithload
	set @lmvcost=(ROUND((@lmvcost/@lmv),0))*@lmv

	

	if(@sabfb>0)
	begin
		set @sabfbcost=(ROUND((@sabfbcost/@sabfb),-1))
	end

	if(@sablb>0)
	begin
		set @sablbcost=(ROUND((@sablbcost/@sablb),-1))
	end

	if(@sablbwoload>0)
	begin
		set @sab_lbwoload=(ROUND((@sab_lbwoload/@sablbwoload),-1))
	end

	if(@sablmvcost>0)
	begin
		set @sab_lmvcost=(ROUND((@sab_lmvcost/@sablmvcost),-1))
	end
--  Row 2
	DECLARE @tempfb DECIMAL(10,5)
	DECLARE @tempLb DECIMAL(10,5)
	DECLARE @tempLbwLoad DECIMAL(10,5)
	DECLARE @tempLmv DECIMAL(10,5)
	DECLARE @totalCost DECIMAL(10,5)

	SET @tempfb=ROUND(@fbcost/@fb,0)
	SET @tempLb=ROUND(@lbcost/@lb,0)
	SET @tempLbwLoad=ROUND(@lbwoload/@lbwithload,0)
	SET @tempLmv=ROUND(@lmvcost/@lmv,0)
	SET @totalCost=ROUND((@tempfb+@tempLb+@tempLbwLoad+@tempLmv),0)

	SET @tempfb=ROUND(@tempfb,-1)
	SET @tempLb=ROUND(@tempLb,-1)
	SET @tempLbwLoad=ROUND(@tempLbwLoad,-1)
	SET @tempLmv=ROUND(@tempLmv,-1)
	SET @totalCost=ROUND(@totalCost,-1)

	
	insert into @retMobCalculations
	(FBWithoutLoad_DM,LBWithoutLoad_DM,LBWithLoad_DM,LMV_DM,ALL_Total,
	SABFBWithoutLoad_DM,  
    SABLBWithoutLoad_DM,  
    SABLBWithLoad_DM ,  
    SABLMV_DM,SAB_Total )
	values (@tempfb,@tempLb,@tempLbwLoad,@tempLmv,@totalCost,
	@sabfbcost,@sablbcost,@sab_lbwoload,@sab_lmvcost,(@sabfbcost+@sablbcost+@sab_lbwoload+@sab_lmvcost))


	

	if(@sabfb>0)
	begin
		set @sabfbcost=@sabfbcost*@sabfb
	end

	if(@sablb>0)
	begin
		set @sablbcost=@sablbcost*@sablb
	end

	if(@sablbwoload>0)
	begin
		set @sab_lbwoload=@sab_lbwoload*@sablbwoload
	end

	if(@sablmvcost>0)
	begin
		set @sab_lmvcost=@sab_lmvcost*@sablmvcost
	end

-- Row 3
	insert into @retMobCalculations
	(FBWithoutLoad_DM,LBWithoutLoad_DM,LBWithLoad_DM,LMV_DM,ALL_Total,
	SABFBWithoutLoad_DM,  
    SABLBWithoutLoad_DM,  
    SABLBWithLoad_DM ,  
    SABLMV_DM,SAB_Total )
	values (ROUND(@fbcost/@fb,-1)*@fb,ROUND(@lbcost/@lb,-1)*@lb,ROUND(@lbwoload/@lbwithload,-1)*@lbwithload,ROUND(@lmvcost/@lmv,-1)*@lmv,
	(ROUND(@fbcost/@fb,-1)*@fb+ROUND(@lbcost/@lb,-1)*@lb+ROUND(@lbwoload/@lbwithload,-1)*@lbwithload+ROUND(@lmvcost/@lmv,-1)*@lmv),
	
	@sabfbcost,@sablbcost,@sab_lbwoload,@sab_lmvcost,(@sabfbcost+@sablbcost+@sab_lbwoload+@sab_lmvcost))

	
	RETURN
END