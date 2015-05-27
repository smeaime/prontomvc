CREATE Procedure [dbo].[Impuestos_TX_TodasLasCuentas]

AS 

SELECT DISTINCT IdCuenta
FROM Impuestos
ORDER BY IdCuenta