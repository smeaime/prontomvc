
CREATE Procedure [dbo].[DetEmpleadosJornadas_M]

@IdDetalleEmpleadoJornada int,
@IdEmpleado int,
@FechaCambio Datetime,
@HorasJornada numeric(6,2)

AS

UPDATE [DetalleEmpleadosJornadas]
SET 
 IdEmpleado=@IdEmpleado,
 FechaCambio=@FechaCambio,
 HorasJornada=@HorasJornada
WHERE (IdDetalleEmpleadoJornada=@IdDetalleEmpleadoJornada)

RETURN(@IdDetalleEmpleadoJornada)
