





















CREATE Procedure [dbo].[CostosPromedios_A]

@IdCostoPromedio int  output,
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
Insert into [CostosPromedios]
(
 IdArticulo,
 TipoComprobante,
 NumeroComprobante,
 Fecha,
 Cantidad,
 Costo,
 StockInicial,
 CostoInicial,
 StockFinal,
 CostoFinal,
 CostoInicialU$S,
 CostoCompraU$S,
 CostoFinalU$S,
 IdDetalleAjusteStock,
 IdDetalleDevolucion,
 IdDetalleRecepcion,
 IdDetalleRemito,
 IdDetalleSalidaMateriales,
 IdDetalleValeSalida,
 IdOrigen,
 IdDetalleOtroIngresoAlmacen
)
Values
(
 @IdArticulo,
 @TipoComprobante,
 @NumeroComprobante,
 @Fecha,
 @Cantidad,
 @Costo,
 @StockInicial,
 @CostoInicial,
 @StockFinal,
 @CostoFinal,
 @CostoInicialU$S,
 @CostoCompraU$S,
 @CostoFinalU$S,
 @IdDetalleAjusteStock,
 @IdDetalleDevolucion,
 @IdDetalleRecepcion,
 @IdDetalleRemito,
 @IdDetalleSalidaMateriales,
 @IdDetalleValeSalida,
 @IdOrigen,
 @IdDetalleOtroIngresoAlmacen
)
Select @IdCostoPromedio=@@identity
Return(@IdCostoPromedio)





















