CREATE Procedure [dbo].[Cuentas_TX_PorIdConDatos]

@IdCuenta int,
@FechaConsulta datetime = Null

AS 

SET @FechaConsulta=IsNull(@FechaConsulta,GetDate())

SELECT 
 Cuentas.*,
 TiposCuentaGrupos.EsCajaBanco,
 (Select Top 1 Bancos.IdBanco From Bancos Where Cuentas.IdCuenta=Bancos.IdCuenta) as [IdBanco],
 IsNull((Select Top 1 dc.CodigoAnterior 
	From DetalleCuentas dc 
	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
	Order By dc.FechaCambio),Cuentas.Codigo) as [Codigo1],
 IsNull((Select Top 1 dc.NombreAnterior 
	From DetalleCuentas dc 
	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
	Order By dc.FechaCambio),Cuentas.Descripcion) as [Descripcion1]
FROM Cuentas
LEFT OUTER JOIN TiposCuentaGrupos ON TiposCuentaGrupos.IdTipoCuentaGrupo=Cuentas.IdTipoCuentaGrupo
WHERE (IdCuenta=@IdCuenta)