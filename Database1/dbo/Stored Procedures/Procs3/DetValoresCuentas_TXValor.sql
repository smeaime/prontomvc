
CREATE PROCEDURE [dbo].[DetValoresCuentas_TXValor]

@IdValor int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='000111133'
SET @vector_T='000332200'

SELECT
 Det.IdDetalleValorCuentas,
 Det.IdValor,
 Det.IdCuenta,
 IsNull((Select Top 1 dc.CodigoAnterior 
	From DetalleCuentas dc 
	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>Valores.FechaValor 
	Order By dc.FechaCambio),Cuentas.Codigo) as [CodigoCuenta],
 IsNull((Select Top 1 dc.NombreAnterior 
	From DetalleCuentas dc 
	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>Valores.FechaValor 
	Order By dc.FechaCambio),Cuentas.Descripcion) as [Cuenta],
 Det.Debe,
 Det.Haber,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleValoresCuentas Det
LEFT OUTER JOIN Valores ON Valores.IdValor=Det.IdValor
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Det.IdCuenta
WHERE (Det.IdValor = @IdValor)
