
CREATE Procedure ProduccionOrdenes_TXMes
@Anio int
As
SELECT 
min(CONVERT(varchar, MONTH(fechaordenproduccion)) + '/' + CONVERT(varchar, YEAR(fechaordenproduccion)) )  AS Período,
YEAR(fechaordenproduccion), 
MONTH(fechaordenproduccion),
CASE 
	WHEN MONTH(fechaordenproduccion)=1 THEN 'Enero'
	WHEN MONTH(fechaordenproduccion)=2 THEN 'Febrero'
	WHEN MONTH(fechaordenproduccion)=3 THEN 'Marzo'
	WHEN MONTH(fechaordenproduccion)=4 THEN 'Abril'
	WHEN MONTH(fechaordenproduccion)=5 THEN 'Mayo'
	WHEN MONTH(fechaordenproduccion)=6 THEN 'Junio'
	WHEN MONTH(fechaordenproduccion)=7 THEN 'Julio'
	WHEN MONTH(fechaordenproduccion)=8 THEN 'Agosto'
	WHEN MONTH(fechaordenproduccion)=9 THEN 'Setiembre'
	WHEN MONTH(fechaordenproduccion)=10 THEN 'Octubre'
	WHEN MONTH(fechaordenproduccion)=11 THEN 'Noviembre'
	WHEN MONTH(fechaordenproduccion)=12 THEN 'Diciembre'
	ELSE 'Error'
END as Mes
FROM ProduccionOrdenes
WHERE YEAR(fechaordenproduccion)=@Anio
GROUP BY  YEAR(fechaordenproduccion) , MONTH(fechaordenproduccion)  
ORDER BY  YEAR(fechaordenproduccion)  desc , MONTH(fechaordenproduccion)  desc
