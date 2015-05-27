
CREATE Procedure [dbo].[OtrosIngresosAlmacenSAT_TXAnio]
AS
SELECT Min(CONVERT(varchar,YEAR(FechaOtroIngresoAlmacen)))  as [Periodo], YEAR(FechaOtroIngresoAlmacen)
FROM OtrosIngresosAlmacenSAT
WHERE FechaOtroIngresoAlmacen is not null
GROUP BY  YEAR(FechaOtroIngresoAlmacen) 
ORDER by  YEAR(FechaOtroIngresoAlmacen)  desc
