





























CREATE Procedure [dbo].[DetAcopiosRevisiones_M]
@IdDetalleAcopiosRevisiones int,
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
as
Update [DetalleAcopiosRevisiones]
SET 
IdAcopio=@IdAcopio,
IdDetalleAcopio=@IdDetalleAcopio,
NumeroItem=@NumeroItem,
Fecha=@Fecha,
Detalle=@Detalle,
IdRealizo=@IdRealizo,
FechaRealizacion=@FechaRealizacion,
IdAprobo=@IdAprobo,
FechaAprobacion=@FechaAprobacion,
NumeroRevision=@NumeroRevision,
EnviarEmail=@EnviarEmail,
IdAcopioOriginal=@IdAcopioOriginal,
IdDetalleAcopiosRevisionesOriginal=@IdDetalleAcopiosRevisionesOriginal,
IdOrigenTransmision=@IdOrigenTransmision
where (IdDetalleAcopiosRevisiones=@IdDetalleAcopiosRevisiones)
Return(@IdDetalleAcopiosRevisiones)






























