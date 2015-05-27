
CREATE Procedure [dbo].[TarjetasCredito_TX_PorId]

@IdTarjetaCredito int

AS 

SELECT *
FROM TarjetasCredito
WHERE (IdTarjetaCredito=@IdTarjetaCredito)
