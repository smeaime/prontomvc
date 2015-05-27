CREATE Procedure [dbo].[DetEmpleadosCuentasBancarias_T]

@IdDetalleEmpleadoCuentaBancaria int

AS 

SELECT *
FROM [DetalleEmpleadosCuentasBancarias]
WHERE (IdDetalleEmpleadoCuentaBancaria=@IdDetalleEmpleadoCuentaBancaria)