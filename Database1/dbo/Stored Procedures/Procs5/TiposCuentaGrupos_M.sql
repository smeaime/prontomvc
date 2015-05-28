
CREATE  Procedure [dbo].[TiposCuentaGrupos_M]
@IdTipoCuentaGrupo int ,
@Descripcion varchar(50),
@EsCajaBanco varchar(2),
@AjustarDiferenciasEnSubdiarios varchar(2)
AS
UPDATE TiposCuentaGrupos
SET
 Descripcion=@Descripcion,
 EsCajaBanco=@EsCajaBanco,
 AjustarDiferenciasEnSubdiarios=@AjustarDiferenciasEnSubdiarios
WHERE (IdTipoCuentaGrupo=@IdTipoCuentaGrupo)
RETURN(@IdTipoCuentaGrupo)
