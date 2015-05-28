
CREATE Procedure [dbo].[CuentasGastos_TX_PorId]

@IdCuentaGasto int

AS 

SELECT *
FROM CuentasGastos
WHERE (IdCuentaGasto=@IdCuentaGasto)
