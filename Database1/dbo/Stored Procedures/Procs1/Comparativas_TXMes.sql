



CREATE Procedure [dbo].[Comparativas_TXMes]
@Anio int
AS
SELECT 
 MIN(CONVERT(varchar, MONTH(Fecha)) + '/' + CONVERT(varchar, YEAR(Fecha))) AS Período,
YEAR(Fecha), 
MONTH(Fecha),
CASE 
	WHEN MONTH(Fecha)=1 THEN 'Enero'
	WHEN MONTH(Fecha)=2 THEN 'Febrero'
	WHEN MONTH(Fecha)=3 THEN 'Marzo'
	WHEN MONTH(Fecha)=4 THEN 'Abril'
	WHEN MONTH(Fecha)=5 THEN 'Mayo'
	WHEN MONTH(Fecha)=6 THEN 'Junio'
	WHEN MONTH(Fecha)=7 THEN 'Julio'
	WHEN MONTH(Fecha)=8 THEN 'Agosto'
	WHEN MONTH(Fecha)=9 THEN 'Setiembre'
	WHEN MONTH(Fecha)=10 THEN 'Octubre'
	WHEN MONTH(Fecha)=11 THEN 'Noviembre'
	WHEN MONTH(Fecha)=12 THEN 'Diciembre'
	ELSE 'Error'
END as Mes
FROM Comparativas
where YEAR(Fecha)=@Anio
GROUP BY YEAR(Fecha) ,MONTH(Fecha)  
ORDER BY YEAR(Fecha) desc ,MONTH(Fecha) desc



