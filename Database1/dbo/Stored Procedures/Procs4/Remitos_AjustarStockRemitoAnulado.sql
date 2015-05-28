CREATE PROCEDURE [dbo].[Remitos_AjustarStockRemitoAnulado]

@IdRemito int

AS

CREATE TABLE #Auxiliar1	
			(
			 IdDetalleRemito INTEGER,
			 IdArticulo INTEGER,
			 Cantidad NUMERIC(18,2),
			 IdUnidad INTEGER,
			 Partida VARCHAR(20),
			 IdUbicacion INTEGER,
			 IdObra INTEGER,
			 DescargaPorKit VARCHAR(2),
			 NumeroCaja INTEGER,
			 Talle VARCHAR(2),
			 IdColor INTEGER
			)
CREATE TABLE #Auxiliar2 
			(
			 IdArticuloConjunto INTEGER, 
			 IdUnidadConjunto INTEGER, 
			 CantidadConjunto NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdArticuloConjunto) ON [PRIMARY]

INSERT INTO #Auxiliar1 
 SELECT IdDetalleRemito, IdArticulo, Cantidad, IdUnidad, Partida, IdUbicacion, IdObra, DescargaPorKit, NumeroCaja, Talle, IdColor
 FROM DetalleRemitos DetRem
 WHERE DetRem.IdRemito = @IdRemito

CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdDetalleRemito) ON [PRIMARY]

/*  CURSOR  */
DECLARE @IdStock int, @IdDetalleRemito int, @IdArticulo int, @Cantidad numeric(18,2), @IdUnidad int, @Partida varchar(20), @IdUbicacion int, @IdObra int, 
	@DescargaPorKit varchar(2), @NumeroCaja int, @Talle varchar(2), @IdColor int

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetalleRemito, IdArticulo, Cantidad, IdUnidad, Partida, IdUbicacion, IdObra, DescargaPorKit, NumeroCaja, Talle, IdColor FROM #Auxiliar1 ORDER BY IdDetalleRemito
OPEN Cur
FETCH NEXT FROM Cur INTO @IdDetalleRemito, @IdArticulo, @Cantidad, @IdUnidad, @Partida, @IdUbicacion, @IdObra, @DescargaPorKit, @NumeroCaja, @Talle, @IdColor
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF IsNull(@DescargaPorKit,'NO')<>'SI'
	   BEGIN
		SET @IdStock=IsNull((Select Top 1 Stock.IdStock From Stock 
					Where IdArticulo=@IdArticulo and Partida=@Partida and IdUbicacion=@IdUbicacion and IdObra=@IdObra and IdUnidad=@IdUnidad and 
						IsNull(NumeroCaja,0)=IsNull(@NumeroCaja,0) and IsNull(IdColor,0)=IsNull(@IdColor,0) and IsNull(Talle,'')=IsNull(@Talle,'')),0)
		IF @IdStock>0 
			UPDATE Stock
			SET CantidadUnidades=IsNull(CantidadUnidades,0)+@Cantidad
			WHERE IdStock=@IdStock
		ELSE
			INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra, NumeroCaja, IdColor, Talle)
			VALUES (@IdArticulo, @Partida, @Cantidad, Null, @IdUnidad, @IdUbicacion, @IdObra, @NumeroCaja, @IdColor, @Talle)
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
			SET @IdStock=IsNull((Select Top 1 Stock.IdStock From Stock 
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

	FETCH NEXT FROM Cur INTO @IdDetalleRemito, @IdArticulo, @Cantidad, @IdUnidad, @Partida, @IdUbicacion, @IdObra, @DescargaPorKit, @NumeroCaja, @Talle, @IdColor
   END
CLOSE Cur
DEALLOCATE Cur

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2