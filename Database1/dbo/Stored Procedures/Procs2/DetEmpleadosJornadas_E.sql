





CREATE Procedure [dbo].[DetEmpleadosJornadas_E]
@IdDetalleEmpleadoJornada int  
AS 
Delete [DetalleEmpleadosJornadas]
Where (IdDetalleEmpleadoJornada=@IdDetalleEmpleadoJornada)






