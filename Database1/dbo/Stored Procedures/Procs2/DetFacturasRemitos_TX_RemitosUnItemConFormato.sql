




























CREATE PROCEDURE [dbo].[DetFacturasRemitos_TX_RemitosUnItemConFormato]
@IdDetalleRemito int
as
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011111133'
set @vector_T='019111100'
SELECT
 0 as [IdAux],
 Remitos.NumeroRemito as [Remito],
 DetalleRemitos.IdDetalleRemito as [IdAux1],
 DetalleRemitos.NumeroItem as [Item],
 Articulos.Descripcion as [Articulo],
 DetalleRemitos.Cantidad as [Cant.],
 Unidades.Descripcion as [Unidad],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRemitos 
LEFT OUTER JOIN Remitos ON DetalleRemitos.IdRemito = Remitos.IdRemito
LEFT OUTER JOIN Articulos ON DetalleRemitos.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetalleRemitos.IdUnidad = Unidades.IdUnidad
WHERE (DetalleRemitos.IdDetalleRemito = @IdDetalleRemito)




























