
CREATE Procedure [dbo].[MovimientosFletes_TXAnio]

AS

SELECT Min(Convert(varchar,Year(Fecha))) as [Período], Year(Fecha)
FROM MovimientosFletes
GROUP BY YEAR(Fecha) 
ORDER BY YEAR(Fecha) Desc
