





























CREATE Procedure [dbo].[ItemsDocumentacion_T]
@IdItemDocumentacion int
AS 
SELECT IdItemDocumentacion, Descripcion
FROM ItemsDocumentacion
where (IdItemDocumentacion=@IdItemDocumentacion)






























