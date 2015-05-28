
CREATE Procedure [dbo].[DetOtrosIngresosAlmacen_T]
@IdDetalleOtroIngresoAlmacen int
AS 
SELECT *
FROM [DetalleOtrosIngresosAlmacen]
WHERE (IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen)
