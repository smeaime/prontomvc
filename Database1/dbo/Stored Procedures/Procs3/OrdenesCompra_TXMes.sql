
CREATE Procedure [dbo].[OrdenesCompra_TXMes]
@Anio int
As
SELECT 
min(CONVERT(varchar, MONTH(FechaOrdenCompra)) + '/' + CONVERT(varchar, YEAR(FechaOrdenCompra)) )  AS Período,
YEAR(FechaOrdenCompra), 
MONTH(FechaOrdenCompra),
CASE 
	WHEN MONTH(FechaOrdenCompra)=1 THEN 'Enero'
	WHEN MONTH(FechaOrdenCompra)=2 THEN 'Febrero'
	WHEN MONTH(FechaOrdenCompra)=3 THEN 'Marzo'
	WHEN MONTH(FechaOrdenCompra)=4 THEN 'Abril'
	WHEN MONTH(FechaOrdenCompra)=5 THEN 'Mayo'
	WHEN MONTH(FechaOrdenCompra)=6 THEN 'Junio'
	WHEN MONTH(FechaOrdenCompra)=7 THEN 'Julio'
	WHEN MONTH(FechaOrdenCompra)=8 THEN 'Agosto'
	WHEN MONTH(FechaOrdenCompra)=9 THEN 'Setiembre'
	WHEN MONTH(FechaOrdenCompra)=10 THEN 'Octubre'
	WHEN MONTH(FechaOrdenCompra)=11 THEN 'Noviembre'
	WHEN MONTH(FechaOrdenCompra)=12 THEN 'Diciembre'
	ELSE 'Error'
END as Mes
FROM OrdenesCompra
WHERE YEAR(FechaOrdenCompra)=@Anio
GROUP BY  YEAR(FechaOrdenCompra) , MONTH(FechaOrdenCompra)  
ORDER BY  YEAR(FechaOrdenCompra)  desc , MONTH(FechaOrdenCompra)  desc
