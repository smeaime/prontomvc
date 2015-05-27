CREATE Procedure [dbo].[DetEmpleadosObras_A]

@IdDetalleEmpleadoObra int  output,
@IdEmpleado int,
@IdObra int

AS 

INSERT INTO [DetalleEmpleadosObras]
(
 IdEmpleado,
 IdObra
)
VALUES
(
 @IdEmpleado,
 @IdObra
)

SELECT @IdDetalleEmpleadoObra=@@identity

RETURN(@IdDetalleEmpleadoObra)