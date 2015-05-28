CREATE Procedure [dbo].[TiposRubrosFinancierosGrupos_TL]

AS 

SELECT 
 IdTipoRubroFinancieroGrupo,
 Descripcion as [Titulo]
FROM TiposRubrosFinancierosGrupos 
ORDER by Descripcion