





CREATE PROCEDURE [dbo].[DetNotasCredito_TXPrimero]

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='000111133'
Set @vector_T='000212300'

SELECT TOP 1
 DetNC.IdDetalleNotaCredito,
 DetNC.IdNotaCredito,
 DetNC.IdConcepto,
 Conceptos.Descripcion [Concepto],
 IsNull(Cajas.Descripcion,CuentasBancarias.Cuenta) as [Caja / Cuenta banco],
 DetNC.Gravado as [Gravado?],
 DetNC.Importe as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleNotasCredito DetNC
LEFT OUTER JOIN Conceptos ON DetNC.IdConcepto = Conceptos.IdConcepto
LEFT OUTER JOIN Cajas ON DetNC.IdCaja = Cajas.IdCaja
LEFT OUTER JOIN CuentasBancarias ON DetNC.IdCuentaBancaria = CuentasBancarias.IdCuentaBancaria





