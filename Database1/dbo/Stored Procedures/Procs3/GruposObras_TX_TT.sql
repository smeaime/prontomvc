
CREATE Procedure [dbo].[GruposObras_TX_TT]

@IdGrupoObra int

AS 

SELECT 
 IdGrupoObra,
 Descripcion
FROM GruposObras
WHERE (IdGrupoObra=@IdGrupoObra)
