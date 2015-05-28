
















CREATE Procedure [dbo].[Pedidos_TX_PorId]
@IdPedido int
AS 
SELECT * 
FROM Pedidos
WHERE (IdPedido=@IdPedido)

















