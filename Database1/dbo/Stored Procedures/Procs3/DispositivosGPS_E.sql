
CREATE Procedure [dbo].[DispositivosGPS_E]

@IdDispositivoGPS int 

AS 

DELETE DispositivosGPS
WHERE (IdDispositivoGPS=@IdDispositivoGPS)
