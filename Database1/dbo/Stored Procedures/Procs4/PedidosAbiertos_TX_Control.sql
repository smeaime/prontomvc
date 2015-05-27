
CREATE PROCEDURE [dbo].[PedidosAbiertos_TX_Control]

@IdPedidoAbierto int

AS

SELECT PedidosAbiertos.*,  
	IsNull((Select Sum(IsNull(Pedidos.TotalPedido,0)) 
		From Pedidos
		Where IsNull(Pedidos.IdPedidoAbierto,0)=@IdPedidoAbierto),0) as [SumaPedidos]
FROM PedidosAbiertos
WHERE PedidosAbiertos.IdPedidoAbierto=@IdPedidoAbierto
