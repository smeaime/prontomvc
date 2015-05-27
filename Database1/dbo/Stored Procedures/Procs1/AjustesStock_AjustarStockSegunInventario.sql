CREATE Procedure [dbo].[AjustesStock_AjustarStockSegunInventario]

@IdAjusteStock int

AS

SET NOCOUNT ON

DECLARE @TipoAjusteInventario varchar(1)

SET @TipoAjusteInventario=IsNull((Select Top 1 TipoAjusteInventario From AjustesStock Where IdAjusteStock=@IdAjusteStock),'')

CREATE TABLE #Auxiliar1 
			(
			 IdDetalleAjusteStock INTEGER,
			 IdArticulo INTEGER,
			 IdObra INTEGER,
			 IdUbicacion INTEGER,
			 Partida VARCHAR(20),
			 Cantidad NUMERIC(18,2),
			 CantidadInventariada NUMERIC(18,2),
			 IdUnidad INTEGER,
			 NumeroCaja INTEGER,
			 IdColor INTEGER,
			 Talle VARCHAR(2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdDetalleAjusteStock) ON [PRIMARY]

INSERT INTO #Auxiliar1 
 SELECT daj.IdDetalleAjusteStock, daj.IdArticulo, daj.IdObra, daj.IdUbicacion, daj.Partida, IsNull(daj.CantidadUnidades,0), IsNull(daj.CantidadInventariada,0), 
	daj.IdUnidad, IsNull(daj.NumeroCaja,0), IsNull(daj.IdColor,0), IsNull(daj.Talle,'')
 FROM DetalleAjustesStock daj
 LEFT OUTER JOIN AjustesStock ON daj.IdAjusteStock=AjustesStock.IdAjusteStock
 WHERE AjustesStock.IdAjusteStock=@IdAjusteStock


CREATE TABLE #Auxiliar2 
			(
			 IdStock INTEGER,
			 IdArticulo INTEGER,
			 IdObra INTEGER,
			 IdUbicacion INTEGER,
			 Partida VARCHAR(20),
			 CantidadUnidades NUMERIC(18,2),
			 IdUnidad INTEGER,
			 NumeroCaja INTEGER,
			 IdColor INTEGER,
			 Talle VARCHAR(2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdStock) ON [PRIMARY]

INSERT INTO #Auxiliar2 
 SELECT IdStock, IdArticulo, IdObra, IdUbicacion, Partida, CantidadUnidades, IdUnidad, NumeroCaja, IdColor, Talle
 FROM Stock
 WHERE IsNull(CantidadUnidades,0)<>0 and (@TipoAjusteInventario='T' or (@TipoAjusteInventario='P' and IsNull((Select Top 1 #Auxiliar1.IdArticulo From #Auxiliar1 Where #Auxiliar1.IdArticulo=Stock.IdArticulo),0)>0))


DECLARE @IdDetalleAjusteStock INTEGER, @IdStock INTEGER, @IdArticulo INTEGER, @IdObra INTEGER, @IdUbicacion INTEGER, @Partida VARCHAR(20), @Cantidad NUMERIC(18,2), 
	@CantidadUnidades NUMERIC(18,2), @CantidadInventariada NUMERIC(18,2), @IdUnidad INTEGER, @NumeroCaja INTEGER, @IdColor INTEGER, @Talle VARCHAR(2)

/* Primero pongo en cero el stock (parcial o total)  */
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdStock, IdArticulo, IdObra, IdUbicacion, Partida, CantidadUnidades, IdUnidad, NumeroCaja, IdColor, Talle FROM #Auxiliar2 ORDER BY IdStock
OPEN Cur
FETCH NEXT FROM Cur INTO @IdStock, @IdArticulo, @IdObra, @IdUbicacion, @Partida, @CantidadUnidades, @IdUnidad, @NumeroCaja, @IdColor, @Talle
WHILE @@FETCH_STATUS = 0
  BEGIN
	UPDATE Stock
	SET CantidadUnidades=0
	WHERE IdStock=@IdStock

	INSERT INTO [DetalleAjustesStock]
	(IdAjusteStock, IdArticulo, Partida, CantidadUnidades, IdUnidad, Observaciones, IdUbicacion, IdObra, NumeroCaja, Talle, IdColor)
	VALUES 
	(@IdAjusteStock, @IdArticulo, @Partida, @CantidadUnidades * -1, @IdUnidad, 'AJUSTE AUTOMATICO POR INVENTARIO', @IdUbicacion, @IdObra, @NumeroCaja, @Talle, @IdColor)
	
	FETCH NEXT FROM Cur INTO @IdStock, @IdArticulo, @IdObra, @IdUbicacion, @Partida, @CantidadUnidades, @IdUnidad, @NumeroCaja, @IdColor, @Talle
  END
CLOSE Cur
DEALLOCATE Cur


/* Luego paso la cantidad inventariada a ajustada y genero el stock  */
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetalleAjusteStock, IdArticulo, IdObra, IdUbicacion, Partida, Cantidad, CantidadInventariada, IdUnidad, NumeroCaja, IdColor, Talle FROM #Auxiliar1 ORDER BY IdDetalleAjusteStock
OPEN Cur
FETCH NEXT FROM Cur INTO @IdDetalleAjusteStock, @IdArticulo, @IdObra, @IdUbicacion, @Partida, @Cantidad, @CantidadInventariada, @IdUnidad, @NumeroCaja, @IdColor, @Talle
WHILE @@FETCH_STATUS = 0
  BEGIN
	UPDATE DetalleAjustesStock
	SET CantidadUnidades=@CantidadInventariada
	WHERE IdDetalleAjusteStock=@IdDetalleAjusteStock

	SET @IdStock=IsNull((Select Top 1 Stock.IdStock From Stock 
				Where IdArticulo=@IdArticulo and Partida=@Partida and IdUbicacion=@IdUbicacion and IdObra=@IdObra and IdUnidad=@IdUnidad and 
					IsNull(NumeroCaja,0)=IsNull(@NumeroCaja,0) and IsNull(IdColor,0)=IsNull(@IdColor,0) and IsNull(Talle,'')=IsNull(@Talle,'')),0)
	IF @IdStock>0 
		UPDATE Stock
		SET CantidadUnidades=IsNull(CantidadUnidades,0) + @CantidadInventariada
		WHERE IdStock=@IdStock
	ELSE
		INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra, NumeroCaja, IdColor, Talle)
		VALUES (@IdArticulo, @Partida, @CantidadInventariada, Null, @IdUnidad, @IdUbicacion, @IdObra, @NumeroCaja, @IdColor, @Talle)
	
	FETCH NEXT FROM Cur INTO @IdDetalleAjusteStock, @IdArticulo, @IdObra, @IdUbicacion, @Partida, @Cantidad, @CantidadInventariada, @IdUnidad, @NumeroCaja, @IdColor, @Talle
  END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2