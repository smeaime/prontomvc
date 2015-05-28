
CREATE Procedure [dbo].[Stock_ActualizarDesdeSAT]

@IdArticulo int,
@Partida varchar(20),
@CantidadUnidades numeric(18,2),
@IdUnidad int,
@IdUbicacion int,
@IdObra int

AS

DECLARE @IdStock int
SET @IdStock=IsNull((Select Top 1 Stock.IdStock
			From Stock
			Where IdArticulo=@IdArticulo and Partida=@Partida and 
				IdUnidad=@IdUnidad and IdUbicacion=@IdUbicacion and 
				IdObra=@IdObra),-1)

IF @IdStock<0
	BEGIN
		INSERT INTO [Stock]
		(
		 IdArticulo,
		 Partida,
		 CantidadUnidades,
		 CantidadAdicional,
		 IdUnidad,
		 IdUbicacion,
		 IdObra
		)
		VALUES
		(
		 @IdArticulo,
		 @Partida,
		 @CantidadUnidades,
		 0,
		 @IdUnidad,
		 @IdUbicacion,
		 @IdObra
		)
	END
ELSE
	BEGIN
		UPDATE Stock
		SET CantidadUnidades=CantidadUnidades+@CantidadUnidades
		WHERE IdArticulo=@IdArticulo and Partida=@Partida and 
			IdUnidad=@IdUnidad and IdUbicacion=@IdUbicacion and 
			IdObra=@IdObra
	END
