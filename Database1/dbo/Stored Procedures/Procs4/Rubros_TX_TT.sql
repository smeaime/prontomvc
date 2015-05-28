CREATE Procedure [dbo].[Rubros_TX_TT]

@IdRubro smallint

AS 

SELECT
 Rubros.IdRubro,
 Rubros.Descripcion as [Rubro],
 Rubros.Codigo as [Codigo],
 Rubros.Abreviatura as [Abreviatura],
 C1.Descripcion as [Cuenta ventas],
 C2.Descripcion as [Cuenta compras],
 C3.Descripcion as [Cuenta compras activo]
FROM Rubros
LEFT OUTER JOIN Cuentas C1 ON C1.IdCuenta=Rubros.IdCuenta
LEFT OUTER JOIN Cuentas C2 ON C2.IdCuenta=Rubros.IdCuentaCompras
LEFT OUTER JOIN Cuentas C3 ON C3.IdCuenta=Rubros.IdCuentaComprasActivo
WHERE (IdRubro=@IdRubro)