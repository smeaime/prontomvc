CREATE PROCEDURE [dbo].[SalidasMateriales_AjustarStockSalidaMaterialesAnulada]

@IdSalidaMateriales int

AS

DECLARE @sql1 nvarchar(1000), @BasePRONTOMANT varchar(50), @TomarObraCabecera varchar(2), @IdObraCabecera int, @IdObraAux int, @IdDetalleAjusteStock int

SET @BasePRONTOMANT=IsNull((Select Top 1 P.BasePRONTOMantenimiento From Parametros P Where P.IdParametro=1),'')
SET @TomarObraCabecera=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
				Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
				Where pic.Clave='Descontar stock tomando obra cabecera en salida de materiales' and IsNull(ProntoIni.Valor,'')='SI'),'')
SET @IdObraCabecera=IsNull((Select Top 1 IsNull(IdObraOrigen,IdObra) From SalidasMateriales Where IdSalidaMateriales=@IdSalidaMateriales),0)

-- ELIMINAR REGISTRO CONTABLE DE DESACTIVACION DE MATERIALES AL GASTO
DELETE Subdiarios 
WHERE IdTipoComprobante=50 and IdComprobante=@IdSalidaMateriales

CREATE TABLE #Auxiliar1	
			(
			 IdDetalleSalidaMateriales INTEGER,
			 IdArticulo INTEGER,
			 Cantidad NUMERIC(18,2),
			 IdUnidad INTEGER,
			 Partida VARCHAR(20),
			 IdUbicacion INTEGER,
			 IdObra INTEGER,
			 DescargaPorKit VARCHAR(2),
			 NumeroCaja INTEGER
			)
CREATE TABLE #Auxiliar2 
			(
			 IdArticuloConjunto INTEGER, 
			 IdUnidadConjunto INTEGER, 
			 CantidadConjunto NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdArticuloConjunto) ON [PRIMARY]

INSERT INTO #Auxiliar1 
 SELECT IdDetalleSalidaMateriales, IdArticulo, Cantidad, IdUnidad, Partida, IdUbicacion, IdObra, DescargaPorKit, NumeroCaja
 FROM DetalleSalidasMateriales DetSal
 WHERE DetSal.IdSalidaMateriales = @IdSalidaMateriales

CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdDetalleSalidaMateriales) ON [PRIMARY]

/*  CURSOR  */
DECLARE @IdStock int, @IdDetalleSalidaMateriales int, @IdArticulo int, @Cantidad numeric(18,2), @IdUnidad int, @Partida varchar(20), @IdUbicacion int, @IdObra int, @DescargaPorKit varchar(2), 
	@NumeroCaja int, @IdArticuloAjuste int, @PartidaAjuste varchar(20), @IdUnidadAjuste int, @IdUbicacionAjuste int, @IdObraAjuste int, @NumeroCajaAjuste int, @CantidadAjuste numeric(18,2)
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdDetalleSalidaMateriales, IdArticulo, Cantidad, IdUnidad, Partida, IdUbicacion, IdObra, DescargaPorKit, NumeroCaja
		FROM #Auxiliar1
		ORDER BY IdDetalleSalidaMateriales
OPEN Cur
FETCH NEXT FROM Cur INTO @IdDetalleSalidaMateriales, @IdArticulo, @Cantidad, @IdUnidad, @Partida, @IdUbicacion, @IdObra, @DescargaPorKit, @NumeroCaja
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @IdDetalleAjusteStock=IsNull((Select Top 1 IdDetalleAjusteStock From DetalleAjustesStock Where IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales),0)

	IF IsNull(@DescargaPorKit,'NO')<>'SI' or @IdDetalleAjusteStock<>0
	   BEGIN
		IF @TomarObraCabecera='SI'
			SET @IdObraAux=@IdObraCabecera
		ELSE
			SET @IdObraAux=@IdObra

		SET @IdStock=IsNull((Select Top 1 Stock.IdStock
					From Stock 
					Where IdArticulo=@IdArticulo and Partida=@Partida and IdUbicacion=@IdUbicacion and IdObra=@IdObraAux and IdUnidad=@IdUnidad and IsNull(NumeroCaja,0)=IsNull(@NumeroCaja,0)),0)
		IF @IdStock>0 
			UPDATE Stock
			SET CantidadUnidades=IsNull(CantidadUnidades,0)+@Cantidad
			WHERE IdStock=@IdStock
		ELSE
			INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra, NumeroCaja)
			VALUES (@IdArticulo, @Partida, @Cantidad, Null, @IdUnidad, @IdUbicacion, @IdObraAux, @NumeroCaja)

		IF @IdDetalleAjusteStock<>0
		   BEGIN
			SET @IdArticuloAjuste=IsNull((Select Top 1 IdArticulo From DetalleAjustesStock Where IdDetalleAjusteStock=@IdDetalleAjusteStock),0)
			SET @PartidaAjuste=IsNull((Select Top 1 Partida From DetalleAjustesStock Where IdDetalleAjusteStock=@IdDetalleAjusteStock),'')
			SET @IdUnidadAjuste=IsNull((Select Top 1 IdUnidad From DetalleAjustesStock Where IdDetalleAjusteStock=@IdDetalleAjusteStock),0)
			SET @IdUbicacionAjuste=IsNull((Select Top 1 IdUbicacion From DetalleAjustesStock Where IdDetalleAjusteStock=@IdDetalleAjusteStock),0)
			SET @IdObraAjuste=IsNull((Select Top 1 IdObra From DetalleAjustesStock Where IdDetalleAjusteStock=@IdDetalleAjusteStock),0)
			SET @NumeroCajaAjuste=(Select Top 1 NumeroCaja From DetalleAjustesStock Where IdDetalleAjusteStock=@IdDetalleAjusteStock)
			SET @CantidadAjuste=IsNull((Select Top 1 CantidadUnidades From DetalleAjustesStock Where IdDetalleAjusteStock=@IdDetalleAjusteStock),0)

			SET @IdStock=IsNull((Select Top 1 Stock.IdStock
						From Stock 
						Where IdArticulo=@IdArticuloAjuste and Partida=@PartidaAjuste and IdUbicacion=@IdUbicacionAjuste and IdObra=@IdObraAjuste and IdUnidad=@IdUnidadAjuste and IsNull(NumeroCaja,0)=IsNull(@NumeroCajaAjuste,0)),0)
			IF @IdStock>0 
				UPDATE Stock
				SET CantidadUnidades=IsNull(CantidadUnidades,0)-@CantidadAjuste
				WHERE IdStock=@IdStock
			ELSE
				INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra, NumeroCaja)
				VALUES (@IdArticuloAjuste, @PartidaAjuste, @CantidadAjuste*-1, Null, @IdUnidadAjuste, @IdUbicacionAjuste, @IdObraAjuste, @NumeroCajaAjuste)

			UPDATE DetalleAjustesStock
			SET CantidadUnidades=0
			WHERE IdDetalleAjusteStock=@IdDetalleAjusteStock
		   END
	   END
	ELSE
	   BEGIN
		SET NOCOUNT ON
		TRUNCATE TABLE #Auxiliar2
		INSERT INTO #Auxiliar2 
		 SELECT dc.IdArticulo, dc.IdUnidad, IsNull(dc.Cantidad,0)
		 FROM DetalleConjuntos dc
		 LEFT OUTER JOIN Conjuntos ON dc.IdConjunto = Conjuntos.IdConjunto
		 WHERE (Conjuntos.IdArticulo = @IdArticulo)

		DECLARE @IdArticuloConjunto int, @IdUnidadConjunto int, @CantidadConjunto numeric(18,2)
		DECLARE Cur1 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdArticuloConjunto, IdUnidadConjunto, CantidadConjunto FROM #Auxiliar2 ORDER BY IdArticuloConjunto
		OPEN Cur1
		FETCH NEXT FROM Cur1 INTO @IdArticuloConjunto, @IdUnidadConjunto, @CantidadConjunto
		WHILE @@FETCH_STATUS = 0
		   BEGIN
			SET @IdStock=IsNull((Select Top 1 Stock.IdStock
						From Stock 
						Where IdArticulo=@IdArticuloConjunto and Partida='' and IdUbicacion=@IdUbicacion and IdObra=@IdObra and IdUnidad=@IdUnidadConjunto),0)
			IF @IdStock>0 
				UPDATE Stock
				SET CantidadUnidades=IsNull(CantidadUnidades,0)+(@Cantidad*@CantidadConjunto)
				WHERE IdStock=@IdStock
			ELSE
				INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra)
				VALUES (@IdArticuloConjunto, 0, (@Cantidad*@CantidadConjunto), Null, @IdUnidadConjunto, @IdUbicacion, @IdObra)
			FETCH NEXT FROM Cur1 INTO @IdArticuloConjunto, @IdUnidadConjunto, @CantidadConjunto
		   END
		CLOSE Cur1
		DEALLOCATE Cur1
		SET NOCOUNT OFF
	   END

	IF DB_ID(@BasePRONTOMANT) is not null
	   BEGIN
		SET @sql1='Delete '+@BasePRONTOMANT+'.dbo.DetalleConsumos Where IsNull(IdDetalleSalidaMaterialesPRONTO,-1)='+Convert(varchar,@IdDetalleSalidaMateriales)
		EXEC sp_executesql @sql1

		SET @sql1='Delete '+@BasePRONTOMANT+'.dbo.DetalleOrdenesTrabajoConsumos Where IsNull(IdDetalleSalidaMaterialesPRONTO,-1)='+Convert(varchar,@IdDetalleSalidaMateriales)
		EXEC sp_executesql @sql1
	   END

	FETCH NEXT FROM Cur INTO @IdDetalleSalidaMateriales, @IdArticulo, @Cantidad, @IdUnidad, @Partida, @IdUbicacion, @IdObra, @DescargaPorKit, @NumeroCaja
   END
CLOSE Cur
DEALLOCATE Cur

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2