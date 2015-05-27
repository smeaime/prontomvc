





























CREATE Procedure [dbo].[ItemsDocumentacion_A]
@IdItemDocumentacion int  output,
@Descripcion varchar(50)
AS 
Insert into [ItemsDocumentacion]
(Descripcion)
Values(@Descripcion)
Select @IdItemDocumentacion=@@identity
Return(@IdItemDocumentacion)






























