
CREATE Procedure [dbo].[TiposCuentaGrupos_TL]
AS 
SELECT 
 IdTipoCuentaGrupo,
 Descripcion as Titulo
FROM TiposCuentaGrupos 
ORDER BY Descripcion
