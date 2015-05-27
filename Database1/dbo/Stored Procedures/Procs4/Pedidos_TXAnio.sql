CREATE Procedure [dbo].[Pedidos_TXAnio]

AS

SELECT Min(CONVERT(varchar,YEAR(FechaPedido)))  as [Período], YEAR(FechaPedido)
FROM Pedidos
WHERE FechaPedido is not null
GROUP BY YEAR(FechaPedido) 
ORDER BY YEAR(FechaPedido)  desc