CREATE Procedure [dbo].[DetAjustesStock_A]

@IdDetalleAjusteStock int  output,
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

DECLARE @IdStock int

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

INSERT INTO [DetalleAjustesStock]
(
 IdAjusteStock,
 IdArticulo,
 Partida,
 CantidadUnidades,
 CantidadAdicional,
 IdUnidad,
 Cantidad1,
 Cantidad2,
 Observaciones,
 IdUbicacion,
 IdObra,
 EnviarEmail,
 IdDetalleAjusteStockOriginal,
 IdAjusteStockOriginal,
 IdOrigenTransmision,
 IdDetalleSalidaMateriales,
 NumeroCaja,
 Talle,
 IdColor,
 CantidadInventariada,
 IdDetalleValeSalida
)
VALUES 
(
 @IdAjusteStock,
 @IdArticulo,
 @Partida,
 @CantidadUnidades,
 @CantidadAdicional,
 @IdUnidad,
 @Cantidad1,
 @Cantidad2,
 @Observaciones,
 @IdUbicacion,
 @IdObra,
 @EnviarEmail,
 @IdDetalleAjusteStockOriginal,
 @IdAjusteStockOriginal,
 @IdOrigenTransmision,
 @IdDetalleSalidaMateriales,
 @NumeroCaja,
 @Talle,
 @IdColor,
 @CantidadInventariada,
 @IdDetalleValeSalida
)
SELECT @IdDetalleAjusteStock=@@identity

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdDetalleAjusteStock)