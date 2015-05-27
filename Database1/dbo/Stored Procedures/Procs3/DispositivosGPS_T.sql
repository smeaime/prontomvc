
CREATE Procedure [dbo].[DispositivosGPS_T]

@IdDispositivoGPS int

AS 

SELECT *
FROM DispositivosGPS
WHERE (IdDispositivoGPS=@IdDispositivoGPS)
