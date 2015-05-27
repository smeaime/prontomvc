




CREATE Procedure [dbo].[PedidosAbiertos_TL]
AS 
SELECT 
 IdPedidoAbierto,
 NumeroPedidoAbierto as [Titulo]
FROM PedidosAbiertos
ORDER BY NumeroPedidoAbierto




