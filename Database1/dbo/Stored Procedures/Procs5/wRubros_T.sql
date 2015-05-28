
CREATE Procedure [dbo].[wRubros_T]

@IdRubro int = Null

AS 

SET @IdRubro=IsNull(@IdRubro,-1)

IF @IdRubro=-2
	SELECT 
	 Rubros.IdRubro as [IdRubro],
	 Rubros.Descripcion as [Descripcion],
	 Rubros.Abreviatura as [Abrev.],
	 C1.Descripcion+' - [ '+Convert(varchar,C1.Codigo)+' ]' as [Cta.Ventas],
	 C2.Descripcion+' - [ '+Convert(varchar,C2.Codigo)+' ]' as [Cta.Compras]
	FROM Rubros
	LEFT OUTER JOIN Cuentas C1 ON Rubros.IdCuenta=C1.IdCuenta
	LEFT OUTER JOIN Cuentas C2 ON Rubros.IdCuentaCompras=C2.IdCuenta
	ORDER BY Rubros.Descripcion
ELSE
	SELECT 
	 Rubros.*,
	 C1.Descripcion as [CuentaVentas],
	 C2.Descripcion as [CuentaCompras]
	FROM Rubros
	LEFT OUTER JOIN Cuentas C1 ON Rubros.IdCuenta=C1.IdCuenta
	LEFT OUTER JOIN Cuentas C2 ON Rubros.IdCuentaCompras=C2.IdCuenta
	WHERE @IdRubro=-1 or Rubros.IdRubro=@IdRubro
	ORDER BY Rubros.Descripcion

