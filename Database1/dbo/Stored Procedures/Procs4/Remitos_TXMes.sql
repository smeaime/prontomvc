

































CREATE Procedure [dbo].[Remitos_TXMes]
@Anio int
As
SELECT 
min(CONVERT(varchar, MONTH(FechaRemito)) + '/' + CONVERT(varchar, YEAR(FechaRemito)) )  AS Período,
YEAR(FechaRemito), 
MONTH(FechaRemito),
CASE 
	WHEN MONTH(FechaRemito)=1 THEN 'Enero'
	WHEN MONTH(FechaRemito)=2 THEN 'Febrero'
	WHEN MONTH(FechaRemito)=3 THEN 'Marzo'
	WHEN MONTH(FechaRemito)=4 THEN 'Abril'
	WHEN MONTH(FechaRemito)=5 THEN 'Mayo'
	WHEN MONTH(FechaRemito)=6 THEN 'Junio'
	WHEN MONTH(FechaRemito)=7 THEN 'Julio'
	WHEN MONTH(FechaRemito)=8 THEN 'Agosto'
	WHEN MONTH(FechaRemito)=9 THEN 'Setiembre'
	WHEN MONTH(FechaRemito)=10 THEN 'Octubre'
	WHEN MONTH(FechaRemito)=11 THEN 'Noviembre'
	WHEN MONTH(FechaRemito)=12 THEN 'Diciembre'
	ELSE 'Error'
END as Mes
FROM Remitos
WHERE YEAR(FechaRemito)=@Anio
GROUP BY  YEAR(FechaRemito) , MONTH(FechaRemito)  
ORDER BY  YEAR(FechaRemito)  desc , MONTH(FechaRemito)  desc


































