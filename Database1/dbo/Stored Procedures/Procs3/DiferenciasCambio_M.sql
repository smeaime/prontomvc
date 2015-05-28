
































CREATE  Procedure [dbo].[DiferenciasCambio_M]
@IdDiferenciaCambio int,
@IdTipoComprobante int,
@IdRegistroOrigen int,
@Estado varchar(2),
@IdTipoComprobanteGenerado int,
@IdComprobanteGenerado int
AS
Update DiferenciasCambio
SET 
 IdTipoComprobante=@IdTipoComprobante,
 IdRegistroOrigen=@IdRegistroOrigen,
 Estado=@Estado,
 IdTipoComprobanteGenerado=@IdTipoComprobanteGenerado,
 IdComprobanteGenerado=@IdComprobanteGenerado
Where (IdDiferenciaCambio=@IdDiferenciaCambio)
Return(@IdDiferenciaCambio)
































