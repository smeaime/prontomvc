
























CREATE Procedure [dbo].[DiferenciasCambio_Eliminar]
@IdTipoComprobante int,
@IdRegistroOrigen int
AS 
DELETE DiferenciasCambio
WHERE IdTipoComprobante=@IdTipoComprobante And 
	 IdRegistroOrigen=@IdRegistroOrigen

























