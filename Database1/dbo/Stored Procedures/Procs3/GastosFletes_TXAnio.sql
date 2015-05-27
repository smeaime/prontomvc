
CREATE Procedure [dbo].[GastosFletes_TXAnio]

AS

SELECT Min(Convert(varchar,Year(Fecha))) as [Período], Year(Fecha)
FROM GastosFletes
GROUP BY YEAR(Fecha) 
ORDER BY YEAR(Fecha) Desc
