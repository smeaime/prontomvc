CREATE PROCEDURE [dbo].[DetOrdenesPagoCuentas_TXOrdenPago]

@IdOrdenPago int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='000111133'
SET @vector_T='000302200'

SELECT
 DetOP.IdDetalleOrdenPagoCuentas,
 DetOP.IdOrdenPago,
 DetOP.IdCuenta,
 IsNull((Select Top 1 dc.CodigoAnterior 
		 From DetalleCuentas dc 
		 Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>OrdenesPago.FechaOrdenPago 
		 Order By dc.FechaCambio),Cuentas.Codigo) as [CodigoCuenta],
 IsNull((Select Top 1 dc.NombreAnterior 
		 From DetalleCuentas dc 
		 Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>OrdenesPago.FechaOrdenPago 
		 Order By dc.FechaCambio),Cuentas.Descripcion) as [Cuenta],
 DetOP.Debe,
 DetOP.Haber,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleOrdenesPagoCuentas DetOP
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=DetOP.IdOrdenPago
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=DetOP.IdCuenta
WHERE (DetOP.IdOrdenPago = @IdOrdenPago)
