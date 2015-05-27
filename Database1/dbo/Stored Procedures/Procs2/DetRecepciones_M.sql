CREATE Procedure [dbo].[DetRecepciones_M]

@IdDetalleRecepcion int,
@IdRecepcion int,
@Cantidad numeric(18,2),
@IdUnidad int,
@IdArticulo int,
@IdControlCalidad int,
@Observaciones ntext,
@Cantidad1 numeric(18,2),
@Cantidad2 numeric(18,2),
@IdDetallePedido int,
@Controlado varchar(2),
@CantidadAdicional numeric(18,2),
@Partida varchar(20),
@CantidadCC numeric(18,2),
@Cantidad1CC numeric(18,2),
@Cantidad2CC numeric(18,2),
@CantidadAdicionalCC numeric(18,2),
@ObservacionesCC ntext,
@CantidadRechazadaCC numeric(18,2),
@IdMotivoRechazo int,
@IdRealizo int,
@IdDetalleRequerimiento int,
@Trasabilidad varchar(10),
@IdDetalleAcopios int,
@IdUbicacion int,
@IdObra int,
@CostoUnitario numeric(18,4),
@IdMoneda int,
@CotizacionDolar numeric(18,3),
@CotizacionMoneda numeric(18,3),
@EnviarEmail tinyint,
@IdDetalleRecepcionOriginal int,
@IdRecepcionOriginal int,
@IdOrigenTransmision int,
@IdDetalleObraDestino int,
@CantidadEnOrigen numeric(18,2),
@IdDetalleSalidaMateriales int,
@IdPresupuestoObrasNodo int,
@CostoOriginal numeric(18,4),
@IdUsuarioModificoCosto int, 
@FechaModificacionCosto datetime, 
@ObservacionModificacionCosto ntext,
@IdMonedaOriginal int,
@NumeroCaja int,
@IdColor int,
@IdDetalleLiquidacionFlete int,
@IdUsuarioDioPorCumplidoLiquidacionFletes int,
@FechaDioPorCumplidoLiquidacionFletes datetime,
@ObservacionDioPorCumplidoLiquidacionFletes ntext,
@Talle varchar(2),
@IdProduccionTerminado int

AS

BEGIN TRAN

DECLARE @Anulada varchar(2), @IdStockAnt int, @IdArticuloAnt int, @PartidaAnt varchar(20), @CantidadUnidadesAnt numeric(18,2), @IdUnidadAnt int, @IdColorAnt int, 
	@IdUbicacionAnt int, @IdObraAnt int, @IdStock int, @CostoReposicionPorComprobanteProveedor varchar(2), @NumeroCajaAnt int, @TalleAnt varchar(2)

SET @CostoReposicionPorComprobanteProveedor=IsNull((Select Top 1 Valor From Parametros2 Where Campo='CostoReposicionPorComprobanteProveedor'),'SI')
SET @Anulada=IsNull((Select Top 1 Recepciones.Anulada From Recepciones Where Recepciones.IdRecepcion=@IdRecepcion),'NO')

IF @Anulada<>'SI'
   BEGIN
	SET @IdArticuloAnt=IsNull((Select Top 1 IdArticulo From DetalleRecepciones Where IdDetalleRecepcion=@IdDetalleRecepcion),0)
	SET @PartidaAnt=IsNull((Select Top 1 Partida From DetalleRecepciones Where IdDetalleRecepcion=@IdDetalleRecepcion),'')
	SET @CantidadUnidadesAnt=IsNull((Select Top 1 Cantidad From DetalleRecepciones Where IdDetalleRecepcion=@IdDetalleRecepcion),0)
	SET @IdUnidadAnt=IsNull((Select Top 1 IdUnidad From DetalleRecepciones Where IdDetalleRecepcion=@IdDetalleRecepcion),0)
	SET @IdUbicacionAnt=IsNull((Select Top 1 IdUbicacion From DetalleRecepciones Where IdDetalleRecepcion=@IdDetalleRecepcion),0)
	SET @IdColorAnt=IsNull((Select Top 1 IdColor From DetalleRecepciones Where IdDetalleRecepcion=@IdDetalleRecepcion),0)
	SET @IdObraAnt=IsNull((Select Top 1 IdObra From DetalleRecepciones Where IdDetalleRecepcion=@IdDetalleRecepcion),0)
	SET @NumeroCajaAnt=(Select Top 1 NumeroCaja From DetalleRecepciones Where IdDetalleRecepcion=@IdDetalleRecepcion)
	SET @TalleAnt=(Select Top 1 Talle From DetalleRecepciones Where IdDetalleRecepcion=@IdDetalleRecepcion)

	SET @IdStockAnt=IsNull((Select Top 1 Stock.IdStock From Stock 
				Where IdArticulo=@IdArticuloAnt and Partida=@PartidaAnt and IdUbicacion=@IdUbicacionAnt and IsNull(@IdColor,0)=IsNull(@IdColorAnt,0) and 
					IdObra=@IdObraAnt and IdUnidad=@IdUnidadAnt and IsNull(NumeroCaja,0)=IsNull(@NumeroCajaAnt,0) and IsNull(Talle,'')=IsNull(@TalleAnt,'')),0)
	IF @IdStockAnt>0 
		UPDATE Stock
		SET CantidadUnidades=IsNull(CantidadUnidades,0)-@CantidadUnidadesAnt
		WHERE IdStock=@IdStockAnt
	ELSE
		INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdColor, IdObra, NumeroCaja, Talle)
		VALUES (@IdArticuloAnt, @PartidaAnt, @CantidadUnidadesAnt*-1, Null, @IdUnidadAnt, @IdUbicacionAnt, @IdColorAnt, @IdObraAnt, @NumeroCajaAnt, @TalleAnt)
	
	SET @IdStock=IsNull((Select Top 1 Stock.IdStock From Stock 
				Where IdArticulo=@IdArticulo and Partida=@Partida and IdUbicacion=@IdUbicacion and IsNull(@IdColor,0)=IsNull(@IdColor,0) and 
					IdObra=@IdObra and IdUnidad=@IdUnidad and IsNull(NumeroCaja,0)=IsNull(@NumeroCaja,0) and IsNull(Talle,'')=IsNull(@Talle,'')),0)
	IF @IdStock>0 
		UPDATE Stock
		SET CantidadUnidades=IsNull(CantidadUnidades,0)+@Cantidad
		WHERE IdStock=@IdStock	ELSE
		INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdColor, IdObra, NumeroCaja, Talle)
		VALUES (@IdArticulo, @Partida, @Cantidad, Null, @IdUnidad, @IdUbicacion, @IdColor, @IdObra, @NumeroCaja, @Talle)

	/* ACTUALIZACION DEL COSTO DE REPOSICION */
	IF @CostoReposicionPorComprobanteProveedor='NO'
	    BEGIN
		DECLARE @FechaRecepcion datetime, @FechaUltimoCostoReposicion datetime, @CostoReposicion numeric(18,2), @CostoReposicionDolar numeric(18,2)
	
		SET @FechaRecepcion=IsNull((Select Top 1 FechaRecepcion From Recepciones Where IdRecepcion=@IdRecepcion),Convert(datetime,'01/01/2000'))
		SET @CostoReposicion=0
		SET @CostoReposicionDolar=0
	
		SET @CostoReposicion=Round(@CostoUnitario * IsNull(@CotizacionMoneda,1),2)
		IF IsNull(@CotizacionDolar,0)<>0
			SET @CostoReposicionDolar=Round(@CostoUnitario * IsNull(@CotizacionMoneda,1) / @CotizacionDolar,2)
		SET @FechaUltimoCostoReposicion=IsNull((Select Top 1 Articulos.FechaUltimoCostoReposicion From Articulos Where Articulos.IdArticulo=@IdArticulo),Convert(datetime,'01/01/2000'))
		IF @FechaRecepcion>=@FechaUltimoCostoReposicion and @CostoReposicion<>0 and @CostoReposicionDolar<>0
			UPDATE Articulos 
			SET CostoReposicion=@CostoReposicion, CostoReposicionDolar=@CostoReposicionDolar, FechaUltimoCostoReposicion=@FechaRecepcion
			WHERE Articulos.IdArticulo=@IdArticulo
	    END

	IF @IdProduccionTerminado is not null
		UPDATE ProduccionTerminados
		SET IdDetalleRecepcion=@IdDetalleRecepcion
		WHERE IdProduccionTerminado=@IdProduccionTerminado
   END

UPDATE [DetalleRecepciones]
SET 
 IdRecepcion=@IdRecepcion,
 Cantidad=@Cantidad,
 IdUnidad=@IdUnidad,
 IdArticulo=@IdArticulo,
 IdControlCalidad=@IdControlCalidad,
 Observaciones=@Observaciones,
 Cantidad1=@Cantidad1,
 Cantidad2=@Cantidad2,
 IdDetallePedido=@IdDetallePedido,
 Controlado=@Controlado,
 CantidadAdicional=@CantidadAdicional,
 Partida=@Partida,
 CantidadCC=@CantidadCC,
 Cantidad1CC=@Cantidad1CC,
 Cantidad2CC=@Cantidad2CC,
 CantidadAdicionalCC=@CantidadAdicionalCC,
 ObservacionesCC=@ObservacionesCC,
 CantidadRechazadaCC=@CantidadRechazadaCC,
 IdMotivoRechazo=@IdMotivoRechazo,
 IdRealizo=@IdRealizo,
 IdDetalleRequerimiento=@IdDetalleRequerimiento, Trasabilidad=@Trasabilidad,
 IdDetalleAcopios=@IdDetalleAcopios,
 IdUbicacion=@IdUbicacion,
 IdObra=@IdObra,
 CostoUnitario=@CostoUnitario,
 IdMoneda=@IdMoneda,
 CotizacionDolar=@CotizacionDolar,
 CotizacionMoneda=@CotizacionMoneda,
 EnviarEmail=@EnviarEmail,
 IdDetalleRecepcionOriginal=@IdDetalleRecepcionOriginal,
 IdRecepcionOriginal=@IdRecepcionOriginal,
 IdOrigenTransmision=@IdOrigenTransmision,
 IdDetalleObraDestino=@IdDetalleObraDestino,
 CantidadEnOrigen=@CantidadEnOrigen,
 IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales,
 IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo,
 CostoOriginal=@CostoOriginal,
 IdUsuarioModificoCosto=@IdUsuarioModificoCosto,
 FechaModificacionCosto=@FechaModificacionCosto,
 ObservacionModificacionCosto=@ObservacionModificacionCosto,
 IdMonedaOriginal=@IdMonedaOriginal,
 NumeroCaja=@NumeroCaja,
 IdColor=@IdColor,
 IdDetalleLiquidacionFlete=@IdDetalleLiquidacionFlete,
 IdUsuarioDioPorCumplidoLiquidacionFletes=@IdUsuarioDioPorCumplidoLiquidacionFletes,
 FechaDioPorCumplidoLiquidacionFletes=@FechaDioPorCumplidoLiquidacionFletes,
 ObservacionDioPorCumplidoLiquidacionFletes=@ObservacionDioPorCumplidoLiquidacionFletes,
 Talle=@Talle,
 IdProduccionTerminado=@IdProduccionTerminado
WHERE (IdDetalleRecepcion=@IdDetalleRecepcion)

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdDetalleRecepcion)