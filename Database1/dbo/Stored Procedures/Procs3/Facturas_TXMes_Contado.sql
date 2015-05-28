CREATE Procedure [dbo].[Facturas_TXMes_Contado]

@Anio int

AS

SELECT 
 min(CONVERT(varchar, MONTH(FechaFactura)) + '/' + CONVERT(varchar, YEAR(FechaFactura)) )  AS Período,
 YEAR(FechaFactura), 
 MONTH(FechaFactura),
 CASE 
	WHEN MONTH(FechaFactura)=1 THEN 'Enero'
	WHEN MONTH(FechaFactura)=2 THEN 'Febrero'
	WHEN MONTH(FechaFactura)=3 THEN 'Marzo'
	WHEN MONTH(FechaFactura)=4 THEN 'Abril'
	WHEN MONTH(FechaFactura)=5 THEN 'Mayo'
	WHEN MONTH(FechaFactura)=6 THEN 'Junio'
	WHEN MONTH(FechaFactura)=7 THEN 'Julio'
	WHEN MONTH(FechaFactura)=8 THEN 'Agosto'
	WHEN MONTH(FechaFactura)=9 THEN 'Setiembre'
	WHEN MONTH(FechaFactura)=10 THEN 'Octubre'
	WHEN MONTH(FechaFactura)=11 THEN 'Noviembre'
	WHEN MONTH(FechaFactura)=12 THEN 'Diciembre'
	ELSE 'Error'
 END as Mes
FROM Facturas
WHERE YEAR(FechaFactura)=@Anio --and IsNull(FacturaContado,'NO')='SI'
GROUP BY YEAR(FechaFactura) , MONTH(FechaFactura)  
ORDER BY YEAR(FechaFactura)  desc , MONTH(FechaFactura)  desc