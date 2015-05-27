

CREATE Procedure [dbo].[LiquidacionesFletes_TXMes]

@Anio int

AS

SELECT Min(CONVERT(varchar,MONTH(FechaLiquidacion)) + '/' + CONVERT(varchar, YEAR(FechaLiquidacion)) )  as [Periodo],
 YEAR(FechaLiquidacion), 
 MONTH(FechaLiquidacion),
 CASE 
	WHEN MONTH(FechaLiquidacion)=1 THEN 'Enero'
	WHEN MONTH(FechaLiquidacion)=2 THEN 'Febrero'
	WHEN MONTH(FechaLiquidacion)=3 THEN 'Marzo'
	WHEN MONTH(FechaLiquidacion)=4 THEN 'Abril'
	WHEN MONTH(FechaLiquidacion)=5 THEN 'Mayo'
	WHEN MONTH(FechaLiquidacion)=6 THEN 'Junio'
	WHEN MONTH(FechaLiquidacion)=7 THEN 'Julio'
	WHEN MONTH(FechaLiquidacion)=8 THEN 'Agosto'
	WHEN MONTH(FechaLiquidacion)=9 THEN 'Setiembre'
	WHEN MONTH(FechaLiquidacion)=10 THEN 'Octubre'
	WHEN MONTH(FechaLiquidacion)=11 THEN 'Noviembre'
	WHEN MONTH(FechaLiquidacion)=12 THEN 'Diciembre'
	ELSE 'Error'
 END as Mes
FROM LiquidacionesFletes  
WHERE YEAR(FechaLiquidacion)=@Anio
GROUP BY YEAR(FechaLiquidacion), MONTH(FechaLiquidacion)  
ORDER BY YEAR(FechaLiquidacion)  desc, MONTH(FechaLiquidacion)  desc

