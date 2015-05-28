
CREATE PROCEDURE [dbo].[DetPatronesGPS_TXPrimero]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111111133'
SET @vector_T='049444441800'

SELECT TOP 1
 Det.IdDetallePatronGPS,
 Det.Latitud as [Latitud],
 Det.IdDetallePatronGPS as [IdAux],
 Det.Longitud as [Longitud],
 Det.Altura as [Altura],
 Det.DistanciaKm as [Distancia en Km],
 Det.Temperatura as [Temperatura],
 Det.Velocidad as [Velocidad],
 Det.Curso as [Curso],
 Det.FechaLectura as [Fecha lectura],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePatronesGPS Det
