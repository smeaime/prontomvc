
CREATE PROCEDURE [dbo].[ComprobantesProveedores_TX_DatosPorIdDetalleRecepcion]

@IdDetalleRecepcion int

AS

SELECT
 Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2),1,15) as [Remito],
 Recepciones.FechaRecepcion as [Fecha rec.],
 Articulos.Descripcion as [Articulo],
 DetRec.Cantidad as [Cantidad],
 Pedidos.NumeroPedido as [Pedido],
 DetPed.NumeroItem as [It.Ped]
FROM DetalleRecepciones DetRec
LEFT OUTER JOIN Articulos ON DetRec.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
LEFT OUTER JOIN DetallePedidos DetPed ON DetRec.IdDetallePedido = DetPed.IdDetallePedido
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
WHERE DetRec.IdDetalleRecepcion = @IdDetalleRecepcion
