
CREATE Procedure [dbo].[TiposCuentaGrupos_A]
@IdTipoCuentaGrupo int  output,
@Descripcion varchar(50),
@EsCajaBanco varchar(2),
@AjustarDiferenciasEnSubdiarios varchar(2)
AS 
INSERT INTO [TiposCuentaGrupos]
(
 Descripcion,
 EsCajaBanco,
 AjustarDiferenciasEnSubdiarios
)
VALUES
(
 @Descripcion,
 @EsCajaBanco,
 @AjustarDiferenciasEnSubdiarios
)
SELECT @IdTipoCuentaGrupo=@@identity
RETURN(@IdTipoCuentaGrupo)
