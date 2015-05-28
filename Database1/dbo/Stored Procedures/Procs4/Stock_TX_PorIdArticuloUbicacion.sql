
CREATE Procedure Stock_TX_PorIdArticuloUbicacion

@IdArticulo int,
@IdUbicacion int = Null,
@Partida varchar(20) = null

AS 

SET @IdUbicacion=IsNull(@IdUbicacion,0)

SELECT Stock.IdArticulo, SUM(Stock.CantidadUnidades) as [Stock actual]
FROM Stock
LEFT OUTER JOIN Articulos ON Stock.IdArticulo=Articulos.IdArticulo
WHERE 
	Stock.IdArticulo=@IdArticulo and 
	IsNull(Stock.IdUbicacion,0)=@IdUbicacion and
	IsNull(Stock.Partida,'')=@Partida
GROUP BY Stock.IdArticulo
