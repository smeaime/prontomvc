





























CREATE Procedure [dbo].[DetAcopiosEquipos_A]
@IdDetalleAcopioEquipo int  output,
@IdAcopio int,
@IdEquipo int,
@EnviarEmail tinyint,
@IdAcopioOriginal int,
@IdDetalleAcopioEquipoOriginal int,
@IdOrigenTransmision int
AS 
Insert into [DetalleAcopiosEquipos]
(
 IdAcopio,
 IdEquipo,
 EnviarEmail,
 IdAcopioOriginal,
 IdDetalleAcopioEquipoOriginal,
 IdOrigenTransmision
)
Values
(
 @IdAcopio,
 @IdEquipo,
 @EnviarEmail,
 @IdAcopioOriginal,
 @IdDetalleAcopioEquipoOriginal,
 @IdOrigenTransmision
)
Select @IdDetalleAcopioEquipo=@@identity
Return(@IdDetalleAcopioEquipo)






























