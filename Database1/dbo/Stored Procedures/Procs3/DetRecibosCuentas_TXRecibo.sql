
CREATE PROCEDURE [dbo].[DetRecibosCuentas_TXRecibo]

@IdRecibo int

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='000111133'
Set @vector_T='000302200'

SELECT
 DetRec.IdDetalleReciboCuentas,
 DetRec.IdRecibo,
 DetRec.IdCuenta,
 IsNull((Select Top 1 dc.CodigoAnterior 
	From DetalleCuentas dc 
	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>Recibos.FechaRecibo 
	Order By dc.FechaCambio),Cuentas.Codigo) as [CodigoCuenta],
 IsNull((Select Top 1 dc.NombreAnterior 
	From DetalleCuentas dc 
	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>Recibos.FechaRecibo 
	Order By dc.FechaCambio),Cuentas.Descripcion) as [Cuenta],
 DetRec.Debe,
 DetRec.Haber,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRecibosCuentas DetRec
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=DetRec.IdRecibo
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=DetRec.IdCuenta
WHERE (DetRec.IdRecibo = @IdRecibo)
