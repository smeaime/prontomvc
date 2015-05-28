





























CREATE  Procedure [dbo].[ItemsDocumentacion_M]
@IdItemDocumentacion int ,
@Descripcion varchar(50)
AS
Update ItemsDocumentacion
SET
Descripcion=@Descripcion
where (IdItemDocumentacion=@IdItemDocumentacion)
Return(@IdItemDocumentacion)






























