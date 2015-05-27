
CREATE PROCEDURE [dbo].[wUnidades_TL]
AS 
SELECT IdUnidad, Descripcion as [Titulo]
FROM Unidades
ORDER BY Descripcion

