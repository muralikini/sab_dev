-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [sp_HR_GetNotifications]
	-- Add the parameters for the stored procedure here
	@empid INT,
	@flag INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @mgrid INT
	SELECT @mgrid= [dbo].[HR.Managers].ManagerID
	FROM [dbo].[HR.Managers]
   	WHERE [dbo].[HR.Managers].FK_EmpId=@empid
	
	IF(@mgrid IS NOT NULL)
		BEGIN
			IF(@mgrid!=6 AND @mgrid!=1 AND @mgrid!=5 AND @mgrid !=3)
				BEGIN
					EXEC [dbo].[sp_subqry_GetNotifications_ReportingMgr]
					@empid,
					@flag
				END
			ELSE IF(@mgrid=5 OR @mgrid=3)
				BEGIN
					EXEC [dbo].[sp_subqry_GetNotifications_HR]
					@empid,
					@flag
				END
			ELSE IF(@mgrid=1 OR @mgrid=6)
				BEGIN
					EXEC [dbo].[sp_subqry_GetNotifications_Management]
					@empid,
					@flag
				end
		      
		END
	ELSE
		BEGIN

			EXEC [dbo].[sp_subqry_GetNotifications_Emp]
			@empid,
			@flag

	END
    

	
END