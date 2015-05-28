
CREATE Procedure [dbo].[wPlazosEntrega_TL]
AS 
SELECT 
 IdPlazoEntrega,
 Descripcion as Titulo
FROM PlazosEntrega
ORDER BY Descripcion

