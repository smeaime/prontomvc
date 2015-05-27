





















CREATE  Procedure [dbo].[CostosPromedios_M]
@IdCostoPromedio int,
@IdArticulo int,
@TipoComprobante varchar(2),
@NumeroComprobante int,
@Fecha datetime,
@Cantidad numeric(12,2),
@Costo money,
@StockInicial numeric(12,2),
@CostoInicial numeric(18,3),
@StockFinal numeric(12,2),
@CostoFinal numeric(18,3),
@CostoInicialU$S numeric(18,3),
@CostoCompraU$S numeric(18,3),
@CostoFinalU$S numeric(18,3),
@IdDetalleAjusteStock int,
@IdDetalleDevolucion int,
@IdDetalleRecepcion int,
@IdDetalleRemito int,
@IdDetalleSalidaMateriales int,
@IdDetalleValeSalida int,
@IdOrigen int,
@IdDetalleOtroIngresoAlmacen int
As
Update CostosPromedios
Set 
 IdArticulo=@IdArticulo,
 TipoComprobante=@TipoComprobante,
 NumeroComprobante=@NumeroComprobante,
 Fecha=@Fecha,
 Cantidad=@Cantidad,
 Costo=@Costo,
 StockInicial=@StockInicial,
 CostoInicial=@CostoInicial,
 StockFinal=@StockFinal,
 CostoFinal=@CostoFinal,
 CostoInicialU$S=@CostoInicialU$S,
 CostoCompraU$S=@CostoCompraU$S,
 CostoFinalU$S=@CostoFinalU$S,
 IdDetalleAjusteStock=@IdDetalleAjusteStock,
 IdDetalleDevolucion=@IdDetalleDevolucion,
 IdDetalleRecepcion=@IdDetalleRecepcion,
 IdDetalleRemito=@IdDetalleRemito,
 IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales,
 IdDetalleValeSalida=@IdDetalleValeSalida,
 IdOrigen=@IdOrigen,
 IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen
Where (IdCostoPromedio=@IdCostoPromedio)
Return(@IdCostoPromedio)





















