
CREATE Procedure [dbo].[DetCuentas_TXDet]

@IdCuenta int

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='00111133'
Set @vector_T='00538500'

SELECT 
 DetalleCuentas.IdDetalleCuenta,
 DetalleCuentas.IdCuenta,
 DetalleCuentas.CodigoAnterior as [Codigo anterior],
 DetalleCuentas.NombreAnterior as [Nombre anterior],
 DetalleCuentas.FechaCambio as [Fecha del cambio],
 DetalleCuentas.JerarquiaAnterior as [Jerarquia anterior],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleCuentas
WHERE (DetalleCuentas.IdCuenta = @IdCuenta)
