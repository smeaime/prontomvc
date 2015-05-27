
CREATE PROCEDURE [dbo].[wRubros_TL]
AS 
SELECT IdRubro, Descripcion as [Titulo]
FROM Rubros
ORDER BY Descripcion

