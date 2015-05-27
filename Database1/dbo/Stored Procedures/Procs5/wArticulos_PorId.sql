
CREATE Procedure [dbo].[wArticulos_PorId]

@IdArticulo int = Null

AS 

SELECT Articulos.*
FROM Articulos
WHERE Articulos.IdArticulo=@IdArticulo and IsNull(Articulos.Activo,'')<>'NO'

