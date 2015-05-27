































CREATE Procedure [dbo].[AcoHHItemsDocumentacion_A]
@IdAcoHHItemDocumentacion int  output,
@IdGrupoTareaHH int
AS 
Insert into [AcoHHItemsDocumentacion]
(
IdGrupoTareaHH
)
Values
(
@IdGrupoTareaHH
)
Select @IdAcoHHItemDocumentacion=@@identity
Return(@IdAcoHHItemDocumentacion)
































