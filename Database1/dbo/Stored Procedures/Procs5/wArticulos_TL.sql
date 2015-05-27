
CREATE PROCEDURE [dbo].[wArticulos_TL]
AS 
SELECT IdArticulo, Descripcion as [Titulo]
FROM Articulos
ORDER BY Descripcion

