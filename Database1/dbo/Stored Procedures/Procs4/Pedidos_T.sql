
CREATE Procedure [dbo].[Pedidos_T]
@IdPedido int
AS 
SELECT * 
FROM Pedidos
WHERE (IdPedido=@IdPedido)
