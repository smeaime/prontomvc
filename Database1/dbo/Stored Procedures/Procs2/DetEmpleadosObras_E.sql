CREATE Procedure [dbo].[DetEmpleadosObras_E]

@IdDetalleEmpleadoObra int  

AS 

DELETE [DetalleEmpleadosObras]
WHERE (IdDetalleEmpleadoObra=@IdDetalleEmpleadoObra)