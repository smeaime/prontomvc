

CREATE Procedure [dbo].[LiquidacionesFletes_TXAnio]

AS

SELECT Min(CONVERT(varchar,YEAR(FechaLiquidacion))) as [Periodo], YEAR(FechaLiquidacion) as [Año]
FROM LiquidacionesFletes 
WHERE FechaLiquidacion is not null
GROUP BY YEAR(FechaLiquidacion) 
ORDER BY YEAR(FechaLiquidacion)  desc

