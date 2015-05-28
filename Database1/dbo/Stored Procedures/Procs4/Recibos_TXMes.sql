
































CREATE Procedure [dbo].[Recibos_TXMes]
@Anio int
As
SELECT 
min(CONVERT(varchar, MONTH(FechaRecibo)) + '/' + CONVERT(varchar, YEAR(FechaRecibo)) )  AS Período,
YEAR(FechaRecibo), 
MONTH(FechaRecibo),
CASE 
	WHEN MONTH(FechaRecibo)=1 THEN 'Enero'
	WHEN MONTH(FechaRecibo)=2 THEN 'Febrero'
	WHEN MONTH(FechaRecibo)=3 THEN 'Marzo'
	WHEN MONTH(FechaRecibo)=4 THEN 'Abril'
	WHEN MONTH(FechaRecibo)=5 THEN 'Mayo'
	WHEN MONTH(FechaRecibo)=6 THEN 'Junio'
	WHEN MONTH(FechaRecibo)=7 THEN 'Julio'
	WHEN MONTH(FechaRecibo)=8 THEN 'Agosto'
	WHEN MONTH(FechaRecibo)=9 THEN 'Setiembre'
	WHEN MONTH(FechaRecibo)=10 THEN 'Octubre'
	WHEN MONTH(FechaRecibo)=11 THEN 'Noviembre'
	WHEN MONTH(FechaRecibo)=12 THEN 'Diciembre'
	ELSE 'Error'
END as Mes
FROM Recibos
where YEAR(FechaRecibo)=@Anio
GROUP BY  YEAR(FechaRecibo) , MONTH(FechaRecibo)  
order by  YEAR(FechaRecibo)  desc , MONTH(FechaRecibo)  desc

































