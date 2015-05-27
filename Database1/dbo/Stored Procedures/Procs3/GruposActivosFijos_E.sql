










CREATE Procedure [dbo].[GruposActivosFijos_E]
@IdGrupoActivoFijo int  
As 
Delete GruposActivosFijos
Where (IdGrupoActivoFijo=@IdGrupoActivoFijo)











