
CREATE  Procedure [dbo].[TiposCuentaGrupos_ActualizarAjusteASubdiarios]
@IdTipoCuentaGrupo int ,
@AjustarDiferenciasEnSubdiarios varchar(2)
AS
UPDATE TiposCuentaGrupos
SET
 AjustarDiferenciasEnSubdiarios=@AjustarDiferenciasEnSubdiarios
WHERE (IdTipoCuentaGrupo=@IdTipoCuentaGrupo)
RETURN(@IdTipoCuentaGrupo)
