




CREATE Procedure [dbo].[OrdenesPago_TXMes]
@Anio int
As
SELECT 
	MIN(CONVERT(varchar, MONTH(FechaOrdenPago)) + '/' + CONVERT(varchar, YEAR(FechaOrdenPago)) )  AS Período,
YEAR(FechaOrdenPago), 
MONTH(FechaOrdenPago),
CASE 
	WHEN MONTH(FechaOrdenPago)=1 THEN 'Enero'
	WHEN MONTH(FechaOrdenPago)=2 THEN 'Febrero'
	WHEN MONTH(FechaOrdenPago)=3 THEN 'Marzo'
	WHEN MONTH(FechaOrdenPago)=4 THEN 'Abril'
	WHEN MONTH(FechaOrdenPago)=5 THEN 'Mayo'
	WHEN MONTH(FechaOrdenPago)=6 THEN 'Junio'
	WHEN MONTH(FechaOrdenPago)=7 THEN 'Julio'
	WHEN MONTH(FechaOrdenPago)=8 THEN 'Agosto'
	WHEN MONTH(FechaOrdenPago)=9 THEN 'Setiembre'
	WHEN MONTH(FechaOrdenPago)=10 THEN 'Octubre'
	WHEN MONTH(FechaOrdenPago)=11 THEN 'Noviembre'
	WHEN MONTH(FechaOrdenPago)=12 THEN 'Diciembre'
	ELSE 'Error'
END as Mes
FROM OrdenesPago op 
WHERE YEAR(FechaOrdenPago)=@Anio and 
	(op.Confirmado is null or op.Confirmado<>'NO')
GROUP BY  YEAR(FechaOrdenPago) , MONTH(FechaOrdenPago)  
ORDER by  YEAR(FechaOrdenPago)  desc , MONTH(FechaOrdenPago)  desc




