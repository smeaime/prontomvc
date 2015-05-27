
CREATE Procedure [dbo].[DepositosBancarios_TXMes]
@Anio int
As
SELECT 
min(CONVERT(varchar, MONTH(FechaDeposito)) + '/' + CONVERT(varchar, YEAR(FechaDeposito)) )  AS Período,
YEAR(FechaDeposito), 
MONTH(FechaDeposito),
CASE 
	WHEN MONTH(FechaDeposito)=1 THEN 'Enero'
	WHEN MONTH(FechaDeposito)=2 THEN 'Febrero'
	WHEN MONTH(FechaDeposito)=3 THEN 'Marzo'
	WHEN MONTH(FechaDeposito)=4 THEN 'Abril'
	WHEN MONTH(FechaDeposito)=5 THEN 'Mayo'
	WHEN MONTH(FechaDeposito)=6 THEN 'Junio'
	WHEN MONTH(FechaDeposito)=7 THEN 'Julio'
	WHEN MONTH(FechaDeposito)=8 THEN 'Agosto'
	WHEN MONTH(FechaDeposito)=9 THEN 'Setiembre'
	WHEN MONTH(FechaDeposito)=10 THEN 'Octubre'
	WHEN MONTH(FechaDeposito)=11 THEN 'Noviembre'
	WHEN MONTH(FechaDeposito)=12 THEN 'Diciembre'
	ELSE 'Error'
END as Mes
FROM DepositosBancarios
WHERE YEAR(FechaDeposito)=@Anio
GROUP BY  YEAR(FechaDeposito) , MONTH(FechaDeposito)  
ORDER BY  YEAR(FechaDeposito)  desc , MONTH(FechaDeposito)  desc
