


CREATE Procedure [dbo].[TiposOperaciones_TX_TT]

@IdTipoOperacion int

AS 

SELECT 
 TiposOperaciones.IdTipoOperacion as [IdTipoOperacion],
 TiposOperaciones.Descripcion as [Descripcion],
 TiposOperaciones.Codigo as [Codigo],
 TiposOperacionesGrupos.Descripcion as [Grupo]
FROM TiposOperaciones
LEFT OUTER JOIN TiposOperacionesGrupos ON TiposOperacionesGrupos.IdTipoOperacionGrupo=TiposOperaciones.IdTipoOperacionGrupo
WHERE TiposOperaciones.IdTipoOperacion=@IdTipoOperacion
