
CREATE Procedure [dbo].[ValesSalida_TXMes]

@Anio int

AS

SELECT Min(Convert(varchar,MONTH(FechaValeSalida)) + '/' +Convert(varchar, Year(FechaValeSalida)) )  as [Período], Year(FechaValeSalida),  Month(FechaValeSalida),
 CASE 
	WHEN MONTH(FechaValeSalida)=1 THEN 'Enero'
	WHEN MONTH(FechaValeSalida)=2 THEN 'Febrero'
	WHEN MONTH(FechaValeSalida)=3 THEN 'Marzo'
	WHEN MONTH(FechaValeSalida)=4 THEN 'Abril'
	WHEN MONTH(FechaValeSalida)=5 THEN 'Mayo'
	WHEN MONTH(FechaValeSalida)=6 THEN 'Junio'
	WHEN MONTH(FechaValeSalida)=7 THEN 'Julio'
	WHEN MONTH(FechaValeSalida)=8 THEN 'Agosto'
	WHEN MONTH(FechaValeSalida)=9 THEN 'Setiembre'
	WHEN MONTH(FechaValeSalida)=10 THEN 'Octubre'
	WHEN MONTH(FechaValeSalida)=11 THEN 'Noviembre'
	WHEN MONTH(FechaValeSalida)=12 THEN 'Diciembre'
	ELSE 'Error'
 END as [Mes]
FROM ValesSalida
WHERE YEAR(FechaValeSalida)=@Anio
GROUP BY YEAR(FechaValeSalida), MONTH(FechaValeSalida)  
ORDER bY YEAR(FechaValeSalida)  DESC, MONTH(FechaValeSalida) DESC
