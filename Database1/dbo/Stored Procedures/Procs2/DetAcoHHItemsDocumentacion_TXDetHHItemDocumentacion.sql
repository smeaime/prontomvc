





























CREATE Procedure [dbo].[DetAcoHHItemsDocumentacion_TXDetHHItemDocumentacion]
@IdAcoHHItemDocumentacion int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011133'
set @vector_T='004400'
Select 
DetalleAcoHHItemsDocumentacion.IdDetalleAcoHHItemDocumentacion,
DetalleAcoHHItemsDocumentacion.IdItemDocumentacion,
ItemsDocumentacion.Descripcion as [Item de documentacion],
DetalleAcoHHItemsDocumentacion.Marca as [*],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleAcoHHItemsDocumentacion
INNER JOIN ItemsDocumentacion ON DetalleAcoHHItemsDocumentacion.IdItemDocumentacion = ItemsDocumentacion.IdItemDocumentacion
WHERE (DetalleAcoHHItemsDocumentacion.IdAcoHHItemDocumentacion = @IdAcoHHItemDocumentacion)






























