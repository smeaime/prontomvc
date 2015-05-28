
CREATE Procedure [dbo].[Articulos_TX_DatosConCuenta]

@IdArticulo int

AS 

SELECT 
 Articulos.*,
 Rubros.IdCuenta,
 Rubros.IdCuentaCompras as [IdCuentaCompras],
 C2.IdTipoCuenta as [IdTipoCuentaCompras]
FROM Articulos
LEFT OUTER JOIN Rubros ON Rubros.IdRubro=Articulos.IdRubro
LEFT OUTER JOIN Cuentas C1 ON C1.IdCuenta=Rubros.IdCuenta
LEFT OUTER JOIN Cuentas C2 ON C2.IdCuenta=Rubros.IdCuentaCompras
WHERE (IdArticulo=@IdArticulo)
