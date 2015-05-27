CREATE Procedure [dbo].[Cuentas_TX_TT]

@IdCuenta int

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111111111111133'
SET @vector_T='0191132213243231313100'

SELECT  
 Cuentas.IdCuenta,
 Cuentas.Descripcion as [Descripcion],
 Cuentas.IdCuenta as [IdAux],
 Cuentas.Codigo as [Codigo],
 TiposCuenta.Descripcion as [Tipo de cuenta],
 Cuentas.Jerarquia as [Jerarquia],
 rc1.Descripcion as [Rubro contable],
 rc2.Descripcion as [Rubro financiero],
 TiposCuentaGrupos.Descripcion as [Grupo cuenta],
 Null as [Cod.Cta.Madre],
 CuentasGastos.Descripcion as [Grupo gasto],
 Obras.Descripcion as [Obra / Centro de costo],
 Cuentas.AjustaPorInflacion as [Ajusta p/inf.],
 Cuentas.CodigoSecundario as [Codigo secundario],
 Null as [Cod.Cons.1],
 Null as [Cta.Cons.1],
 Null as [Cod.Cons.2],
 Null as [Cta.Cons.2],
 Null as [Cod.Cons.3],
 Null as [Cta.Cons.3],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Cuentas 
LEFT OUTER JOIN TiposCuenta ON TiposCuenta.IdTipoCuenta=Cuentas.IdTipoCuenta
LEFT OUTER JOIN RubrosContables rc1 ON rc1.IdRubroContable=Cuentas.IdRubroContable
LEFT OUTER JOIN RubrosContables rc2 ON rc2.IdRubroContable=Cuentas.IdRubroFinanciero
LEFT OUTER JOIN TiposCuentaGrupos ON TiposCuentaGrupos.IdTipoCuentaGrupo=Cuentas.IdTipoCuentaGrupo
LEFT OUTER JOIN Obras ON Obras.IdObra=Cuentas.IdObra
LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
WHERE (Cuentas.IdCuenta=@IdCuenta)