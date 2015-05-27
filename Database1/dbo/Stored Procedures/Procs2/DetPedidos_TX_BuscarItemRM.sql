


CREATE PROCEDURE [dbo].[DetPedidos_TX_BuscarItemRM]

@IdDetalleRequerimiento int

AS

SELECT
 DetPed.IdDetallePedido,
 DetPed.IdPedido,
 Pedidos.NumeroPedido,
 DetPed.NumeroItem,
 DetPed.Cantidad
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
WHERE DetPed.IdDetalleRequerimiento = @IdDetalleRequerimiento and 
	IsNull(Pedidos.Cumplido,'NO')<>'AN' and IsNull(DetPed.Cumplido,'NO')<>'AN'
ORDER BY Pedidos.NumeroPedido


