





























CREATE Procedure [dbo].[DetAcopiosEquipos_M]
@IdDetalleAcopioEquipo int,
@IdAcopio int,
@IdEquipo int,
@EnviarEmail tinyint,
@IdAcopioOriginal int,
@IdDetalleAcopioEquipoOriginal int,
@IdOrigenTransmision int
as
Update [DetalleAcopiosEquipos]
SET 
IdAcopio=@IdAcopio,
IdEquipo=@IdEquipo,
EnviarEmail=@EnviarEmail,
IdAcopioOriginal=@IdAcopioOriginal,
IdDetalleAcopioEquipoOriginal=@IdDetalleAcopioEquipoOriginal,
IdOrigenTransmision=@IdOrigenTransmision
where (IdDetalleAcopioEquipo=@IdDetalleAcopioEquipo)
Return(@IdDetalleAcopioEquipo)






























