
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////

CREATE Procedure DetProduccionOrdenes_M

@IdDetalleProduccionOrden int,

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

DECLARE @IdStockAnt int, @IdArticuloAnt int, @PartidaAnt varchar(20), @CantidadUnidadesAnt numeric(18,2),
	@IdUnidadAnt int, @IdUbicacionAnt int, @IdObraAnt int, @IdStock1 int, @Anulada varchar(2)

SET @Anulada=IsNull((Select Top 1 Anulada From ProduccionOrdenes 
			Where IdProduccionOrden=@IdProduccionOrden),'NO')
UPDATE [DetalleProduccionOrdenes]
SET 
 IdProduccionOrden=@IdProduccionOrden,

 IdArticulo=@IdArticulo,
 IdStock=@IdStock,
 Partida=@Partida,
 Cantidad=@Cantidad,

 CantidadAdicional=@CantidadAdicional,
 IdUnidad=@IdUnidad,
 Cantidad1=@Cantidad1,
 Cantidad2=@Cantidad2,
 IdDetalleValeSalida=@IdDetalleValeSalida,
 Adjunto=@Adjunto,

 Observaciones=@Observaciones,
 IdUbicacion=@IdUbicacion,
 IdObra=@IdObra,
 CostoUnitario=@CostoUnitario,
 IdMoneda=@IdMoneda,
 CotizacionDolar=@CotizacionDolar,
 CotizacionMoneda=@CotizacionMoneda,

 IdEquipoDestino=@IdEquipoDestino,
 EnviarEmail=@EnviarEmail,

 IdOrigenTransmision=@IdOrigenTransmision,
 DescargaPorKit=@DescargaPorKit,
 FechaImputacion=@FechaImputacion,
 IdOrdenesTrabajo=@IdOrdenesTrabajo,
 IdDetalleObraDestino=@IdDetalleObraDestino,
 IdPresupuestoObraRubro=@IdPresupuestoObraRubro,
 Porcentaje=@Porcentaje,
IdProduccionProceso= @IdProduccionProceso,
IdColor=@IdColor,
Tolerancia=@Tolerancia
,Orden=@Orden,
IdProduccionParteQueCerroEsteInsumo=@IdProduccionParteQueCerroEsteInsumo
WHERE (IdDetalleProduccionOrden=@IdDetalleProduccionOrden)


IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdDetalleProduccionOrden)
