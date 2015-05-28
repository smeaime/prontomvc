





























CREATE Procedure [dbo].[DetAcopios_A]
@IdDetalleAcopios int  output,
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
AS 
Insert into [DetalleAcopios]
(
 IdAcopio,
 NumeroItem,
 Revision,
 Cantidad,
 IdUnidad,
 IdArticulo,
 Peso,
 IdUnidadPeso,
 IdControlCalidad,
 FechaNecesidad,
 Adjunto,
 Cantidad1,
 Cantidad2,
 ArchivoAdjunto,
 Observaciones,
 IdCuenta,
 Cumplido,
 ArchivoAdjunto1,
 ArchivoAdjunto2,
 ArchivoAdjunto3,
 ArchivoAdjunto4,
 ArchivoAdjunto5,
 ArchivoAdjunto6,
 ArchivoAdjunto7,
 ArchivoAdjunto8,
 ArchivoAdjunto9,
 ArchivoAdjunto10,
 IdProveedor,
 IdComprador,
 IdLlamadoAProveedor,
 FechaLlamadoAProveedor,
 IdLlamadoRegistradoPor,
 FechaRegistracionLlamada,
 ObservacionesLlamada,
 IdAutorizoCumplido,
 IdDioPorCumplido,
 FechaDadoPorCumplido,
 ObservacionesCumplido,
 IdAproboAlmacen,
 EnviarEmail,
 IdAcopioOriginal,
 IdDetalleAcopiosOriginal,
 IdOrigenTransmision,
 Precio,
 IdEquipo,
 FechaEntrega_Tel
)
Values
(
 @IdAcopio,
 @NumeroItem,
 @Revision,
 @Cantidad,
 @IdUnidad,
 @IdArticulo,
 @Peso,
 @IdUnidadPeso,
 @IdControlCalidad,
 @FechaNecesidad,
 @Adjunto,
 @Cantidad1,
 @Cantidad2,
 @ArchivoAdjunto,
 @Observaciones,
 @IdCuenta,
 @Cumplido,
 @ArchivoAdjunto1,
 @ArchivoAdjunto2,
 @ArchivoAdjunto3,
 @ArchivoAdjunto4,
 @ArchivoAdjunto5,
 @ArchivoAdjunto6,
 @ArchivoAdjunto7,
 @ArchivoAdjunto8,
 @ArchivoAdjunto9,
 @ArchivoAdjunto10,
 @IdProveedor,
 @IdComprador,
 @IdLlamadoAProveedor,
 @FechaLlamadoAProveedor,
 @IdLlamadoRegistradoPor,
 @FechaRegistracionLlamada,
 @ObservacionesLlamada,
 @IdAutorizoCumplido,
 @IdDioPorCumplido,
 @FechaDadoPorCumplido,
 @ObservacionesCumplido,
 @IdAproboAlmacen,
 @EnviarEmail,
 @IdAcopioOriginal,
 @IdDetalleAcopiosOriginal,
 @IdOrigenTransmision,
 @Precio,
 @IdEquipo,
 @FechaEntrega_Tel
)
Select @IdDetalleAcopios=@@identity
Return(@IdDetalleAcopios)






























