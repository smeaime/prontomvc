






















CREATE Procedure [dbo].[EstadoPedidos_TX_PorNumeroPedido]
@NumeroPedido int,
@SubnumeroPedido int
AS 
SELECT TOP 1 *
FROM EstadoPedidos
WHERE NumeroPedido=@NumeroPedido And SubnumeroPedido=@SubnumeroPedido and
	IdTipoComprobante=1






















