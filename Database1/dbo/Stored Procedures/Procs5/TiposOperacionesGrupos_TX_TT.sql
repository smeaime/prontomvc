


CREATE Procedure [dbo].[TiposOperacionesGrupos_TX_TT]

@IdTipoOperacionGrupo int

AS 

SELECT 
 TiposOperacionesGrupos.IdTipoOperacionGrupo as [IdTipoOperacionGrupo],
 TiposOperacionesGrupos.Descripcion as [Descripcion]
FROM TiposOperacionesGrupos
WHERE TiposOperacionesGrupos.IdTipoOperacionGrupo=@IdTipoOperacionGrupo
