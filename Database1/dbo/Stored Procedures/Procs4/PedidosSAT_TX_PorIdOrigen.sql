
CREATE Procedure [dbo].[PedidosSAT_TX_PorIdOrigen]
@IdPedidoOriginal int,
@IdOrigenTransmision int
AS 
SELECT TOP 1 IdPedido
FROM PedidosSAT
WHERE IdPedidoOriginal=@IdPedidoOriginal and 
	IdOrigenTransmision=@IdOrigenTransmision
