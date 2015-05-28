CREATE Procedure [dbo].[DetEmpleadosObras_T]

@IdDetalleEmpleadoObra int

AS 

SELECT *
FROM [DetalleEmpleadosObras]
WHERE (IdDetalleEmpleadoObra=@IdDetalleEmpleadoObra)