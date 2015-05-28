


































CREATE Procedure [dbo].[Asientos_TXMes]
@Anio int
As
SELECT 
min(CONVERT(varchar, MONTH(FechaAsiento)) + '/' + CONVERT(varchar, YEAR(FechaAsiento)) )  AS Período,
YEAR(FechaAsiento), 
MONTH(FechaAsiento),
CASE 
	WHEN MONTH(FechaAsiento)=1 THEN "Enero"
	WHEN MONTH(FechaAsiento)=2 THEN "Febrero"
	WHEN MONTH(FechaAsiento)=3 THEN "Marzo"
	WHEN MONTH(FechaAsiento)=4 THEN "Abril"
	WHEN MONTH(FechaAsiento)=5 THEN "Mayo"
	WHEN MONTH(FechaAsiento)=6 THEN "Junio"
	WHEN MONTH(FechaAsiento)=7 THEN "Julio"
	WHEN MONTH(FechaAsiento)=8 THEN "Agosto"
	WHEN MONTH(FechaAsiento)=9 THEN "Setiembre"
	WHEN MONTH(FechaAsiento)=10 THEN "Octubre"
	WHEN MONTH(FechaAsiento)=11 THEN "Noviembre"
	WHEN MONTH(FechaAsiento)=12 THEN "Diciembre"
	ELSE "Error"
END as Mes
FROM Asientos
where YEAR(FechaAsiento)=@Anio
GROUP BY  YEAR(FechaAsiento) , MONTH(FechaAsiento)  
order by  YEAR(FechaAsiento)  desc , MONTH(FechaAsiento)  desc



































