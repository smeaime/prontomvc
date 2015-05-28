
--FUNCION OBSOLETA!!!!!!!!!!!!!!!
--FUNCION OBSOLETA!!!!!!!!!!!!!!!
--ProduccionOrdenes_AnularAjustarStock
--FUNCION OBSOLETA!!!!!!!!!!!!!!!
--Me parece que funcionaba cuando todavía hacías la suma y resta del stock recién al cierre de la OP..


CREATE PROCEDURE ProduccionOrdenes_AnularAjustarStock

@IdProduccionOrden int

AS

DECLARE @sql1 nvarchar(1000), @BasePRONTOMANT varchar(50)
SET @BasePRONTOMANT=IsNull((Select Top 1 P.BasePRONTOMantenimiento 
				From Parametros P Where P.IdParametro=1),'')

CREATE TABLE #Auxiliar1	
			(
			 IdDetalleProduccionOrden INTEGER,
			 IdArticulo INTEGER,
			 Cantidad NUMERIC(18,2),
			 IdUnidad INTEGER,
			 Partida VARCHAR(20),
			 IdUbicacion INTEGER,
			 IdObra INTEGER,
			 DescargaPorKit VARCHAR(2)
			)
CREATE TABLE #Auxiliar2 
			(
			 IdArticuloConjunto INTEGER, 
			 IdUnidadConjunto INTEGER, 
			 CantidadConjunto NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdArticuloConjunto) ON [PRIMARY]

INSERT INTO #Auxiliar1 
 SELECT IdDetalleProduccionOrden, IdArticulo, Cantidad, IdUnidad, Partida, IdUbicacion, 
	IdObra, DescargaPorKit
 FROM DetalleProduccionOrdenes DetSal
 WHERE DetSal.IdProduccionOrden = @IdProduccionOrden

CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdDetalleProduccionOrden) ON [PRIMARY]

/*  CURSOR  */
DECLARE @IdStock int, @IdDetalleProduccionOrden int, @IdArticulo int, @Cantidad numeric(18,2), 
	@IdUnidad int, @Partida varchar(20), @IdUbicacion int, @IdObra int, @DescargaPorKit varchar(2)

DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdDetalleProduccionOrden, IdArticulo, Cantidad, IdUnidad, Partida, 
			IdUbicacion, IdObra, DescargaPorKit
		FROM #Auxiliar1
		ORDER BY IdDetalleProduccionOrden
OPEN Cur
FETCH NEXT FROM Cur INTO @IdDetalleProduccionOrden, @IdArticulo, @Cantidad, @IdUnidad, 
			 @Partida, @IdUbicacion, @IdObra, @DescargaPorKit
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF IsNull(@DescargaPorKit,'NO')<>'SI'
	   BEGIN
		SET @IdStock=IsNull((Select Top 1 Stock.IdStock
					From Stock 
					Where IdArticulo=@IdArticulo and Partida=@Partida and 
						IdUbicacion=@IdUbicacion and IdObra=@IdObra and 
						IdUnidad=@IdUnidad),0)
		IF @IdStock>0 
			UPDATE Stock
			SET CantidadUnidades=IsNull(CantidadUnidades,0)+@Cantidad
			WHERE IdArticulo=@IdArticulo and Partida=@Partida and 
				IdUbicacion=@IdUbicacion and IdObra=@IdObra and IdUnidad=@IdUnidad
		ELSE
			INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional,
						IdUnidad, IdUbicacion, IdObra)
			VALUES (@IdArticulo, @Partida, @Cantidad, Null, @IdUnidad, @IdUbicacion, @IdObra)
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
		DECLARE Cur1 CURSOR LOCAL FORWARD_ONLY 
			FOR SELECT IdArticuloConjunto, IdUnidadConjunto, CantidadConjunto 
				FROM #Auxiliar2 ORDER BY IdArticuloConjunto
		OPEN Cur1
		FETCH NEXT FROM Cur1 INTO @IdArticuloConjunto, @IdUnidadConjunto, @CantidadConjunto
		WHILE @@FETCH_STATUS = 0
		   BEGIN
			SET @IdStock=IsNull((Select Top 1 Stock.IdStock
						From Stock 
						Where IdArticulo=@IdArticuloConjunto and Partida='' and 
							IdUbicacion=@IdUbicacion and IdObra=@IdObra and 
							IdUnidad=@IdUnidadConjunto),0)
			IF @IdStock>0 
				UPDATE Stock
				SET CantidadUnidades=IsNull(CantidadUnidades,0)+(@Cantidad*@CantidadConjunto)
				WHERE IdStock=@IdStock
			ELSE
				INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional,
							IdUnidad, IdUbicacion, IdObra)
				VALUES (@IdArticuloConjunto, 0, (@Cantidad*@CantidadConjunto), Null, 
					@IdUnidadConjunto, @IdUbicacion, @IdObra)
			FETCH NEXT FROM Cur1 INTO @IdArticuloConjunto, @IdUnidadConjunto, @CantidadConjunto
		   END
		CLOSE Cur1
		DEALLOCATE Cur1
		SET NOCOUNT OFF
	   END

	IF DB_ID(@BasePRONTOMANT) is not null
	   BEGIN
		SET @sql1='Delete '+@BasePRONTOMANT+'.dbo.DetalleConsumos 
				Where IsNull(IdDetalleProduccionOrdenPRONTO,-1)='+Convert(varchar,@IdDetalleProduccionOrden)
		EXEC sp_executesql @sql1

		SET @sql1='Delete '+@BasePRONTOMANT+'.dbo.DetalleOrdenesesTrabajoConsumos 
				Where IsNull(IdDetalleProduccionOrdenPRONTO,-1)='+Convert(varchar,@IdDetalleProduccionOrden)
		EXEC sp_executesql @sql1
	   END

	FETCH NEXT FROM Cur INTO @IdDetalleProduccionOrden, @IdArticulo, @Cantidad, @IdUnidad, 
				 @Partida, @IdUbicacion, @IdObra, @DescargaPorKit
   END
CLOSE Cur
DEALLOCATE Cur

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
