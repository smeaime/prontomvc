





















CREATE Procedure [dbo].[CostosPromedios_TX_PorIdDetalleOtroIngresoAlmacen]
@IdDetalleOtroIngresoAlmacen int
AS 
SELECT Top 1 *
FROM CostosPromedios
WHERE IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen






















