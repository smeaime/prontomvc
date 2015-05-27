
CREATE PROCEDURE [dbo].[wSubrubros_TL]
AS 
SELECT IdSubrubro, Descripcion as [Titulo]
FROM Subrubros
ORDER BY Descripcion

