



















CREATE Procedure [dbo].[DetOrdenesCompra_TX_PorIdOrdenPago]
@IdDetalleOrdenCompra int
As 
Select 
 doc.*,
 Articulos.Descripcion as [Articulo],
 Articulos.IdUbicacionStandar
FROM DetalleOrdenesCompra doc
LEFT OUTER JOIN Articulos ON doc.IdArticulo = Articulos.IdArticulo
WHERE (doc.IdDetalleOrdenCompra = @IdDetalleOrdenCompra)


















