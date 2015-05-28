CREATE  Procedure [dbo].[TiposRubrosFinancierosGrupos_M]

@IdTipoRubroFinancieroGrupo int ,
@Descripcion varchar(100),
@Codigo int

AS

UPDATE TiposRubrosFinancierosGrupos
SET 
 Descripcion=@Descripcion,
 Codigo=@Codigo
WHERE (IdTipoRubroFinancieroGrupo=@IdTipoRubroFinancieroGrupo)

RETURN(@IdTipoRubroFinancieroGrupo)