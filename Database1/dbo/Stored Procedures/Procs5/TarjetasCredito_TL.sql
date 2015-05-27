CREATE Procedure [dbo].[TarjetasCredito_TL]

AS 

SELECT 
 IdTarjetaCredito,
 Nombre as Titulo
FROM TarjetasCredito
ORDER BY Nombre
