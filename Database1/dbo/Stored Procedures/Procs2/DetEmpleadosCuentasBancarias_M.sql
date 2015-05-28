CREATE Procedure [dbo].[DetEmpleadosCuentasBancarias_M]

@IdDetalleEmpleadoCuentaBancaria int,
@IdEmpleado int,
@IdCuentaBancaria int

AS

UPDATE [DetalleEmpleadosCuentasBancarias]
SET 
 IdEmpleado=@IdEmpleado,
 IdCuentaBancaria=@IdCuentaBancaria
WHERE (IdDetalleEmpleadoCuentaBancaria=@IdDetalleEmpleadoCuentaBancaria)

RETURN(@IdDetalleEmpleadoCuentaBancaria)