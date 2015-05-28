
CREATE Procedure [dbo].[OtrosIngresosAlmacen_TXAnio]
AS
SELECT Min(CONVERT(varchar,YEAR(FechaOtroIngresoAlmacen)))  as [Periodo], YEAR(FechaOtroIngresoAlmacen)
FROM OtrosIngresosAlmacen
WHERE FechaOtroIngresoAlmacen is not null
GROUP BY  YEAR(FechaOtroIngresoAlmacen) 
ORDER by  YEAR(FechaOtroIngresoAlmacen)  desc
