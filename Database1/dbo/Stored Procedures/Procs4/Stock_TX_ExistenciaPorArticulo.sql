
CREATE Procedure [dbo].[Stock_TX_ExistenciaPorArticulo]

@IdArticulo int

AS 

SELECT Stock.IdArticulo, SUM(Stock.CantidadUnidades) as [Stock actual]
FROM Stock 
LEFT OUTER JOIN Articulos ON Stock.IdArticulo=Articulos.IdArticulo
WHERE Stock.IdArticulo=@IdArticulo and IsNull(Articulos.RegistrarStock,'SI')='SI'
GROUP BY Stock.IdArticulo
