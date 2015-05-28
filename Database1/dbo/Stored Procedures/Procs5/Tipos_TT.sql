CREATE Procedure [dbo].[Tipos_TT]

AS 

SELECT 
 IdTipo,
 Descripcion as [Descripcion],
 Abreviatura as [Abrev.],
 Codigo as [Codigo]
FROM Tipos
WHERE IsNull(Grupo,0)=0
ORDER BY Descripcion