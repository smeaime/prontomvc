

CREATE Procedure [dbo].[OrdenesTrabajo_TX_SegunFechaFinalizacion]
@FechaHasta datetime
AS 
SELECT
 IdOrdenTrabajo,
 NumeroOrdenTrabajo as [Titulo]
FROM OrdenesTrabajo
WHERE FechaFinalizacion is null or 
	(FechaFinalizacion is not null and FechaFinalizacion>@FechaHasta)
ORDER BY NumeroOrdenTrabajo


