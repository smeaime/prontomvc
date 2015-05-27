
CREATE Procedure [dbo].[Articulos_TX_ValidarNumeroInventario]
@NumeroInventario varchar(20),
@IdArticulo int
AS 
SELECT * 
FROM Articulos
WHERE (@IdArticulo<=0 or Articulos.IdArticulo<>@IdArticulo) and 
	NumeroInventario=@NumeroInventario
