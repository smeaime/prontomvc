CREATE Procedure [dbo].[DetEmpleadosObras_M]

@IdDetalleEmpleadoObra int,
@IdEmpleado int,
@IdObra int

AS

UPDATE [DetalleEmpleadosObras]
SET 
 IdEmpleado=@IdEmpleado,
 IdObra=@IdObra
WHERE (IdDetalleEmpleadoObra=@IdDetalleEmpleadoObra)

RETURN(@IdDetalleEmpleadoObra)