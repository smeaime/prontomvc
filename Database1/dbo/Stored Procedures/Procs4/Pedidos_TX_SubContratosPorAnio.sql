




CREATE Procedure [dbo].[Pedidos_TX_SubContratosPorAnio]
AS
SELECT 
 MIN(CONVERT(varchar, YEAR(FechaPedido))) AS Período,YEAR(FechaPedido)
FROM Pedidos
WHERE FechaPedido is not null and IsNull(Subcontrato,'NO')='SI'
GROUP BY  YEAR(FechaPedido) 
ORDER by  YEAR(FechaPedido) DESC




