




CREATE Procedure [dbo].[DetObrasRecepciones_A]

@IdDetalleObraRecepcion int  output,
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

Insert into [DetalleObrasRecepciones]
(
 IdObra,
 NumeroRecepcion,
 FechaRecepcion,
 TipoRecepcion,
 Detalle,
 IdRealizo,
 FechaRealizo,
 IdAprobo,
 FechaAprobo
)
Values
(
 @IdObra,
 @NumeroRecepcion,
 @FechaRecepcion,
 @TipoRecepcion,
 @Detalle,
 @IdRealizo,
 @FechaRealizo,
 @IdAprobo,
 @FechaAprobo
)
Select @IdDetalleObraRecepcion=@@identity
Return(@IdDetalleObraRecepcion)





