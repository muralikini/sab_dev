-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_UpdateRigMoveFleet]
	-- Add the parameters for the stored procedure here
	@vehicletype INT,
	@routesurveyid INT,
	@vehid INT,
	@dateofmob DATE =NULL,
	@dateofdemob DATE =NULL,
	@startodo INT=NULL,
	@endodo INT =NULL,
	@remarks NVARCHAR(MAX)=null,
	@flag INT  -- 0 to update and 1 to insert
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @retval INT

	BEGIN try
    BEGIN transaction
	IF(@vehicletype = 0)
	BEGIN
			EXEC  @retval= [dbo].[sp_OPS_subqry_UpdateRigMoveFlatbeds]
			@routesurveyid,
			@vehid,
			@dateofmob,
			@dateofdemob,
			@startodo,
			@endodo,
			@remarks,
			@flag

	END
    ELSE IF (@vehicletype=1)
	BEGIN
		EXEC  @retval= [dbo].[sp_OPS_subqry_UpdateRigMoveLowbeds]
			@routesurveyid,
			@vehid,
			@dateofmob,
			@dateofdemob,
			@startodo,
			@endodo,
			@remarks,
			@flag
	END
    ELSE IF (@vehicletype=2)
	BEGIN
		EXEC  @retval= [dbo].[sp_OPS_subqry_UpdateRigMoveCranes]
			@routesurveyid,
			@vehid,
			@dateofmob,
			@dateofdemob,
			@startodo,
			@endodo,
			@remarks,
			@flag
	END
	ELSE IF (@vehicletype=3)
	BEGIN
		EXEC  @retval= [dbo].[sp_OPS_subqry_UpdateRigMoveWL]
			@routesurveyid,
			@vehid,
			@dateofmob,
			@dateofdemob,
			@startodo,
			@endodo,
			@remarks,
			@flag
	END
	ELSE IF (@vehicletype=4)
	BEGIN
		EXEC  @retval= [dbo].[sp_OPS_subqry_UpdateRigMoveLMV]
			@routesurveyid,
			@vehid,
			@dateofmob,
			@dateofdemob,
			@startodo,
			@endodo,
			@remarks,
			@flag
	END
	ELSE IF (@vehicletype=5)
	BEGIN
		EXEC  @retval= [dbo].[sp_OPS_subqry_UpdateRigMoveOFT]
			@routesurveyid,
			@vehid,
			@dateofmob,
			@dateofdemob,
			@startodo,
			@endodo,
			@remarks,
			@flag
	END
	ELSE IF (@vehicletype=6)
	BEGIN
		EXEC  @retval= [dbo].[sp_OPS_subqry_UpdateRigMoveRentals]
			@routesurveyid,
			@vehid,
			@dateofmob,
			@dateofdemob,
			@startodo,
			@endodo,
			@remarks,
			@flag
	END
	ELSE IF (@vehicletype=7)
	BEGIN
		EXEC  @retval= [dbo].[sp_OPS_subqry_UpdateRigMoveManpower]
			@routesurveyid,
			@vehid,
			@dateofmob,
			@dateofdemob,
			@flag
	END
		COMMIT TRANSACTION

	END TRY
    BEGIN CATCH
		ROLLBACK TRANSACTION
		SET @retval=0
	END catch
    
END
RETURN @retval