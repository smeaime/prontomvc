CREATE Procedure [dbo].[DetEmpleadosUbicaciones_E]

@IdDetalleEmpleadoUbicacion int  

AS 

DELETE [DetalleEmpleadosUbicaciones]
WHERE (IdDetalleEmpleadoUbicacion=@IdDetalleEmpleadoUbicacion)