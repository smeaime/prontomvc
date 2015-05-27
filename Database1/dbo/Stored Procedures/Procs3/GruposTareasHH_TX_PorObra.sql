





























CREATE Procedure [dbo].[GruposTareasHH_TX_PorObra]
@IdObra int
AS 
SELECT DISTINCT 
GruposTareasHH.IdGrupoTareaHH,
GruposTareasHH.Descripcion as [Titulo]
FROM GruposTareasHH
LEFT OUTER JOIN Equipos ON GruposTareasHH.IdGrupoTareaHH=Equipos.IdGrupoTareaHH
LEFT OUTER JOIN Obras ON Obras.IdObra=Equipos.IdObra
WHERE Obras.IdObra = @IdObra
ORDER by GruposTareasHH.Descripcion






























