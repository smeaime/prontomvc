CREATE Procedure [dbo].[TiposCuentaGrupos_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011133'
SET @vector_T='058900'

SELECT
 IdTipoCuentaGrupo,
 Descripcion,
 EsCajaBanco as [Es Caja o Banco?],
 AjustarDiferenciasEnSubdiarios,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM TiposCuentaGrupos
ORDER BY Descripcion