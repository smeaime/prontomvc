
CREATE Procedure [dbo].[Presupuestos_TXMes]

@Anio int

AS

SELECT Min(CONVERT(varchar, MONTH(FechaIngreso)) + '/' + CONVERT(varchar, YEAR(FechaIngreso)) ) as [Período],
	YEAR(FechaIngreso), MONTH(FechaIngreso),
	CASE 
		WHEN MONTH(FechaIngreso)=1 THEN 'Enero'
		WHEN MONTH(FechaIngreso)=2 THEN 'Febrero'
		WHEN MONTH(FechaIngreso)=3 THEN 'Marzo'
		WHEN MONTH(FechaIngreso)=4 THEN 'Abril'
		WHEN MONTH(FechaIngreso)=5 THEN 'Mayo'
		WHEN MONTH(FechaIngreso)=6 THEN 'Junio'
		WHEN MONTH(FechaIngreso)=7 THEN 'Julio'
		WHEN MONTH(FechaIngreso)=8 THEN 'Agosto'
		WHEN MONTH(FechaIngreso)=9 THEN 'Setiembre'
		WHEN MONTH(FechaIngreso)=10 THEN 'Octubre'
		WHEN MONTH(FechaIngreso)=11 THEN 'Noviembre'
		WHEN MONTH(FechaIngreso)=12 THEN 'Diciembre'
		ELSE 'Error'
	END as Mes
FROM Presupuestos
WHERE YEAR(FechaIngreso)=@Anio
GROUP BY YEAR(FechaIngreso), MONTH(FechaIngreso)  
ORDER BY YEAR(FechaIngreso) desc, MONTH(FechaIngreso) desc
