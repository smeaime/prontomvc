CREATE Procedure [dbo].[DetSalidasMateriales_A]

@IdDetalleSalidaMateriales int  output,
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

DECLARE @Anulada varchar(2), @IdStock1 int, @IdDepositoAux int, @IdObraAux int, @IdObraAux1 int, @TomarObraCabecera varchar(2), @IdProduccionOrden int, @IdDepositoIntermedio int, 
		@IdAjusteStock int, @NumeroAjusteStock int, @NumeroSalida varchar(20), @BasePRONTOMANT varchar(50), @IdUbicacionDestino1 int, @IdUnidadStandar int, @IdDetalleSalidaMaterialesPresupuestosObras int, 
		@GenerarConsumosAutomaticamente varchar(2), @IdConjunto int, @NumeroParteProduccion int, @IdPesada int, @IdTarifaFlete int, @TarifaFlete numeric(18,2), @IdSalidaMateriales1 int, @IdObraPlanta int, 
		@IdObraAuxiliarDeColocacion int, @IdObraAuxiliarDeMateriales int, @IdPresupuestoObrasNodoElaboracionColocacion int, @IdPresupuestoObrasNodoMateriales int, @IdNodoPadre int

SET @BasePRONTOMANT=IsNull((Select Top 1 BasePRONTOMantenimiento From Parametros Where IdParametro=1),'')
SET @Anulada=IsNull((Select Top 1 Anulada From SalidasMateriales Where IdSalidaMateriales=@IdSalidaMateriales),'NO')
SET @IdProduccionOrden=IsNull((Select Top 1 IdProduccionOrden From SalidasMateriales Where IdSalidaMateriales=@IdSalidaMateriales),0)
SET @IdDepositoIntermedio=IsNull((Select Top 1 IdDepositoIntermedio From SalidasMateriales Where IdSalidaMateriales=@IdSalidaMateriales),0)
SET @IdPesada=IsNull((Select Top 1 IdPesada From SalidasMateriales Where IdSalidaMateriales=@IdSalidaMateriales),0)
SET @IdTarifaFlete=IsNull((Select Top 1 IdTarifaFlete From SalidasMateriales Where IdSalidaMateriales=@IdSalidaMateriales),0)
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
	IF IsNull(@DescargaPorKit,'NO')<>'SI' or @IdDepositoIntermedio<>0 or @IdUbicacionDestino1<>0
	  BEGIN
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

		IF @IdDepositoIntermedio<>0
		  BEGIN
			SET @IdDepositoAux=IsNull((Select Top 1 IdDeposito From Ubicaciones Where IdUbicacion=@IdDepositoIntermedio),0)
			SET @IdObraAux1=IsNull((Select Top 1 IdObra From Depositos Where IdDeposito=@IdDepositoAux),0)
			SET @IdStock1=IsNull((Select Top 1 Stock.IdStock From Stock 
						Where IdArticulo=@IdArticulo and Partida=@Partida and IdUbicacion=@IdDepositoIntermedio and IdObra=@IdObraAux1 and IdUnidad=@IdUnidad and 
							IsNull(NumeroCaja,0)=IsNull(@NumeroCaja,0) and IsNull(IdColor,0)=IsNull(@IdColor,0) and IsNull(Talle,'')=IsNull(@Talle,'')),0)
			IF @IdStock1>0 
				UPDATE Stock
				SET CantidadUnidades=IsNull(CantidadUnidades,0)+@Cantidad
				WHERE IdStock=@IdStock1
			ELSE
				INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra, NumeroCaja, IdColor, Talle)
				VALUES (@IdArticulo, @Partida, @Cantidad, Null, @IdUnidad, @IdDepositoIntermedio, @IdObraAux1, @NumeroCaja, @IdColor, @Talle)
		  END
		ELSE
		  BEGIN
			IF @IdUbicacionDestino1<>0
			  BEGIN
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
	  END
	ELSE
	  BEGIN
		SET NOCOUNT ON
		SET @IdUnidadStandar=IsNull((Select Top 1 IdUnidad From Articulos Where IdArticulo=@IdArticulo),@IdUnidad)

		CREATE TABLE #Auxiliar1 (IdArticuloConjunto INTEGER, IdUnidadConjunto INTEGER, CantidadConjunto NUMERIC(18,3))
		INSERT INTO #Auxiliar1 
		 SELECT dc.IdArticulo, dc.IdUnidad, IsNull(dc.Cantidad,0)
		 FROM DetalleConjuntos dc
		 LEFT OUTER JOIN Conjuntos ON dc.IdConjunto = Conjuntos.IdConjunto
		 WHERE (Conjuntos.IdArticulo = @IdArticulo)

		DECLARE @IdArticuloConjunto int, @IdUnidadConjunto int, @CantidadConjunto numeric(18,3), @CantidadProducto numeric(18,3), @Equivalencia numeric(18,6)
		CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdArticuloConjunto) ON [PRIMARY]
		DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdArticuloConjunto, IdUnidadConjunto, CantidadConjunto FROM #Auxiliar1 ORDER BY IdArticuloConjunto
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

		DROP TABLE #Auxiliar1
		SET NOCOUNT OFF
	  END
  END

INSERT INTO [DetalleSalidasMateriales]
(
 IdSalidaMateriales,
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
 ArchivoAdjunto1,
 ArchivoAdjunto2,
 ArchivoAdjunto3,
 ArchivoAdjunto4,
 ArchivoAdjunto5,
 ArchivoAdjunto6, 
 ArchivoAdjunto7,
 ArchivoAdjunto8,
 ArchivoAdjunto9,
 ArchivoAdjunto10,
 Observaciones,
 IdUbicacion,
 IdObra,
 CostoUnitario,
 IdMoneda,
 CotizacionDolar,
 CotizacionMoneda,
 IdEquipoDestino,
 EnviarEmail,
 IdDetalleSalidaMaterialesOriginal,
 IdSalidaMaterialesOriginal,
 IdOrigenTransmision,
 DescargaPorKit,
 FechaImputacion,
 IdOrdenTrabajo,
 IdDetalleObraDestino,
 IdDetalleSalidaMaterialesPRONTOaSAT,
 IdPresupuestoObraRubro,
 IdCuenta,
 IdCuentaGasto,
 IdPresupuestoObrasNodo,
 NumeroCaja,
 IdUbicacionDestino,
 IdFlete,
 IdDetalleRecepcion,
 CostoOriginal,
 IdUsuarioModificoCosto,
 FechaModificacionCosto,
 ObservacionModificacionCosto,
 IdMonedaOriginal,
 IdDetalleProduccionOrden,
 IdDetalleLiquidacionFlete,
 IdUsuarioDioPorCumplidoLiquidacionFletes,
 FechaDioPorCumplidoLiquidacionFletes,
 ObservacionDioPorCumplidoLiquidacionFletes,
 Talle,
 IdColor,
 IdPresupuestoObrasNodoFleteLarga,
 IdPresupuestoObrasNodoFleteInterno,
 CostoFleteLarga,
 CostoFleteInterno,
 IdUsuarioDioPorRecepcionado,
 FechaDioPorRecepcionado,
 ObservacionDioPorRecepcionado,
 ImputarConsumoAObraActualEquipoMantenimiento
)
VALUES 
(
 @IdSalidaMateriales,
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
 @ArchivoAdjunto1,
 @ArchivoAdjunto2,
 @ArchivoAdjunto3,
 @ArchivoAdjunto4,
 @ArchivoAdjunto5,
 @ArchivoAdjunto6,
 @ArchivoAdjunto7,
 @ArchivoAdjunto8,
 @ArchivoAdjunto9,
 @ArchivoAdjunto10,
 @Observaciones,
 @IdUbicacion,
 @IdObra,
 @CostoUnitario,
 @IdMoneda,
 @CotizacionDolar,
 @CotizacionMoneda,
 @IdEquipoDestino,
 @EnviarEmail,
 @IdDetalleSalidaMaterialesOriginal,
 @IdSalidaMaterialesOriginal,
 @IdOrigenTransmision,
 @DescargaPorKit,
 @FechaImputacion,
 @IdOrdenTrabajo,
 @IdDetalleObraDestino,
 @IdDetalleSalidaMaterialesPRONTOaSAT,
 @IdPresupuestoObraRubro,
 @IdCuenta,
 @IdCuentaGasto,
 @IdPresupuestoObrasNodo,
 @NumeroCaja,
 @IdUbicacionDestino,
 @IdFlete,
 @IdDetalleRecepcion,
 @CostoOriginal,
 @IdUsuarioModificoCosto,
 @FechaModificacionCosto,
 @ObservacionModificacionCosto,
 @IdMonedaOriginal,
 @IdDetalleProduccionOrden,
 @IdDetalleLiquidacionFlete,
 @IdUsuarioDioPorCumplidoLiquidacionFletes,
 @FechaDioPorCumplidoLiquidacionFletes,
 @ObservacionDioPorCumplidoLiquidacionFletes,
 @Talle,
 @IdColor,
 @IdPresupuestoObrasNodoFleteLarga,
 @IdPresupuestoObrasNodoFleteInterno, @CostoFleteLarga,
 @CostoFleteInterno,
 @IdUsuarioDioPorRecepcionado,
 @FechaDioPorRecepcionado,
 @ObservacionDioPorRecepcionado,
 @ImputarConsumoAObraActualEquipoMantenimiento
)
SELECT @IdDetalleSalidaMateriales=@@identity

IF @IdDepositoIntermedio>0 and @IdProduccionOrden>0
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
	INSERT INTO [DetalleAjustesStock]
	(IdAjusteStock, IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, Cantidad1, Cantidad2, IdUbicacion, IdObra, IdDetalleSalidaMateriales, NumeroCaja, IdColor, Talle)
	VALUES 
	(@IdAjusteStock, @IdArticulo, @Partida, @Cantidad, @CantidadAdicional, @IdUnidad, @Cantidad1, @Cantidad2, @IdDepositoIntermedio, @IdObraAux, @IdDetalleSalidaMateriales, @NumeroCaja, @IdColor, @Talle)
   END
ELSE
  BEGIN
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
		INSERT INTO [DetalleAjustesStock]
		(IdAjusteStock, IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, Cantidad1, Cantidad2, IdUbicacion, IdObra, IdDetalleSalidaMateriales, NumeroCaja, IdColor, Talle)
		VALUES 
		(@IdAjusteStock, @IdArticulo, @Partida, @Cantidad, @CantidadAdicional, @IdUnidad, @Cantidad1, @Cantidad2, @IdUbicacionDestino1, @IdObraAux, @IdDetalleSalidaMateriales, @NumeroCaja, @IdColor, @Talle)
	  END
  END

IF @IdEquipoDestino is Not null and DB_ID(@BasePRONTOMANT) is not null and @GenerarConsumosAutomaticamente<>'NO'
  BEGIN
	SET NOCOUNT ON
	DECLARE @sql1 nvarchar(1000), @IdEquipo int, @IdConsumibleParametro int, @IdConsumible int, @Articulo varchar(300), @IdUnidadConsumible int, 
			@NumeroObra varchar(30), @IdObraMantenimiento int, @ObservacionesRM varchar(2500), @IdDetalleRequerimiento int, @IdObraCabecera int, @IdObraActualEquipo int, 
			@FacturarConsumosAObra varchar(2), @IdConsumo int, @IdFalla int, @NumeroConsumo int, @NumeroSalidaMaterialesPRONTO int, @FechaSalidaMateriales datetime, 
			@IdDetalleOrdenTrabajo int, @IdUsuario int, @Usuario varchar(30), @ObraDestino varchar(30)

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
	SET @NumeroSalidaMaterialesPRONTO=IsNull((Select Top 1 S.NumeroSalidaMateriales From SalidasMateriales S Where S.IdSalidaMateriales=@IdSalidaMateriales),1)
	SET @FechaSalidaMateriales=IsNull((Select Top 1 S.FechaSalidaMateriales From SalidasMateriales S Where S.IdSalidaMateriales=@IdSalidaMateriales),GetDate())
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

	IF IsNull(@CostoUnitario,0)>0
	  BEGIN
		SET @sql1='Update '+@BasePRONTOMANT+'.dbo.Articulos 
					Set CostoReposicion='+Convert(varchar,IsNull(@CostoUnitario,0)*IsNull(@CotizacionMoneda,1))+' 
					Where IdArticulo='+Convert(varchar,@IdConsumible)
		EXEC sp_executesql @sql1
	  END

	IF @IdOrdenTrabajo is null
	  BEGIN
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

		SET @ObservacionesRM=@Articulo
		SET @IdDetalleRequerimiento=IsNull((Select Top 1 IdDetalleRequerimiento From DetalleValesSalida Where IdDetalleValeSalida=@IdDetalleValeSalida),0)
		SET @ObservacionesRM=@ObservacionesRM + ' ' + 
			IsNull(Char(10) + 'Obs.RM: '+
					(Select Top 1 Convert(varchar(1000),IsNull(Observaciones,'')) From DetalleRequerimientos Where IdDetalleRequerimiento=@IdDetalleRequerimiento),'')
		IF Len(Ltrim(Convert(varchar(1000),@Observaciones)))>0 
			SET @ObservacionesRM=@ObservacionesRM + ' ' + IsNull(Char(10) + 'Obs.Salida: '+Convert(varchar(1000),@Observaciones),'')

		SET @sql1='Insert Into '+@BasePRONTOMANT+'.dbo.DetalleConsumos 
					(IdConsumo, IdConsumible, Cantidad, IdUnidadConsumible, Costo, Observaciones, IdArticulo, FechaImportacion, IdDetalleSalidaMaterialesPRONTO, BDOrigenSalidaPRONTO, Detalle1, Detalle2, IdObraAFacturar)
					Values 
					('+Convert(varchar,@IdConsumo)+', '+Convert(varchar,@IdConsumible)+', 
					 '+Convert(varchar,@Cantidad)+', '+Convert(varchar,@IdUnidadConsumible)+', 
					 '+Convert(varchar,IsNull(@CostoUnitario,0))+' * '+Convert(varchar,IsNull(@CotizacionMoneda,1))+' , 
					 '''+@ObservacionesRM+''', '+Convert(varchar,@IdEquipo)+', 
					 Convert(datetime,'''+Convert(varchar,GetDate(),103)+''',103), 
					 '+Convert(varchar,@IdDetalleSalidaMateriales)+', 
					 '+''''+DB_NAME()+''', '+''''+@ObraDestino+''''+', '+''''+@Usuario++''''+', '+
					 Case When @FacturarConsumosAObra='NO' Then 'Null' Else Convert(varchar,@IdObraMantenimiento) End+')'
		EXEC sp_executesql @sql1
	  END
	ELSE
	  BEGIN
		TRUNCATE TABLE #Auxiliar3
		SET @sql1='Select Top 1 Det.IdDetalleOrdenTrabajo From '+@BasePRONTOMANT+'.dbo.DetalleOrdenesTrabajo Det 
					Where Det.IdOrdenTrabajo='+Convert(varchar,@IdOrdenTrabajo)+' and 
					IsNull(Det.FechaEstimada,Det.FechaEjecucion)=Convert(datetime,'''+Convert(varchar,IsNull(@FechaImputacion,@FechaSalidaMateriales),103)+''',103)'
		INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
		SET @IdDetalleOrdenTrabajo=IsNull((Select Top 1 IdAux From #Auxiliar3),0)

		IF @IdDetalleOrdenTrabajo=0
		  BEGIN
			SET @sql1='Select Top 1 Det.IdFalla From '+@BasePRONTOMANT+'.dbo.DetalleOrdenesTrabajo Det Where Det.IdOrdenTrabajo='+Convert(varchar,@IdOrdenTrabajo)
			TRUNCATE TABLE #Auxiliar3
			INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
			SET @IdFalla=IsNull((Select Top 1 IdAux From #Auxiliar3),0)

			SET @sql1='Insert Into '+@BasePRONTOMANT+'.dbo.DetalleOrdenesTrabajo 
						(IdOrdenTrabajo, FechaEjecucion, IdFalla)						Values 
						('+Convert(varchar,@IdOrdenTrabajo)+', 
						 Convert(datetime,'''+Convert(varchar,IsNull(@FechaImputacion,@FechaSalidaMateriales),103)+''',103), 
						 '+Convert(varchar,@IdFalla)+') 
						Select @@identity'
			TRUNCATE TABLE #Auxiliar3
			INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
			SET @IdDetalleOrdenTrabajo=IsNull((Select Top 1 IdAux From #Auxiliar3),0)
		  END

		SET @ObservacionesRM=@Articulo
		IF Len(Ltrim(Convert(varchar(1000),@Observaciones)))>0 
			SET @ObservacionesRM=@ObservacionesRM + ' ' + IsNull(Char(10) + 'Obs.Salida: '+Convert(varchar(1000),@Observaciones),'')

		SET @sql1='Insert Into '+@BasePRONTOMANT+'.dbo.DetalleOrdenesTrabajoConsumos 
					(IdDetalleOrdenTrabajo, IdArticulo, Cantidad, IdUnidad, Costo, Observaciones, IdDetalleSalidaMaterialesPRONTO, IdObra)
					Values 
					('+Convert(varchar,@IdDetalleOrdenTrabajo)+', 
					 '+Convert(varchar,@IdConsumible)+', 
					 '+Convert(varchar,@Cantidad)+', '+Convert(varchar,@IdUnidadConsumible)+', 
					 '+Convert(varchar,IsNull(@CostoUnitario,0))+' * '+Convert(varchar,IsNull(@CotizacionMoneda,1))+' , 
					 '''+@ObservacionesRM+''', '+Convert(varchar,@IdDetalleSalidaMateriales)+', 
					 '+Convert(varchar,@IdObraMantenimiento)+')'
		EXEC sp_executesql @sql1
	 END
	DROP TABLE #Auxiliar3
	SET NOCOUNT OFF
  END

IF IsNull((Select Top 1 SalidaADepositoEnTransito From SalidasMateriales Where IdSalidaMateriales=@IdSalidaMateriales),'NO')='SI' and 
	Exists(Select Top 1 IdObra From ArchivosATransmitirDestinos Where IsNull(Activo,'SI')='SI' and IsNull(Sistema,'')='SAT' and IdObra=@IdObra)
  BEGIN
	DECLARE @IdOtroIngresoAlmacen int, @IdUbicacionStockEnTransito int
	SET @IdOtroIngresoAlmacen=IsNull((Select Top 1 IdOtroIngresoAlmacen From OtrosIngresosAlmacen Where IdSalidaMateriales=@IdSalidaMateriales),0)
	SET @IdUbicacionStockEnTransito=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdUbicacionStockEnTransito'),0)

	EXEC DetOtrosIngresosAlmacen_A 0, @IdOtroIngresoAlmacen, @IdArticulo, @IdStock, @Partida, @Cantidad, 0, @IdUnidad, Null, Null, 
		'NO', Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, @IdUbicacionStockEnTransito, @IdObra, Null,  Null,  
		Null,  Null, @CostoUnitario, @IdMoneda, Null, Null, @Cantidad, 0, @IdDetalleSalidaMateriales, @IdEquipoDestino, @IdOrdenTrabajo  END

--Registro de imputacion a presupuesto de obra (salidas que vienen de balanza)
IF IsNull(@IdPresupuestoObrasNodo,0)>0 
  BEGIN
	INSERT INTO [DetalleSalidasMaterialesPresupuestosObras]
	(IdDetalleSalidaMateriales, IdPresupuestoObrasNodo, Cantidad, IdDetalleSalidaMaterialesKit)
	VALUES 
	(@IdDetalleSalidaMateriales, @IdPresupuestoObrasNodo, @Cantidad, Null)
  END

--Registro de parte de produccion y costo de flete para salidas de kits (salidas que vienen de balanza)
IF @IdPesada>0
  BEGIN
	SET @IdConjunto=IsNull((Select Top 1 IdConjunto From Conjuntos Where IdArticulo=@IdArticulo),0)
	IF @IdConjunto>0 
	  BEGIN
		SET @NumeroParteProduccion=IsNull((Select Top 1 Valor From Parametros2 Where Campo='ProximoNumeroParteProduccion'),-1)
		IF @NumeroParteProduccion=-1
		  BEGIN
			SET @NumeroParteProduccion=1
			INSERT INTO Parametros2 (Campo,Valor) VALUES ('ProximoNumeroParteProduccion',2)
		  END
		ELSE
		  BEGIN
			UPDATE Parametros2 SET Valor=Convert(varchar,@NumeroParteProduccion+1) WHERE IsNull(Campo,'')='ProximoNumeroParteProduccion'
		  END

		SET @IdObraPlanta=IsNull((Select Top 1 IdObra From Obras Where IsNull(IdObraRelacionada,0)=@IdObra and IsNull(EsPlantaDeProduccionInterna,'')='SI'),0)
		SET @IdObraAuxiliarDeColocacion=IsNull((Select Top 1 IdObra From Obras Where IsNull(IdObraRelacionada,0)=@IdObra and IsNull(EsPlantaDeProduccionInterna,'')='AU' and IsNull(AuxiliarDeMateriales,'')<>'SI'),0)
		SET @IdObraAuxiliarDeMateriales=IsNull((Select Top 1 IdObra From Obras Where IsNull(IdObraRelacionada,0)=@IdObra and IsNull(EsPlantaDeProduccionInterna,'')='AU' and IsNull(AuxiliarDeMateriales,'')='SI'),0)
		SET @IdNodoPadre=IsNull((Select Top 1 IdNodoPadre From PresupuestoObrasNodos Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo),0)
		SET @IdPresupuestoObrasNodoElaboracionColocacion=IsNull((Select Top 1 IdPresupuestoObrasNodo From PresupuestoObrasNodos Where IdNodoPadre=@IdNodoPadre and IdNodoAuxiliar=@IdObraPlanta),0)
		SET @IdPresupuestoObrasNodoMateriales=IsNull((Select Top 1 IdPresupuestoObrasNodo From PresupuestoObrasNodos Where IdNodoPadre=@IdNodoPadre and IdNodoAuxiliar=@IdObraAuxiliarDeMateriales),0)

		INSERT INTO PartesProduccion
		(NumeroParteProduccion, FechaParteProduccion, IdObra, IdArticulo, Cantidad, IdUnidad, Importe, IdPresupuestoObrasNodo, Observaciones, IdObraDestino, IdPresupuestoObrasNodoMateriales, IdDetalleSalidaMateriales)
		VALUES
		(@NumeroParteProduccion, GetDate(), @IdObraPlanta, @IdArticulo, @Cantidad, @IdUnidad, @CostoUnitario, 
		 Case When @IdPresupuestoObrasNodoElaboracionColocacion>0 Then @IdPresupuestoObrasNodoElaboracionColocacion Else Null End, '', @IdObra, 
		 Case When @IdPresupuestoObrasNodoMateriales>0 Then @IdPresupuestoObrasNodoMateriales Else Null End, @IdDetalleSalidaMateriales)

		SET @TarifaFlete=IsNull((Select Top 1 ValorUnitario From TarifasFletes Where IdTarifaFlete=@IdTarifaFlete),0)

		UPDATE DetalleSalidasMateriales 
		SET CostoFleteInterno=@TarifaFlete*@Cantidad
		WHERE IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales
	  END
  END

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdDetalleSalidaMateriales)