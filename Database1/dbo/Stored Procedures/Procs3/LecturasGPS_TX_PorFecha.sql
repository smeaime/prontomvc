
CREATE PROCEDURE [dbo].[LecturasGPS_TX_PorFecha]

@Fecha datetime, 
@IdDispositivoGPS int

AS

SELECT TOP 1 *
FROM LecturasGPS
WHERE FechaLectura<=@Fecha and IdDispositivoGPS=@IdDispositivoGPS
ORDER BY FechaLectura Desc, NumeroRegistro
