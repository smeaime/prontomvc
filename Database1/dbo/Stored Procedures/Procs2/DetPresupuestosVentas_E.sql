CREATE Procedure [dbo].[DetPresupuestosVentas_E]

@IdDetallePresupuestosVentas int

AS 

DELETE DetallePresupuestosVentas
WHERE (IdDetallePresupuestoVenta=@IdDetallePresupuestosVentas)