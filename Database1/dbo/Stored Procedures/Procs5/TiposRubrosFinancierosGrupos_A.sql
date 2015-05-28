CREATE Procedure [dbo].[TiposRubrosFinancierosGrupos_A]

@IdTipoRubroFinancieroGrupo int  output,
@Descripcion varchar(100),
@Codigo int

AS

INSERT INTO [TiposRubrosFinancierosGrupos]
(
 Descripcion,
 Codigo
)
VALUES
(
 @Descripcion,
 @Codigo
)

SELECT @IdTipoRubroFinancieroGrupo=@@identity

RETURN(@IdTipoRubroFinancieroGrupo)