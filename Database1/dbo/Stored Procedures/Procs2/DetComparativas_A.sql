



CREATE Procedure [dbo].[DetComparativas_A]
@IdDetalleComparativa int  output,
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
As 
Insert into [DetalleComparativas]
(
 IdComparativa,
 IdPresupuesto,
 NumeroPresupuesto,
 FechaPresupuesto,
 IdArticulo,
 Cantidad,
 Precio,
 Estado,
 SubNumero,
 Observaciones,
 IdUnidad,
 IdMoneda,
 OrigenDescripcion,
 PorcentajeBonificacion,
 CotizacionMoneda,
 IdDetallePresupuesto
)
Values
(
 @IdComparativa,
 @IdPresupuesto,
 @NumeroPresupuesto,
 @FechaPresupuesto,
 @IdArticulo,
 @Cantidad,
 @Precio,
 @Estado,
 @SubNumero,
 @Observaciones,
 @IdUnidad,
 @IdMoneda,
 @OrigenDescripcion,
 @PorcentajeBonificacion,
 @CotizacionMoneda,
 @IdDetallePresupuesto
)
Select @IdDetalleComparativa=@@identity
Return(@IdDetalleComparativa)



