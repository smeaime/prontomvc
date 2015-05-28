
CREATE Procedure [dbo].[Clausulas_TL]

AS 

SELECT IdClausula, Descripcion as [Titulo]
FROM Clausulas 
ORDER BY Orden, Descripcion
