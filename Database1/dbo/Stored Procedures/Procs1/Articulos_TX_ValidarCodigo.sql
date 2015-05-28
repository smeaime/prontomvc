
CREATE Procedure [dbo].[Articulos_TX_ValidarCodigo]
@Codigo varchar(20),
@IdArticulo int
AS 
SELECT * 
FROM Articulos
WHERE (@IdArticulo<=0 or Articulos.IdArticulo<>@IdArticulo) and Codigo=@Codigo
