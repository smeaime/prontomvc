





CREATE Procedure [dbo].[DetEmpleadosJornadas_T]
@IdDetalleEmpleadoJornada int
AS 
SELECT *
FROM [DetalleEmpleadosJornadas]
WHERE (IdDetalleEmpleadoJornada=@IdDetalleEmpleadoJornada)






