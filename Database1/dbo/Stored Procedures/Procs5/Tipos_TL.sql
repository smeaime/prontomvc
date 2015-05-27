
CREATE Procedure [dbo].[Tipos_TL]

AS 

SELECT IdTipo, Descripcion as [Titulo]
FROM Tipos 
WHERE IsNull(Grupo,0)=0
ORDER BY Descripcion
