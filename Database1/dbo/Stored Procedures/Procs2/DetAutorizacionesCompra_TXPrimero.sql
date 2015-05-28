
CREATE PROCEDURE [dbo].[DetAutorizacionesCompra_TXPrimero]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111133'
SET @vector_T='03D31500'

SELECT TOP 1 
 Det.IdDetalleAutorizacionCompra,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Det.Cantidad as [Cantidad],
 Unidades.Abreviatura as [En :],
 Det.Observaciones,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleAutorizacionesCompra Det
LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON Det.IdUnidad = Unidades.IdUnidad
