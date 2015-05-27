
CREATE Procedure [dbo].[wDetPresupuestos_T]
@IdDetallePresupuesto int
AS 
SELECT *
FROM [DetallePresupuestos]
where (IdDetallePresupuesto=@IdDetallePresupuesto)

