
CREATE Procedure [dbo].[Conciliaciones_TXMes]

@Anio int

AS

SELECT Min(CONVERT(varchar, MONTH(FechaFinal)) + '/' + CONVERT(varchar, YEAR(FechaFinal)) ) as [Período],
	YEAR(FechaFinal), MONTH(FechaFinal),
	CASE 
		WHEN MONTH(FechaFinal)=1 THEN 'Enero'
		WHEN MONTH(FechaFinal)=2 THEN 'Febrero'
		WHEN MONTH(FechaFinal)=3 THEN 'Marzo'
		WHEN MONTH(FechaFinal)=4 THEN 'Abril'
		WHEN MONTH(FechaFinal)=5 THEN 'Mayo'
		WHEN MONTH(FechaFinal)=6 THEN 'Junio'
		WHEN MONTH(FechaFinal)=7 THEN 'Julio'
		WHEN MONTH(FechaFinal)=8 THEN 'Agosto'
		WHEN MONTH(FechaFinal)=9 THEN 'Setiembre'
		WHEN MONTH(FechaFinal)=10 THEN 'Octubre'
		WHEN MONTH(FechaFinal)=11 THEN 'Noviembre'
		WHEN MONTH(FechaFinal)=12 THEN 'Diciembre'
		ELSE 'Error'
	END as Mes
FROM Conciliaciones
WHERE YEAR(FechaFinal)=@Anio
GROUP BY YEAR(FechaFinal), MONTH(FechaFinal)  
ORDER BY YEAR(FechaFinal) desc, MONTH(FechaFinal) desc
