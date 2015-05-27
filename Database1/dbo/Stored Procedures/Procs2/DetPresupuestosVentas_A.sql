CREATE Procedure [dbo].[DetPresupuestosVentas_A]

@IdDetallePresupuestoVenta int  output,
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

INSERT INTO [DetallePresupuestosVentas]
(
 IdPresupuestoVenta,
 IdArticulo,
 Cantidad,
 PrecioUnitario,
 Bonificacion,
 IdUnidad,
 Talle,
 IdColor,
 Estado
)
VALUES
(
 @IdPresupuestoVenta,
 @IdArticulo,
 @Cantidad,
 @PrecioUnitario,
 @Bonificacion,
 @IdUnidad,
 @Talle,
 @IdColor,
 @Estado
)
SELECT @IdDetallePresupuestoVenta=@@identity

RETURN(@IdDetallePresupuestoVenta)