


CREATE PROCEDURE [dbo].[DetFacturasRemitos_TXRemitos]
@IdDetalleFactura int
as
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011111133'
set @vector_T='039111100'
SELECT
 DetFacRem.IdDetalleFacturaRemitos,
 Remitos.NumeroRemito as [Remito],
 DetFacRem.IdDetalleRemito as [IdAux],
 DetalleRemitos.NumeroItem as [Item],
 Articulos.Descripcion as [Articulo],
 DetalleRemitos.Cantidad as [Cant.],
 Unidades.Descripcion as [Unidad],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleFacturasRemitos DetFacRem
LEFT OUTER JOIN DetalleRemitos ON DetFacRem.IdDetalleRemito = DetalleRemitos.IdDetalleRemito
LEFT OUTER JOIN Remitos ON DetalleRemitos.IdRemito = Remitos.IdRemito
LEFT OUTER JOIN Articulos ON DetalleRemitos.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetalleRemitos.IdUnidad = Unidades.IdUnidad
WHERE (DetFacRem.IdDetalleFactura = @IdDetalleFactura)


