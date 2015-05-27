
CREATE Procedure [dbo].[DiferenciasCambio_MarcarComoGenerada]

@IdDiferenciaCambio int,
@IdTipoComprobanteGenerado int,
@IdComprobanteGenerado int

AS 

UPDATE DiferenciasCambio
SET 	Estado='GE',
	IdTipoComprobanteGenerado=@IdTipoComprobanteGenerado,
	IdComprobanteGenerado=@IdComprobanteGenerado
WHERE (IdDiferenciaCambio=@IdDiferenciaCambio)
