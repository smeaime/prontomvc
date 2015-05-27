
CREATE Procedure [dbo].[TiposCuentaGrupos_E]
@IdTipoCuentaGrupo smallint  
AS 
DELETE TiposCuentaGrupos
WHERE (IdTipoCuentaGrupo=@IdTipoCuentaGrupo)
