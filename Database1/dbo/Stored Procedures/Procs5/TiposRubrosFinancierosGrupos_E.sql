CREATE Procedure [dbo].[TiposRubrosFinancierosGrupos_E]

@IdTipoRubroFinancieroGrupo int  

AS 

DELETE TiposRubrosFinancierosGrupos
WHERE (IdTipoRubroFinancieroGrupo=@IdTipoRubroFinancieroGrupo)