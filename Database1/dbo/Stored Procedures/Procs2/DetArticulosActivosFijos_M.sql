






CREATE Procedure [dbo].[DetArticulosActivosFijos_M]
@IdDetalleArticuloActivosFijos int,
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
Update [DetalleArticulosActivosFijos]
Set 
 IdArticulo=@IdArticulo,
 Fecha=@Fecha,
 TipoConcepto=@TipoConcepto,
 Detalle=@Detalle,
 ModificacionVidaUtilImpositiva=@ModificacionVidaUtilImpositiva,
 ModificacionVidaUtilContable=@ModificacionVidaUtilContable,
 Importe=@Importe,
 IdRevaluo=@IdRevaluo,
 ImporteRevaluo=@ImporteRevaluo,
 VidaUtilRevaluo=@VidaUtilRevaluo
Where (IdDetalleArticuloActivosFijos=@IdDetalleArticuloActivosFijos)
Return(@IdDetalleArticuloActivosFijos)






