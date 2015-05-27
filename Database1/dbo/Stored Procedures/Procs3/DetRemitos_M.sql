CREATE Procedure [dbo].[DetRemitos_M]

@IdDetalleRemito int,
@IdRemito int,
@NumeroItem int,
@Cantidad numeric(18,3),
@IdUnidad int,
@IdArticulo int,
@Precio numeric(18,2),
@Observaciones ntext,
@PorcentajeCertificacion numeric(6,2),
@OrigenDescripcion int,
@IdDetalleOrdenCompra int,
@TipoCancelacion int,
@IdUbicacion int,
@IdObra int,
@Partida varchar(20),
@DescargaPorKit varchar(2),
@NumeroCaja int,
@Talle varchar(2),
@IdColor int

AS

BEGIN TRAN

DECLARE @IdStockAnt int, @IdArticuloAnt int, @PartidaAnt varchar(20), @CantidadUnidadesAnt numeric(18,2), @IdUnidadAnt int, @IdUbicacionAnt int, @IdObraAnt int, 
	@NumeroCajaAnt int, @IdStock1 int, @Anulado varchar(2), @IdColorAnt int, @TalleAnt varchar(2)

SET @Anulado=IsNull((Select Top 1 Anulado From Remitos Where IdRemito=@IdRemito),'NO')
IF @Anulado<>'SI'
   BEGIN
	SET @IdArticuloAnt=IsNull((Select Top 1 IdArticulo From DetalleRemitos Where IdDetalleRemito=@IdDetalleRemito),0)
	SET @PartidaAnt=IsNull((Select Top 1 Partida From DetalleRemitos Where IdDetalleRemito=@IdDetalleRemito),'')
	SET @CantidadUnidadesAnt=IsNull((Select Top 1 Cantidad From DetalleRemitos Where IdDetalleRemito=@IdDetalleRemito),0)
	SET @IdUnidadAnt=IsNull((Select Top 1 IdUnidad From DetalleRemitos Where IdDetalleRemito=@IdDetalleRemito),0)
	SET @IdUbicacionAnt=IsNull((Select Top 1 IdUbicacion From DetalleRemitos Where IdDetalleRemito=@IdDetalleRemito),0)
	SET @IdObraAnt=IsNull((Select Top 1 IdObra From DetalleRemitos Where IdDetalleRemito=@IdDetalleRemito),0)
	SET @NumeroCajaAnt=IsNull((Select Top 1 NumeroCaja From DetalleRemitos Where IdDetalleRemito=@IdDetalleRemito),0)
	SET @IdColorAnt=IsNull((Select Top 1 IdColor From DetalleRemitos Where IdDetalleRemito=@IdDetalleRemito),0)
	SET @TalleAnt=(Select Top 1 Talle From DetalleRemitos Where IdDetalleRemito=@IdDetalleRemito)

	IF IsNull(@DescargaPorKit,'NO')<>'SI'
	   BEGIN
		SET @IdStockAnt=IsNull((Select Top 1 Stock.IdStock
					From Stock 
					Where IdArticulo=@IdArticuloAnt and Partida=@PartidaAnt and IdUbicacion=@IdUbicacionAnt and IdObra=@IdObraAnt and IdUnidad=@IdUnidadAnt and 
						IsNull(NumeroCaja,0)=IsNull(@NumeroCajaAnt,0) and IsNull(IdColor,0)=IsNull(@IdColorAnt,0) and IsNull(Talle,'')=IsNull(@TalleAnt,'')),0)
		IF @IdStockAnt>0 
			UPDATE Stock
			SET CantidadUnidades=IsNull(CantidadUnidades,0)+@CantidadUnidadesAnt
			WHERE IdStock=@IdStockAnt
		ELSE
			INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra, NumeroCaja, IdColor, Talle)
			VALUES (@IdArticuloAnt, @PartidaAnt, @CantidadUnidadesAnt, Null, @IdUnidadAnt, @IdUbicacionAnt, @IdObraAnt, @NumeroCajaAnt, @IdColorAnt, @TalleAnt)
		
		SET @IdStock1=IsNull((Select Top 1 Stock.IdStock
					From Stock 
					Where IdArticulo=@IdArticulo and Partida=@Partida and IdUbicacion=@IdUbicacion and IdObra=@IdObra and IdUnidad=@IdUnidad and 
						IsNull(NumeroCaja,0)=IsNull(@NumeroCaja,0) and IsNull(IdColor,0)=IsNull(@IdColor,0) and IsNull(Talle,'')=IsNull(@Talle,'')),0)
		IF @IdStock1>0 
			UPDATE Stock
			SET CantidadUnidades=IsNull(CantidadUnidades,0)-@Cantidad
			WHERE IdStock=@IdStock1
		ELSE
			INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra, NumeroCaja, IdColor, Talle)
			VALUES (@IdArticulo, @Partida, @Cantidad*-1, Null, @IdUnidad, @IdUbicacion, @IdObra, @NumeroCaja, @IdColor, @Talle)
	   END
	ELSE
	   BEGIN
		SET NOCOUNT ON
		DECLARE @IdArticuloConjunto int, @IdUnidadConjunto int, @CantidadConjunto numeric(18,3)

		CREATE TABLE #Auxiliar1 (IdArticuloConjunto INTEGER, IdUnidadConjunto INTEGER, CantidadConjunto NUMERIC(18,3))
		INSERT INTO #Auxiliar1 
		 SELECT dc.IdArticulo, dc.IdUnidad, IsNull(dc.Cantidad,0)
		 FROM DetalleConjuntos dc
		 LEFT OUTER JOIN Conjuntos ON dc.IdConjunto = Conjuntos.IdConjunto
		 WHERE (Conjuntos.IdArticulo = @IdArticuloAnt)

		CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdArticuloConjunto) ON [PRIMARY]
		DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
			FOR SELECT IdArticuloConjunto, IdUnidadConjunto, CantidadConjunto FROM #Auxiliar1 ORDER BY IdArticuloConjunto
		OPEN Cur
		FETCH NEXT FROM Cur INTO @IdArticuloConjunto, @IdUnidadConjunto, @CantidadConjunto
		WHILE @@FETCH_STATUS = 0
		   BEGIN
			SET @IdStock1=IsNull((Select Top 1 Stock.IdStock
						From Stock 
						Where IdArticulo=@IdArticuloConjunto and Partida='' and IdUbicacion=@IdUbicacion and IdObra=@IdObra and 
							IdUnidad=@IdUnidadConjunto),0)
			IF @IdStock1>0 
				UPDATE Stock
				SET CantidadUnidades=IsNull(CantidadUnidades,0)+(@Cantidad*@CantidadConjunto)
				WHERE IdStock=@IdStock1
			ELSE
				INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra)
				VALUES (@IdArticuloConjunto, 0, (@Cantidad*@CantidadConjunto), Null, @IdUnidadConjunto, @IdUbicacion, @IdObra)
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
			SET @IdStock1=IsNull((Select Top 1 Stock.IdStock
						From Stock 
						Where IdArticulo=@IdArticuloConjunto and Partida='' and IdUbicacion=@IdUbicacion and IdObra=@IdObra and 
							IdUnidad=@IdUnidadConjunto),0)
			IF @IdStock1>0 
				UPDATE Stock
				SET CantidadUnidades=IsNull(CantidadUnidades,0)-(@Cantidad*@CantidadConjunto)
				WHERE IdStock=@IdStock1
			ELSE
				INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra)
				VALUES (@IdArticuloConjunto, 0, (@Cantidad*@CantidadConjunto)*-1, Null, @IdUnidadConjunto, @IdUbicacion, @IdObra)
			FETCH NEXT FROM Cur INTO @IdArticuloConjunto, @IdUnidadConjunto, @CantidadConjunto
		   END
		CLOSE Cur
		DEALLOCATE Cur
		DROP TABLE #Auxiliar2
		SET NOCOUNT OFF
	   END
   END

UPDATE [DetalleRemitos]
SET 
 IdRemito=@IdRemito,
 NumeroItem=@NumeroItem,
 Cantidad=@Cantidad,
 IdUnidad=@IdUnidad,
 IdArticulo=@IdArticulo,
 Precio=@Precio,
 Observaciones=@Observaciones,
 PorcentajeCertificacion=@PorcentajeCertificacion,
 OrigenDescripcion=@OrigenDescripcion,
 IdDetalleOrdenCompra=@IdDetalleOrdenCompra,
 TipoCancelacion=@TipoCancelacion,
 IdUbicacion=@IdUbicacion,
 IdObra=@IdObra,
 Partida=@Partida,
 DescargaPorKit=@DescargaPorKit,
 NumeroCaja=@NumeroCaja,
 Talle=@Talle,
 IdColor=@IdColor
WHERE (IdDetalleRemito=@IdDetalleRemito)

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdDetalleRemito)