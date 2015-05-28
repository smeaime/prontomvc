CREATE PROCEDURE [dbo].[Recepciones_AjustarStockRecepcionAnulada]

@IdRecepcion int

AS

CREATE TABLE #Auxiliar1	
			(
			 IdDetalleRecepcion INTEGER,
			 IdArticulo INTEGER,
			 Cantidad NUMERIC(18,2),
			 IdUnidad INTEGER,
			 Partida VARCHAR(20),
			 IdUbicacion INTEGER,
			 IdObra INTEGER,
			 NumeroCaja INTEGER,
			 IdColor INTEGER,
			 IdProduccionTerminado INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdDetalleRecepcion) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT IdDetalleRecepcion, IdArticulo, CantidadCC, IdUnidad, Partida, IdUbicacion, IdObra, NumeroCaja, IdColor, IdProduccionTerminado
 FROM DetalleRecepciones DetRec
 WHERE DetRec.IdRecepcion = @IdRecepcion

/*  CURSOR  */
DECLARE @IdStock int, @IdDetalleRecepcion int, @IdArticulo int, @Cantidad numeric(18,2), @IdUnidad int, @Partida varchar(20), @IdUbicacion int, @IdObra int, @NumeroCaja int, @IdColor int, @IdProduccionTerminado int

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetalleRecepcion, IdArticulo, Cantidad, IdUnidad, Partida, IdUbicacion, IdObra, NumeroCaja, IdColor, IdProduccionTerminado FROM #Auxiliar1 ORDER BY IdDetalleRecepcion
OPEN Cur
FETCH NEXT FROM Cur INTO @IdDetalleRecepcion, @IdArticulo, @Cantidad, @IdUnidad, @Partida, @IdUbicacion, @IdObra, @NumeroCaja, @IdColor, @IdProduccionTerminado
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @IdStock=IsNull((Select Top 1 Stock.IdStock From Stock Where IdArticulo=@IdArticulo and Partida=@Partida and IdUbicacion=@IdUbicacion and IdObra=@IdObra and IdUnidad=@IdUnidad and IsNull(NumeroCaja,0)=IsNull(@NumeroCaja,0) and IsNull(IdColor,0)=IsNull(@IdColor,0)),0)
	IF @IdStock>0 
		UPDATE Stock
		SET CantidadUnidades=IsNull(CantidadUnidades,0)-@Cantidad
		WHERE IdStock=@IdStock
	ELSE
		INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra, NumeroCaja, IdColor)
		VALUES (@IdArticulo, @Partida, @Cantidad*-1, Null, @IdUnidad, @IdUbicacion, @IdObra, @NumeroCaja, @IdColor)

	IF @IdProduccionTerminado is not null
		UPDATE ProduccionTerminados
		SET IdDetalleRecepcion=Null
		WHERE IdProduccionTerminado=@IdProduccionTerminado

	FETCH NEXT FROM Cur INTO @IdDetalleRecepcion, @IdArticulo, @Cantidad, @IdUnidad, @Partida, @IdUbicacion, @IdObra, @NumeroCaja, @IdColor, @IdProduccionTerminado
END
CLOSE Cur
DEALLOCATE Cur

--BORRADO DE SUBDIARIOS
DELETE FROM Subdiarios WHERE IdTipoComprobante=60 and IdComprobante=@IdRecepcion

DROP TABLE #Auxiliar1