


CREATE Procedure [dbo].[TiposOperacionesGrupos_T]

@IdTipoOperacionGrupo int

AS 

SELECT *
FROM TiposOperacionesGrupos
WHERE (IdTipoOperacionGrupo=@IdTipoOperacionGrupo)
