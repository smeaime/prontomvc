


CREATE Procedure [dbo].[AjustesStockSAT_TXAnio]
AS
SELECT Min(CONVERT(varchar,YEAR(AJ.FechaAjuste)))  as [Periodo], YEAR(AJ.FechaAjuste) as [Año]
FROM AjustesStockSAT AJ
WHERE AJ.FechaAjuste is not null
GROUP BY YEAR(AJ.FechaAjuste) 
ORDER BY YEAR(AJ.FechaAjuste)  desc


