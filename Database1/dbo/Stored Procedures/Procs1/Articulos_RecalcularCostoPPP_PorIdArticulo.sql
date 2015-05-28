CREATE PROCEDURE [dbo].[Articulos_RecalcularCostoPPP_PorIdArticulo]

@IdArticulo int,
@ProcesoCompleto varchar(2) = Null

AS

SET NOCOUNT ON

SET @ProcesoCompleto=IsNull(@ProcesoCompleto,'NO')

DECLARE @FechaArranqueCalculoPPP datetime, @FechaAux varchar(20)

SET @FechaAux=lTrim(rTrim(IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='FechaArranqueCalculoPPP'),'01/01/2000')))
IF Len(@FechaAux)<>10
	SET @FechaAux='01/01/2000'
SET @FechaArranqueCalculoPPP=Convert(datetime,@FechaAux,103)

CREATE TABLE #Auxiliar1
			(
			 IdArticulo INTEGER,
			 TipoComprobante VARCHAR(2),
			 NumeroComprobante INTEGER,
			 Fecha DATETIME,
			 Cantidad NUMERIC(18, 2),
			 Costo NUMERIC(18, 4),
			 StockInicial NUMERIC(18, 2),
			 CostoInicial NUMERIC(18, 4),
			 StockFinal NUMERIC(18, 2),
			 CostoFinal NUMERIC(18, 4),
			 CostoInicialU$S NUMERIC(18, 4),
			 CostoCompraU$S NUMERIC(18, 4),
			 CostoFinalU$S NUMERIC(18, 4),
			 IdDetalleAjusteStock INTEGER,
			 IdDetalleDevolucion INTEGER,
			 IdDetalleRecepcion INTEGER,
			 IdDetalleRemito INTEGER,
			 IdDetalleSalidaMateriales INTEGER,
			 IdDetalleValeSalida INTEGER,
			 IdOrigen INTEGER,
			 IdDetalleOtroIngresoAlmacen INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (Fecha,IdDetalleAjusteStock,IdDetalleDevolucion,IdDetalleRecepcion,IdDetalleRemito,
							IdDetalleSalidaMateriales,IdDetalleValeSalida,IdDetalleOtroIngresoAlmacen) ON [PRIMARY]

INSERT INTO #Auxiliar1 
 SELECT 
  @IdArticulo,
  'AJ',
  aj.NumeroAjusteStock,
  aj.FechaAjuste,
  daj.CantidadUnidades,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  daj.IdDetalleAjusteStock,
  Null,
  Null,
  Null,
  Null,
  Null,
  Null,
  Null
 FROM DetalleAjustesStock daj
 LEFT OUTER JOIN AjustesStock aj ON aj.IdAjusteStock=daj.IdAjusteStock
 WHERE daj.IdArticulo=@IdArticulo and aj.FechaAjuste>=@FechaArranqueCalculoPPP

 UNION ALL 

 SELECT 
  @IdArticulo,
  'SM',
  sm.NumeroSalidaMateriales,
  sm.FechaSalidaMateriales,
  dsm.Cantidad * -1,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  Null,
  Null,
  Null,
  Null,
  dsm.IdDetalleSalidaMateriales,
  Null,
  Null,
  Null
 FROM DetalleSalidasMateriales dsm
 LEFT OUTER JOIN SalidasMateriales sm ON dsm.IdSalidaMateriales=sm.IdSalidaMateriales
 WHERE IsNull(sm.Anulada,'NO')<>'SI' and dsm.IdArticulo=@IdArticulo and sm.FechaSalidaMateriales>=@FechaArranqueCalculoPPP

 UNION ALL 

 SELECT 
  @IdArticulo,
  'RE',
  re.NumeroRecepcionAlmacen,
  re.FechaRecepcion,
  dr.CantidadCC,
  Case When IsNull(pe.PedidoExterior,'NO')='NO' Then IsNull(dr.CostoUnitario,0) * IsNull(dr.CotizacionMoneda,0)
		When IsNull(pe.PedidoExterior,'NO')='SI' and IsNull(dp.CostoAsignado,0)<>0 Then IsNull(dp.CostoAsignado,0)
		Else 0
  End,
  0,
  0,
  0,
  0,
  0,
  Case When IsNull(pe.PedidoExterior,'NO')='NO' and IsNull(dr.CotizacionDolar,0)<>0 Then IsNull(dr.CostoUnitario,0) * IsNull(dr.CotizacionMoneda,0) / IsNull(dr.CotizacionDolar,0)
		When IsNull(pe.PedidoExterior,'NO')='SI' and IsNull(dp.CostoAsignadoDolar,0)<>0 Then IsNull(dp.CostoAsignadoDolar,0)
		Else 0
  End,
  0,
  Null,
  Null,
  dr.IdDetalleRecepcion,
  Null,
  Null,
  Null,
  Null,
  Null
 FROM DetalleRecepciones dr
 LEFT OUTER JOIN Recepciones re ON dr.IdRecepcion=re.IdRecepcion
 LEFT OUTER JOIN DetallePedidos dp ON dr.IdDetallePedido=dp.IdDetallePedido
 LEFT OUTER JOIN Pedidos pe ON dp.IdPedido=pe.IdPedido
 WHERE dr.IdArticulo=@IdArticulo and IsNull(re.Anulada,'NO')<>'SI' and re.FechaRecepcion>=@FechaArranqueCalculoPPP

 UNION ALL 

 SELECT 
  @IdArticulo,
  'OI',
  oia.NumeroOtroIngresoAlmacen,
  oia.FechaOtroIngresoAlmacen,
  doia.CantidadCC,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  Null,
  Null,
  Null,
  Null,
  Null,
  Null,
  Null,
  doia.IdDetalleOtroIngresoAlmacen
 FROM DetalleOtrosIngresosAlmacen doia
 LEFT OUTER JOIN OtrosIngresosAlmacen oia ON doia.IdOtroIngresoAlmacen=oia.IdOtroIngresoAlmacen
 WHERE IsNull(oia.Anulado,'NO')<>'SI' and doia.IdArticulo=@IdArticulo and oia.FechaOtroIngresoAlmacen>=@FechaArranqueCalculoPPP

 UNION ALL 

 SELECT 
  @IdArticulo,
  'RM',
  re.NumeroRemito,
  re.FechaRemito,
  dr.Cantidad * -1,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  Null,
  Null,
  Null,
  dr.IdDetalleRemito,
  Null,
  Null,
  Null,
  Null
 FROM DetalleRemitos dr
 LEFT OUTER JOIN Remitos re ON dr.IdRemito=re.IdRemito
 WHERE dr.IdArticulo=@IdArticulo and IsNull(re.Anulado,'NO')<>'SI' and re.FechaRemito>=@FechaArranqueCalculoPPP

 UNION ALL 

 SELECT 
  @IdArticulo,
  'DV',
  de.NumeroDevolucion,
  de.FechaDevolucion,
  dv.Cantidad,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  Null,
  dv.IdDetalleDevolucion,
  Null,
  Null,
  Null,
  Null,
  Null,
  Null
 FROM DetalleDevoluciones dv
 LEFT OUTER JOIN Devoluciones de ON dv.IdDevolucion=de.IdDevolucion
 WHERE dv.IdArticulo=@IdArticulo and de.FechaDevolucion>=@FechaArranqueCalculoPPP

SET NOCOUNT ON

/*  CURSOR  */
DECLARE @Cantidad numeric(18,2), @Costo numeric(18,4), @StockInicial numeric(18,2), @CostoInicial numeric(18,4), @StockFinal numeric(18,2), 
	@CostoFinal numeric(18,4), @CostoInicialU$S numeric(18,4), @CostoCompraU$S numeric(18,4), @CostoFinalU$S numeric(18,4), @Stock numeric(18,2), 
	@UltimoCosto numeric(18,4), @NuevoCosto numeric(18,4), @UltimoCostoU$S numeric(18,4), @NuevoCostoU$S numeric(18,4)

SET @Stock=0
SET @UltimoCosto=0
SET @NuevoCosto=0
SET @UltimoCostoU$S=0
SET @NuevoCostoU$S=0

DECLARE PPP CURSOR LOCAL FORWARD_ONLY FOR 
		SELECT Cantidad, Costo, StockInicial, CostoInicial, StockFinal, CostoFinal, CostoInicialU$S, CostoCompraU$S, CostoFinalU$S
		FROM #Auxiliar1
		ORDER BY Fecha
OPEN PPP
FETCH NEXT FROM PPP INTO @Cantidad, @Costo, @StockInicial, @CostoInicial, @StockFinal, @CostoFinal, @CostoInicialU$S, @CostoCompraU$S, @CostoFinalU$S
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Costo<>0 and (@Stock + @Cantidad)<>0
		IF @UltimoCosto<>0 and @Stock>0
			SET @NuevoCosto = ((@Stock * @UltimoCosto) + (@Cantidad * @Costo)) / (@Stock + @Cantidad)
		ELSE
			SET @NuevoCosto = @Costo
	ELSE
		SET @NuevoCosto = @UltimoCosto

	IF @CostoCompraU$S<>0 and (@Stock + @Cantidad)<>0
		IF @UltimoCostoU$S<>0 and @Stock>0
			SET @NuevoCostoU$S = ((@Stock * @UltimoCostoU$S) + (@Cantidad * @CostoCompraU$S)) / (@Stock + @Cantidad)
		ELSE
			SET @NuevoCostoU$S = @CostoCompraU$S
	ELSE
		SET @NuevoCostoU$S = @UltimoCostoU$S

	UPDATE #Auxiliar1
	SET StockInicial = @Stock, 
		StockFinal = @Stock + @Cantidad, 
		CostoInicial = @UltimoCosto, 
		CostoFinal = @NuevoCosto, 
		CostoInicialU$S = @UltimoCostoU$S, 
		CostoFinalU$S = @NuevoCostoU$S 
	WHERE CURRENT OF PPP

	SET @Stock = @Stock + @Cantidad
	SET @UltimoCosto = @NuevoCosto
	SET @UltimoCostoU$S = @NuevoCostoU$S

	FETCH NEXT FROM PPP INTO @Cantidad, @Costo, @StockInicial, @CostoInicial, @StockFinal, @CostoFinal, @CostoInicialU$S, @CostoCompraU$S, @CostoFinalU$S
   END
CLOSE PPP
DEALLOCATE PPP

UPDATE Articulos
SET CostoPPP=@UltimoCosto, CostoPPPDolar=@UltimoCostoU$S
WHERE IdArticulo=@IdArticulo

IF @ProcesoCompleto<>'SI'
	DELETE FROM CostosPromedios
	WHERE IdArticulo=@IdArticulo

INSERT INTO CostosPromedios
 SELECT *
 FROM #Auxiliar1

--DETERMINAR SI EL ARTICULO ESTA EN KITS Y SI ES ASI RECALCULAR LOS COSTOS DEL KIT
CREATE TABLE #Auxiliar2 (IdArticulo INTEGER, IdConjunto INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdArticulo, IdConjunto) ON [PRIMARY]

INSERT INTO #Auxiliar2 
 SELECT DISTINCT Conjuntos.IdArticulo, dc.IdConjunto
 FROM DetalleConjuntos dc
 LEFT OUTER JOIN Conjuntos ON Conjuntos.IdConjunto=dc.IdConjunto
 WHERE dc.IdArticulo=@IdArticulo

DECLARE @IdArticulo1 int, @IdConjunto int, @CostoPPP numeric(18,4), @CostoReposicion numeric(18,4), @CostoPPPDolar numeric(18,4), @CostoReposicionDolar numeric(18,4)

DECLARE PPP CURSOR LOCAL FORWARD_ONLY FOR SELECT IdArticulo, IdConjunto FROM #Auxiliar2 ORDER BY IdArticulo, IdConjunto
OPEN PPP
FETCH NEXT FROM PPP INTO @IdArticulo1, @IdConjunto
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @CostoPPP=IsNull((Select Sum(IsNull(dc.Cantidad,0)*IsNull(Articulos.CostoPPP,0))
				From DetalleConjuntos dc 
				Left Outer Join Articulos On Articulos.IdArticulo=dc.IdArticulo
				Where dc.IdConjunto=@IdConjunto),0)
	SET @CostoPPPDolar=IsNull((Select Sum(IsNull(dc.Cantidad,0)*IsNull(Articulos.CostoPPPDolar,0))
					From DetalleConjuntos dc 
					Left Outer Join Articulos On Articulos.IdArticulo=dc.IdArticulo
					Where dc.IdConjunto=@IdConjunto),0)
	SET @CostoReposicion=IsNull((Select Sum(IsNull(dc.Cantidad,0)*IsNull(Articulos.CostoReposicion,0))
					From DetalleConjuntos dc 
					Left Outer Join Articulos On Articulos.IdArticulo=dc.IdArticulo
					Where dc.IdConjunto=@IdConjunto),0)
	SET @CostoReposicionDolar=IsNull((Select Sum(IsNull(dc.Cantidad,0)*IsNull(Articulos.CostoReposicionDolar,0))
						From DetalleConjuntos dc 
						Left Outer Join Articulos On Articulos.IdArticulo=dc.IdArticulo
						Where dc.IdConjunto=@IdConjunto),0)

	UPDATE Articulos
	SET CostoPPP=@CostoPPP, CostoPPPDolar=@CostoPPPDolar, CostoReposicion=@CostoReposicion, CostoReposicionDolar=@CostoReposicionDolar
	WHERE IdArticulo=@IdArticulo1

	FETCH NEXT FROM PPP INTO @IdArticulo1, @IdConjunto
   END
CLOSE PPP
DEALLOCATE PPP

SET NOCOUNT OFF

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2