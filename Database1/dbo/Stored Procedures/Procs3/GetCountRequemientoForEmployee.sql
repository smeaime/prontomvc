
CREATE PROCEDURE [dbo].[GetCountRequemientoForEmployee]
@IdSolicito int
 AS
DECLARE @rowcount INT
SELECT @rowcount = Count(*) FROM Requerimientos WHERE IdSolicito = @IdSolicito and Cumplido <> 'AN'

IF @rowcount > 0  
BEGIN
            RETURN @rowcount
END
ELSE
BEGIN
            RETURN 0
END

