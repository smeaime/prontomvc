




CREATE Procedure [dbo].[Pedidos_SetearPedidoPresto]
@IdPedido int,
@PRESTOPedido varchar(13)
As 
Update Pedidos
Set 	PRESTOPedido=@PRESTOPedido,
	PRESTOFechaProceso=GetDate()
Where IdPedido=@IdPedido




