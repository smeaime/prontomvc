
CREATE Procedure [dbo].[PedidosSAT_TXAnio]

AS

SELECT Min(CONVERT(varchar, YEAR(FechaPedido)))  as [Periodo], YEAR(FechaPedido)
FROM PedidosSAT
WHERE FechaPedido is not null
GROUP BY YEAR(FechaPedido) 
ORDER BY YEAR(FechaPedido)  desc
