
CREATE Procedure [dbo].[DetOtrosIngresosAlmacenSAT_T]
@IdDetalleOtroIngresoAlmacen int
AS 
SELECT *
FROM [DetalleOtrosIngresosAlmacenSAT]
WHERE (IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen)
