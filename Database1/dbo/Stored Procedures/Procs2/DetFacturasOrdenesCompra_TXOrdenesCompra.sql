


CREATE PROCEDURE [dbo].[DetFacturasOrdenesCompra_TXOrdenesCompra]

@IdDetalleFactura int

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='01111111111133'
Set @vector_T='03906H9C001200'

SELECT
 DetFacOC.IdDetalleFacturaOrdenesCompra,
 OrdenesCompra.NumeroOrdenCompra as [O.Compra],
 DetFacOC.IdDetalleFacturaOrdenesCompra as [IdAux],
 OrdenesCompra.NumeroOrdenCompraCliente as [O.C.(Cli.)],
 Obras.NumeroObra as [Obra],
 doc.NumeroItem as [Item],
 doc.IdArticulo,
 Articulos.Descripcion as [Articulo],
 doc.Cantidad as [Cant.],
 Unidades.Abreviatura as [Unidad],
 doc.Precio as [Precio],
 doc.Cantidad * doc.Precio as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleFacturasOrdenesCompra DetFacOC
LEFT OUTER JOIN DetalleOrdenesCompra doc ON DetFacOC.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra
LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
LEFT OUTER JOIN Obras ON OrdenesCompra.IdObra = Obras.IdObra
LEFT OUTER JOIN Articulos ON doc.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON doc.IdUnidad = Unidades.IdUnidad
WHERE (DetFacOC.IdDetalleFactura = @IdDetalleFactura)


