
CREATE Procedure [dbo].[OtrosIngresosAlmacenSAT_T]
@IdOtroIngresoAlmacen int
AS 
SELECT * 
FROM OtrosIngresosAlmacenSAT
WHERE (IdOtroIngresoAlmacen=@IdOtroIngresoAlmacen)
