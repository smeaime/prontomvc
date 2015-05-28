




CREATE Procedure [dbo].[Pedidos_TX_SubContratosPorMes]
@Anio int
AS
SELECT 
 MIN(CONVERT(varchar, MONTH(FechaPedido)) + '/' + CONVERT(varchar, YEAR(FechaPedido)) ) AS [Período],
 YEAR(FechaPedido), 
 MONTH(FechaPedido),
 CASE 
	WHEN MONTH(FechaPedido)=1 THEN 'Enero'
	WHEN MONTH(FechaPedido)=2 THEN 'Febrero'
	WHEN MONTH(FechaPedido)=3 THEN 'Marzo'
	WHEN MONTH(FechaPedido)=4 THEN 'Abril'
	WHEN MONTH(FechaPedido)=5 THEN 'Mayo'
	WHEN MONTH(FechaPedido)=6 THEN 'Junio'
	WHEN MONTH(FechaPedido)=7 THEN 'Julio'
	WHEN MONTH(FechaPedido)=8 THEN 'Agosto'
	WHEN MONTH(FechaPedido)=9 THEN 'Setiembre'
	WHEN MONTH(FechaPedido)=10 THEN 'Octubre'
	WHEN MONTH(FechaPedido)=11 THEN 'Noviembre'
	WHEN MONTH(FechaPedido)=12 THEN 'Diciembre'
	ELSE 'Error'
 END as [Mes]
FROM Pedidos
WHERE YEAR(FechaPedido)=@Anio and IsNull(Subcontrato,'NO')='SI'
GROUP BY YEAR(FechaPedido) , MONTH(FechaPedido)  
ORDER BY YEAR(FechaPedido) DESC , MONTH(FechaPedido) DESC




