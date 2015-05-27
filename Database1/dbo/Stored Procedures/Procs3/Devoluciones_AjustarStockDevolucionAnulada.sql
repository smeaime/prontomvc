CREATE PROCEDURE [dbo].[Devoluciones_AjustarStockDevolucionAnulada]

@IdDevolucion int

AS

CREATE TABLE #Auxiliar1	
			(
			 IdDetalleDevolucion INTEGER,
			 IdArticulo INTEGER,
			 Cantidad NUMERIC(18,2),
			 IdUnidad INTEGER,
			 Partida VARCHAR(20),
			 IdUbicacion INTEGER,
			 IdObra INTEGER,
			 NumeroCaja INTEGER,
			 Talle VARCHAR(2),
			 IdColor INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdDetalleDevolucion) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT IdDetalleDevolucion, IdArticulo, Cantidad, IdUnidad, Partida, IdUbicacion, IdObra, NumeroCaja, Talle, IdColor
 FROM DetalleDevoluciones 
 WHERE IdDevolucion = @IdDevolucion

/*  CURSOR  */
DECLARE @IdStock int, @IdDetalleDevolucion int, @IdArticulo int, @Cantidad numeric(18,2), @IdUnidad int, @Partida varchar(20), @IdUbicacion int, @IdObra int, @NumeroCaja int, @Talle varchar(2), @IdColor int

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetalleDevolucion, IdArticulo, Cantidad, IdUnidad, Partida, IdUbicacion, IdObra, NumeroCaja, Talle, IdColor FROM #Auxiliar1 ORDER BY IdDetalleDevolucion
OPEN Cur
FETCH NEXT FROM Cur INTO @IdDetalleDevolucion, @IdArticulo, @Cantidad, @IdUnidad, @Partida, @IdUbicacion, @IdObra, @NumeroCaja, @Talle, @IdColor
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @IdStock=IsNull((Select Top 1 Stock.IdStock From Stock 
				Where IdArticulo=@IdArticulo and Partida=@Partida and IdUbicacion=@IdUbicacion and IdObra=@IdObra and IdUnidad=@IdUnidad and 
					IsNull(NumeroCaja,0)=IsNull(@NumeroCaja,0) and IsNull(IdColor,0)=IsNull(@IdColor,0) and IsNull(Talle,'')=IsNull(@Talle,'')),0)
	IF @IdStock>0 
		UPDATE Stock
		SET CantidadUnidades=IsNull(CantidadUnidades,0)-@Cantidad
		WHERE IdStock=@IdStock
	ELSE
		INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra, NumeroCaja, IdColor, Talle)
		VALUES (@IdArticulo, @Partida, @Cantidad*-1, Null, @IdUnidad, @IdUbicacion, @IdObra, @NumeroCaja, @IdColor, @Talle)

	FETCH NEXT FROM Cur INTO @IdDetalleDevolucion, @IdArticulo, @Cantidad, @IdUnidad, @Partida, @IdUbicacion, @IdObra, @NumeroCaja, @Talle, @IdColor
   END
CLOSE Cur
DEALLOCATE Cur

DROP TABLE #Auxiliar1