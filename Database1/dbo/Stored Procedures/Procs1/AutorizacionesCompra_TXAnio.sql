
CREATE Procedure [dbo].[AutorizacionesCompra_TXAnio]

AS

SELECT Min(CONVERT(varchar,YEAR(Fecha))) as [Periodo], YEAR(Fecha) as [Año]
FROM AutorizacionesCompra
WHERE Fecha is not null
GROUP BY YEAR(Fecha) 
ORDER BY YEAR(Fecha) desc
