CREATE Procedure [dbo].[Bancos_TX_CuentasPorIdBanco]

@IdBanco int,
@IdEmpleado int = Null,
@Orden int = Null

AS 

SET @IdEmpleado=IsNull(@IdEmpleado,-1)
SET @Orden=IsNull(@Orden,1)

IF @Orden=1
	SELECT CuentasBancarias.*, Bancos.Nombre as [Banco]
	FROM CuentasBancarias 
	LEFT OUTER JOIN Bancos ON Bancos.IdBanco=CuentasBancarias.IdBanco
	WHERE (@IdBanco=-1 or CuentasBancarias.IdBanco=@IdBanco) and 
		(@IdEmpleado=-1 or Not Exists(Select Top 1 decb.IdEmpleado From DetalleEmpleadosCuentasBancarias decb Where decb.IdEmpleado=@IdEmpleado) or 
		 Exists(Select Top 1 decb.IdCuentaBancaria From DetalleEmpleadosCuentasBancarias decb 
			Where decb.IdEmpleado=@IdEmpleado and decb.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria))
	ORDER BY Bancos.CodigoUniversal, Bancos.Nombre

IF @Orden=2
	SELECT CuentasBancarias.*, Bancos.Nombre as [Banco]
	FROM CuentasBancarias 
	LEFT OUTER JOIN Bancos ON Bancos.IdBanco=CuentasBancarias.IdBanco
	WHERE (@IdBanco=-1 or CuentasBancarias.IdBanco=@IdBanco) and 
		(@IdEmpleado=-1 or Not Exists(Select Top 1 decb.IdEmpleado From DetalleEmpleadosCuentasBancarias decb Where decb.IdEmpleado=@IdEmpleado) or 
		 Exists(Select Top 1 decb.IdCuentaBancaria From DetalleEmpleadosCuentasBancarias decb 
			Where decb.IdEmpleado=@IdEmpleado and decb.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria))
	ORDER BY Bancos.CodigoUniversal Desc, Bancos.Nombre