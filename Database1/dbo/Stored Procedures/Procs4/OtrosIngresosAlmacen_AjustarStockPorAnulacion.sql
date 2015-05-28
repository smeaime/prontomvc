
CREATE PROCEDURE [dbo].[OtrosIngresosAlmacen_AjustarStockPorAnulacion]

@IdOtroIngresoAlmacen int

AS

CREATE TABLE #Auxiliar1	
			(
			 IdDetalleOtroIngresoAlmacen INTEGER,
			 IdArticulo INTEGER,
			 Cantidad NUMERIC(18,2),
			 IdUnidad INTEGER,
			 Partida VARCHAR(20),
			 IdUbicacion INTEGER,
			 IdObra INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT Det.IdDetalleOtroIngresoAlmacen, Det.IdArticulo, Det.CantidadCC, 
	Det.IdUnidad, Det.Partida, Det.IdUbicacion, Det.IdObra
 FROM DetalleOtrosIngresosAlmacen Det
 WHERE Det.IdOtroIngresoAlmacen = @IdOtroIngresoAlmacen

CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdDetalleOtroIngresoAlmacen) ON [PRIMARY]

/*  CURSOR  */
DECLARE @IdStock int, @IdDetalleOtroIngresoAlmacen int, @IdArticulo int, 
	@Cantidad numeric(18,2), @IdUnidad int, @Partida varchar(20), @IdUbicacion int, 
	@IdObra int

DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR
		SELECT IdDetalleOtroIngresoAlmacen, IdArticulo, Cantidad, IdUnidad, 
			Partida, IdUbicacion, IdObra
		FROM #Auxiliar1
		ORDER BY IdDetalleOtroIngresoAlmacen
OPEN Cur
FETCH NEXT FROM Cur INTO @IdDetalleOtroIngresoAlmacen, @IdArticulo, @Cantidad, 
			 @IdUnidad, @Partida, @IdUbicacion, @IdObra
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @IdStock=IsNull((Select Top 1 Stock.IdStock
				From Stock 
				Where IdArticulo=@IdArticulo and Partida=@Partida and 
					IdUbicacion=@IdUbicacion and IdObra=@IdObra and 
					IdUnidad=@IdUnidad),0)
	IF @IdStock>0 
		UPDATE Stock
		SET CantidadUnidades=IsNull(CantidadUnidades,0)-@Cantidad
		WHERE IdArticulo=@IdArticulo and Partida=@Partida and 
			IdUbicacion=@IdUbicacion and IdObra=@IdObra and IdUnidad=@IdUnidad
	ELSE
		INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional,
					IdUnidad, IdUbicacion, IdObra)
		VALUES (@IdArticulo, @Partida, @Cantidad*-1, Null, @IdUnidad, @IdUbicacion, @IdObra)
	FETCH NEXT FROM Cur INTO @IdDetalleOtroIngresoAlmacen, @IdArticulo, @Cantidad, 
				 @IdUnidad, @Partida, @IdUbicacion, @IdObra
END
CLOSE Cur
DEALLOCATE Cur

DROP TABLE #Auxiliar1
