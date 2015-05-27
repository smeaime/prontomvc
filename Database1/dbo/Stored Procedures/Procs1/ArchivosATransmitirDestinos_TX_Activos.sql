CREATE Procedure [dbo].[ArchivosATransmitirDestinos_TX_Activos]

AS 

SELECT *
FROM ArchivosATransmitirDestinos
WHERE Activo='SI'
ORDER by Descripcion