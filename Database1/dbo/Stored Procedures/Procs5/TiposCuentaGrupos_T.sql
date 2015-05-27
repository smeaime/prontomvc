
CREATE Procedure [dbo].[TiposCuentaGrupos_T]
@IdTipoCuentaGrupo int
AS 
SELECT *
FROM TiposCuentaGrupos
WHERE (IdTipoCuentaGrupo=@IdTipoCuentaGrupo)
