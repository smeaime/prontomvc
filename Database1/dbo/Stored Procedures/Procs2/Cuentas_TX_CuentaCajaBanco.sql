CREATE Procedure [dbo].[Cuentas_TX_CuentaCajaBanco]

@IdCuenta int

AS 

SELECT 
 Cuentas.*,
 TiposCuentaGrupos.EsCajaBanco,
 Cajas.IdCaja
FROM Cuentas 
LEFT OUTER JOIN TiposCuentaGrupos ON TiposCuentaGrupos.IdTipoCuentaGrupo=Cuentas.IdTipoCuentaGrupo
LEFT OUTER JOIN Cajas ON Cajas.IdCuenta=Cuentas.IdCuenta
WHERE Cuentas.IdCuenta=@IdCuenta
