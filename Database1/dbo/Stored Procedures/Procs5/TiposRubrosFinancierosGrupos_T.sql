CREATE Procedure [dbo].[TiposRubrosFinancierosGrupos_T]

@IdTipoRubroFinancieroGrupo int

AS 

SELECT*
FROM TiposRubrosFinancierosGrupos
WHERE (IdTipoRubroFinancieroGrupo=@IdTipoRubroFinancieroGrupo)