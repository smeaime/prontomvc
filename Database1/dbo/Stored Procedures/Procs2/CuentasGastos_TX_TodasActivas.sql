CREATE Procedure [dbo].[CuentasGastos_TX_TodasActivas]

AS 

SELECT *, (Select Top 1 c.IdRubroFinanciero From Cuentas c Where c.IdCuenta=CuentasGastos.IdCuentaMadre) as [IdRubroFinanciero]
FROM CuentasGastos 
WHERE IsNull(Activa,'NO')='SI'
ORDER BY CuentasGastos.Codigo, CuentasGastos.Titulo Desc, CuentasGastos.Descripcion