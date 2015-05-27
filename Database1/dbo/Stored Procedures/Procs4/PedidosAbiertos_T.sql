




CREATE Procedure [dbo].[PedidosAbiertos_T]
@IdPedidoAbierto int
AS 
SELECT *
FROM PedidosAbiertos
WHERE (IdPedidoAbierto=@IdPedidoAbierto)




