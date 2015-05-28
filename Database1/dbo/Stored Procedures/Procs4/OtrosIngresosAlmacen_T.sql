
CREATE Procedure [dbo].[OtrosIngresosAlmacen_T]
@IdOtroIngresoAlmacen int
AS 
SELECT * 
FROM OtrosIngresosAlmacen
WHERE (IdOtroIngresoAlmacen=@IdOtroIngresoAlmacen)
