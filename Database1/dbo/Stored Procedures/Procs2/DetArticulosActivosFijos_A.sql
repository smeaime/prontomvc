






CREATE Procedure [dbo].[DetArticulosActivosFijos_A]
@IdDetalleArticuloActivosFijos int output,
@IdArticulo int,
@Fecha datetime,
@TipoConcepto varchar(1),
@Detalle varchar(50),
@ModificacionVidaUtilImpositiva int,
@ModificacionVidaUtilContable int,
@Importe numeric(18,4),
@IdRevaluo int,
@ImporteRevaluo numeric(18,4),
@VidaUtilRevaluo int
As 
Insert into [DetalleArticulosActivosFijos]
(
 IdArticulo,
 Fecha,
 TipoConcepto,
 Detalle,
 ModificacionVidaUtilImpositiva,
 ModificacionVidaUtilContable,
 Importe,
 IdRevaluo,
 ImporteRevaluo,
 VidaUtilRevaluo
)
Values
(
 @IdArticulo,
 @Fecha,
 @TipoConcepto,
 @Detalle,
 @ModificacionVidaUtilImpositiva,
 @ModificacionVidaUtilContable,
 @Importe,
 @IdRevaluo,
 @ImporteRevaluo,
 @VidaUtilRevaluo
)
Select @IdDetalleArticuloActivosFijos=@@identity
Return(@IdDetalleArticuloActivosFijos)






