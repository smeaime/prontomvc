CREATE Procedure [dbo].[DetEmpleadosUbicaciones_A]

@IdDetalleEmpleadoUbicacion int  output,
@IdEmpleado int,
@IdUbicacion int

AS 

INSERT INTO [DetalleEmpleadosUbicaciones]
(
 IdEmpleado,
 IdUbicacion
)
VALUES
(
 @IdEmpleado,
 @IdUbicacion
)

SELECT @IdDetalleEmpleadoUbicacion=@@identity

RETURN(@IdDetalleEmpleadoUbicacion)