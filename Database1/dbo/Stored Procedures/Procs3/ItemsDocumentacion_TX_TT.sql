





























CREATE Procedure [dbo].[ItemsDocumentacion_TX_TT]
@IdItemDocumentacion int
AS 
Select IdItemDocumentacion,Descripcion
FROM ItemsDocumentacion
where (IdItemDocumentacion=@IdItemDocumentacion)






























