CREATE Procedure [dbo].[Cuentas_TT]

AS 

SELECT 
 Cuentas.IdCuenta,
 Cuentas.Descripcion,
 Cuentas.Codigo,
 TiposCuenta.Descripcion as [Tipo de cuenta],
 Cuentas.Jerarquia,
 RubrosContables.Descripcion as [Rubro],
 TiposCuentaGrupos.Descripcion as [Grupo cuenta],
 Obras.Descripcion as [Obra / Centro de costo],
 Cuentas.AjustaPorInflacion as [Ajusta p/inf.],
 Cuentas.CodigoSecundario as [Codigo secundario]
FROM Cuentas 
LEFT OUTER JOIN TiposCuenta ON TiposCuenta.IdTipoCuenta=Cuentas.IdTipoCuenta
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=Cuentas.IdRubroContable
LEFT OUTER JOIN TiposCuentaGrupos ON TiposCuentaGrupos.IdTipoCuentaGrupo=Cuentas.IdTipoCuentaGrupo
LEFT OUTER JOIN Obras ON Obras.IdObra=Cuentas.IdObra
ORDER by Cuentas.Codigo