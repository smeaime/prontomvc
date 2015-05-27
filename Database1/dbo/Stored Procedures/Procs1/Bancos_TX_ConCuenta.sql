
CREATE Procedure [dbo].[Bancos_TX_ConCuenta]

@IdEmpleado int = Null

AS 

SET @IdEmpleado=IsNull(@IdEmpleado,-1)

SELECT IdBanco, Nombre as [Titulo]
FROM Bancos 
WHERE IdCuenta is not null and 
	Exists(Select Top 1 CuentasBancarias.IdCuentaBancaria From CuentasBancarias Where CuentasBancarias.IdBanco=Bancos.IdBanco) and 
	(@IdEmpleado=-1 or Not Exists(Select Top 1 decb.IdEmpleado From DetalleEmpleadosCuentasBancarias decb Where decb.IdEmpleado=@IdEmpleado) or 
	 Exists(Select Top 1 decb.IdCuentaBancaria From DetalleEmpleadosCuentasBancarias decb 
		Left Outer Join CuentasBancarias On CuentasBancarias.IdCuentaBancaria=decb.IdCuentaBancaria
		Where decb.IdEmpleado=@IdEmpleado and CuentasBancarias.IdBanco=Bancos.IdBanco))
ORDER by Nombre
