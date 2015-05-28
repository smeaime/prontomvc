CREATE Procedure [dbo].[DetRecepciones_A]

@IdDetalleRecepcion int  output,
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

DECLARE @Anulada varchar(2), @IdStock int, @ActivarSolicitudMateriales varchar(2), @IdDepositoCentral int, @IdDepositoRecepcion int, @AsignarPartidasAutomaticamente varchar(2), 
	@ProximoNumeroPartida int, @CostoReposicionPorComprobanteProveedor varchar(2), @IdUnidadEmpaque int, @NumeroUnidad1 int, @EmisionEtiquetasEnRecepcion varchar(2), 
	@Tara numeric(18,3), @PesoNeto numeric(18,2), @ModalidadTipoCompra varchar(2)

SET @AsignarPartidasAutomaticamente=IsNull((Select Top 1 Valor From Parametros2 Where Campo='AsignarPartidasAutomaticamente'),'NO')
SET @ProximoNumeroPartida=IsNull((Select Top 1 Valor From Parametros2 Where Campo='ProximoNumeroPartida'),1)
SET @CostoReposicionPorComprobanteProveedor=IsNull((Select Top 1 Valor From Parametros2 Where Campo='CostoReposicionPorComprobanteProveedor'),'SI')

SET @Anulada=IsNull((Select Top 1 Recepciones.Anulada From Recepciones Where Recepciones.IdRecepcion=@IdRecepcion),'NO')
SET @NumeroUnidad1=Null

IF @Anulada<>'SI' 
    BEGIN
	/* GENERACION DE UNIDAD DE EMPAQUE (CAJA) */
	SET @EmisionEtiquetasEnRecepcion=IsNull((Select Top 1 Valor From Parametros2 Where Campo='EmisionEtiquetasEnRecepcion'),'')
	IF @EmisionEtiquetasEnRecepcion='SI'
	    BEGIN
		SET @Tara=IsNull((Select Top 1 TaraEnKg From Unidades Where IdUnidad=@IdUnidad),0)
		SET @PesoNeto=@Cantidad-@Tara

		SET @NumeroUnidad1=IsNull((Select Top 1 Valor From Parametros2 Where Campo='ProximoNumeroCajaStock'),0)
		SET @NumeroCaja=@NumeroUnidad1

		UPDATE Parametros2
		SET Valor=Convert(varchar,@NumeroUnidad1+1)
		WHERE IsNull(Campo,'')='ProximoNumeroCajaStock'

		INSERT INTO [UnidadesEmpaque]
		(NumeroUnidad, IdArticulo, Partida, IdUnidad, PesoBruto, Tara, PesoNeto, IdUsuarioAlta, FechaAlta, IdUbicacion, IdColor, IdUnidadTipoCaja, EsDevolucion, IdDetalleRecepcion)
		VALUES
		(@NumeroUnidad1, @IdArticulo, @Partida, @IdUnidad, @Cantidad, @Tara, @PesoNeto, 0, GetDate(), @IdUbicacion, @IdColor, @IdUnidad, Null, 0)
		SELECT @IdUnidadEmpaque=@@identity
	    END

	/* ASIGNACION DE PARTIDA AUTOMATICA */
	IF @AsignarPartidasAutomaticamente='SI'
	    BEGIN
		SET @Partida=Convert(varchar,@ProximoNumeroPartida)

		UPDATE Parametros2
		SET Valor=Convert(varchar,@ProximoNumeroPartida+1)
		WHERE IsNull(Campo,'')='ProximoNumeroPartida'
	    END

	IF IsNull(@Controlado,'')='DI'
	    BEGIN
		SET @IdStock=IsNull((Select Top 1 Stock.IdStock From Stock 
					Where IdArticulo=@IdArticulo and Partida=@Partida and IdUbicacion=@IdUbicacion and IsNull(IdColor,0)=IsNull(@IdColor,0) and 
						IdObra=@IdObra and IdUnidad=@IdUnidad and IsNull(NumeroCaja,0)=IsNull(@NumeroUnidad1,0) and IsNull(Talle,'')=IsNull(@Talle,'')),0)
		IF @IdStock>0 
			UPDATE Stock
			SET CantidadUnidades=IsNull(CantidadUnidades,0)+@Cantidad
			WHERE IdStock=@IdStock
		ELSE
			INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdColor, IdObra, NumeroCaja, Talle)
			VALUES (@IdArticulo, @Partida, @Cantidad, Null, @IdUnidad, @IdUbicacion, @IdColor, @IdObra, @NumeroUnidad1, @Talle)
	    END

	SET @ActivarSolicitudMateriales=IsNull((Select Top 1 P.ActivarSolicitudMateriales From Parametros P Where P.IdParametro=1),'NO')
	SET @IdDepositoCentral=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='IdDepositoCentral'),0)
	SET @IdDepositoRecepcion=IsNull((Select Top 1 U.IdDeposito From Ubicaciones U Where U.IdUbicacion=@IdUbicacion),0)
	SET @ModalidadTipoCompra=IsNull((Select Top 1 TiposCompra.Modalidad From DetalleRequerimientos dr 
					 Left Outer Join Requerimientos On Requerimientos.IdRequerimiento=dr.IdRequerimiento
					 Left Outer Join TiposCompra On TiposCompra.IdTipoCompra=Requerimientos.IdTipoCompra
					 Where dr.IdDetalleRequerimiento=IsNull(@IdDetalleRequerimiento,0)),'')

	IF (@ActivarSolicitudMateriales='SI' or @ModalidadTipoCompra='CR') and IsNull(@IdDetalleRequerimiento,0)>0 
		IF @IdDepositoCentral>0 and @IdDepositoCentral<>@IdDepositoRecepcion
			UPDATE DetalleRequerimientos
			SET TipoDesignacion='CMP'
			WHERE IdDetalleRequerimiento=@IdDetalleRequerimiento and TipoDesignacion='CMP'
		ELSE
			UPDATE DetalleRequerimientos
			SET TipoDesignacion='REC'
			WHERE IdDetalleRequerimiento=@IdDetalleRequerimiento and TipoDesignacion='CMP'

	
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
    END

INSERT INTO [DetalleRecepciones]
(
 IdRecepcion,
 Cantidad,
 IdUnidad,
 IdArticulo,
 IdControlCalidad,
 Observaciones,
 Cantidad1,
 Cantidad2,
 IdDetallePedido,
 Controlado,
 CantidadAdicional,
 Partida,
 CantidadCC,
 Cantidad1CC,
 Cantidad2CC,
 CantidadAdicionalCC,
 ObservacionesCC,
 CantidadRechazadaCC,
 IdMotivoRechazo,
 IdRealizo,
 IdDetalleRequerimiento,
 Trasabilidad,
 IdDetalleAcopios,
 IdUbicacion,
 IdObra,
 CostoUnitario,
 IdMoneda,
 CotizacionDolar,
 CotizacionMoneda,
 EnviarEmail,
 IdDetalleRecepcionOriginal,
 IdRecepcionOriginal,
 IdOrigenTransmision,
 IdDetalleObraDestino,
 CantidadEnOrigen,
 IdDetalleSalidaMateriales,
 IdPresupuestoObrasNodo,
 CostoOriginal,
 IdUsuarioModificoCosto,
 FechaModificacionCosto,
 ObservacionModificacionCosto,
 IdMonedaOriginal,
 NumeroCaja,
 IdColor,
 IdDetalleLiquidacionFlete,
 IdUsuarioDioPorCumplidoLiquidacionFletes,
 FechaDioPorCumplidoLiquidacionFletes,
 ObservacionDioPorCumplidoLiquidacionFletes,
 Talle,
 IdProduccionTerminado
)
VALUES
(
 @IdRecepcion,
 @Cantidad,
 @IdUnidad,
 @IdArticulo,
 @IdControlCalidad,
 @Observaciones,
 @Cantidad1,
 @Cantidad2,
 @IdDetallePedido,
 @Controlado,
 @CantidadAdicional,
 @Partida,
 @CantidadCC,
 @Cantidad1CC,
 @Cantidad2CC,
 @CantidadAdicionalCC,
 @ObservacionesCC,
 @CantidadRechazadaCC,
 @IdMotivoRechazo,
 @IdRealizo,
 @IdDetalleRequerimiento,
 @Trasabilidad,
 @IdDetalleAcopios,
 @IdUbicacion,
 @IdObra,
 @CostoUnitario,
 @IdMoneda,
 @CotizacionDolar,
 @CotizacionMoneda,
 @EnviarEmail,
 @IdDetalleRecepcionOriginal,
 @IdRecepcionOriginal,
 @IdOrigenTransmision,
 @IdDetalleObraDestino,
 @CantidadEnOrigen,
 @IdDetalleSalidaMateriales,
 @IdPresupuestoObrasNodo,
 @CostoOriginal,
 @IdUsuarioModificoCosto,
 @FechaModificacionCosto,
 @ObservacionModificacionCosto,
 @IdMonedaOriginal,
 @NumeroCaja,
 @IdColor,
 @IdDetalleLiquidacionFlete,
 @IdUsuarioDioPorCumplidoLiquidacionFletes,
 @FechaDioPorCumplidoLiquidacionFletes,
 @ObservacionDioPorCumplidoLiquidacionFletes,
 @Talle,
 @IdProduccionTerminado
)

SELECT @IdDetalleRecepcion=@@identity

IF @EmisionEtiquetasEnRecepcion='SI'
	UPDATE UnidadesEmpaque
	SET IdDetalleRecepcion=@IdDetalleRecepcion
	WHERE IdUnidadEmpaque=@IdUnidadEmpaque

IF @IdProduccionTerminado is not null
	UPDATE ProduccionTerminados
	SET IdDetalleRecepcion=@IdDetalleRecepcion
	WHERE IdProduccionTerminado=@IdProduccionTerminado

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdDetalleRecepcion)