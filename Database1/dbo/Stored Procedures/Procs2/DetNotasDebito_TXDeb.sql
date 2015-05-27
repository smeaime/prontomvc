
CREATE PROCEDURE [dbo].[DetNotasDebito_TXDeb]

@IdNotaDebito int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='000111133'
SET @vector_T='000555500'

SELECT
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
WHERE (DetND.IdNotaDebito = @IdNotaDebito)
