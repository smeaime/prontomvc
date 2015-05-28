
CREATE Procedure ProduccionPartes_TXMes
@Anio int
As
SELECT 
min(CONVERT(varchar, MONTH(fechadia)) + '/' + CONVERT(varchar, YEAR(fechadia)) )  AS Período,
YEAR(fechadia), 
MONTH(fechadia),
CASE 
	WHEN MONTH(fechadia)=1 THEN 'Enero'
	WHEN MONTH(fechadia)=2 THEN 'Febrero'
	WHEN MONTH(fechadia)=3 THEN 'Marzo'
	WHEN MONTH(fechadia)=4 THEN 'Abril'
	WHEN MONTH(fechadia)=5 THEN 'Mayo'
	WHEN MONTH(fechadia)=6 THEN 'Junio'
	WHEN MONTH(fechadia)=7 THEN 'Julio'
	WHEN MONTH(fechadia)=8 THEN 'Agosto'
	WHEN MONTH(fechadia)=9 THEN 'Setiembre'
	WHEN MONTH(fechadia)=10 THEN 'Octubre'
	WHEN MONTH(fechadia)=11 THEN 'Noviembre'
	WHEN MONTH(fechadia)=12 THEN 'Diciembre'
	ELSE 'Error'
END as Mes
FROM ProduccionPartes
WHERE YEAR(fechadia)=@Anio
GROUP BY  YEAR(fechadia) , MONTH(fechadia)  
ORDER BY  YEAR(fechadia)  desc , MONTH(fechadia)  desc
