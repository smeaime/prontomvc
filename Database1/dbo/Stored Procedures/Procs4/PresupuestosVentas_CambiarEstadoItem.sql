CREATE Procedure [dbo].[PresupuestosVentas_CambiarEstadoItem]

@IdDetallePresupuestoVenta int,
@Estado varchar(1) = Null

AS 

SET @Estado=IsNull(@Estado,'C')

UPDATE DetallePresupuestosVentas
SET Estado=@Estado
WHERE IdDetallePresupuestoVenta=@IdDetallePresupuestoVenta