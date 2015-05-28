CREATE Procedure [dbo].[DetPresupuestosVentas_M]

@IdDetallePresupuestoVenta int,
@IdPresupuestoVenta int,
@IdArticulo int,
@Cantidad numeric(9,2),
@PrecioUnitario numeric(19,8),
@Bonificacion numeric(12,2),
@IdUnidad int,
@Talle varchar(2),
@IdColor int,
@Estado varchar(1)

AS

UPDATE DetallePresupuestosVentas
SET
 IdPresupuestoVenta=@IdPresupuestoVenta,
 IdArticulo=@IdArticulo,
 Cantidad=@Cantidad,
 PrecioUnitario=@PrecioUnitario,
 Bonificacion=@Bonificacion,
 IdUnidad=@IdUnidad,
 Talle=@Talle,
 IdColor=@IdColor,
 Estado=@Estado
WHERE (IdDetallePresupuestoVenta=@IdDetallePresupuestoVenta)

RETURN(@IdDetallePresupuestoVenta)