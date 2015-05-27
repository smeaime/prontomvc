





























CREATE Procedure [dbo].[DetPresupuestosHHObras_T]
@IdDetallePresupuestoHHObras int
AS 
SELECT *
FROM [DetallePresupuestosHHObras]
where (IdDetallePresupuestoHHObras=@IdDetallePresupuestoHHObras)






























