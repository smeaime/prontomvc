































CREATE PROCEDURE [dbo].[Obras_TXEquiposPorGrupo]
@IdObra int,
@IdGrupoTareaHH int
as
SELECT
Equipos.IdEquipo,
Equipos.Descripcion as [Titulo],
Equipos.Tag,
Equipos.HorasEstimadas,
Equipos.FechaTerminacion,
CASE	WHEN GruposTareasHH.Descripcion is null THEN 'S/Grupo'
	ELSE GruposTareasHH.Descripcion
END as [Grupo],
ItemDocumentacion1,
(	Select ItemsDocumentacion.Descripcion 
	From ItemsDocumentacion 
	Where ItemsDocumentacion.IdItemDocumentacion=Equipos.IdItemDocumentacion1	) as [Descripcion1],
ItemDocumentacion2,
(	Select ItemsDocumentacion.Descripcion 
	From ItemsDocumentacion 
	Where ItemsDocumentacion.IdItemDocumentacion=Equipos.IdItemDocumentacion2	) as [Descripcion2],
ItemDocumentacion3,
(	Select ItemsDocumentacion.Descripcion 
	From ItemsDocumentacion 
	Where ItemsDocumentacion.IdItemDocumentacion=Equipos.IdItemDocumentacion3	) as [Descripcion3],
ItemDocumentacion4,
(	Select ItemsDocumentacion.Descripcion 
	From ItemsDocumentacion 
	Where ItemsDocumentacion.IdItemDocumentacion=Equipos.IdItemDocumentacion4	) as [Descripcion4],
ItemDocumentacion5,
(	Select ItemsDocumentacion.Descripcion 
	From ItemsDocumentacion 
	Where ItemsDocumentacion.IdItemDocumentacion=Equipos.IdItemDocumentacion5	) as [Descripcion5],
ItemDocumentacion6,
(	Select ItemsDocumentacion.Descripcion 
	From ItemsDocumentacion 
	Where ItemsDocumentacion.IdItemDocumentacion=Equipos.IdItemDocumentacion6	) as [Descripcion6]
FROM Equipos
LEFT OUTER JOIN GruposTareasHH ON Equipos.IdGrupoTareaHH=GruposTareasHH.IdGrupoTareaHH
WHERE Equipos.IdObra = @IdObra and Equipos.IdGrupoTareaHH=@IdGrupoTareaHH
Order By GruposTareasHH.Descripcion,Equipos.Descripcion
































