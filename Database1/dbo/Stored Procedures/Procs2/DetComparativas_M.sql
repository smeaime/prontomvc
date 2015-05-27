



CREATE Procedure [dbo].[DetComparativas_M]
@IdDetalleComparativa int,
@IdComparativa int,
@IdPresupuesto int,
@NumeroPresupuesto int,
@FechaPresupuesto datetime,
@IdArticulo int,
@Cantidad numeric(12,2),
@Precio numeric(12,4),
@Estado varchar(2),
@SubNumero int,
@Observaciones ntext,
@IdUnidad int,
@IdMoneda int,
@OrigenDescripcion int,
@PorcentajeBonificacion numeric(6,2),
@CotizacionMoneda numeric(18,3),
@IdDetallePresupuesto int
AS
UPDATE [DetalleComparativas]
SET 
 IdComparativa=@IdComparativa,
 IdPresupuesto=@IdPresupuesto,
 NumeroPresupuesto=@NumeroPresupuesto,
 FechaPresupuesto=@FechaPresupuesto,
 IdArticulo=@IdArticulo,
 Cantidad=@Cantidad,
 Precio=@Precio,
 Estado=@Estado,
 SubNumero=@SubNumero,
 Observaciones=@Observaciones,
 IdUnidad=@IdUnidad,
 IdMoneda=@IdMoneda,
 OrigenDescripcion=@OrigenDescripcion,
 PorcentajeBonificacion=@PorcentajeBonificacion,
 CotizacionMoneda=@CotizacionMoneda,
 IdDetallePresupuesto=@IdDetallePresupuesto
WHERE (IdDetalleComparativa=@IdDetalleComparativa)
RETURN(@IdDetalleComparativa)



