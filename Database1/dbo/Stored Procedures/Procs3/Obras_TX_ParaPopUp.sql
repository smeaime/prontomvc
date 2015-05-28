
CREATE Procedure [dbo].[Obras_TX_ParaPopUp]

AS 

SELECT
 IdObra as [Id],
 NumeroObra as [Clave],
 'O' as [Nivel],
 CASE 	WHEN TipoObra is null THEN 1
	ELSE TipoObra
 END as [Tipo]
FROM Obras
WHERE Obras.FechaFinalizacion is null 

UNION ALL

SELECT
 IdItemProduccion as [Id],
 Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS as [Clave],
 'C' as [Nivel],
 Null as [Tipo]
FROM ItemsProduccion 

UNION ALL

SELECT
 IdTareaMantenimiento as [Id],
 Descripcion as [Clave],
 'M' as [Nivel],
 Null as [Tipo]
FROM TareasMantenimiento

UNION ALL

SELECT
 IdOrdenTrabajo as [Id],
 NumeroOrdenTrabajo COLLATE SQL_Latin1_General_CP1_CI_AS+' '+Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS as [Clave],
 'T' as [Nivel],
 Null as [Tipo]
FROM OrdenesTrabajo
WHERE OrdenesTrabajo.FechaFinalizacion is null

ORDER by Nivel, Tipo, Clave
