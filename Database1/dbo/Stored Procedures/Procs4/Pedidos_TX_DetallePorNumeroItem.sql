
CREATE Procedure [dbo].[Pedidos_TX_DetallePorNumeroItem]

@NumeroPedido int,
@SubNumero int,
@NumeroItem int

AS 

SELECT * 
FROM DetallePedidos
LEFT OUTER JOIN Pedidos ON DetallePedidos.IdPedido=Pedidos.IdPedido
WHERE Pedidos.NumeroPedido=@NumeroPedido and Pedidos.SubNumero=@SubNumero and DetallePedidos.NumeroItem=@NumeroItem
