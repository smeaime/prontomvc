
CREATE Procedure [dbo].[Valores_TX_TarjetasConMovimientos]

AS 

SELECT 
 Valores.IdTarjetaCredito,
 TarjetasCredito.Nombre
FROM Valores
LEFT OUTER JOIN TarjetasCredito ON TarjetasCredito.IdTarjetaCredito=Valores.IdTarjetaCredito
WHERE Valores.IdTarjetaCredito is not null
GROUP BY Valores.IdTarjetaCredito, TarjetasCredito.Nombre
ORDER BY TarjetasCredito.Nombre
