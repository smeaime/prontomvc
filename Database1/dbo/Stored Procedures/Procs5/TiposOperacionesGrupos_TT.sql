


CREATE Procedure [dbo].[TiposOperacionesGrupos_TT]

AS 

SELECT 
 TiposOperacionesGrupos.IdTipoOperacionGrupo as [IdTipoOperacionGrupo],
 TiposOperacionesGrupos.Descripcion as [Descripcion]
FROM TiposOperacionesGrupos
ORDER BY TiposOperacionesGrupos.Descripcion
