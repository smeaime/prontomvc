CREATE Procedure [dbo].[CuentasBancarias_TX_TodasParaCombo]

@IdEmpleado int = Null

AS 

SET NOCOUNT ON

SET @IdEmpleado=IsNull(@IdEmpleado,-1)

CREATE TABLE #Auxiliar1
			(
			 A_IdCuentaBancaria INTEGER,
			 A_Titulo1 VARCHAR(50),
			 A_Titulo2 VARCHAR(50)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  IdCuentaBancaria,
  Bancos.Nombre,
  CuentasBancarias.Cuenta
 FROM CuentasBancarias 
 LEFT OUTER JOIN Bancos ON Bancos.IdBanco=CuentasBancarias.IdBanco
 WHERE @IdEmpleado=-1 or Not Exists(Select Top 1 decb.IdEmpleado From DetalleEmpleadosCuentasBancarias decb Where decb.IdEmpleado=@IdEmpleado) or 
	Exists(Select Top 1 decb.IdCuentaBancaria From DetalleEmpleadosCuentasBancarias decb 
		Where decb.IdEmpleado=@IdEmpleado and decb.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria)

SET NOCOUNT OFF

SELECT
 #Auxiliar1.A_IdCuentaBancaria as [IdCuentaBancaria],
 #Auxiliar1.A_Titulo1+' - Cuenta: '+#Auxiliar1.A_Titulo2 as [Titulo]
FROM #Auxiliar1
ORDER BY #Auxiliar1.A_Titulo1,#Auxiliar1.A_Titulo2

DROP TABLE #Auxiliar1