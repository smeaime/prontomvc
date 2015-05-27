
CREATE Procedure [dbo].[TiposCuentaGrupos_TX_TT]
@IdTipoCuentaGrupo int
AS 
SELECT 
 IdTipoCuentaGrupo,
 Descripcion,
 EsCajaBanco as [Es Caja o Banco?]
FROM TiposCuentaGrupos
WHERE (IdTipoCuentaGrupo=@IdTipoCuentaGrupo)
