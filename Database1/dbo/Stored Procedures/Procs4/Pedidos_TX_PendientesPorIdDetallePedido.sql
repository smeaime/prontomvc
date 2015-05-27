
CREATE PROCEDURE [dbo].[Pedidos_TX_PendientesPorIdDetallePedido]

@IdDetallePedido int,
@IdDetalleRecepcion int

AS 

SELECT
 DetPed.IdDetallePedido,
 DetPed.NumeroItem,
 Pedidos.NumeroPedido,
 DetPed.Cantidad,
 IsNull((Select Sum(DetRec.Cantidad)
	From DetalleRecepciones DetRec
	Left Outer Join Recepciones On DetRec.IdRecepcion = Recepciones.IdRecepcion
	Where DetPed.IdDetallePedido=DetRec.IdDetallePedido and 
		DetRec.IdDetalleRecepcion<>@IdDetalleRecepcion and 
		(Recepciones.Anulada is null or Recepciones.Anulada<>'SI')),0) as [Entregado],
 DetPed.Cantidad - Isnull((Select Sum(DetRec.Cantidad)
 				From DetalleRecepciones DetRec 
				Left Outer Join Recepciones On Recepciones.IdRecepcion=DetRec.IdRecepcion
				Where DetRec.IdDetallePedido=DetPed.IdDetallePedido and 
					DetRec.IdDetalleRecepcion<>@IdDetalleRecepcion and 
					(Recepciones.Anulada is null or Recepciones.Anulada<>'SI')),0)
 as [Pendiente]
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
WHERE DetPed.IdDetallePedido=@IdDetallePedido
