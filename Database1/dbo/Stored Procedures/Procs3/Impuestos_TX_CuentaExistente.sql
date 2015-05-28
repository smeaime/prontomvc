CREATE Procedure [dbo].[Impuestos_TX_CuentaExistente]

@IdCuenta int

AS 

SELECT TOP 1 *
FROM Impuestos
WHERE IdCuenta=@IdCuenta