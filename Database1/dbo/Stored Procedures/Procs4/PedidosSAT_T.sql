
CREATE Procedure [dbo].[PedidosSAT_T]
@IdPedido int
AS 
SELECT * 
FROM PedidosSAT
WHERE (IdPedido=@IdPedido)
