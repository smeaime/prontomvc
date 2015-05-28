































CREATE Procedure [dbo].[AcoHHItemsDocumentacion_TT]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0133'
set @vector_T='0400'
Select 
AcoHHItemsDocumentacion.IdAcoHHItemDocumentacion,
GruposTareasHH.Descripcion as [Grupo de ItemsDocumentacion],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM AcoHHItemsDocumentacion
INNER JOIN GruposTareasHH ON AcoHHItemsDocumentacion.IdGrupoTareaHH = GruposTareasHH.IdGrupoTareaHH
































