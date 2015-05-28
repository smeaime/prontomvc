
CREATE Procedure [dbo].[CuentasGastos_TX_TT]

@IdCuentaGasto int

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111133'
SET @vector_T='0194H32432200'

SELECT 
 CuentasGastos.IdCuentaGasto,
 CuentasGastos.Codigo as [Codigo],
 CuentasGastos.IdCuentaGasto as [IdAux],
 CuentasGastos.Descripcion as [Cuenta],
 CuentasGastos.Activa as [Act?],
 RubrosContables.Descripcion as [Rubro],
 Cuentas.Codigo as [Cod.Cta.],
 Cuentas.Descripcion as [Cta.Madre],
 CuentasGastos.CodigoDestino as [Cod.Dest.],
 Case When IsNull(CuentasGastos.Titulo,'')='SI' Then 'Titulo' Else Null End as [Titulo],
 CuentasGastos.Nivel as [Nivel],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM CuentasGastos 
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=CuentasGastos.IdRubroContable
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=CuentasGastos.IdCuentaMadre
WHERE CuentasGastos.IdCuentaGasto=@IdCuentaGasto
