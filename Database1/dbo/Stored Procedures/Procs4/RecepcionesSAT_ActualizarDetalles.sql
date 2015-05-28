
CREATE Procedure [dbo].[RecepcionesSAT_ActualizarDetalles]

@IdRecepcionOriginal int,
@IdOrigenTransmision int

AS

DECLARE @GenerarSalidaDesdeRecepcionSAT varchar(2), @IdUbicacionStockEnTransito int, 
	@IdRecepcionSAT int, @IdSalidaMateriales int, @NumeroSalidaMateriales int, 
	@IdObra int, @IdAjusteStock int, @NumeroAjusteStock int, @Cantidad1 numeric(18,2)

SET @GenerarSalidaDesdeRecepcionSAT=IsNull((Select Top 1 P2.Valor From Parametros2 P2 
						Where P2.Campo='GenerarSalidaDesdeRecepcionSAT'),'NO')

IF @GenerarSalidaDesdeRecepcionSAT='SI'
   BEGIN
	SET @IdUbicacionStockEnTransito=IsNull((Select Top 1 P2.Valor From Parametros2 P2 
						Where P2.Campo='IdUbicacionStockEnTransito'),0)
	SET @IdRecepcionSAT=IsNull((Select Top 1 IdRecepcion 
					From RecepcionesSAT 
					Where IdRecepcionOriginal=@IdRecepcionOriginal and 
						IdOrigenTransmision=@IdOrigenTransmision),0)
	SET @IdObra=IsNull((Select Top 1 IdObra From DetalleRecepcionesSAT 
				Where IdRecepcionOriginal=@IdRecepcionOriginal and 
					IdOrigenTransmision=@IdOrigenTransmision),0)
/*
	SET @IdSalidaMateriales=IsNull((Select Top 1 IdSalidaMateriales 
					From SalidasMateriales 
					Where IsNull(IdRecepcionSAT,-1)=@IdRecepcionSAT),0)
	IF @IdSalidaMateriales=0
	   BEGIN
		SET @NumeroSalidaMateriales=IsNull((Select Top 1 P.ProximoNumeroSalidaMaterialesAObra
							From Parametros P Where P.IdParametro=1),1)
		UPDATE Parametros
		SET ProximoNumeroSalidaMaterialesAObra=@NumeroSalidaMateriales+1
		INSERT INTO SalidasMateriales
		(NumeroSalidaMateriales, FechaSalidaMateriales, IdObra, TipoSalida,
		 NumeroSalidaMateriales2, FechaRegistracion, IdRecepcionSAT)
		VALUES
		(@NumeroSalidaMateriales, GetDate(), @IdObra, 1, 1, GetDate(), @IdRecepcionSAT)
		SET @IdSalidaMateriales=@@identity
	   END
*/
	SET @IdAjusteStock=IsNull((Select Top 1 IdAjusteStock 
					From AjustesStock 
					Where IsNull(IdRecepcionSAT,-1)=@IdRecepcionSAT),0)
	IF @IdAjusteStock=0 and @IdRecepcionSAT<>0
	   BEGIN
		SET @NumeroAjusteStock=IsNull((Select Top 1 P.ProximoNumeroAjusteStock
						From Parametros P Where P.IdParametro=1),1)
		UPDATE Parametros
		SET ProximoNumeroAjusteStock=@NumeroAjusteStock+1
		INSERT INTO AjustesStock
		(NumeroAjusteStock, FechaAjuste, TipoAjuste, FechaIngreso, IdRecepcionSAT)
		VALUES
		(@NumeroAjusteStock, GetDate(), 'N', Convert(datetime,Convert(varchar,getdate(),103)), @IdRecepcionSAT)
		SET @IdAjusteStock=@@identity
	   END

	CREATE TABLE #Auxiliar9 
				(
				 IdDetalleRecepcion INTEGER,
				 Cantidad NUMERIC(18,2),
				 IdUnidad INTEGER,
				 IdArticulo INTEGER,
				 IdObra INTEGER,
				 CostoUnitario NUMERIC(18,4),
				 IdMoneda INTEGER,
				 CotizacionDolar NUMERIC(18,4),
				 CotizacionMoneda NUMERIC(18,4),
				 IdDetalleSalidaMaterialesPRONTO INTEGER
				)
	CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar9 (IdDetalleRecepcion) ON [PRIMARY]
	INSERT INTO #Auxiliar9 
	 SELECT IdDetalleRecepcion, Cantidad, IdUnidad, IdArticulo, IdObra, CostoUnitario, 
		  IdMoneda, CotizacionDolar, CotizacionMoneda, IdDetalleSalidaMaterialesPRONTO
	 FROM DetalleRecepcionesSAT
	 WHERE IdRecepcionOriginal=@IdRecepcionOriginal and 
		IdOrigenTransmision=@IdOrigenTransmision and 
		IsNull(IdRecepcion,0)=0 and @IdAjusteStock<>0

	/*  CURSOR  */
	DECLARE @IdDetalleRecepcion int, @Cantidad numeric(18,2), @IdUnidad int, @IdArticulo int, 
		@CostoUnitario numeric(18,4), @IdMoneda int, @CotizacionDolar numeric(18,4), 
		@CotizacionMoneda numeric(18,4), @IdDetalleSalidaMaterialesPRONTO int
	DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
		FOR	SELECT IdDetalleRecepcion, Cantidad, IdUnidad, IdArticulo, IdObra, CostoUnitario, 
				 IdMoneda, CotizacionDolar, CotizacionMoneda, IdDetalleSalidaMaterialesPRONTO
			FROM #Auxiliar9
			ORDER BY IdDetalleRecepcion
	OPEN Cur
	FETCH NEXT FROM Cur INTO @IdDetalleRecepcion, @Cantidad, @IdUnidad, @IdArticulo, @IdObra, @CostoUnitario, 
					@IdMoneda, @CotizacionDolar, @CotizacionMoneda, @IdDetalleSalidaMaterialesPRONTO
	WHILE @@FETCH_STATUS = 0
	   BEGIN
		/*
		EXEC DetSalidasMateriales_A 0, @IdSalidaMateriales, @IdArticulo, Null, 0, @Cantidad, 
			0, @IdUnidad, Null, Null, Null, 'NO', Null, Null, Null, Null, Null, Null, Null, 
			Null, Null, Null, Null, @IdUbicacionStockEnTransito, @IdObra, @CostoUnitario, 
			@IdMoneda, @CotizacionDolar, @CotizacionMoneda, Null, Null, Null, Null, Null, 
			'NO', Null, Null, Null, @IdDetalleSalidaMaterialesPRONTO
		*/
		SET @Cantidad1=@Cantidad * -1
		EXEC DetAjustesStock_A 0, @IdAjusteStock, @IdArticulo, 0, @Cantidad1, 0, 
			@IdUnidad, Null, Null, Null, @IdUbicacionStockEnTransito, @IdObra, 
			Null, Null, Null, Null, @IdDetalleSalidaMaterialesPRONTO
		FETCH NEXT FROM Cur INTO @IdDetalleRecepcion, @Cantidad, @IdUnidad, @IdArticulo, @IdObra, @CostoUnitario, 
						@IdMoneda, @CotizacionDolar, @CotizacionMoneda, @IdDetalleSalidaMaterialesPRONTO
	   END
	CLOSE Cur
	DEALLOCATE Cur
	DROP TABLE #Auxiliar9
   END

UPDATE DetalleRecepcionesSAT
SET 
 IdRecepcion=(Select Top 1 Rec.IdRecepcion 
		From RecepcionesSAT Rec 
		Where Rec.IdRecepcionOriginal=@IdRecepcionOriginal and 
			Rec.IdOrigenTransmision=@IdOrigenTransmision)
WHERE IdRecepcionOriginal=@IdRecepcionOriginal and IdOrigenTransmision=@IdOrigenTransmision
