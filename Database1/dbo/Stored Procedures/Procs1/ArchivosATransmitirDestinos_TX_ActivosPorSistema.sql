CREATE Procedure [dbo].[ArchivosATransmitirDestinos_TX_ActivosPorSistema]

@Sistema varchar(20)

AS 

SELECT *
FROM ArchivosATransmitirDestinos
WHERE Activo='SI' and Sistema=@Sistema
ORDER by Descripcion