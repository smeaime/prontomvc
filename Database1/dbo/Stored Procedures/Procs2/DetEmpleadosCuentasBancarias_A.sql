CREATE Procedure [dbo].[DetEmpleadosCuentasBancarias_A]

@IdDetalleEmpleadoCuentaBancaria int  output,
@IdEmpleado int,
@IdCuentaBancaria int

AS 

INSERT INTO [DetalleEmpleadosCuentasBancarias]
(
 IdEmpleado,
 IdCuentaBancaria
)
VALUES
(
 @IdEmpleado,
 @IdCuentaBancaria
)

SELECT @IdDetalleEmpleadoCuentaBancaria=@@identity

RETURN(@IdDetalleEmpleadoCuentaBancaria)