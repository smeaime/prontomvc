































CREATE Procedure [dbo].[ArchivosATransmitirLoteo_TX_UltimoLote]
@IdArchivoATransmitirDestino int,
@IdArchivoATransmitir int
AS 
Select MAX(NumeroLote) as [Lote]
FROM ArchivosATransmitirLoteo
WHERE IdArchivoATransmitirDestino=@IdArchivoATransmitirDestino and 
	 IdArchivoATransmitir=@IdArchivoATransmitir
































