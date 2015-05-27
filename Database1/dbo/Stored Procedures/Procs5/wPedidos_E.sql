
CREATE Procedure [dbo].[wPedidos_E]

@IdPedido int  

AS 

DELETE Pedidos 
WHERE (IdPedido=@IdPedido)

