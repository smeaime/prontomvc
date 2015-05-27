




CREATE Procedure [dbo].[Pedidos_BorrarAsignacionCosto]

@IdAsignacionCosto int

As 

Declare @IdDetallePedido int
Set @IdDetallePedido=(Select Top 1 AsignacionesCostos.IdDetallePedido 
			From AsignacionesCostos
			Where AsignacionesCostos.IdAsignacionCosto=@IdAsignacionCosto)

Update DetallePedidos
Set IdAsignacionCosto=Null
Where (IdDetallePedido=@IdDetallePedido)
Return(@IdDetallePedido)





