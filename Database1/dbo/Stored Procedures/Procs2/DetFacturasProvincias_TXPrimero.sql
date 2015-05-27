




CREATE PROCEDURE [dbo].[DetFacturasProvincias_TXPrimero]

AS

Declare @vector_X varchar(60),@vector_T varchar(60)
Set @vector_X='001133'
Set @vector_T='001400'

SELECT TOP 1
 DetFac.IdDetalleFacturaProvincias,
 DetFac.IdFactura,
 Provincias.Nombre as [Provincia destino],
 DetFac.Porcentaje as [Porcentaje],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleFacturasProvincias DetFac
LEFT OUTER JOIN Provincias ON DetFac.IdProvinciaDestino = Provincias.IdProvincia




