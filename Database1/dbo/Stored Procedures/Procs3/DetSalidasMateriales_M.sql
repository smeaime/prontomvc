CREATE Procedure [dbo].[DetSalidasMateriales_M]

@IdDetalleSalidaMateriales int,
@IdSalidaMateriales int,
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
@ArchivoAdjunto1 varchar(100),
@ArchivoAdjunto2 varchar(100),
@ArchivoAdjunto3 varchar(100),
@ArchivoAdjunto4 varchar(100),
@ArchivoAdjunto5 varchar(100),
@ArchivoAdjunto6 varchar(100),
@ArchivoAdjunto7 varchar(100),
@ArchivoAdjunto8 varchar(100),
@ArchivoAdjunto9 varchar(100),
@ArchivoAdjunto10 varchar(100),
@Observaciones ntext,
@IdUbicacion int,
@IdObra int,
@CostoUnitario numeric(18,4),
@IdMoneda int,
@CotizacionDolar numeric(18,4),
@CotizacionMoneda numeric(18,4),
@IdEquipoDestino int,
@EnviarEmail tinyint,
@IdDetalleSalidaMaterialesOriginal int,
@IdSalidaMaterialesOriginal int,
@IdOrigenTransmision int,
@DescargaPorKit varchar(2),
@FechaImputacion datetime,
@IdOrdenTrabajo int,
@IdDetalleObraDestino int,
@IdDetalleSalidaMaterialesPRONTOaSAT int,
@IdPresupuestoObraRubro int,
@IdCuenta int,
@IdCuentaGasto int,
@IdPresupuestoObrasNodo int,
@NumeroCaja int,
@IdUbicacionDestino int,
@IdFlete int,
@IdDetalleRecepcion int,
@CostoOriginal numeric(18,4),
@IdUsuarioModificoCosto int, 
@FechaModificacionCosto datetime, 
@ObservacionModificacionCosto ntext,
@IdMonedaOriginal int,
@IdDetalleProduccionOrden int,
@IdDetalleLiquidacionFlete int,
@IdUsuarioDioPorCumplidoLiquidacionFletes int,
@FechaDioPorCumplidoLiquidacionFletes datetime,
@ObservacionDioPorCumplidoLiquidacionFletes ntext,
@Talle varchar(2),
@IdColor int,
@IdPresupuestoObrasNodoFleteLarga int,
@IdPresupuestoObrasNodoFleteInterno int,
@CostoFleteLarga numeric(18,2),
@CostoFleteInterno numeric(18,2),
@IdUsuarioDioPorRecepcionado int,
@FechaDioPorRecepcionado datetime,
@ObservacionDioPorRecepcionado ntext,
@ImputarConsumoAObraActualEquipoMantenimiento varchar(2)

AS

BEGIN TRAN

DECLARE @IdStockAnt int, @IdArticuloAnt int, @PartidaAnt varchar(20), @CantidadUnidadesAnt numeric(18,2), @IdUnidadAnt int, @IdUbicacionAnt int, @IdObraAnt int, @IdStock1 int, @Anulada varchar(2), 
	@NumeroCajaAnt int, @IdUbicacionDestinoAnt int, @IdDepositoAux int, @IdObraAux int, @TomarObraCabecera varchar(2), @NumeroSalida varchar(20), @IdUbicacionDestino1 int, @IdAjusteStock int, 
	@IdDetalleAjusteStock int, @NumeroAjusteStock int, @IdUnidadStandar int, @GenerarConsumosAutomaticamente varchar(2), @TalleAnt varchar(2), @IdColorAnt int

SET @Anulada=IsNull((Select Top 1 Anulada From SalidasMateriales Where IdSalidaMateriales=@IdSalidaMateriales),'NO')
SET @GenerarConsumosAutomaticamente=IsNull((Select Top 1 GenerarConsumosAutomaticamente From Articulos Where IdArticulo=@IdArticulo),'SI')
SET @TomarObraCabecera=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
				Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
				Where pic.Clave='Descontar stock tomando obra cabecera en salida de materiales' and IsNull(ProntoIni.Valor,'')='SI'),'')
IF @TomarObraCabecera='SI'
	SET @IdObraAux=IsNull((Select Top 1 IsNull(IdObraOrigen,IdObra) From SalidasMateriales Where IdSalidaMateriales=@IdSalidaMateriales),@IdObra)
ELSE
	SET @IdObraAux=@IdObra
IF @IdObraAux=0
	SET @IdObraAux=@IdObra
SET @IdUbicacionDestino1=IsNull(@IdUbicacionDestino,0)

IF @Anulada<>'SI'
   BEGIN
	SET @IdArticuloAnt=IsNull((Select Top 1 IdArticulo From DetalleSalidasMateriales Where IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales),0)
	SET @PartidaAnt=IsNull((Select Top 1 Partida From DetalleSalidasMateriales Where IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales),'')
	SET @CantidadUnidadesAnt=IsNull((Select Top 1 Cantidad From DetalleSalidasMateriales Where IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales),0)
	SET @IdUnidadAnt=IsNull((Select Top 1 IdUnidad From DetalleSalidasMateriales Where IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales),0)
	SET @IdUbicacionAnt=IsNull((Select Top 1 IdUbicacion From DetalleSalidasMateriales Where IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales),0)
	SET @IdUbicacionDestinoAnt=IsNull((Select Top 1 IdUbicacionDestino From DetalleSalidasMateriales Where IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales),0)
	SET @IdObraAnt=IsNull((Select Top 1 IdObra From DetalleSalidasMateriales Where IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales),0)
	SET @TalleAnt=(Select Top 1 Talle From DetalleSalidasMateriales Where IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales)
	SET @IdColorAnt=IsNull((Select Top 1 IdColor From DetalleSalidasMateriales Where IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales),0)

	IF @TomarObraCabecera='SI'
		SET @IdObraAnt=IsNull((Select Top 1 IsNull(IdObraOrigen,IdObra) From SalidasMateriales Where IdSalidaMateriales=@IdSalidaMateriales),@IdObraAnt)
	SET @NumeroCajaAnt=(Select Top 1 NumeroCaja From DetalleSalidasMateriales Where IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales)

	IF IsNull(@DescargaPorKit,'NO')<>'SI' or IsNull(@IdUbicacionDestinoAnt,0)<>0 or IsNull(@IdUbicacionDestino,0)<>0
	   BEGIN
		SET @IdStockAnt=IsNull((Select Top 1 Stock.IdStock From Stock 
					Where IdArticulo=@IdArticuloAnt and Partida=@PartidaAnt and IdUbicacion=@IdUbicacionAnt and IdObra=@IdObraAnt and IdUnidad=@IdUnidadAnt and 
						IsNull(NumeroCaja,0)=IsNull(@NumeroCajaAnt,0) and IsNull(IdColor,0)=IsNull(@IdColorAnt,0) and IsNull(Talle,'')=IsNull(@TalleAnt,'')),0)
		IF @IdStockAnt>0 
			UPDATE Stock
			SET CantidadUnidades=IsNull(CantidadUnidades,0)+@CantidadUnidadesAnt
			WHERE IdStock=@IdStockAnt
		ELSE
			INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra, NumeroCaja, IdColor, Talle)
			VALUES (@IdArticuloAnt, @PartidaAnt, @CantidadUnidadesAnt, Null, @IdUnidadAnt, @IdUbicacionAnt, @IdObraAnt, @NumeroCajaAnt, @IdColorAnt, @TalleAnt)

		IF @IdUbicacionDestinoAnt<>0
		   BEGIN
			SET @IdDepositoAux=IsNull((Select Top 1 IdDeposito From Ubicaciones Where IdUbicacion=@IdUbicacionDestinoAnt),0)
			SET @IdStockAnt=IsNull((Select Top 1 Stock.IdStock From Stock 
						Where IdArticulo=@IdArticuloAnt and Partida=@PartidaAnt and IdUbicacion=@IdUbicacionDestinoAnt and IdObra=@IdObraAux and IdUnidad=@IdUnidadAnt and 
							IsNull(NumeroCaja,0)=IsNull(@NumeroCajaAnt,0) and IsNull(IdColor,0)=IsNull(@IdColorAnt,0) and IsNull(Talle,'')=IsNull(@TalleAnt,'')),0)
			IF @IdStockAnt>0 
				UPDATE Stock
				SET CantidadUnidades=IsNull(CantidadUnidades,0)-@CantidadUnidadesAnt
				WHERE IdStock=@IdStockAnt
			ELSE
				INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra, NumeroCaja, IdColor, Talle)
				VALUES (@IdArticuloAnt, @PartidaAnt, @CantidadUnidadesAnt*-1, Null, @IdUnidadAnt, @IdUbicacionDestinoAnt, @IdObraAux, @NumeroCajaAnt, @IdColorAnt, @TalleAnt)
		   END

		SET @IdStock1=IsNull((Select Top 1 Stock.IdStock From Stock 
					Where IdArticulo=@IdArticulo and Partida=@Partida and IdUbicacion=@IdUbicacion and IdObra=@IdObraAux and IdUnidad=@IdUnidad and 
						IsNull(NumeroCaja,0)=IsNull(@NumeroCaja,0) and IsNull(IdColor,0)=IsNull(@IdColor,0) and IsNull(Talle,'')=IsNull(@Talle,'')),0)
		IF @IdStock1>0 
			UPDATE Stock
			SET CantidadUnidades=IsNull(CantidadUnidades,0)-@Cantidad
			WHERE IdStock=@IdStock1
		ELSE
			INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra, NumeroCaja, IdColor, Talle)
			VALUES (@IdArticulo, @Partida, @Cantidad*-1, Null, @IdUnidad, @IdUbicacion, @IdObraAux, @NumeroCaja, @IdColor, @Talle)

		IF @IdUbicacionDestino1<>0
		   BEGIN
			SET @IdDepositoAux=IsNull((Select Top 1 IdDeposito From Ubicaciones Where IdUbicacion=@IdUbicacionDestino1),0)
			SET @IdStock1=IsNull((Select Top 1 Stock.IdStock From Stock 
						Where IdArticulo=@IdArticulo and Partida=@Partida and IdUbicacion=@IdUbicacionDestino1 and IdObra=@IdObraAux and IdUnidad=@IdUnidad and 
							IsNull(NumeroCaja,0)=IsNull(@NumeroCaja,0) and IsNull(IdColor,0)=IsNull(@IdColor,0) and IsNull(Talle,'')=IsNull(@Talle,'')),0)
			IF @IdStock1>0 
				UPDATE Stock
				SET CantidadUnidades=IsNull(CantidadUnidades,0)+@Cantidad
				WHERE IdStock=@IdStock1
			ELSE
				INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra, NumeroCaja, IdColor, Talle)
				VALUES (@IdArticulo, @Partida, @Cantidad, Null, @IdUnidad, @IdUbicacionDestino1, @IdObraAux, @NumeroCaja, @IdColor, @Talle)
		   END

	   END
	ELSE
	   BEGIN
		SET NOCOUNT ON
		DECLARE @IdArticuloConjunto int, @IdUnidadConjunto int, @CantidadConjunto numeric(18,3), @CantidadProducto numeric(18,3), @Equivalencia numeric(18,6)

		SET @IdUnidadStandar=IsNull((Select Top 1 IdUnidad From Articulos Where IdArticulo=@IdArticulo),@IdUnidad)

		CREATE TABLE #Auxiliar1 (IdArticuloConjunto INTEGER, IdUnidadConjunto INTEGER, CantidadConjunto NUMERIC(18,3))
		INSERT INTO #Auxiliar1 
		 SELECT dc.IdArticulo, dc.IdUnidad, IsNull(dc.Cantidad,0)
		 FROM DetalleConjuntos dc
		 LEFT OUTER JOIN Conjuntos ON dc.IdConjunto = Conjuntos.IdConjunto
		 WHERE (Conjuntos.IdArticulo = @IdArticuloAnt)

		CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdArticuloConjunto) ON [PRIMARY]
		DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdArticuloConjunto, IdUnidadConjunto, CantidadConjunto FROM #Auxiliar1 ORDER BY IdArticuloConjunto
		OPEN Cur
		FETCH NEXT FROM Cur INTO @IdArticuloConjunto, @IdUnidadConjunto, @CantidadConjunto
		WHILE @@FETCH_STATUS = 0
		   BEGIN
			IF @IdUnidadAnt=@IdUnidadStandar
			   BEGIN
				SET @CantidadProducto=@Cantidad
			   END
			ELSE
			   BEGIN
				SET @Equivalencia=IsNull((Select Top 1 Equivalencia From DetalleArticulosUnidades Where IdArticulo=@IdArticulo and IdUnidad=@IdUnidadAnt),1)
				SET @CantidadProducto=@Cantidad
				IF @Equivalencia<>0
					SET @CantidadProducto=@Cantidad/@Equivalencia
			   END

			SET @IdStock1=IsNull((Select Top 1 Stock.IdStock From Stock 
						Where IdArticulo=@IdArticuloConjunto and Partida='' and IdUbicacion=@IdUbicacion and IdObra=@IdObraAux and IdUnidad=@IdUnidadConjunto),0)
			IF @IdStock1>0 
				UPDATE Stock
				SET CantidadUnidades=IsNull(CantidadUnidades,0)+(@CantidadProducto*@CantidadConjunto)
				WHERE IdStock=@IdStock1
			ELSE
				INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra)
				VALUES (@IdArticuloConjunto, 0, (@CantidadProducto*@CantidadConjunto), Null, @IdUnidadConjunto, @IdUbicacion, @IdObraAux)
			FETCH NEXT FROM Cur INTO @IdArticuloConjunto, @IdUnidadConjunto, @CantidadConjunto
		   END
		CLOSE Cur
		DEALLOCATE Cur
		DROP TABLE #Auxiliar1
		CREATE TABLE #Auxiliar2 (IdArticuloConjunto INTEGER, IdUnidadConjunto INTEGER, CantidadConjunto NUMERIC(18,3))
		INSERT INTO #Auxiliar2 
		 SELECT dc.IdArticulo, dc.IdUnidad, IsNull(dc.Cantidad,0)
		 FROM DetalleConjuntos dc
		 LEFT OUTER JOIN Conjuntos ON dc.IdConjunto = Conjuntos.IdConjunto
		 WHERE (Conjuntos.IdArticulo = @IdArticulo)

		CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdArticuloConjunto) ON [PRIMARY]
		DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
			FOR SELECT IdArticuloConjunto, IdUnidadConjunto, CantidadConjunto FROM #Auxiliar2 ORDER BY IdArticuloConjunto
		OPEN Cur
		FETCH NEXT FROM Cur INTO @IdArticuloConjunto, @IdUnidadConjunto, @CantidadConjunto
		WHILE @@FETCH_STATUS = 0
		   BEGIN
			IF @IdUnidad=@IdUnidadStandar
			   BEGIN
				SET @CantidadProducto=@Cantidad
			   END
			ELSE
			   BEGIN
				SET @Equivalencia=IsNull((Select Top 1 Equivalencia From DetalleArticulosUnidades Where IdArticulo=@IdArticulo and IdUnidad=@IdUnidad),1)
				SET @CantidadProducto=@Cantidad
				IF @Equivalencia<>0
					SET @CantidadProducto=@Cantidad/@Equivalencia
			   END

			SET @IdStock1=IsNull((Select Top 1 Stock.IdStock From Stock 
						Where IdArticulo=@IdArticuloConjunto and Partida='' and IdUbicacion=@IdUbicacion and IdObra=@IdObraAux and IdUnidad=@IdUnidadConjunto),0)
			IF @IdStock1>0 
				UPDATE Stock
				SET CantidadUnidades=IsNull(CantidadUnidades,0)-(@CantidadProducto*@CantidadConjunto)
				WHERE IdStock=@IdStock1
			ELSE
				INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra)
				VALUES (@IdArticuloConjunto, 0, (@CantidadProducto*@CantidadConjunto)*-1, Null, @IdUnidadConjunto, @IdUbicacion, @IdObraAux)
			FETCH NEXT FROM Cur INTO @IdArticuloConjunto, @IdUnidadConjunto, @CantidadConjunto
		   END
		CLOSE Cur
		DEALLOCATE Cur
		DROP TABLE #Auxiliar2
		SET NOCOUNT OFF
	   END
   END

UPDATE [DetalleSalidasMateriales]
SET 
 IdSalidaMateriales=@IdSalidaMateriales,
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
 ArchivoAdjunto1=@ArchivoAdjunto1,
 ArchivoAdjunto2=@ArchivoAdjunto2,
 ArchivoAdjunto3=@ArchivoAdjunto3,
 ArchivoAdjunto4=@ArchivoAdjunto4,
 ArchivoAdjunto5=@ArchivoAdjunto5,
 ArchivoAdjunto6=@ArchivoAdjunto6,
 ArchivoAdjunto7=@ArchivoAdjunto7,
 ArchivoAdjunto8=@ArchivoAdjunto8,
 ArchivoAdjunto9=@ArchivoAdjunto9,
 ArchivoAdjunto10=@ArchivoAdjunto10,
 Observaciones=@Observaciones,
 IdUbicacion=@IdUbicacion,
 IdObra=@IdObra,
 CostoUnitario=@CostoUnitario,
 IdMoneda=@IdMoneda,
 CotizacionDolar=@CotizacionDolar,
 CotizacionMoneda=@CotizacionMoneda,
 IdEquipoDestino=@IdEquipoDestino,
 EnviarEmail=@EnviarEmail,
 IdDetalleSalidaMaterialesOriginal=@IdDetalleSalidaMaterialesOriginal,
 IdSalidaMaterialesOriginal=@IdSalidaMaterialesOriginal,
 IdOrigenTransmision=@IdOrigenTransmision,
 DescargaPorKit=@DescargaPorKit,
 FechaImputacion=@FechaImputacion,
 IdOrdenTrabajo=@IdOrdenTrabajo,
 IdDetalleObraDestino=@IdDetalleObraDestino,
 IdDetalleSalidaMaterialesPRONTOaSAT=@IdDetalleSalidaMaterialesPRONTOaSAT,
 IdPresupuestoObraRubro=@IdPresupuestoObraRubro,
 IdCuenta=@IdCuenta,
 IdCuentaGasto=@IdCuentaGasto,
 IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo,
 NumeroCaja=@NumeroCaja,
 IdUbicacionDestino=@IdUbicacionDestino,
 IdFlete=@IdFlete,
 IdDetalleRecepcion=@IdDetalleRecepcion,
 CostoOriginal=@CostoOriginal,
 IdUsuarioModificoCosto=@IdUsuarioModificoCosto,
 FechaModificacionCosto=@FechaModificacionCosto,
 ObservacionModificacionCosto=@ObservacionModificacionCosto,
 IdMonedaOriginal=@IdMonedaOriginal,
 IdDetalleProduccionOrden=@IdDetalleProduccionOrden,
 IdDetalleLiquidacionFlete=@IdDetalleLiquidacionFlete,
 IdUsuarioDioPorCumplidoLiquidacionFletes=@IdUsuarioDioPorCumplidoLiquidacionFletes,
 FechaDioPorCumplidoLiquidacionFletes=@FechaDioPorCumplidoLiquidacionFletes,
 ObservacionDioPorCumplidoLiquidacionFletes=@ObservacionDioPorCumplidoLiquidacionFletes,
 Talle=@Talle,
 IdColor=@IdColor,
 IdPresupuestoObrasNodoFleteLarga=@IdPresupuestoObrasNodoFleteLarga,
 IdPresupuestoObrasNodoFleteInterno=@IdPresupuestoObrasNodoFleteInterno,
 CostoFleteLarga=@CostoFleteLarga,
 CostoFleteInterno=@CostoFleteInterno,
 IdUsuarioDioPorRecepcionado=@IdUsuarioDioPorRecepcionado,
 FechaDioPorRecepcionado=@FechaDioPorRecepcionado,
 ObservacionDioPorRecepcionado=@ObservacionDioPorRecepcionado,
 ImputarConsumoAObraActualEquipoMantenimiento=@ImputarConsumoAObraActualEquipoMantenimiento
WHERE (IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales)

DECLARE @BasePRONTOMANT varchar(50)

SET @BasePRONTOMANT=IsNull((Select Top 1 BasePRONTOMantenimiento From Parametros Where IdParametro=1),'')

IF @IdEquipoDestino is Not null and DB_ID(@BasePRONTOMANT) is not null and @GenerarConsumosAutomaticamente<>'NO'
  BEGIN
	SET NOCOUNT ON
	DECLARE @sql1 nvarchar(4000), @sql2 nvarchar(4000), @IdEquipo int, @IdConsumibleParametro int, @IdConsumible int, 
			@Articulo varchar(300), @IdUnidadConsumible int, @IdConsumo int, @NumeroObra varchar(30), @IdObraMantenimiento int, @IdObraActualEquipo int, 
			@ObservacionesRM varchar(2500), @IdDetalleRequerimiento int, @IdObraCabecera int, @IdDetalleConsumo int, 
			@FacturarConsumosAObra varchar(2), @NumeroConsumo int, @NumeroSalidaMaterialesPRONTO int, @FechaSalidaMateriales datetime, 
			@IdDetalleOrdenTrabajoConsumo int, @IdDetalleOrdenTrabajo int, @IdFalla int, @IdUsuario int, @Usuario varchar(30), @ObraDestino varchar(30)

	SET @FacturarConsumosAObra=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='FacturarConsumosAObra'),'NO')
	SET @IdObraCabecera=IsNull((Select Top 1 Case When IsNull(IdObra,0)>0 Then IdObra Else IdObraOrigen End From SalidasMateriales Where IdSalidaMateriales=@IdSalidaMateriales),0)
	SET @IdEquipo=@IdEquipoDestino
	SET @IdConsumibleParametro=IsNull((Select Top 1 IdArticuloPRONTO_MANTENIMIENTO From Parametros Where IdParametro=1),0)
	SET @IdConsumible=IsNull((Select Top 1 TiposRosca.IdArticuloPRONTO_MANTENIMIENTO From Articulos
							  Left Outer Join TiposRosca On Articulos.IdTipoRosca=TiposRosca.IdTipoRosca
							  Where Articulos.IdArticulo=@IdArticulo),@IdConsumibleParametro)
	SET @Articulo=IsNull((Select Top 1 Descripcion From Articulos Where Articulos.IdArticulo=@IdArticulo),'S/D')
	SET @NumeroObra=IsNull((Select Top 1 NumeroObra From Obras Where Obras.IdObra=@IdObraCabecera),'S/D')
	SET @ObraDestino=IsNull((Select Top 1 Substring(NumeroObra+' '+IsNull(Descripcion,''),1,30) From Obras Where Obras.IdObra=@IdObraCabecera),'S/D')
	SET @NumeroSalidaMaterialesPRONTO=IsNull((Select Top 1 NumeroSalidaMateriales From SalidasMateriales Where IdSalidaMateriales=@IdSalidaMateriales),1)
	SET @FechaSalidaMateriales=IsNull((Select Top 1 FechaSalidaMateriales From SalidasMateriales Where IdSalidaMateriales=@IdSalidaMateriales),GetDate())
	SET @IdUsuario=IsNull((Select Top 1 IsNull(S.IdUsuarioModifico,S.IdUsuarioIngreso) From SalidasMateriales S Where S.IdSalidaMateriales=@IdSalidaMateriales),0)
	SET @Usuario=Substring(IsNull((Select Top 1 E.Nombre From Empleados E Where E.IdEmpleado=@IdUsuario),''),1,30)

	CREATE TABLE #Auxiliar3 (IdAux INTEGER)

	SET @sql1='Select Top 1 Art.IdUnidad From '+@BasePRONTOMANT+'.dbo.Articulos Art Where Art.IdArticulo='+Convert(varchar,@IdConsumible)
	TRUNCATE TABLE #Auxiliar3
	INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
	SET @IdUnidadConsumible=IsNull((Select Top 1 IdAux From #Auxiliar3),0)

	SET @sql1='Select Top 1 Art.IdObraActual From '+@BasePRONTOMANT+'.dbo.Articulos Art Where Art.IdArticulo='+Convert(varchar,@IdConsumible)
	TRUNCATE TABLE #Auxiliar3
	INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
	SET @IdObraActualEquipo=IsNull((Select Top 1 IdAux From #Auxiliar3),0)

	SET @sql1='Select Top 1 Ob.IdObra From '+@BasePRONTOMANT+'.dbo.Obras Ob Where Ob.NumeroObra='+''''+@NumeroObra+''''
	TRUNCATE TABLE #Auxiliar3
	INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
	SET @IdObraMantenimiento=IsNull((Select Top 1 IdAux From #Auxiliar3),0)

	IF IsNull(@ImputarConsumoAObraActualEquipoMantenimiento,'')='SI' and @IdObraActualEquipo>0
		SET @IdObraMantenimiento=@IdObraActualEquipo

	IF @IdOrdenTrabajo is null
	  BEGIN
		SET @IdDetalleRequerimiento=IsNull((Select Top 1 IdDetalleRequerimiento From DetalleValesSalida Where IdDetalleValeSalida=@IdDetalleValeSalida),0)
		SET @ObservacionesRM=@Articulo
		SET @ObservacionesRM=@ObservacionesRM + ' ' + 
			IsNull(Char(10) + 'Obs.RM: '+
				(Select Top 1 Convert(varchar(1000),IsNull(Det.Observaciones,'')) 
				 From DetalleRequerimientos Det 
				 Where Det.IdDetalleRequerimiento=@IdDetalleRequerimiento),'')
		IF Len(Ltrim(Convert(varchar(1000),@Observaciones)))>0 
			SET @ObservacionesRM=@ObservacionesRM + ' ' + IsNull(Char(10) + 'Obs.Salida: '+Convert(varchar(1000),@Observaciones),'')

		SET @sql1='Delete '+@BasePRONTOMANT+'.dbo.DetalleOrdenesTrabajoConsumos Where IsNull(IdDetalleSalidaMaterialesPRONTO,-1)='+Convert(varchar,@IdDetalleSalidaMateriales)
		EXEC sp_executesql @sql1

		SET @sql1='Select Top 1 con.IdConsumo From '+@BasePRONTOMANT+'.dbo.Consumos con 
					Where IsNull(con.IdSalidaMaterialesPRONTO,0)='+Convert(varchar,@IdSalidaMateriales)+' and con.BDOrigenSalidaPRONTO='+''''+DB_NAME()+''''
		TRUNCATE TABLE #Auxiliar3
		INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
		SET @IdConsumo=IsNull((Select Top 1 IdAux From #Auxiliar3),0)

		IF @IdConsumo=0
		  BEGIN
			SET @sql1='Select Top 1 Par.ProximoConsumo From '+@BasePRONTOMANT+'.dbo.Parametros Par Where Par.IdParametro=1'
			TRUNCATE TABLE #Auxiliar3
			INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
			SET @NumeroConsumo=IsNull((Select Top 1 IdAux From #Auxiliar3),1)
			SET @sql1='Insert Into '+@BasePRONTOMANT+'.dbo.Consumos 
						(NumeroConsumo, FechaConsumo, IdObra, FechaImportacion, IdSalidaMaterialesPRONTO, NumeroSalidaMaterialesPRONTO, BDOrigenSalidaPRONTO)
						Values 
						('+Convert(varchar,@NumeroConsumo)+', 
						 Convert(datetime,'''+Convert(varchar,IsNull(@FechaImputacion,@FechaSalidaMateriales),103)+''',103), 
						 '+Convert(varchar,@IdObraMantenimiento)+', 
						 Convert(datetime,'''+Convert(varchar,GetDate(),103)+''',103), 
						 '+Convert(varchar,@IdSalidaMateriales)+', 
						 '+Convert(varchar,@NumeroSalidaMaterialesPRONTO)+','+''''+DB_NAME()+''')
						Select @@identity'
			TRUNCATE TABLE #Auxiliar3
			INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
			SET @IdConsumo=IsNull((Select Top 1 IdAux From #Auxiliar3),0)

			SET @NumeroConsumo=@NumeroConsumo+1
			SET @sql1='Update '+@BasePRONTOMANT+'.dbo.Parametros 
						Set ProximoConsumo='+Convert(varchar,@NumeroConsumo)+' 
						Where IdParametro=1'
			EXEC sp_executesql @sql1
		  END

		SET @sql1='Select Top 1 det.IdDetalleConsumo From '+@BasePRONTOMANT+'.dbo.DetalleConsumos det 
					Where IsNull(det.IdDetalleSalidaMaterialesPRONTO,0)='+Convert(varchar,@IdDetalleSalidaMateriales)+' and det.BDOrigenSalidaPRONTO='+''''+DB_NAME()+''''
		TRUNCATE TABLE #Auxiliar3
		INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
		SET @IdDetalleConsumo=IsNull((Select Top 1 IdAux From #Auxiliar3),0)

		IF @IdDetalleConsumo=0
		  BEGIN
			SET @sql2='Insert Into '+@BasePRONTOMANT+'.dbo.DetalleConsumos 
						(IdConsumo, IdConsumible, Cantidad, IdUnidadConsumible, Costo, 
						 Observaciones, IdArticulo, FechaImportacion, IdDetalleSalidaMaterialesPRONTO, 
						 BDOrigenSalidaPRONTO, Detalle1, Detalle2, IdObraAFacturar)
						Values 
						('+Convert(varchar,@IdConsumo)+', '+Convert(varchar,@IdConsumible)+', 
						 '+Convert(varchar,@Cantidad)+', '+Convert(varchar,@IdUnidadConsumible)+', 
						 '+Convert(varchar,IsNull(@CostoUnitario,0))+' * '+Convert(varchar,IsNull(@CotizacionMoneda,1))+' , 
						 '''+@ObservacionesRM+''', '+Convert(varchar,@IdEquipo)+', 
						 Convert(datetime,'''+Convert(varchar,GetDate(),103)+''',103), 
						 '+Convert(varchar,@IdDetalleSalidaMateriales)+', 
						 '+''''+DB_NAME()+''', '+''''+@ObraDestino+''''+', '+''''+@Usuario++''''+', '+
						 Case When @FacturarConsumosAObra='NO' Then 'Null' Else Convert(varchar,@IdObraMantenimiento) End+')'
			EXEC sp_executesql @sql2
		  END
		ELSE
			SET @sql1='Update '+@BasePRONTOMANT+'.dbo.DetalleConsumos 
						Set 
						 IdConsumible='+Convert(varchar,@IdConsumible)+', 
						 Cantidad='+Convert(varchar,@Cantidad)+', 
						 IdUnidadConsumible='+Convert(varchar,@IdUnidadConsumible)+', 
						 Costo='+Convert(varchar,@CostoUnitario)+' * '+Convert(varchar,IsNull(@CotizacionMoneda,1))+' , 
						 Observaciones='''+@ObservacionesRM+''', 
						 Detalle1='''+@ObraDestino+''', 
						 Detalle2='''+@Usuario+''', 
						 IdArticulo='+Convert(varchar,@IdEquipo)+' 
						Where IdDetalleSalidaMaterialesPRONTO='+Convert(varchar,@IdDetalleSalidaMateriales)
			EXEC sp_executesql @sql1
	  END

	ELSE

	  BEGIN
		SET @sql1='Delete '+@BasePRONTOMANT+'.dbo.DetalleConsumos 
					Where IsNull(IdDetalleSalidaMaterialesPRONTO,-1)='+
					Convert(varchar,@IdDetalleSalidaMateriales)+' and BDOrigenSalidaPRONTO='+''''+DB_NAME()+''''
		EXEC sp_executesql @sql1

		SET @sql1='Select Top 1 Det.IdDetalleOrdenTrabajoConsumo 
					From '+@BasePRONTOMANT+'.dbo.DetalleOrdenesTrabajoConsumos Det 
					Where Det.IdDetalleSalidaMaterialesPRONTO='+Convert(varchar,@IdDetalleSalidaMateriales)
		TRUNCATE TABLE #Auxiliar3
		INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
		SET @IdDetalleOrdenTrabajoConsumo=IsNull((Select Top 1 IdAux From #Auxiliar3),0)

		SET @ObservacionesRM=@Articulo
		IF Len(Ltrim(Convert(varchar(1000),@Observaciones)))>0 
			SET @ObservacionesRM=@ObservacionesRM + ' ' + IsNull(Char(10) + 'Obs.Salida: '+Convert(varchar(1000),@Observaciones),'')

		IF @IdDetalleOrdenTrabajoConsumo<>0
		  BEGIN
			SET @sql1='Update '+@BasePRONTOMANT+'.dbo.DetalleOrdenesTrabajoConsumos 
						Set 
						 IdArticulo='+Convert(varchar,@IdConsumible)+', 
						 Cantidad='+Convert(varchar,@Cantidad)+', 
						 IdUnidad='+Convert(varchar,@IdUnidadConsumible)+', 
						 Costo='+Convert(varchar,IsNull(@CostoUnitario,0))+' * '+Convert(varchar,IsNull(@CotizacionMoneda,1))+' , 
						 Observaciones='''+@ObservacionesRM+''', 
						 IdObra='+Convert(varchar,@IdObraMantenimiento)+' 
						Where IdDetalleSalidaMaterialesPRONTO='+Convert(varchar,@IdDetalleSalidaMateriales)
			EXEC sp_executesql @sql1
		  END
		ELSE
		  BEGIN
			SET @sql1='Select Top 1 Det.IdDetalleOrdenTrabajo From '+@BasePRONTOMANT+'.dbo.DetalleOrdenesTrabajo Det 
						Where Det.IdOrdenTrabajo='+Convert(varchar,@IdOrdenTrabajo)+' and 
						IsNull(Det.FechaEstimada,Det.FechaEjecucion)=Convert(datetime,'''+Convert(varchar,IsNull(@FechaImputacion,@FechaSalidaMateriales),103)+''',103)'
			TRUNCATE TABLE #Auxiliar3
			INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
			SET @IdDetalleOrdenTrabajo=IsNull((Select Top 1 IdAux From #Auxiliar3),0)

			IF @IdDetalleOrdenTrabajo=0
			  BEGIN
				SET @sql1='Select Top 1 Det.IdFalla From '+@BasePRONTOMANT+'.dbo.DetalleOrdenesTrabajo Det 
							Where Det.IdOrdenTrabajo='+Convert(varchar,@IdOrdenTrabajo)
				TRUNCATE TABLE #Auxiliar3
				INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
				SET @IdFalla=IsNull((Select Top 1 IdAux From #Auxiliar3),0)
	
				SET @sql1='Insert Into '+@BasePRONTOMANT+'.dbo.DetalleOrdenesTrabajo 
							(IdOrdenTrabajo, FechaEjecucion, IdFalla)
							Values 
							('+Convert(varchar,@IdOrdenTrabajo)+', 
							 Convert(datetime,'''+Convert(varchar,IsNull(@FechaImputacion,@FechaSalidaMateriales),103)+''',103), 
							 '+Convert(varchar,@IdFalla)+') 
							Select @@identity'
				TRUNCATE TABLE #Auxiliar3
				INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
				SET @IdDetalleOrdenTrabajo=IsNull((Select Top 1 IdAux From #Auxiliar3),0)
			  END

			SET @sql1='Insert Into '+@BasePRONTOMANT+'.dbo.DetalleOrdenesTrabajoConsumos 
						(IdDetalleOrdenTrabajo, IdArticulo, Cantidad, IdUnidad, Costo, Observaciones, IdDetalleSalidaMaterialesPRONTO, IdObra)
						Values 
						('+Convert(varchar,@IdDetalleOrdenTrabajo)+', 
						 '+Convert(varchar,@IdConsumible)+', 
						 '+Convert(varchar,@Cantidad)+', 
						 '+Convert(varchar,@IdUnidadConsumible)+', 
						 '+Convert(varchar,IsNull(@CostoUnitario,0))+' * '+Convert(varchar,IsNull(@CotizacionMoneda,1))+' , 
						 '''+@ObservacionesRM+''', '+Convert(varchar,@IdDetalleSalidaMateriales)+', 
						 '+Convert(varchar,@IdObraMantenimiento)+')'
			EXEC sp_executesql @sql1
		  END
	  END
	DROP TABLE #Auxiliar3
	SET NOCOUNT OFF
  END

IF IsNull((Select Top 1 SalidaADepositoEnTransito From SalidasMateriales 
			Where IdSalidaMateriales=@IdSalidaMateriales),'NO')='SI' and 
				Exists(Select Top 1 IdObra From ArchivosATransmitirDestinos 
						Where IsNull(Activo,'SI')='SI' and IsNull(Sistema,'')='SAT' and IdObra=@IdObra) and Not Exists(Select Top 1 IdOtroIngresoAlmacen From DetalleOtrosIngresosAlmacen Where IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales)
  BEGIN
	DECLARE @IdOtroIngresoAlmacen int, @IdUbicacionStockEnTransito int

	SET @IdOtroIngresoAlmacen=IsNull((Select Top 1 IdOtroIngresoAlmacen From OtrosIngresosAlmacen Where IdSalidaMateriales=@IdSalidaMateriales),0)
	SET @IdUbicacionStockEnTransito=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdUbicacionStockEnTransito'),0)

	EXEC DetOtrosIngresosAlmacen_A 0, @IdOtroIngresoAlmacen, @IdArticulo, @IdStock, @Partida, @Cantidad, 0, @IdUnidad, Null, Null, 
		'NO', Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, @IdUbicacionStockEnTransito, @IdObra, Null,  Null,  
		Null,  Null, @CostoUnitario, @IdMoneda, Null, Null, @Cantidad, 0, @IdDetalleSalidaMateriales, @IdEquipoDestino, @IdOrdenTrabajo
  END

IF @IdUbicacionDestinoAnt<>0
  BEGIN
	SET @IdDetalleAjusteStock=IsNull((Select Top 1 IdDetalleAjusteStock From DetalleAjustesStock Where IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales),0)
	IF @IdDetalleAjusteStock=0
		UPDATE DetalleAjustesStock
		SET CantidadUnidades=0
		WHERE IdDetalleAjusteStock=@IdDetalleAjusteStock
  END

IF @IdUbicacionDestino1<>0
  BEGIN
	SET @IdAjusteStock=IsNull((Select Top 1 IdAjusteStock From AjustesStock Where IdSalidaMateriales=@IdSalidaMateriales),0)
	IF @IdAjusteStock=0
	  BEGIN
		SET @NumeroSalida=IsNull((Select Top 1 Substring('0000',1,4-Len(Convert(varchar,IsNull(NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(NumeroSalidaMateriales2,0))+'-'+
									Substring('00000000',1,8-Len(Convert(varchar,NumeroSalidaMateriales)))+Convert(varchar,NumeroSalidaMateriales) 
									From SalidasMateriales Where IdSalidaMateriales=@IdSalidaMateriales),'')
		SET @NumeroAjusteStock=IsNull((Select Top 1 ProximoNumeroAjusteStock From Parametros Where IdParametro=1),1)
		UPDATE Parametros
		SET ProximoNumeroAjusteStock=@NumeroAjusteStock+1
		WHERE IdParametro=1

		INSERT INTO AjustesStock
		(NumeroAjusteStock, FechaAjuste, TipoAjuste, FechaIngreso, IdSalidaMateriales, Observaciones)
		VALUES
		(@NumeroAjusteStock, Convert(datetime,Convert(varchar,Day(GetDate()))+'/'+Convert(varchar,Month(GetDate()))+'/'+Convert(varchar,Year(GetDate())),103), 'N', GetDate(), @IdSalidaMateriales, 'Ajuste generado desde salida '+@NumeroSalida)
		SET @IdAjusteStock=@@identity
	  END

	SET @IdDetalleAjusteStock=IsNull((Select Top 1 IdDetalleAjusteStock From DetalleAjustesStock Where IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales),0)
	IF @IdDetalleAjusteStock=0
		INSERT INTO [DetalleAjustesStock]
		(IdAjusteStock, IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, Cantidad1, Cantidad2, IdUbicacion, IdObra, IdDetalleSalidaMateriales, NumeroCaja, IdColor, Talle)
		VALUES 
		(@IdAjusteStock, @IdArticulo, @Partida, @Cantidad, @CantidadAdicional, @IdUnidad, @Cantidad1, @Cantidad2, @IdUbicacionDestino1, @IdObraAux, @IdDetalleSalidaMateriales, @NumeroCaja, @IdColor, @Talle)
	ELSE
		UPDATE DetalleAjustesStock
		SET CantidadUnidades=@Cantidad
		WHERE IdDetalleAjusteStock=@IdDetalleAjusteStock
  END

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdDetalleSalidaMateriales)