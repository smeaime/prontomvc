
CREATE Procedure [dbo].[ArchivosATransmitir_TX_PorSistema]

@Sistema varchar(20)

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01133'
SET @vector_T='05400'

SELECT 
 IdArchivoATransmitir,
 Descripcion as [Tabla],
 Sistema as [Sistema],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ArchivosATransmitir
WHERE Sistema=@Sistema
ORDER by IdArchivoATransmitir
