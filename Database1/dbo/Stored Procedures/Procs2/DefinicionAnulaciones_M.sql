


CREATE Procedure [dbo].[DefinicionAnulaciones_M]
@IdDefinicionAnulacion int,
@IdFormulario int
As
Update DefinicionAnulaciones
Set 
 IdFormulario=@IdFormulario
Where (IdDefinicionAnulacion=@IdDefinicionAnulacion)
Return(@IdDefinicionAnulacion)


