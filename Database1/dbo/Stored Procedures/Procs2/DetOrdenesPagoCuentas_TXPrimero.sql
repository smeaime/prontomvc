
CREATE PROCEDURE [dbo].[DetOrdenesPagoCuentas_TXPrimero]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='000111133'
SET @vector_T='000302200'

SELECT TOP 1
 DetOP.IdDetalleOrdenPagoCuentas,
 DetOP.IdOrdenPago,
 DetOP.IdCuenta,
 DetOP.CodigoCuenta,
 Cuentas.Descripcion as [Cuenta],
 DetOP.Debe,
 DetOP.Haber,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleOrdenesPagoCuentas DetOP
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=DetOP.IdCuenta
