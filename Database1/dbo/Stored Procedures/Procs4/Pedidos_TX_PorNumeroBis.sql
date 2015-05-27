CREATE Procedure [dbo].[Pedidos_TX_PorNumeroBis]

@NumeroPedido int

AS 

SELECT 
IdPedido,
SubNumero
FROM Pedidos
WHERE NumeroPedido=@NumeroPedido