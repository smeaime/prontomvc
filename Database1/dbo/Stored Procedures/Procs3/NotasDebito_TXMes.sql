






























CREATE Procedure [dbo].[NotasDebito_TXMes]
@Anio int
As
SELECT 
min(CONVERT(varchar, MONTH(FechaNotaDebito)) + '/' + CONVERT(varchar, YEAR(FechaNotaDebito)) )  AS Período,
YEAR(FechaNotaDebito), 
MONTH(FechaNotaDebito),
CASE 
	WHEN MONTH(FechaNotaDebito)=1 THEN "Enero"
	WHEN MONTH(FechaNotaDebito)=2 THEN "Febrero"
	WHEN MONTH(FechaNotaDebito)=3 THEN "Marzo"
	WHEN MONTH(FechaNotaDebito)=4 THEN "Abril"
	WHEN MONTH(FechaNotaDebito)=5 THEN "Mayo"
	WHEN MONTH(FechaNotaDebito)=6 THEN "Junio"
	WHEN MONTH(FechaNotaDebito)=7 THEN "Julio"
	WHEN MONTH(FechaNotaDebito)=8 THEN "Agosto"
	WHEN MONTH(FechaNotaDebito)=9 THEN "Setiembre"
	WHEN MONTH(FechaNotaDebito)=10 THEN "Octubre"
	WHEN MONTH(FechaNotaDebito)=11 THEN "Noviembre"
	WHEN MONTH(FechaNotaDebito)=12 THEN "Diciembre"
	ELSE "Error"
END as Mes
FROM NotasDebito
where YEAR(FechaNotaDebito)=@Anio
GROUP BY  YEAR(FechaNotaDebito) , MONTH(FechaNotaDebito)  
order by  YEAR(FechaNotaDebito)  desc , MONTH(FechaNotaDebito)  desc































