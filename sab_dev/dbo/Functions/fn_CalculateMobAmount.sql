-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_CalculateMobAmount]
(
	-- Add the parameters for the function here
	@routesurveyid int
	

)
RETURNS @retMobCalculations TABLE   
(  
    FBWithoutLoad_MOB DECIMAL(10,5)  NOT NULL,  
    LBWithoutLoad_MOB DECIMAL(10,5) NOT NULL,  
    LBWithLoad_MOB DECIMAL(10,5) NOT NULL,  
    LMV_MOB DECIMAL(10,5) NOT NULL,
	All_Total DECIMAL(10,5) NOT NULL,
	SABFBWithoutLoad_MOB DECIMAL(10,5)  NOT NULL,  
    SABLBWithoutLoad_MOB DECIMAL(10,5) NOT NULL,  
    SABLBWithLoad_MOB DECIMAL(10,5) NOT NULL,  
    SABLMV_MOB DECIMAL(10,5) NOT NULL,
	SAB_Total DECIMAL(10,5) NOT NULL
     
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

	declare @dieselcost DECIMAL(10,5)
	declare @gasolinecost DECIMAL(10,5)
	declare @FBfactor DECIMAL(10,5)
	declare @LBfactor DECIMAL(10,5)
	declare @lmvfactor DECIMAL(10,5)

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

	declare @fbcost DECIMAL(10,5)
	declare @lbcost DECIMAL(10,5)
	declare @lbwoload DECIMAL(10,5)
	declare @lmvcost DECIMAL(10,5)

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

	declare @sabfbcost DECIMAL(10,5)
	declare @sablbcost DECIMAL(10,5)
	declare @sab_lbwoload DECIMAL(10,5)
	declare @sab_lmvcost DECIMAL(10,5)

	set @fbcost=ROUND(@mobdistance*@fb*@FBfactor*@dieselcost,0,0)
	set @lbcost=ROUND(@mobdistance*@lb*@LBfactor*@dieselcost,0,0)
	set @lbwoload=ROUND(((@mobdistance*@lbwithload*@LBfactor*@dieselcost)+(@loadedlbmob*@lbwithload)),0,0)
	set @lmvcost=ROUND((@mobdistance*@lmv*@lmvfactor*@gasolinecost),0,0)

	set @sabfbcost=ROUND(@mobdistance*@sabfb*@FBfactor*@dieselcost,0,0)
	set @sablbcost=ROUND(@mobdistance*@sablb*@LBfactor*@dieselcost,0,0)
	set @sab_lbwoload=ROUND(((@mobdistance*@sablbwoload*@LBfactor*@dieselcost)+(@loadedlbmob*@sablbwoload)),0,0)
	set @sab_lmvcost=ROUND((@mobdistance*@sablmvcost*@lmvfactor*@gasolinecost),0,0)

	
	--row 1
	insert into @retMobCalculations
	(FBWithoutLoad_MOB,LBWithoutLoad_MOB,LBWithLoad_MOB,LMV_MOB,ALL_Total,
	SABFBWithoutLoad_MOB,  
    SABLBWithoutLoad_MOB,  
    SABLBWithLoad_MOB ,  
    SABLMV_MOB, SAB_Total)
	values (@fbcost,@lbcost,@lbwoload,@lmvcost,(@fbcost+@lbcost+@lbwoload+@lmvcost),
	@sabfbcost,@sablbcost,@sab_lbwoload,@sab_lmvcost,(@sabfbcost+@sablbcost+@sab_lbwoload+@sab_lmvcost))

	


	set @fbcost=(ROUND((@fbcost/@fb),0))*@fb
	set @lbcost=(ROUND((@lbcost/@lb),0))*@lb
	set @lbwoload=(ROUND((@lbwoload/@lbwithload),0))*@lbwithload
	set @lmvcost=(ROUND((@lmvcost/@lmv),0))*@lmv

	

	if(@sabfb>0)
		BEGIN
        set @sabfbcost=ROUND((@sabfbcost/@sabfb),0)
		set @sabfbcost=ROUND(@sabfbcost,-1)
		end
	
	if(@sablb>0)
	BEGIN
		SET @sablbcost=ROUND((@sablbcost/@sablb),0)
		set @sablbcost=ROUND(@sablbcost,-1)
		end

	if(@sablbwoload>0)
	BEGIN
		set @sab_lbwoload=ROUND((@sab_lbwoload/@sablbwoload),0)
		set @sab_lbwoload=ROUND(@sab_lbwoload,-1)
		end

	if(@sablmvcost>0)
	BEGIN
		set @sab_lmvcost=ROUND((@sab_lmvcost/@sablmvcost),0)
		set @sab_lmvcost=ROUND(@sab_lmvcost,-1)
		end

--row 2
DECLARE @totalcost DECIMAL(10,5)

set @fbcost=ROUND(@fbcost/@fb,0)
set @lbcost=ROUND(@lbcost/@lb,0)
set @lbwoload=ROUND(@lbwoload/@lbwithload,0)
set @lmvcost=ROUND(@lmvcost/@lmv,0)
SET @totalcost=ROUND((@fbcost+@lbcost+@lbwoload+@lmvcost),0)

set @fbcost=ROUND(@fbcost,-1)
set @lbcost=ROUND(@lbcost,-1)
set @lbwoload=ROUND(@lbwoload,-1)
set @lmvcost=ROUND(@lmvcost,-1)
SET @totalcost=ROUND(@totalcost,-1)

		insert into @retMobCalculations
	(FBWithoutLoad_MOB,LBWithoutLoad_MOB,LBWithLoad_MOB,LMV_MOB,All_Total,
	SABFBWithoutLoad_MOB,  
    SABLBWithoutLoad_MOB,  
    SABLBWithLoad_MOB ,  
    SABLMV_MOB,SAB_Total )
	values (@fbcost,@lbcost,@lbwoload,@lmvcost,	@totalcost,
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

	-- row 3
	set @fbcost=@fbcost*@fb
	SET @lbcost=@lbcost*@lb
	SET @lbwoload=@lbwoload*@lbwithload
	SET @lmvcost=@lmvcost*@lmv
	SET @totalcost=ROUND((@fbcost+@lbcost+@lbwoload+@lmvcost),-1)

	insert into @retMobCalculations
	(FBWithoutLoad_MOB,LBWithoutLoad_MOB,LBWithLoad_MOB,LMV_MOB,All_Total,
	SABFBWithoutLoad_MOB,  
    SABLBWithoutLoad_MOB,  
    SABLBWithLoad_MOB ,  
    SABLMV_MOB,SAB_Total )
	--values (@fbcost,@lbcost,@lbwoload,@lmvcost,(@fbcost+@lbcost+@lbwoload+@lmvcost),
	--@sabfbcost,@sablbcost,@sab_lbwoload,@sab_lmvcost,(@sabfbcost+@sablbcost+@sab_lbwoload+@sab_lmvcost))
	--values (ROUND(@fbcost/@fb,-1)*@fb,
	--ROUND(@lbcost/@lb,-1)*@lb,
	--ROUND(@lbwoload/@lbwithload,-1)*@lbwithload,
	--ROUND(@lmvcost/@lmv,-1)*@lmv,
	--(ROUND(@fbcost/@fb,-1)*@fb+ROUND(@lbcost/@lb,-1)*@lb+ROUND(@lbwoload/@lbwithload,-1)*@lbwithload+ROUND(@lmvcost/@lmv,-1)*@lmv),
	VALUES(
	@fbcost,@lbcost,@lbwoload,@lmvcost,@totalcost,
	@sabfbcost,@sablbcost,@sab_lbwoload,@sab_lmvcost,(@sabfbcost+@sablbcost+@sab_lbwoload+@sab_lmvcost))

	
	RETURN
END