





























CREATE Procedure [dbo].[DetAcoHHItemsDocumentacion_T]
@IdDetalleAcoHHItemDocumentacion int
AS 
SELECT *
FROM DetalleAcoHHItemsDocumentacion
where (IdDetalleAcoHHItemDocumentacion=@IdDetalleAcoHHItemDocumentacion)






























