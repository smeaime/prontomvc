


CREATE PROCEDURE ProduccionOrdenes_CerrarAjustarStock

@IdProduccionOrden int

AS

--DECLARE @IdArticulo int, @Cantidad numeric(18,2), 
--	@IdUnidad int, @Partida varchar(20), @IdUbicacion int, 	@IdObra int


--doy el alta de stock del producido. La Partida es el numero de Orden

	INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional,
				IdUnidad, IdUbicacion, IdObra)
--	VALUES (@IdArticulo, @Partida, @Cantidad, Null, @IdUnidad, @IdUbicacion, @IdObra)
	select IdArticuloGenerado, NumeroOrdenProduccion, Cantidad, NumeroOrdenProduccion, IdUnidad, null,null
	from ProduccionOrdenes
	where idproduccionorden=@IdProduccionOrden

--y doy la baja de stock de lo usado

/*
	UPDATE Stock
	SET CantidadUnidades=IsNull(CantidadUnidades,0)+@Cantidad
	WHERE IdArticulo=@IdArticulo and Partida=@Partida and 
		IdUbicacion=@IdUbicacion and IdObra=@IdObra and IdUnidad=@IdUnidad

	select IdArticulo, Partida, Cantidad, Null, IdUnidad, IdUbicacion,IdObra
	from detalleOrdenProduccion
	where idproduccionorden=@IdProduccionOrden

*/


	/*  CURSOR  */
	DECLARE @IdStock int, @IdDetalleProduccionOrden int, @IdArticulo int, @Cantidad numeric(18,2), 
		@IdUnidad int, @Partida varchar(20), @IdUbicacion int, @IdObra int, @DescargaPorKit varchar(2)
	
	DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
		FOR	select IdDetalleProduccionOrden,IdArticulo, Partida, Cantidad, IdUnidad, 
				IdUbicacion,IdObra
			from detalleProduccionordenes
			where idproduccionorden=@IdProduccionOrden

	OPEN Cur
	FETCH NEXT FROM Cur INTO @IdDetalleProduccionOrden, @IdArticulo,@Partida, @Cantidad, @IdUnidad, 
				 @IdUbicacion, @IdObra

WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE Stock
	SET CantidadUnidades=IsNull(CantidadUnidades,0)-@Cantidad
	WHERE IdArticulo=@IdArticulo and Partida=@Partida and 
		IdUbicacion=@IdUbicacion and IdUnidad=@IdUnidad

	FETCH NEXT FROM Cur INTO @IdDetalleProduccionOrden, @IdArticulo,@Partida, @Cantidad, @IdUnidad, 
				 @IdUbicacion, @IdObra
end

