






























CREATE PROCEDURE [dbo].[DetRecibosCuentas_TXPrimero]
as
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='000111133'
set @vector_T='000502200'
SELECT TOP 1
DetRec.IdDetalleReciboCuentas,
DetRec.IdRecibo,
DetRec.IdCuenta,
DetRec.CodigoCuenta,
Cuentas.Descripcion as [Cuenta],
DetRec.Debe,
DetRec.Haber,
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleRecibosCuentas DetRec
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=DetRec.IdCuenta































