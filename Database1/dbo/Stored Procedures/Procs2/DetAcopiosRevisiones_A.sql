





























CREATE Procedure [dbo].[DetAcopiosRevisiones_A]
@IdDetalleAcopiosRevisiones int  output,
@IdAcopio int,
@IdDetalleAcopio int,
@NumeroItem int,
@Fecha datetime,
@Detalle varchar(100),
@IdRealizo int,
@FechaRealizacion datetime,
@IdAprobo int,
@FechaAprobacion datetime,
@NumeroRevision varchar(10),
@EnviarEmail tinyint,
@IdAcopioOriginal int,
@IdDetalleAcopiosRevisionesOriginal int,
@IdOrigenTransmision int
AS 
Insert into DetalleAcopiosRevisiones
(
 IdAcopio,
 IdDetalleAcopio,
 NumeroItem,
 Fecha,
 Detalle,
 IdRealizo,
 FechaRealizacion,
 IdAprobo,
 FechaAprobacion,
 NumeroRevision,
 EnviarEmail,
 IdAcopioOriginal,
 IdDetalleAcopiosRevisionesOriginal,
 IdOrigenTransmision
)
Values
(
 @IdAcopio,
 @IdDetalleAcopio,
 @NumeroItem,
 @Fecha,
 @Detalle,
 @IdRealizo,
 @FechaRealizacion,
 @IdAprobo,
 @FechaAprobacion,
 @NumeroRevision,
 @EnviarEmail,
 @IdAcopioOriginal,
 @IdDetalleAcopiosRevisionesOriginal,
 @IdOrigenTransmision
)
Select @IdDetalleAcopiosRevisiones=@@identity
Return(@IdDetalleAcopiosRevisiones)






























