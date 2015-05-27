CREATE Procedure [dbo].[DetAjustesStock_M]

@IdDetalleAjusteStock int,
@IdAjusteStock int,
@IdArticulo int,
@Partida varchar(20),
@CantidadUnidades numeric(18,2),
@CantidadAdicional numeric(18,2),
@IdUnidad int,
@Cantidad1 numeric(18,2),
@Cantidad2 numeric(18,2),
@Observaciones ntext,
@IdUbicacion int,
@IdObra int,
@EnviarEmail tinyint,
@IdDetalleAjusteStockOriginal int,
@IdAjusteStockOriginal int,
@IdOrigenTransmision int,
@IdDetalleSalidaMateriales int,
@NumeroCaja int = Null,
@Talle varchar(2) = Null,
@IdColor int = Null,
@CantidadInventariada numeric(18,2) = Null,
@IdDetalleValeSalida int = Null

AS

BEGIN TRAN

DECLARE @IdStockAnt int, @IdArticuloAnt int, @PartidaAnt varchar(20), @CantidadUnidadesAnt numeric(18,2),@IdUnidadAnt int, @IdUbicacionAnt int, @IdObraAnt int, @IdStock int, 
		@NumeroCajaAnt int, @TalleAnt varchar(20), @IdColorAnt int

SET @IdArticuloAnt=IsNull((Select Top 1 IdArticulo From DetalleAjustesStock Where IdDetalleAjusteStock=@IdDetalleAjusteStock),0)
SET @PartidaAnt=IsNull((Select Top 1 Partida From DetalleAjustesStock Where IdDetalleAjusteStock=@IdDetalleAjusteStock),'')
SET @CantidadUnidadesAnt=IsNull((Select Top 1 CantidadUnidades From DetalleAjustesStock Where IdDetalleAjusteStock=@IdDetalleAjusteStock),0)
SET @IdUnidadAnt=IsNull((Select Top 1 IdUnidad From DetalleAjustesStock Where IdDetalleAjusteStock=@IdDetalleAjusteStock),0)
SET @IdUbicacionAnt=IsNull((Select Top 1 IdUbicacion From DetalleAjustesStock Where IdDetalleAjusteStock=@IdDetalleAjusteStock),0)
SET @IdObraAnt=IsNull((Select Top 1 IdObra From DetalleAjustesStock Where IdDetalleAjusteStock=@IdDetalleAjusteStock),0)
SET @NumeroCajaAnt=(Select Top 1 NumeroCaja From DetalleAjustesStock Where IdDetalleAjusteStock=@IdDetalleAjusteStock)
SET @TalleAnt=(Select Top 1 Talle From DetalleAjustesStock Where IdDetalleAjusteStock=@IdDetalleAjusteStock)
SET @IdColorAnt=IsNull((Select Top 1 IdColor From DetalleAjustesStock Where IdDetalleAjusteStock=@IdDetalleAjusteStock),0)

SET @IdStockAnt=IsNull((Select Top 1 Stock.IdStock From Stock 
			Where IdArticulo=@IdArticuloAnt and Partida=@PartidaAnt and IdUbicacion=@IdUbicacionAnt and IdObra=@IdObraAnt and IdUnidad=@IdUnidadAnt and 
				IsNull(NumeroCaja,0)=IsNull(@NumeroCajaAnt,0) and IsNull(IdColor,0)=IsNull(@IdColorAnt,0) and IsNull(Talle,'')=IsNull(@TalleAnt,'')),0)
IF @IdStockAnt>0 
	UPDATE Stock
	SET CantidadUnidades=IsNull(CantidadUnidades,0)-@CantidadUnidadesAnt
	WHERE IdStock=@IdStockAnt
ELSE
	INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra, NumeroCaja, IdColor, Talle)
	VALUES (@IdArticuloAnt, @PartidaAnt, @CantidadUnidadesAnt*-1, Null, @IdUnidadAnt, @IdUbicacionAnt, @IdObraAnt, @NumeroCajaAnt, @IdColorAnt, @TalleAnt)

SET @IdStock=IsNull((Select Top 1 Stock.IdStock
			From Stock 
			Where IdArticulo=@IdArticulo and Partida=@Partida and IdUbicacion=@IdUbicacion and IdObra=@IdObra and IdUnidad=@IdUnidad and 
				IsNull(NumeroCaja,0)=IsNull(@NumeroCaja,0) and IsNull(IdColor,0)=IsNull(@IdColor,0) and IsNull(Talle,'')=IsNull(@Talle,'')),0)
IF @IdStock>0 
	UPDATE Stock
	SET CantidadUnidades=IsNull(CantidadUnidades,0)+@CantidadUnidades
	WHERE IdStock=@IdStock
ELSE
	INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra, NumeroCaja, IdColor, Talle)
	VALUES (@IdArticulo, @Partida, @CantidadUnidades, Null, @IdUnidad, @IdUbicacion, @IdObra, @NumeroCaja, @IdColor, @Talle)

UPDATE [DetalleAjustesStock]
SET 
 IdAjusteStock=@IdAjusteStock,
 IdArticulo=@IdArticulo,
 Partida=@Partida,
 CantidadUnidades=@CantidadUnidades,
 CantidadAdicional=@CantidadAdicional,
 IdUnidad=@IdUnidad,
 Cantidad1=@Cantidad1,
 Cantidad2=@Cantidad2,
 Observaciones=@Observaciones,
 IdUbicacion=@IdUbicacion,
 IdObra=@IdObra,
 EnviarEmail=@EnviarEmail,
 IdDetalleAjusteStockOriginal=@IdDetalleAjusteStockOriginal,
 IdAjusteStockOriginal=@IdAjusteStockOriginal,
 IdOrigenTransmision=@IdOrigenTransmision,
 IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales,
 NumeroCaja=@NumeroCaja,
 Talle=@Talle,
 IdColor=@IdColor,
 CantidadInventariada=@CantidadInventariada,
 IdDetalleValeSalida=@IdDetalleValeSalida
WHERE (IdDetalleAjusteStock=@IdDetalleAjusteStock)

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdDetalleAjusteStock)