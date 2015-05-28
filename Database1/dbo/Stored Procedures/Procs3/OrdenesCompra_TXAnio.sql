
CREATE Procedure [dbo].[OrdenesCompra_TXAnio]
As
SELECT 
 Min(CONVERT(varchar, YEAR(FechaOrdenCompra)))  AS Período,YEAR(FechaOrdenCompra)
FROM OrdenesCompra
WHERE FechaOrdenCompra is not null
GROUP BY  YEAR(FechaOrdenCompra) 
ORDER by  YEAR(FechaOrdenCompra)  desc
