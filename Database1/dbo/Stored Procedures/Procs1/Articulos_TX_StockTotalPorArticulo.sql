
CREATE Procedure [dbo].[Articulos_TX_StockTotalPorArticulo]

@IdArticulo int

AS

SELECT Articulos.Descripcion as [Articulo], Articulos.RegistrarStock as [RegistrarStock], Sum(CantidadUnidades) as [Stock]
FROM Stock 
LEFT OUTER JOIN Articulos ON Stock.IdArticulo = Articulos.IdArticulo
WHERE Stock.IdArticulo=@IdArticulo and IsNull(Articulos.RegistrarStock,'SI')='SI'
GROUP BY Articulos.Descripcion, Articulos.RegistrarStock
