




CREATE Procedure [dbo].[DetPedidos_SetearPedidoPresto]
@IdDetallePedido int,
@PRESTOPedido varchar(13)
As 
Update DetallePedidos
Set 	PRESTOPedido=@PRESTOPedido,
	PRESTOFechaProceso=GetDate()
Where IdDetallePedido=@IdDetallePedido




