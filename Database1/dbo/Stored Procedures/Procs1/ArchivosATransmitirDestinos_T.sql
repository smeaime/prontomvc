﻿































CREATE Procedure [dbo].[ArchivosATransmitirDestinos_T]
@IdArchivoATransmitirDestino int
AS 
SELECT *
FROM ArchivosATransmitirDestinos
where (IdArchivoATransmitirDestino=@IdArchivoATransmitirDestino)
































