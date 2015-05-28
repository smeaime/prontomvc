CREATE Procedure [dbo].[DetEmpleadosCuentasBancarias_E]

@IdDetalleEmpleadoCuentaBancaria int  

AS 

DELETE [DetalleEmpleadosCuentasBancarias]
WHERE (IdDetalleEmpleadoCuentaBancaria=@IdDetalleEmpleadoCuentaBancaria)