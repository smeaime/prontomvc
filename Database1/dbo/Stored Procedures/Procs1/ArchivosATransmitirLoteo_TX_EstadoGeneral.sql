































CREATE Procedure [dbo].[ArchivosATransmitirLoteo_TX_EstadoGeneral]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011111133'
set @vector_T='083313500'
Select 
atl.IdArchivoATransmitirLoteo,
FechaTransmision as [Fecha envio],
aat.Descripcion as [Archivo],
atd.Descripcion as [Destino],
atl.NumeroLote as [Lote],
atl.Confirmado,
atl.FechaRecepcionOK as [Fecha conf.],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM ArchivosATransmitirLoteo atl
LEFT OUTER JOIN ArchivosATransmitir aat ON atl.IdArchivoATransmitir=aat.IdArchivoATransmitir
LEFT OUTER JOIN ArchivosATransmitirDestinos atd ON atl.IdArchivoATransmitirDestino=atd.IdArchivoATransmitirDestino
ORDER BY atl.FechaTransmision,aat.Descripcion
































