





























CREATE Procedure [dbo].[DetAcopios_M]
@IdDetalleAcopios int,
@IdAcopio int,
@NumeroItem int,
@Revision varchar(10),
@Cantidad numeric(12,2),
@IdUnidad int,
@IdArticulo int,
@Peso numeric(12,2),
@IdUnidadPeso int,
@IdControlCalidad int,
@FechaNecesidad datetime,
@Adjunto varchar(2),
@Cantidad1 numeric(12,2),
@Cantidad2 numeric(12,2),
@ArchivoAdjunto varchar(50),
@Observaciones ntext,
@IdCuenta int,
@Cumplido varchar(2),
@ArchivoAdjunto1 varchar(100),
@ArchivoAdjunto2 varchar(100),
@ArchivoAdjunto3 varchar(100),
@ArchivoAdjunto4 varchar(100),
@ArchivoAdjunto5 varchar(100),
@ArchivoAdjunto6 varchar(100),
@ArchivoAdjunto7 varchar(100),
@ArchivoAdjunto8 varchar(100),
@ArchivoAdjunto9 varchar(100),
@ArchivoAdjunto10 varchar(100),
@IdProveedor int,
@IdComprador int,
@IdLlamadoAProveedor int,
@FechaLlamadoAProveedor datetime,
@IdLlamadoRegistradoPor int,
@FechaRegistracionLlamada datetime,
@ObservacionesLlamada ntext,
@IdAutorizoCumplido int,
@IdDioPorCumplido int,
@FechaDadoPorCumplido datetime,
@ObservacionesCumplido ntext,
@IdAproboAlmacen int,
@EnviarEmail tinyint,
@IdAcopioOriginal int,
@IdDetalleAcopiosOriginal int,
@IdOrigenTransmision int,
@Precio numeric(12,2),
@IdEquipo int,
@FechaEntrega_Tel datetime
as
Update [DetalleAcopios]
SET 
IdAcopio=@IdAcopio,
NumeroItem=@NumeroItem,
Revision=@Revision,
Cantidad=@Cantidad,
IdUnidad=@IdUnidad,
IdArticulo=@IdArticulo,
Peso=@Peso,
IdUnidadPeso=@IdUnidadPeso,
IdControlCalidad=@IdControlCalidad,
FechaNecesidad=@FechaNecesidad,
Adjunto=@Adjunto,
Cantidad1=@Cantidad1,
Cantidad2=@Cantidad2,
ArchivoAdjunto=@ArchivoAdjunto,
Observaciones=@Observaciones,
IdCuenta=@IdCuenta,
Cumplido=@Cumplido,
ArchivoAdjunto1=@ArchivoAdjunto1,
ArchivoAdjunto2=@ArchivoAdjunto2,
ArchivoAdjunto3=@ArchivoAdjunto3,
ArchivoAdjunto4=@ArchivoAdjunto4,
ArchivoAdjunto5=@ArchivoAdjunto5,
ArchivoAdjunto6=@ArchivoAdjunto6,
ArchivoAdjunto7=@ArchivoAdjunto7,
ArchivoAdjunto8=@ArchivoAdjunto8,
ArchivoAdjunto9=@ArchivoAdjunto9,
ArchivoAdjunto10=@ArchivoAdjunto10,
IdProveedor=@IdProveedor,
IdComprador=@IdComprador,
IdLlamadoAProveedor=@IdLlamadoAProveedor,
FechaLlamadoAProveedor=@FechaLlamadoAProveedor,
IdLlamadoRegistradoPor=@IdLlamadoRegistradoPor,
FechaRegistracionLlamada=@FechaRegistracionLlamada,
ObservacionesLlamada=@ObservacionesLlamada,
IdAutorizoCumplido=@IdAutorizoCumplido,
IdDioPorCumplido=@IdDioPorCumplido,
FechaDadoPorCumplido=@FechaDadoPorCumplido,
ObservacionesCumplido=@ObservacionesCumplido,
IdAproboAlmacen=@IdAproboAlmacen,
EnviarEmail=@EnviarEmail,
IdAcopioOriginal=@IdAcopioOriginal,
IdDetalleAcopiosOriginal=@IdDetalleAcopiosOriginal,
IdOrigenTransmision=@IdOrigenTransmision,
Precio=@Precio,
IdEquipo=@IdEquipo,
FechaEntrega_Tel=@FechaEntrega_Tel
where (IdDetalleAcopios=@IdDetalleAcopios)
Return(@IdDetalleAcopios)






























