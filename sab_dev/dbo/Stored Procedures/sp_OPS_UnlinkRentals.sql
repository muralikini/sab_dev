-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_OPS_UnlinkRentals]
	-- Add the parameters for the stored procedure here
	@rentalsid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @ret int

	begin try
		begin transaction
			update  OPS_Rentals
			set StatusFlag=0
			where RentalsId=@rentalsid
		commit transaction
		set @ret=1
	end try
	begin catch

		rollback transaction
		set @ret=0
	end catch
    
END