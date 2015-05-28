




CREATE Procedure [dbo].[DetObrasRecepciones_M]

@IdDetalleObraRecepcion int,
@IdObra int,
@NumeroRecepcion int,
@FechaRecepcion datetime,
@TipoRecepcion varchar(10),
@Detalle ntext,
@IdRealizo int,
@FechaRealizo datetime,
@IdAprobo int,
@FechaAprobo datetime

As

Update [DetalleObrasRecepciones]
Set 
 IdObra=@IdObra,
 NumeroRecepcion=@NumeroRecepcion,
 FechaRecepcion=@FechaRecepcion,
 TipoRecepcion=@TipoRecepcion,
 Detalle=@Detalle,
 IdRealizo=@IdRealizo,
 FechaRealizo=@FechaRealizo,
 IdAprobo=@IdAprobo,
 FechaAprobo=@FechaAprobo
Where (IdDetalleObraRecepcion=@IdDetalleObraRecepcion)

Return(@IdDetalleObraRecepcion)





