
CREATE Procedure [dbo].[CuentasGastos_TX_PorIdCuentaMadre]

@IdCuentaMadre int

AS 

SELECT *
FROM CuentasGastos
WHERE (IdCuentaMadre=@IdCuentaMadre)
