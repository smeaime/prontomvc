CREATE Procedure [dbo].[DetEmpleadosUbicaciones_M]

@IdDetalleEmpleadoUbicacion int,
@IdEmpleado int,
@IdUbicacion int

AS

UPDATE [DetalleEmpleadosUbicaciones]
SET 
 IdEmpleado=@IdEmpleado,
 IdUbicacion=@IdUbicacion
WHERE (IdDetalleEmpleadoUbicacion=@IdDetalleEmpleadoUbicacion)

RETURN(@IdDetalleEmpleadoUbicacion)