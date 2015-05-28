
CREATE Procedure [dbo].[Articulos_TX_StockPorArticuloPartidaUnidadUbicacionObra]

@IdArticulo int,
@Partida varchar(20) = Null,
@IdUnidad int,
@IdUbicacion int,
@IdObra int

AS

SET @Partida=IsNull(@Partida,'')

SELECT Articulos.Descripcion as [Articulo], 
	IsNull((Select Sum(IsNull(CantidadUnidades,0)) From Stock
		Where Stock.IdArticulo = Articulos.IdArticulo and IsNull(Stock.Partida,'')=@Partida and Stock.IdUnidad=@IdUnidad and 
			(@IdUbicacion<=0 or Stock.IdUbicacion=@IdUbicacion) and (@IdObra<=0 or Stock.IdObra=@IdObra) and IsNull(Articulos.RegistrarStock,'SI')='SI'),0) as [Stock]
FROM Articulos
WHERE Articulos.IdArticulo=@IdArticulo
