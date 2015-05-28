























CREATE Procedure [dbo].[DetOtrosIngresosAlmacen_TX_Todos]
@IdOtroIngresoAlmacen int
AS 
SELECT *
FROM DetalleOtrosIngresosAlmacen
WHERE IdOtroIngresoAlmacen=@IdOtroIngresoAlmacen
























