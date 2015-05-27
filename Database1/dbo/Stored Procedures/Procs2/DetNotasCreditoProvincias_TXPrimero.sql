




CREATE PROCEDURE [dbo].[DetNotasCreditoProvincias_TXPrimero]

AS

Declare @vector_X varchar(60),@vector_T varchar(60)
Set @vector_X='001133'
Set @vector_T='001400'

SELECT TOP 1
 DetCre.IdDetalleNotaCreditoProvincias,
 DetCre.IdNotaCredito,
 Provincias.Nombre as [Provincia destino],
 DetCre.Porcentaje as [Porcentaje],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleNotasCreditoProvincias DetCre
LEFT OUTER JOIN Provincias ON DetCre.IdProvinciaDestino = Provincias.IdProvincia




