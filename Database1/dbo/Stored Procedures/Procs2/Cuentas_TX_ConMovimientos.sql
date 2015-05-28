
CREATE PROCEDURE [dbo].[Cuentas_TX_ConMovimientos]

@IdCuenta int

AS

SELECT DetAsi.IdCuenta
FROM DetalleAsientos DetAsi
LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
WHERE DetAsi.IdCuenta=@IdCuenta and asientos.IdCuentaSubdiario is null 

UNION ALL

SELECT Subdiarios.IdCuenta
FROM Subdiarios
WHERE Subdiarios.IdCuenta=@IdCuenta
