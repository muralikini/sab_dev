-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_GetTrucksInRigMove]
	-- Add the parameters for the stored procedure here
	@routesurveyid INT,
	@vehicletype int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF(@vehicletype=0) -- flatbed
	begin
		SELECT        OPS_RigMoveFlatbeds.RMFBId, OPS_RigMoveFlatbeds.FK_FBid, OPS_Flatbeds.SAB_ID
FROM            OPS_RigMoveFlatbeds INNER JOIN
                         OPS_FlatbedJn ON OPS_RigMoveFlatbeds.FK_FBid = OPS_FlatbedJn.FBJnId INNER JOIN
                         OPS_Flatbeds ON OPS_FlatbedJn.FK_FBId = OPS_Flatbeds.FlatbedId
		WHERE        (OPS_RigMoveFlatbeds.RouteSurveyId = @routesurveyid) AND OPS_RigMoveFlatbeds.StatusFlag>0
	end
	else IF(@vehicletype=1) -- Lowbed
	begin
		SELECT        OPS_RigMoveLowbeds.RMLBId, OPS_RigMoveLowbeds.FK_LBId, OPS_Lowbeds.Sab_Id
FROM            OPS_Lowbeds INNER JOIN
                         OPS_LowbedJn ON OPS_Lowbeds.LowbedId = OPS_LowbedJn.FK_LBId INNER JOIN
                         OPS_RigMoveLowbeds ON OPS_LowbedJn.LBJnId = OPS_RigMoveLowbeds.FK_LBId
WHERE        (OPS_RigMoveLowbeds.StatusFlag > 0) AND (OPS_RigMoveLowbeds.RouteSurveyId = @routesurveyid)
	END
    else IF(@vehicletype=2) -- CRANES
	begin
		SELECT        OPS_RigMoveCranes.RMCraneId, OPS_RigMoveCranes.FK_CraneJnId, OPS_Cranes.SAB_ID
FROM            OPS_CraneJn INNER JOIN
                         OPS_RigMoveCranes ON OPS_CraneJn.CraneJnId = OPS_RigMoveCranes.FK_CraneJnId INNER JOIN
                         OPS_Cranes ON OPS_CraneJn.FK_CraneId = OPS_Cranes.CraneId
WHERE        (OPS_RigMoveCranes.FK_RouteSurveyId = @routesurveyid) AND (OPS_RigMoveCranes.StatusFlag > 0)
	END
    else IF(@vehicletype=3) -- Wheel Loaders
	begin
		SELECT        OPS_RigMoveWL.RMWLId, OPS_RigMoveWL.FK_WLJnId, OPS_WL.SAB_ID, OPS_RigMoveWL.StatusFlag
FROM            OPS_WLJn INNER JOIN
                         OPS_WL ON OPS_WLJn.FK_WLId = OPS_WL.WLId INNER JOIN
                         OPS_RigMoveWL ON OPS_WLJn.WLJnId = OPS_RigMoveWL.FK_WLJnId
						 WHERE        (OPS_RigMoveWL.FK_RouteSurveyId = @routesurveyid) AND (OPS_RigMoveWL.StatusFlag > 0)
	END
    else IF(@vehicletype=4) -- LMV
	begin
		SELECT        OPS_RigMoveLMV.RMLMVId, OPS_RigMoveLMV.FK_LMVJnId, OPS_LMV.SAB_ID, OPS_RigMoveLMV.StatusFlag
FROM            OPS_LMVJn INNER JOIN
                         OPS_LMV ON OPS_LMVJn.FK_LMVId = OPS_LMV.LMVId INNER JOIN
                         OPS_RigMoveLMV ON OPS_LMVJn.LMVJn = OPS_RigMoveLMV.FK_LMVJnId
						 WHERE        (OPS_RigMoveLMV.FK_RouteSurveyId = @routesurveyid) AND (OPS_RigMoveLMV.StatusFlag > 0)
	END
     else IF(@vehicletype=5) -- OFT- Oil field trucks
	begin
		SELECT        OPS_RigMoveOFT.RMOFTId, OPS_RigMoveOFT.FK_OFTJnId, OPS_OFT.SAB_ID, OPS_RigMoveOFT.StatusFlag
FROM            OPS_OFTJn INNER JOIN
                         OPS_RigMoveOFT ON OPS_OFTJn.OFTJnId = OPS_RigMoveOFT.FK_OFTJnId INNER JOIN
                         OPS_OFT ON OPS_OFTJn.FK_OFTId = OPS_OFT.OFTId
WHERE        (OPS_RigMoveOFT.FK_RouteSurveyId = @routesurveyid) AND (OPS_RigMoveOFT.StatusFlag > 0)
	END
     else IF(@vehicletype=6) -- Rentals
	begin
		SELECT        OPS_RigMoveRentals.RMRentalsId, OPS_RigMoveRentals.FK_RentalsId, OPS_Rentals.Name, OPS_RigMoveRentals.StatusFlag
FROM            OPS_Rentals INNER JOIN
                         OPS_RigMoveRentals ON OPS_Rentals.RentalsId = OPS_RigMoveRentals.FK_RentalsId
WHERE        (OPS_RigMoveRentals.StatusFlag > 0) AND (OPS_RigMoveRentals.FK_RouteSurveyId=@routesurveyid)
	end
END