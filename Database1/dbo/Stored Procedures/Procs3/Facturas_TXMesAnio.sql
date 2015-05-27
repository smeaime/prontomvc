CREATE Procedure [dbo].[Facturas_TXMesAnio]

AS

SELECT min(CONVERT(varchar, MONTH(FechaFactura)) + '/' + CONVERT(varchar, YEAR(FechaFactura)) )  AS Período,YEAR(FechaFactura) , MONTH(FechaFactura)  
FROM Facturas
GROUP BY  YEAR(FechaFactura) , MONTH(FechaFactura)  
ORDER BY YEAR(FechaFactura)  desc , MONTH(FechaFactura)  desc