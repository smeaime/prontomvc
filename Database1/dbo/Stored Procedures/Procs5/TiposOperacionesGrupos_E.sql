

CREATE Procedure [dbo].[TiposOperacionesGrupos_E]

@IdTipoOperacionGrupo int

AS 

DELETE TiposOperacionesGrupos
WHERE (IdTipoOperacionGrupo=@IdTipoOperacionGrupo)
