
CREATE PROCEDURE [dbo].[DetValoresCuentas_TXPrimero]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='000111133'
SET @vector_T='000332200'

SELECT TOP 1
 Det.IdDetalleValorCuentas,
 Det.IdValor,
 Det.IdCuenta,
 Det.CodigoCuenta,
 Cuentas.Descripcion as [Cuenta],
 Det.Debe,
 Det.Haber,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleValoresCuentas Det
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Det.IdCuenta
