CREATE Procedure [dbo].[ArchivosATransmitirDestinos_TL]

AS 

SELECT
 IdArchivoATransmitirDestino,
 CASE 	WHEN Tipo=1 THEN 'Obra - ' + Descripcion 
	ELSE 'Tercerizado - ' + Descripcion 
 END as [Titulo]
FROM ArchivosATransmitirDestinos
ORDER By Descripcion