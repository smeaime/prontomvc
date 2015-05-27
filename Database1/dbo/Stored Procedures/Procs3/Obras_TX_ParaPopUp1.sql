



CREATE Procedure [dbo].[Obras_TX_ParaPopUp1]

AS 

SELECT 
 IdObra as [Id],
 NumeroObra as [Clave],
 'O' as [Nivel],
 CASE 	WHEN TipoObra is null THEN 1
	ELSE TipoObra
 END as [Tipo]
FROM Obras
WHERE Obras.FechaFinalizacion is null and 
	(Obras.Activa is null or Obras.Activa<>'NO') 
--and (Obras.IncluirEnMenuDesplegable is not null and Obras.IncluirEnMenuDesplegable='SI')

UNION ALL

SELECT 
 IdTarea as [Id],
 Descripcion as [Clave],
 'C' as [Nivel],
 Null as [Tipo]
FROM Tareas
WHERE IsNull(Tareas.TipoTarea,1)=3

UNION ALL

SELECT 
 IdTarea as [Id],
 Descripcion as [Clave],
 'M' as [Nivel],
 Null as [Tipo]
FROM Tareas
WHERE IsNull(Tareas.TipoTarea,1)=2

/*
UNION ALL

SELECT 
 IdOrdenTrabajo as [Id],
 NumeroOrdenTrabajo+' '+Descripcion as [Clave],
 'T' as [Nivel],
 Null as [Tipo]
FROM OrdenesTrabajo
WHERE OrdenesTrabajo.FechaFinalizacion is null
*/

ORDER by Nivel,Tipo,Clave



