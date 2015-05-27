


CREATE Procedure [dbo].[OrdenesTrabajo_TXMes]
@Anio int
As
SELECT 
 MIN(CONVERT(varchar, MONTH(FechaInicio)) + '/' + CONVERT(varchar, YEAR(FechaInicio)) )  AS Período,
 YEAR(FechaInicio), 
 MONTH(FechaInicio),
 CASE 
	WHEN MONTH(FechaInicio)=1 THEN 'Enero'
	WHEN MONTH(FechaInicio)=2 THEN 'Febrero'
	WHEN MONTH(FechaInicio)=3 THEN 'Marzo'
	WHEN MONTH(FechaInicio)=4 THEN 'Abril'
	WHEN MONTH(FechaInicio)=5 THEN 'Mayo'
	WHEN MONTH(FechaInicio)=6 THEN 'Junio'
	WHEN MONTH(FechaInicio)=7 THEN 'Julio'
	WHEN MONTH(FechaInicio)=8 THEN 'Agosto'
	WHEN MONTH(FechaInicio)=9 THEN 'Setiembre'
	WHEN MONTH(FechaInicio)=10 THEN 'Octubre'
	WHEN MONTH(FechaInicio)=11 THEN 'Noviembre'
	WHEN MONTH(FechaInicio)=12 THEN 'Diciembre'
	ELSE 'Error'
 END as Mes
FROM OrdenesTrabajo  
WHERE YEAR(FechaInicio)=@Anio
GROUP BY YEAR(FechaInicio), MONTH(FechaInicio)  
ORDER by YEAR(FechaInicio) desc, MONTH(FechaInicio) desc


