
CREATE Procedure [dbo].[CuentasGastos_TX_Todos]

AS 

SELECT *
FROM CuentasGastos 
ORDER BY Descripcion
