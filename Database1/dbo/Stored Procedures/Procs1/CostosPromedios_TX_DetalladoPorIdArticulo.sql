




CREATE Procedure [dbo].[CostosPromedios_TX_DetalladoPorIdArticulo]

@IdArticulo int

AS

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='000011111111111133'
set @vector_T='000012433333356500'

SELECT
 CP.IdCostoPromedio,
 CP.IdArticulo,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Producto],
 CP.TipoComprobante as [Comp.],
 CP.NumeroComprobante as [Numero],
 CP.Fecha,
 CP.StockInicial as [Stock inicial],
 CP.CostoInicial as [Costo inicial],
 CP.Cantidad as [Cant.compra],
 CP.Costo as [Cos.compra],
 CP.StockFinal as [Stock final],
 CP.CostoFinal as [Costo final],
 CP.CostoInicialU$S as [Cos.inicial u$s],
 CP.CostoCompraU$S as [Cos.compra u$s],
 CP.CostoFinalU$S as [Cos.final u$s],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM CostosPromedios CP
LEFT OUTER JOIN Articulos ON CP.IdArticulo = Articulos.IdArticulo
WHERE (CP.IdArticulo = @IdArticulo)
ORDER BY Articulos.Codigo, CP.Fecha, CP.IdDetalleAjusteStock, CP.IdDetalleDevolucion, CP.IdDetalleRecepcion,
		CP.IdDetalleRemito, CP.IdDetalleSalidaMateriales, CP.IdDetalleValeSalida, CP.IdDetalleOtroIngresoAlmacen




