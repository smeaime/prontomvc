





























CREATE Procedure [dbo].[Equipos_TX_PorObra1]
@IdObra int
AS 
Select 
Equipos.IdEquipo,
Equipos.Descripcion,
Equipos.Tag,
Obras.NumeroObra,
Equipos.HorasEstimadas as [Horas estimadas],
FechaTerminacion as [Fecha de terminacion],
GruposTareasHH.Descripcion as [Grupo],
(Select Count(*) From DetalleEquipos Where Equipos.IdEquipo=DetalleEquipos.IdEquipo) as [Cant.Planos]
FROM Equipos
LEFT OUTER JOIN Obras ON Equipos.IdObra = Obras.IdObra
LEFT OUTER JOIN GruposTareasHH ON Equipos.IdGrupoTareaHH=GruposTareasHH.IdGrupoTareaHH
WHERE Equipos.IdObra = @IdObra
ORDER by Equipos.Descripcion






























