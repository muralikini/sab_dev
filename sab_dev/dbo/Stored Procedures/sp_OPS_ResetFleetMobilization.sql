-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_ResetFleetMobilization]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM dbo.OPS_RigMoveFlatbeds
DELETE FROM dbo.OPS_RigMoveLMV
DELETE FROM dbo.OPS_RigMoveLowbeds
DELETE FROM dbo.OPS_RigMoveCranes
DELETE FROM dbo.OPS_RigMoveWL
DELETE FROM dbo.OPS_RigMoveOFT
DELETE FROM dbo.OPS_RigMoveManpower
DELETE FROM dbo.OPS_RigMoveRentals


DELETE FROM dbo.OPS_FlatbedJn
DELETE FROM dbo.OPS_LowbedJn
DELETE FROM dbo.OPS_CraneJn
DELETE FROM dbo.OPS_WLJn
DELETE FROM dbo.OPS_OFTJn
DELETE FROM dbo.OPS_LMVJn


UPDATE dbo.OPS_Flatbeds
SET StatusFlag=0
UPDATE dbo.OPS_FlatbedDrivers
SET StatusFlag=0

UPDATE dbo.OPS_Lowbeds
SET StatusFlag=0

UPDATE dbo.OPS_LowbedDrivers
SET StatusFlag=0

UPDATE dbo.OPS_Cranes
SET StatusFlag=0

UPDATE dbo.OPS_CraneOperators
SET StatusFlag=0

UPDATE dbo.OPS_WL
SET StatusFlag=0

UPDATE dbo.OPS_WLOperators
SET StatusFlag=0

UPDATE dbo.OPS_LMV
SET StatusFlag=0

UPDATE dbo.OPS_LMVDrivers
SET StatusFlag=0

UPDATE dbo.OPS_OFT
SET StatusFlag=0

UPDATE dbo.OPS_Rentals
SET StatusFlag=0

UPDATE dbo.OPS_Manpower
SET StatusFlag=1

END