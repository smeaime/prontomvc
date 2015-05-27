




CREATE Procedure [dbo].[GruposObras_T]
@IdGrupoObra int
AS 
SELECT *
FROM GruposObras
WHERE (IdGrupoObra=@IdGrupoObra)





