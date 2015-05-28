
CREATE Procedure [dbo].[Obras_TX_ObrasMasOTParaCombo]

AS 

SELECT
 IdObra as [Id],
 NumeroObra as [Titulo]
FROM Obras
WHERE Obras.FechaFinalizacion is null

UNION ALL

SELECT
 IdOrdenTrabajo+100000 as [Id],
 NumeroOrdenTrabajo COLLATE SQL_Latin1_General_CP1_CI_AS as [Titulo]
FROM OrdenesTrabajo
WHERE OrdenesTrabajo.FechaFinalizacion is null

ORDER BY [Titulo]
