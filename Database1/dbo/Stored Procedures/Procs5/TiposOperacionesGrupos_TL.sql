


CREATE Procedure [dbo].[TiposOperacionesGrupos_TL]

AS 

SELECT IdTipoOperacionGrupo, Descripcion as [Titulo]
FROM TiposOperacionesGrupos 
ORDER BY Descripcion
