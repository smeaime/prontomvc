
CREATE Procedure [dbo].[CuentasBancarias_TX_PorIdBanco]

@IdBanco int, 
@IdEmpleado int = Null

AS 

SET NOCOUNT ON

SET @IdEmpleado=IsNull(@IdEmpleado,-1)

CREATE TABLE #Auxiliar 
			(
			 A_IdCuentaBancaria INTEGER,
			 A_Titulo1 varchar(50),
			 A_Titulo2 varchar(50)
			)
INSERT INTO #Auxiliar 
 SELECT 
  CuentasBancarias.IdCuentaBancaria,
  Bancos.Nombre,
  CuentasBancarias.Cuenta
 FROM CuentasBancarias 
 LEFT OUTER JOIN Bancos ON Bancos.IdBanco=CuentasBancarias.IdBanco
 WHERE CuentasBancarias.IdBanco=@IdBanco and 
	(@IdEmpleado=-1 or Not Exists(Select Top 1 decb.IdEmpleado From DetalleEmpleadosCuentasBancarias decb Where decb.IdEmpleado=@IdEmpleado) or 
	 Exists(Select Top 1 decb.IdCuentaBancaria From DetalleEmpleadosCuentasBancarias decb 
		Where decb.IdEmpleado=@IdEmpleado and decb.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria))

SET NOCOUNT OFF

SELECT 
 A_IdCuentaBancaria as [IdCuentaBancaria],
 A_Titulo1 + '  [' + A_Titulo2 + ']' as [Titulo]
FROM #Auxiliar

DROP TABLE #Auxiliar
