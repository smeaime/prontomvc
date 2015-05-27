

CREATE Procedure [dbo].[OtrosIngresosAlmacen_TX_PorId]
@IdOtroIngresoAlmacen int
AS 
SELECT * 
FROM OtrosIngresosAlmacen
WHERE (IdOtroIngresoAlmacen=@IdOtroIngresoAlmacen)

