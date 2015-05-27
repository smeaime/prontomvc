
CREATE PROCEDURE [dbo].[SalidasMateriales_ActualizarEstadoRM]

@IdSalidaMateriales int

AS

DECLARE @Anulada varchar(2)
SET @Anulada=IsNull((Select Top 1 Anulada From SalidasMateriales 
			Where IdSalidaMateriales=@IdSalidaMateriales),'NO')

CREATE TABLE #Auxiliar3 (IdDetalleRequerimiento INTEGER)
INSERT INTO #Auxiliar3 
 SELECT DetalleValesSalida.IdDetalleRequerimiento
 FROM DetalleSalidasMateriales Det
 LEFT OUTER JOIN DetalleValesSalida ON DetalleValesSalida.IdDetalleValeSalida=Det.IdDetalleValeSalida
 WHERE Det.IdSalidaMateriales = @IdSalidaMateriales and 
	DetalleValesSalida.IdDetalleRequerimiento is not null
 GROUP BY DetalleValesSalida.IdDetalleRequerimiento

CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 (IdDetalleRequerimiento) ON [PRIMARY]

/*  CURSOR  */
DECLARE @IdDetalleRequerimiento int, @CantidadEntregada numeric(18,2)
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdDetalleRequerimiento
		FROM #Auxiliar3
OPEN Cur
FETCH NEXT FROM Cur INTO @IdDetalleRequerimiento
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @CantidadEntregada=IsNull((Select Sum(IsNull(Det.Cantidad,0))
					From DetalleSalidasMateriales Det
					Left Outer Join SalidasMateriales On Det.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
					Left Outer Join DetalleValesSalida On DetalleValesSalida.IdDetalleValeSalida=Det.IdDetalleValeSalida
					Where IsNull(DetalleValesSalida.IdDetalleRequerimiento,-1)=@IdDetalleRequerimiento and 
						IsNull(SalidasMateriales.Anulada,'NO')<>'SI'),0)

	UPDATE DetalleRequerimientos
	SET Entregado = 'SI'
	WHERE IdDetalleRequerimiento=@IdDetalleRequerimiento and IsNull(Cumplido,'NO')<>'AN' and 
		(Cantidad<=@CantidadEntregada or IdDioPorCumplido is not null)

	UPDATE DetalleRequerimientos
	SET Entregado = 'PA'
	WHERE IdDetalleRequerimiento=@IdDetalleRequerimiento and IsNull(Cumplido,'NO')<>'AN' and 
		Cantidad>@CantidadEntregada and @CantidadEntregada<>0 and IdDioPorCumplido is null

	UPDATE DetalleRequerimientos
	SET Entregado = Null
	WHERE IdDetalleRequerimiento=@IdDetalleRequerimiento and IsNull(Cumplido,'NO')<>'AN' and 
		Cantidad>@CantidadEntregada and @CantidadEntregada=0 and IdDioPorCumplido is null

	FETCH NEXT FROM Cur INTO @IdDetalleRequerimiento
END
CLOSE Cur
DEALLOCATE Cur

CREATE TABLE #Auxiliar4	(IdRequerimiento INTEGER)
INSERT INTO #Auxiliar4 
 SELECT DetReq.IdRequerimiento
 FROM DetalleSalidasMateriales Det
 LEFT OUTER JOIN DetalleValesSalida ON DetalleValesSalida.IdDetalleValeSalida=Det.IdDetalleValeSalida
 LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetReq.IdDetalleRequerimiento = DetalleValesSalida.IdDetalleRequerimiento
 WHERE Det.IdSalidaMateriales = @IdSalidaMateriales and DetReq.IdRequerimiento is not null
 GROUP BY DetReq.IdRequerimiento

CREATE NONCLUSTERED INDEX IX__Auxiliar4 ON #Auxiliar4 (IdRequerimiento) ON [PRIMARY]

/*  CURSOR  */
DECLARE @IdRequerimiento int
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdRequerimiento
		FROM #Auxiliar4
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRequerimiento
WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE Requerimientos
	SET Entregado=Null
	WHERE IdRequerimiento=@IdRequerimiento and IsNull(Cumplido,'NO')<>'AN' 

	UPDATE Requerimientos
	SET Entregado='SI'
	WHERE IdRequerimiento=@IdRequerimiento and IsNull(Cumplido,'NO')<>'AN' and 
		not exists(Select Top 1 DetReq.IdRequerimiento
				From DetalleRequerimientos DetReq
				Where DetReq.IdRequerimiento=@IdRequerimiento and 
					(IsNull(DetReq.Entregado,'NO')='NO' or IsNull(DetReq.Entregado,'NO')='PA'))

	UPDATE Requerimientos
	SET Entregado='PA'
	WHERE IdRequerimiento=@IdRequerimiento and IsNull(Cumplido,'NO')<>'AN' and 
		Entregado is null and 
		exists(Select Top 1 DetReq.IdRequerimiento
			From DetalleRequerimientos DetReq
			Where DetReq.IdRequerimiento=@IdRequerimiento and 
				IsNull(DetReq.Entregado,'NO')<>'NO')
	FETCH NEXT FROM Cur INTO @IdRequerimiento
END
CLOSE Cur
DEALLOCATE Cur


IF @Anulada='SI'
   BEGIN
	CREATE TABLE #Auxiliar5 (IdDetalleValeSalida INTEGER)
	INSERT INTO #Auxiliar5 
	 SELECT IdDetalleValeSalida
	 FROM DetalleSalidasMateriales Det
	 WHERE IdSalidaMateriales = @IdSalidaMateriales and IdDetalleValeSalida is not null
	 GROUP BY IdDetalleValeSalida

	CREATE NONCLUSTERED INDEX IX__Auxiliar5 ON #Auxiliar5 (IdDetalleValeSalida) ON [PRIMARY]
	
	/*  CURSOR  */
	DECLARE @IdDetalleValeSalida int
	DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
		FOR	SELECT IdDetalleValeSalida
			FROM #Auxiliar5
	OPEN Cur
	FETCH NEXT FROM Cur INTO @IdDetalleValeSalida
	WHILE @@FETCH_STATUS = 0
	   BEGIN
		UPDATE DetalleValesSalida
		SET Cumplido = Null
		WHERE IdDetalleValeSalida=@IdDetalleValeSalida
	
		UPDATE ValesSalida
		SET Cumplido = Null
		WHERE IdValeSalida=(Select Top 1 IdValeSalida 
					From DetalleValesSalida 
					Where IdDetalleValeSalida=@IdDetalleValeSalida)
	
		FETCH NEXT FROM Cur INTO @IdDetalleValeSalida
	END
	CLOSE Cur
	DEALLOCATE Cur

	DROP TABLE #Auxiliar5
   END

DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
