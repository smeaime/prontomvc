CREATE Procedure [dbo].[Pedidos_ActualizarCosto]

@IdDetallePedido int,
@IdAsignacionCosto int,
@Costo numeric(12,2)

AS 

DECLARE @IdPedido int

SET @IdPedido=IsNull((Select Top 1 IdPedido From DetallePedidos Where IdDetallePedido=@IdDetallePedido),0)

UPDATE DetallePedidos
SET 
 IdAsignacionCosto=@IdAsignacionCosto,
 Precio=@Costo
WHERE IdDetallePedido=@IdDetallePedido

EXEC Pedidos_RecalcularTotales @IdPedido