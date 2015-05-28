CREATE Procedure [dbo].[TarjetasCredito_TX_ConCuentaParaCombo]

AS 

SELECT 
 IdTarjetaCredito,
 Nombre as Titulo
FROM TarjetasCredito
WHERE IsNull(IdCuenta,0)>0
ORDER BY Nombre
