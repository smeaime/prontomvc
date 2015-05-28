
CREATE Procedure [dbo].[Cuentas_TX_CuentasDependientesPorIdCuenta]

@IdCuenta int

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 (A_IdCuenta INTEGER)
INSERT INTO #Auxiliar1 
 SELECT Cuentas.IdCuenta
 FROM Cuentas 
 LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaMadre=@IdCuenta
 WHERE Cuentas.IdCuentaGasto IS NOT NULL AND Cuentas.IdCuentaGasto=CuentasGastos.IdCuentaGasto

SET NOCOUNT OFF

SELECT *
FROM #Auxiliar1

DROP TABLE #Auxiliar1
