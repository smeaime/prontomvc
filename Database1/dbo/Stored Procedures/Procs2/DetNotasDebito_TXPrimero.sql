





CREATE PROCEDURE [dbo].[DetNotasDebito_TXPrimero]

As

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='000111133'
Set @vector_T='000555500'

SELECT TOP 1
 DetND.IdDetalleNotaDebito,
 DetND.IdNotaDebito,
 DetND.IdConcepto,
 Conceptos.Descripcion [Concepto],
 IsNull(Cajas.Descripcion,CuentasBancarias.Cuenta) as [Caja / Cuenta banco],
 DetND.Gravado as [Gravado?],
 DetND.Importe as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleNotasDebito DetND
LEFT OUTER JOIN Conceptos ON DetND.IdConcepto = Conceptos.IdConcepto
LEFT OUTER JOIN Cajas ON DetND.IdCaja = Cajas.IdCaja
LEFT OUTER JOIN CuentasBancarias ON DetND.IdCuentaBancaria = CuentasBancarias.IdCuentaBancaria





