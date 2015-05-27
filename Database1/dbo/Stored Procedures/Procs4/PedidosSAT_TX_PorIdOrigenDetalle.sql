
CREATE Procedure [dbo].[PedidosSAT_TX_PorIdOrigenDetalle]
@IdDetallePedidoOriginal int,
@IdOrigenTransmision int
AS 
SELECT TOP 1 det.*, PedidosSAT.IdPedido
FROM DetallePedidosSAT det
LEFT OUTER JOIN PedidosSAT ON det.IdPedido=PedidosSAT.IdPedido
WHERE det.IdDetallePedidoOriginal=@IdDetallePedidoOriginal and 
	det.IdOrigenTransmision=@IdOrigenTransmision
