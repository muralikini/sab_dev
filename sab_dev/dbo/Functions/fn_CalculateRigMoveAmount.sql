-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_CalculateRigMoveAmount]
(
	-- Add the parameters for the function here
	@routesurveyid int
	

)
RETURNS @retMobCalculations TABLE   
(  
    FB_RM float  NOT NULL,  
    LB_RM float NOT NULL,  
    LMV_RM float NOT NULL,  
    Food_RM float  NULL,
	Total float NOT NULL
	
     
)
AS
BEGIN


	DECLARE @rigmovetype INT
	
	SELECT @rigmovetype=dbo.RoadSurveyDetails.InHouseRigMove
	FROM dbo.RoadSurveyDetails
	WHERE RouteSurveyId=@routesurveyid

	IF(@rigmovetype=1)
	begin

			declare @fb int
			declare @lb int
			declare @lbwithload int
			declare @lmv int

			declare @loadedlbmob int
			declare @loadedlbdemob int
			declare @fooddays int
			declare @foodrate float
			declare @manpower int
			declare @maintainance float

			select 
			@fb=Flatbed,
			@lb=Lowbed,
			@lbwithload=LBwithLoad,
			@lmv=LMV
			from [dbo].[MDC_VehicleDetails]
			where FK_RouteSurveyId=@routesurveyid

	

			select 
			@loadedlbmob=ExtraMobLoadedLB,
			@loadedlbdemob=ExtraDemobLoadedLB,
			@fooddays=FoodDays,
			@foodrate=FoodRate,
			@manpower=Manpower,
			@maintainance=Maintainance
			from MDC_AddOnCost
			where FK_RouteSurveyId=@routesurveyid



			-- Declare the return variable here
			declare @mobdistance int
			declare @rigmovedistance int
			declare @demobdistance int

			declare @dieselcost float
			declare @gasolinecost float
			declare @FBfactor float
			declare @LBfactor float
			declare @lmvfactor float

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

			declare @fbcost float
			declare @lbcost float
			declare @lbwoload float
			declare @lmvcost FLOAT
    
			DECLARE @rentalfb INT
			DECLARE @rentallb INT
			DECLARE @rentallbload INT
			DECLARE @rentallmv int

			declare @sabfb int
			declare @sablb int
			declare @sablbwoload int
			declare @sablmvcost int

			select 
			@rentalfb=Flatbed,
			@rentallb=Lowbed,
			@rentallbload=LBwithLoad,
			@rentallmv=LMV
			from [dbo].[MDC_RentalVehicleDetails]
			where FK_RouteSurveyId=@routesurveyid

			declare @sabfbcost float
			declare @sablbcost float
			declare @sab_lbwoload float
			declare @sab_lmvcost float

			set @sabfb=@fb-@rentalfb
			set @sablb=@lb-@rentallb
			set @sablbwoload=@lbwithload-@rentallbload
			set @sablmvcost=@lmv-@rentallmv



			declare @totalloads int
			declare @loaded1sidetrip int
			declare @empty1sidetrip int

			select 
			@totalloads=TotalLoads
			from [dbo].[MDC_LoadDetails]
			where FK_RouteSurveyId=@routesurveyId

			declare @foodcost float

			set @loaded1sidetrip=ROUND((@totalloads/(@fb+@lb+@lbwithload)),0,0)
			set @empty1sidetrip=@loaded1sidetrip-1

			set @fbcost=ROUND(@rigmovedistance*@fb*(@loaded1sidetrip+@empty1sidetrip)*@FBfactor*@dieselcost,0,0)
			set @lbcost=ROUND(@rigmovedistance*(@lb+@lbwithload)*(@loaded1sidetrip+@empty1sidetrip)*@LBfactor*@dieselcost,0,0)
			--set @lbcost=ROUND(@rigmovedistance*(@lb+@lbwithload)*(@loaded1sidetrip+@empty1sidetrip)*@dieselcost,0,0)
			set @lmvcost=ROUND((@rigmovedistance*@lmv*(@loaded1sidetrip+@empty1sidetrip)*(.75/4)),0,0)
			set @foodcost=Round((@fooddays*@foodrate*@manpower),0,0)

			--row 1
			insert into @retMobCalculations
			(FB_RM,LB_RM,LMV_RM,Food_RM,Total)
			values 
	
			(@fbcost,@lbcost,@lmvcost,@foodcost,(@fbcost+@lbcost+@lmvcost+@foodcost))

			set @fbcost=ROUND(@fbcost/@fb,0)
			set @lbcost=ROUND((@lbcost/(@lb+@lbwithload)),0)
			set @lmvcost=ROUND(@lmvcost/@lmv,0)
			set @foodcost=ROUND(@foodcost/@manpower,0)

			set @fbcost=ROUND(@fbcost,-1)
			set @lbcost=ROUND(@lbcost,-1)
			set @lmvcost=ROUND(@lmvcost,-1)
			set @foodcost=ROUND(@foodcost,-1)
			--row 2
			insert into @retMobCalculations
			(FB_RM,LB_RM,LMV_RM,Food_RM,Total)
			values 
	
			(@fbcost,@lbcost,@lmvcost,@foodcost,(@fbcost+@lbcost+@lmvcost+@foodcost))

			set @fbcost=@fbcost*@fb
			set @lbcost=@lbcost*(@lb+@lbwithload)
			set @lmvcost=@lmvcost*@lmv
			set @foodcost=@foodcost*@manpower

	
	-- row 3
	
				insert into @retMobCalculations
				(FB_RM,LB_RM,LMV_RM,Food_RM,Total)
				values 
				--(@lmv,@lmvfactor,@loaded1sidetrip,@empty1sidetrip)
				(@fbcost,@lbcost,@lmvcost,@foodcost,(@fbcost+@lbcost+@lmvcost+@foodcost))
	
	
	end
	
	RETURN
END