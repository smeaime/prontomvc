
CREATE Procedure ProduccionOrdenes_TXAnio
As
SELECT 
 Min(CONVERT(varchar, YEAR(fechaordenproduccion)))  AS Período,YEAR(fechaordenproduccion)
FROM ProduccionOrdenes
WHERE fechaordenproduccion is not null
GROUP BY  YEAR(fechaordenproduccion) 
ORDER by  YEAR(fechaordenproduccion)  desc
