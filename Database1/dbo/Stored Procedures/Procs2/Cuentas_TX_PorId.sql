




CREATE Procedure [dbo].[Cuentas_TX_PorId]
@IdCuenta int
AS 
SELECT 
 Cuentas.*,
 TiposCuentaGrupos.EsCajaBanco
FROM Cuentas
LEFT OUTER JOIN TiposCuentaGrupos ON TiposCuentaGrupos.IdTipoCuentaGrupo=Cuentas.IdTipoCuentaGrupo
WHERE (IdCuenta=@IdCuenta)




