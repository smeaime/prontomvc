


CREATE  Procedure [dbo].[AjustesStockSAT_TX_Todos]

@IdObraAsignadaUsuario int = Null

AS 

SET @IdObraAsignadaUsuario=IsNull(@IdObraAsignadaUsuario,-1)

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111133'
SET @vector_T='0343500'

SELECT 
 AJ.IdAjusteStock,
 AJ.NumeroAjusteStock as Numero,
 AJ.FechaAjuste as Fecha,
 Case When AJ.TipoAjuste='I' Then 'Inventario' Else 'Ajuste normal' End as [Tipo de ajuste],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 AJ.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM AjustesStockSAT AJ
LEFT OUTER JOIN ArchivosATransmitirDestinos ON AJ.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
ORDER BY AJ.FechaAjuste, AJ.NumeroAjusteStock


