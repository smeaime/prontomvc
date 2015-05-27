
CREATE PROCEDURE [dbo].[DetAsientos_TXPrimero]

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='01111116633'
Set @vector_T='01994577700'

SELECT TOP 1
 DetAsi.IdDetalleAsiento,
 DetAsi.Item as [Item],
 DetAsi.IdDetalleAsiento as [IdAux1],
 DetAsi.IdValor as [IdAux2],
 Cuentas.Codigo as [Cuenta],
 Cuentas.Descripcion as [Detalle de cuenta],
 Obras.NumeroObra as [Obra],
 DetAsi.Debe as [Debe],
 DetAsi.Haber as [Haber],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleAsientos DetAsi
LEFT OUTER JOIN Cuentas ON DetAsi.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN TiposComprobante ON DetAsi.IdTipoComprobante = TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN Obras ON DetAsi.IdObra = Obras.IdObra
