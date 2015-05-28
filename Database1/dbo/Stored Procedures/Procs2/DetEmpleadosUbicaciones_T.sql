CREATE Procedure [dbo].[DetEmpleadosUbicaciones_T]

@IdDetalleEmpleadoUbicacion int

AS 

SELECT *
FROM [DetalleEmpleadosUbicaciones]
WHERE (IdDetalleEmpleadoUbicacion=@IdDetalleEmpleadoUbicacion)