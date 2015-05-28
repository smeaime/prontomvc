
CREATE Procedure [dbo].[TarjetasCredito_T]

@IdTarjetaCredito int

AS 

SELECT *
FROM TarjetasCredito
WHERE (IdTarjetaCredito=@IdTarjetaCredito)
