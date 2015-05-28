
CREATE Procedure [dbo].[wDetPresupuestos_E]
@IdDetallePresupuesto int  AS 
Delete [DetallePresupuestos]
where (IdDetallePresupuesto=@IdDetallePresupuesto)

