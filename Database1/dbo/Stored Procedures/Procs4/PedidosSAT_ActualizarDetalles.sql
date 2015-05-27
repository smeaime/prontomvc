
CREATE Procedure [dbo].[PedidosSAT_ActualizarDetalles]

@IdPedidoOriginal int,
@IdOrigenTransmision int

AS

UPDATE DetallePedidosSAT
SET 
 IdPedido=(Select Top 1 sat.IdPedido 
		From PedidosSAT sat
		Where sat.IdPedidoOriginal=@IdPedidoOriginal and 
			sat.IdOrigenTransmision=@IdOrigenTransmision)
WHERE IdPedidoOriginal=@IdPedidoOriginal and 
	IdOrigenTransmision=@IdOrigenTransmision
