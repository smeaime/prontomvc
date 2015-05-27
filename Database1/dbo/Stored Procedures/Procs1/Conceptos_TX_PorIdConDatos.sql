
CREATE  Procedure [dbo].[Conceptos_TX_PorIdConDatos]

@IdConcepto int  

AS 

SELECT 
 Conceptos.*,
 Cuentas.Codigo as [Codigo],
 Cuentas.Descripcion as [Cuenta],
 TiposCuentaGrupos.EsCajaBanco
FROM Conceptos 
LEFT OUTER JOIN Cuentas ON Conceptos.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN TiposCuentaGrupos ON TiposCuentaGrupos.IdTipoCuentaGrupo=Cuentas.IdTipoCuentaGrupo
WHERE (IdConcepto=@IdConcepto)
