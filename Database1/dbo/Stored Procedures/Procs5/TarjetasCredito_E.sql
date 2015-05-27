


CREATE Procedure [dbo].[TarjetasCredito_E]
@IdTarjetaCredito int 
AS 
DELETE TarjetasCredito
WHERE (IdTarjetaCredito=@IdTarjetaCredito)


