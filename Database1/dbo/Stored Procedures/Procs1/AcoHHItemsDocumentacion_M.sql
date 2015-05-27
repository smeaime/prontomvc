































CREATE  Procedure [dbo].[AcoHHItemsDocumentacion_M]
@IdAcoHHItemDocumentacion int  output,
@IdGrupoTareaHH int
AS
Update AcoHHItemsDocumentacion
SET
IdGrupoTareaHH=@IdGrupoTareaHH
where (IdAcoHHItemDocumentacion=@IdAcoHHItemDocumentacion)
Return(@IdAcoHHItemDocumentacion)
































