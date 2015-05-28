CREATE Procedure [dbo].[DetRemitos_A]

@IdDetalleRemito int  output,
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

DECLARE @Anulado varchar(2), @IdStock1 int

SET @Anulado=IsNull((Select Top 1 Anulado From Remitos Where IdRemito=@IdRemito),'NO')

IF @Anulado<>'SI'
  BEGIN
	IF IsNull(@DescargaPorKit,'NO')<>'SI'
	  BEGIN
		SET @IdStock1=IsNull((Select Top 1 Stock.IdStock From Stock 
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
		CREATE TABLE #Auxiliar1 (IdArticuloConjunto INTEGER, IdUnidadConjunto INTEGER, CantidadConjunto NUMERIC(18,3))
		INSERT INTO #Auxiliar1 
		 SELECT dc.IdArticulo, dc.IdUnidad, IsNull(dc.Cantidad,0)
		 FROM DetalleConjuntos dc
		 LEFT OUTER JOIN Conjuntos ON dc.IdConjunto = Conjuntos.IdConjunto
		 WHERE (Conjuntos.IdArticulo = @IdArticulo)

		DECLARE @IdArticuloConjunto int, @IdUnidadConjunto int, @CantidadConjunto numeric(18,3)
		CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdArticuloConjunto) ON [PRIMARY]
		DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
			FOR SELECT IdArticuloConjunto, IdUnidadConjunto, CantidadConjunto FROM #Auxiliar1 ORDER BY IdArticuloConjunto
		OPEN Cur
		FETCH NEXT FROM Cur INTO @IdArticuloConjunto, @IdUnidadConjunto, @CantidadConjunto
		WHILE @@FETCH_STATUS = 0
		  BEGIN
			SET @IdStock1=IsNull((Select Top 1 Stock.IdStock From Stock 
						Where IdArticulo=@IdArticuloConjunto and Partida='' and IdUbicacion=@IdUbicacion and IdObra=@IdObra and IdUnidad=@IdUnidadConjunto),0)
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

		DROP TABLE #Auxiliar1
		SET NOCOUNT OFF
	  END
  END

INSERT INTO [DetalleRemitos]
(
 IdRemito,
 NumeroItem,
 Cantidad,
 IdUnidad,
 IdArticulo,
 Precio,
 Observaciones,
 PorcentajeCertificacion,
 OrigenDescripcion,
 IdDetalleOrdenCompra,
 TipoCancelacion,
 IdUbicacion,
 IdObra,
 Partida,
 DescargaPorKit,
 NumeroCaja,
 Talle,
 IdColor
)
VALUES 
(
 @IdRemito,
 @NumeroItem,
 @Cantidad,
 @IdUnidad,
 @IdArticulo,
 @Precio,
 @Observaciones,
 @PorcentajeCertificacion,
 @OrigenDescripcion,
 @IdDetalleOrdenCompra,
 @TipoCancelacion,
 @IdUbicacion,
 @IdObra,
 @Partida,
 @DescargaPorKit,
 @NumeroCaja,
 @Talle,
 @IdColor
)

SELECT @IdDetalleRemito=@@identity

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdDetalleRemito)