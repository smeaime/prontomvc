
CREATE Procedure [dbo].[CuentasGastos_TX_PorCodigo]

@CodigoSubcuenta int

AS 

SELECT *
FROM CuentasGastos
WHERE (CodigoSubcuenta=@CodigoSubcuenta)
