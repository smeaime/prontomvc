





























CREATE Procedure [dbo].[DetPresupuestos_T]
@IdDetallePresupuesto int
AS 
SELECT *
FROM [DetallePresupuestos]
where (IdDetallePresupuesto=@IdDetallePresupuesto)






























