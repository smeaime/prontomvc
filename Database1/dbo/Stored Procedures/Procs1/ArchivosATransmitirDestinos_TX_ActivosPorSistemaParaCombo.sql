CREATE Procedure [dbo].[ArchivosATransmitirDestinos_TX_ActivosPorSistemaParaCombo]

@Sistema varchar(20)

AS 

SELECT
 IdArchivoATransmitirDestino,
 Case When Tipo=1 Then 'Obra - ' + Descripcion Else 'Tercerizado - ' + Descripcion End as [Titulo]
FROM ArchivosATransmitirDestinos
WHERE Activo='SI' and Sistema=@Sistema
ORDER By Descripcion