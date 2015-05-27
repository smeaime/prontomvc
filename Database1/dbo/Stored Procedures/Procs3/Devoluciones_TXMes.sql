






























CREATE Procedure [dbo].[Devoluciones_TXMes]
@Anio int
As
SELECT 
min(CONVERT(varchar, MONTH(FechaDevolucion)) + '/' + CONVERT(varchar, YEAR(FechaDevolucion)) )  AS Período,
YEAR(FechaDevolucion), 
MONTH(FechaDevolucion),
CASE 
	WHEN MONTH(FechaDevolucion)=1 THEN "Enero"
	WHEN MONTH(FechaDevolucion)=2 THEN "Febrero"
	WHEN MONTH(FechaDevolucion)=3 THEN "Marzo"
	WHEN MONTH(FechaDevolucion)=4 THEN "Abril"
	WHEN MONTH(FechaDevolucion)=5 THEN "Mayo"
	WHEN MONTH(FechaDevolucion)=6 THEN "Junio"
	WHEN MONTH(FechaDevolucion)=7 THEN "Julio"
	WHEN MONTH(FechaDevolucion)=8 THEN "Agosto"
	WHEN MONTH(FechaDevolucion)=9 THEN "Setiembre"
	WHEN MONTH(FechaDevolucion)=10 THEN "Octubre"
	WHEN MONTH(FechaDevolucion)=11 THEN "Noviembre"
	WHEN MONTH(FechaDevolucion)=12 THEN "Diciembre"
	ELSE "Error"
END as Mes
FROM Devoluciones
where YEAR(FechaDevolucion)=@Anio
GROUP BY  YEAR(FechaDevolucion) , MONTH(FechaDevolucion)  
order by  YEAR(FechaDevolucion)  desc , MONTH(FechaDevolucion)  desc































