
CREATE Procedure [dbo].[Cajas_TX_PorCuentaContable]

@CodigoCuenta int

AS 

SELECT Cajas.*
FROM Cajas
LEFT OUTER JOIN Cuentas ON Cajas.IdCuenta=Cuentas.IdCuenta
WHERE Cuentas.Codigo=@CodigoCuenta
