































CREATE Procedure [dbo].[AcoHHItemsDocumentacion_TX_PorGrupo]
@IdGrupoTareaHH int
AS
Select 
DetalleAcoHHItemsDocumentacion.IdDetalleAcoHHItemDocumentacion,
DetalleAcoHHItemsDocumentacion.IdItemDocumentacion,
ItemsDocumentacion.Descripcion
FROM DetalleAcoHHItemsDocumentacion
INNER JOIN AcoHHItemsDocumentacion ON DetalleAcoHHItemsDocumentacion.IdAcoHHItemDocumentacion = AcoHHItemsDocumentacion.IdAcoHHItemDocumentacion
INNER JOIN ItemsDocumentacion ON DetalleAcoHHItemsDocumentacion.IdItemDocumentacion = ItemsDocumentacion.IdItemDocumentacion
WHERE AcoHHItemsDocumentacion.IdGrupoTareaHH=@IdGrupoTareaHH
































