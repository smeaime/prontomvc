
CREATE PROCEDURE [dbo].[LecturasGPS_TT]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111111D133'
SET @vector_T='049444418300'

SELECT
 LecturasGPS.IdLecturaGPS,
 LecturasGPS.Latitud as [Latitud],
 LecturasGPS.IdLecturaGPS as [IdAux],
 LecturasGPS.Longitud as [Longitud],
 LecturasGPS.Altura as [Altura],
 LecturasGPS.Temperatura as [Temperatura],
 LecturasGPS.Velocidad as [Velocidad],
 LecturasGPS.Curso as [Curso],
 LecturasGPS.FechaLectura as [Fecha lectura],
 DispositivosGPS.Descripcion as [Dispositivo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM LecturasGPS 
LEFT OUTER JOIN DispositivosGPS ON DispositivosGPS.IdDispositivoGPS=LecturasGPS.IdDispositivoGPS
ORDER BY LecturasGPS.FechaLectura, LecturasGPS.NumeroRegistro
