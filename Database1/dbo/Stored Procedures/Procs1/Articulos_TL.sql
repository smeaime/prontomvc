
CREATE Procedure [dbo].[Articulos_TL]
AS 
SELECT IdArticulo, Descripcion as Titulo
FROM Articulos
WHERE IsNull(Articulos.Activo,'')<>'NO'
ORDER by Descripcion
