-- =============================================
-- Author:		Muralidhar Kini
-- Create date: 16-02-2019
-- Description:	used to retrieve different datasets
--				that could be used to display in combo box in UI
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_GetFilter] 
	-- Add the parameters for the stored procedure here
	@filtertype int --1, rental types
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   if(@filtertype=1)
   begin
		select distinct TypeDescription
		from OPS_RentalTypes
	end
  if(@filtertype=2)
   begin
		SELECT        OPS_Rentals.RentalsId, OPS_RentalTypes.TypeDescription, OPS_Rentals.Name
		FROM            OPS_Rentals INNER JOIN
                         OPS_RentalTypes ON OPS_Rentals.FK_RentalTypeId = OPS_RentalTypes.RentalTypeId
		WHERE        (OPS_Rentals.StatusFlag = 1)
	end

	if(@filtertype=3)
	begin
			SELECT DISTINCT RigMoveStatusId, Description
FROM            RigMoveStatus

	end

END