
CREATE PROCEDURE [dbo].[DetNotasCreditoOC_TXPrimero]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30), @Entregado numeric, @Pedido numeric
SET @vector_X='011111111111111133'
SET @vector_T='039000000933000100'

SELECT TOP 1
 DetNC_OC.IdDetalleNotaCreditoOrdenesCompra,
 OrdenesCompra.NumeroOrdenCompra as [O.Compra],
 DetNC_OC.IdDetalleOrdenCompra as [IdAux],
 OrdenesCompra.NumeroOrdenCompraCliente as [O.C.(Cli.)],
 Obras.NumeroObra as [Obra],
 doc.NumeroItem as [Item],
 Articulos.Descripcion as [Articulo],
 doc.Cantidad as [Cant.],
 Unidades.Descripcion as [Unidad],
 doc.IdArticulo,
 doc.Precio as [Precio],
 doc.Cantidad * doc.Precio as [Importe],
 '0.00' as [Pendiente],
 '0.00' as [A acreditar],
 '0.00' as [Nuevo pend.],
 Colores.Descripcion as [Color],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleNotasCreditoOrdenesCompra DetNC_OC
LEFT OUTER JOIN DetalleOrdenesCompra doc ON DetNC_OC.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra
LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
LEFT OUTER JOIN Obras ON OrdenesCompra.IdObra = Obras.IdObra
LEFT OUTER JOIN Articulos ON doc.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON doc.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Colores ON doc.IdColor=Colores.IdColor
