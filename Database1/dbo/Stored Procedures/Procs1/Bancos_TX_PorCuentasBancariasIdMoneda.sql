CREATE Procedure [dbo].[Bancos_TX_PorCuentasBancariasIdMoneda]

@IdMoneda int, 
@IdEmpleado int = Null,
@EstadoCuenta varchar(1) = Null

AS 

SET NOCOUNT ON

SET @IdEmpleado=IsNull(@IdEmpleado,-1)
SET @EstadoCuenta=IsNull(@EstadoCuenta,'*')

CREATE TABLE #Auxiliar (
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
 WHERE CuentasBancarias.IdMoneda=@IdMoneda and 
	(@IdEmpleado=-1 or Not Exists(Select Top 1 decb.IdEmpleado From DetalleEmpleadosCuentasBancarias decb Where decb.IdEmpleado=@IdEmpleado) or 
	 Exists(Select Top 1 decb.IdCuentaBancaria From DetalleEmpleadosCuentasBancarias decb 
		Where decb.IdEmpleado=@IdEmpleado and decb.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria)) and 
	(@EstadoCuenta='*' or IsNull(CuentasBancarias.Activa,'SI')='SI')

SET NOCOUNT OFF

SELECT 
 A_IdCuentaBancaria as [IdCuentaBancaria],
 A_Titulo1 + '  [' + A_Titulo2 + ']' as [Titulo]
FROM #Auxiliar
ORDER BY [Titulo]

DROP TABLE #Auxiliar