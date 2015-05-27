































CREATE Procedure [dbo].[Obras_TX_ItemsDocumentacion]
@IdObra as int
AS 
Select 
dd.IdItemDocumentacion,
ItemsDocumentacion.Descripcion
from DetalleAcoHHItemsDocumentacion dd
Left Outer Join ItemsDocumentacion ON dd.IdItemDocumentacion=ItemsDocumentacion.IdItemDocumentacion
Left Outer Join AcoHHItemsDocumentacion ad ON dd.IdAcoHHItemDocumentacion=ad.IdAcoHHItemDocumentacion
Left Outer Join Equipos ON ad.IdGrupoTareaHH=Equipos.IdGrupoTareaHH
Left Outer Join Obras ON Equipos.IdObra=Obras.IdObra
Where Equipos.IdObra=@IdObra
Group By dd.IdItemDocumentacion,ItemsDocumentacion.Descripcion
































