






























CREATE Procedure [dbo].[NotasCredito_TXMes]
@Anio int
As
SELECT 
min(CONVERT(varchar, MONTH(FechaNotaCredito)) + '/' + CONVERT(varchar, YEAR(FechaNotaCredito)) )  AS Período,
YEAR(FechaNotaCredito), 
MONTH(FechaNotaCredito),
CASE 
	WHEN MONTH(FechaNotaCredito)=1 THEN "Enero"
	WHEN MONTH(FechaNotaCredito)=2 THEN "Febrero"
	WHEN MONTH(FechaNotaCredito)=3 THEN "Marzo"
	WHEN MONTH(FechaNotaCredito)=4 THEN "Abril"
	WHEN MONTH(FechaNotaCredito)=5 THEN "Mayo"
	WHEN MONTH(FechaNotaCredito)=6 THEN "Junio"
	WHEN MONTH(FechaNotaCredito)=7 THEN "Julio"
	WHEN MONTH(FechaNotaCredito)=8 THEN "Agosto"
	WHEN MONTH(FechaNotaCredito)=9 THEN "Setiembre"
	WHEN MONTH(FechaNotaCredito)=10 THEN "Octubre"
	WHEN MONTH(FechaNotaCredito)=11 THEN "Noviembre"
	WHEN MONTH(FechaNotaCredito)=12 THEN "Diciembre"
	ELSE "Error"
END as Mes
FROM NotasCredito
where YEAR(FechaNotaCredito)=@Anio
GROUP BY  YEAR(FechaNotaCredito) , MONTH(FechaNotaCredito)  
order by  YEAR(FechaNotaCredito)  desc , MONTH(FechaNotaCredito)  desc































