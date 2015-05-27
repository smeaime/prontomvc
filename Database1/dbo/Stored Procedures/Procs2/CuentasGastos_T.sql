






























CREATE Procedure [dbo].[CuentasGastos_T]
@IdCuentaGasto int
AS 
SELECT *
FROM CuentasGastos
WHERE (IdCuentaGasto=@IdCuentaGasto)































