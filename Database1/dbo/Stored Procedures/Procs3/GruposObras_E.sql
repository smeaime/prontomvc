




CREATE Procedure [dbo].[GruposObras_E]
@IdGrupoObra int  
As 
Delete GruposObras
Where (IdGrupoObra=@IdGrupoObra)





