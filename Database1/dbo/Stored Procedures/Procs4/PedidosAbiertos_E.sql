




CREATE Procedure [dbo].[PedidosAbiertos_E]
@IdPedidoAbierto int 
AS 
DELETE PedidosAbiertos
WHERE (IdPedidoAbierto=@IdPedidoAbierto)




