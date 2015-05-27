CREATE Procedure [dbo].[DetPresupuestosVentas_T]

@IdDetallePresupuestoVenta int

AS 

SELECT *
FROM DetallePresupuestosVentas
WHERE (IdDetallePresupuestoVenta=@IdDetallePresupuestoVenta)