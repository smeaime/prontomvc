CREATE Procedure [dbo].[Valores_TX_GastosPorAnioMes]

@Anio int,
@Estado varchar(1) = Null

AS

SET @Estado=IsNull(@Estado,'G')

SELECT 
 MIN(CONVERT(varchar, MONTH(FechaComprobante)) + '/' + CONVERT(varchar, YEAR(FechaComprobante)) ) AS Período,
 YEAR(FechaComprobante), 
 MONTH(FechaComprobante),
 CASE 
	WHEN MONTH(FechaComprobante)=1 THEN 'Enero'
	WHEN MONTH(FechaComprobante)=2 THEN 'Febrero'
	WHEN MONTH(FechaComprobante)=3 THEN 'Marzo'
	WHEN MONTH(FechaComprobante)=4 THEN 'Abril'
	WHEN MONTH(FechaComprobante)=5 THEN 'Mayo'
	WHEN MONTH(FechaComprobante)=6 THEN 'Junio'
	WHEN MONTH(FechaComprobante)=7 THEN 'Julio'
	WHEN MONTH(FechaComprobante)=8 THEN 'Agosto'
	WHEN MONTH(FechaComprobante)=9 THEN 'Setiembre'
	WHEN MONTH(FechaComprobante)=10 THEN 'Octubre'
	WHEN MONTH(FechaComprobante)=11 THEN 'Noviembre'
	WHEN MONTH(FechaComprobante)=12 THEN 'Diciembre'
	ELSE 'Error'
 END as Mes
FROM Valores
WHERE Valores.Estado=@Estado and YEAR(FechaComprobante)=@Anio
GROUP BY YEAR(FechaComprobante) , MONTH(FechaComprobante)  
ORDER BY YEAR(FechaComprobante)  desc , MONTH(FechaComprobante)  desc
