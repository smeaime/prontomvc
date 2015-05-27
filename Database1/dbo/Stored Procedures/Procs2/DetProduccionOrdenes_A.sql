--///////////////////////////////////////////////////////////////

CREATE Procedure DetProduccionOrdenes_A

@IdDetalleProduccionOrden int  output,
@IdProduccionOrden int,
@IdArticulo int,
@IdStock int,
@Partida varchar(20),
@Cantidad numeric(12,2),

@CantidadAdicional numeric(12,2),
@IdUnidad int,
@Cantidad1 numeric(12,2),
@Cantidad2 numeric(12,2),
@IdDetalleValeSalida int,
@Adjunto varchar(2),

@Observaciones ntext,
@IdUbicacion int,
@IdObra int,
@CostoUnitario numeric(18,4),
@IdMoneda int,
@CotizacionDolar numeric(18,4),
@CotizacionMoneda numeric(18,4),

@IdEquipoDestino int,
@EnviarEmail tinyint,
@IdOrigenTransmision int,
@DescargaPorKit varchar(2),
@FechaImputacion datetime,
@IdOrdenesTrabajo int,
@IdDetalleObraDestino int,
@IdPresupuestoObraRubro int,

@Porcentaje numeric(18,2),

@IdProduccionProceso INT,
@IdColor int,

@Tolerancia numeric(18,2)

,@Orden int
,@IdProduccionParteQueCerroEsteInsumo int

AS 

BEGIN TRAN


INSERT INTO [DetalleProduccionOrdenes]
(
 IdProduccionOrden,
 IdArticulo,
 IdStock,
 Partida,
 Cantidad,

 CantidadAdicional,
 IdUnidad,
 Cantidad1,
 Cantidad2,
 IdDetalleValeSalida,
 Adjunto,

 Observaciones,
 IdUbicacion,
 IdObra,
 CostoUnitario,
 IdMoneda,
 CotizacionDolar,
 CotizacionMoneda,

 IdEquipoDestino,
 EnviarEmail,

 IdOrigenTransmision,
 DescargaPorKit,
 FechaImputacion,
 IdOrdenesTrabajo,
 IdDetalleObraDestino,
 IdPresupuestoObraRubro,

 Porcentaje ,
 IdProduccionProceso,
 IdColor, 
 Tolerancia

,Orden 
,IdProduccionParteQueCerroEsteInsumo
)
VALUES 
(
 @IdProduccionOrden,
 @IdArticulo,
 @IdStock,
 @Partida,
 @Cantidad,
 @CantidadAdicional,
 @IdUnidad,
 @Cantidad1,
 @Cantidad2,
 @IdDetalleValeSalida,
 @Adjunto,
 @Observaciones,
 @IdUbicacion,
 @IdObra,
 @CostoUnitario,
 @IdMoneda,
 @CotizacionDolar,
 @CotizacionMoneda,
 @IdEquipoDestino,
 @EnviarEmail,
 @IdOrigenTransmision,
 @DescargaPorKit,
 @FechaImputacion,
 @IdOrdenesTrabajo,
 @IdDetalleObraDestino,
 @IdPresupuestoObraRubro,
 @Porcentaje,
 @IdProduccionProceso,
 @idColor,
 @Tolerancia 

,@Orden
,@IdProduccionParteQueCerroEsteInsumo
)
SELECT @IdDetalleProduccionOrden=@@identity




IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdDetalleProduccionOrden)
