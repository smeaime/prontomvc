





























CREATE PROCEDURE [dbo].[Equipos_TX_PorcentajesStandar]
@IdSector int,
@IdEquipo int
as
SELECT
Equipos.IdEquipo,
Equipos.Descripcion as Titulo,
Equipos.Tag,
Equipos.HorasEstimadas,
GruposTareasHH.Preparacion,
GruposTareasHH.CaldereriaPlana,
GruposTareasHH.Mecanica,
GruposTareasHH.Caldereria,
GruposTareasHH.Soldadura,
GruposTareasHH.Almacenes
FROM Equipos
LEFT OUTER JOIN GruposTareasHH ON Equipos.IdGrupoTareaHH=GruposTareasHH.IdGrupoTareaHH
WHERE Equipos.IdEquipo = @IdEquipo






























