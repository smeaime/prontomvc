CREATE Procedure [dbo].[DefinicionesFlujoCaja_TX_DetallesPorCodigo]

@Codigo int

AS 

SELECT 
 dfcc.*, 
 dfc.TipoConcepto, 
 IsNull(Convert(varchar,Cuentas.Codigo)+' '+Cuentas.Descripcion,'') as [CuentaContable],
 IsNull(Convert(varchar,RubrosContables.Codigo)+' '+RubrosContables.Descripcion,'') as [Rubro]
FROM DetalleDefinicionesFlujoCajaCuentas dfcc
LEFT OUTER JOIN DefinicionesFlujoCaja dfc ON dfcc.IdDefinicionFlujoCaja=dfc.IdDefinicionFlujoCaja
LEFT OUTER JOIN Cuentas ON dfcc.IdCuenta=Cuentas.IdCuenta
LEFT OUTER JOIN RubrosContables ON dfcc.IdRubroContable = RubrosContables.IdRubroContable
WHERE dfc.Codigo=@Codigo