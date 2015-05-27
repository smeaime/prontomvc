CREATE Procedure [dbo].[OrdenesTrabajo_TL]

AS 

SELECT
 OrdenesTrabajo.IdOrdenTrabajo,
 Substring('00000',1,5-Len(Convert(varchar,OrdenesTrabajo.NumeroOrdenTrabajo)))+Convert(varchar,OrdenesTrabajo.NumeroOrdenTrabajo) as [Titulo]
FROM OrdenesTrabajo
WHERE OrdenesTrabajo.FechaFinalizacion is null
ORDER BY NumeroOrdenTrabajo