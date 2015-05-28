




CREATE PROCEDURE [dbo].[DetNotasDebitoProvincias_TXPrimero]

AS

Declare @vector_X varchar(60),@vector_T varchar(60)
Set @vector_X='001133'
Set @vector_T='001400'

SELECT TOP 1
 DetDeb.IdDetalleNotaDebitoProvincias,
 DetDeb.IdNotaDebito,
 Provincias.Nombre as [Provincia destino],
 DetDeb.Porcentaje as [Porcentaje],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleNotasDebitoProvincias DetDeb
LEFT OUTER JOIN Provincias ON DetDeb.IdProvinciaDestino = Provincias.IdProvincia




