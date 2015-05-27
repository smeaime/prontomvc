































CREATE Procedure [dbo].[ArchivosATransmitirLoteo_TX_PorArchivoLote]
@NombreTabla varchar(50),
@Email varchar(50),
@NumeroLote int
AS 
Select Top 1 IdArchivoATransmitirLoteo
FROM ArchivosATransmitirLoteo
WHERE 	IdArchivoATransmitir=(Select aat.IdArchivoATransmitir 
				From ArchivosATransmitir aat 
				Where aat.Descripcion=@NombreTabla)
	and
      	IdArchivoATransmitirDestino=(Select aatd.IdArchivoATransmitirDestino 
					From ArchivosATransmitirDestinos aatd 
					Where aatd.Email=@Email)
	and
	NumeroLote=@NumeroLote
































