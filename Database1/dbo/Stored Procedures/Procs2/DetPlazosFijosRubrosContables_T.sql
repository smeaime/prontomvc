CREATE Procedure [dbo].[DetPlazosFijosRubrosContables_T]

@IdDetallePlazoFijoRubrosContables int

AS 

SELECT *
FROM DetallePlazosFijosRubrosContables
WHERE (IdDetallePlazoFijoRubrosContables=@IdDetallePlazoFijoRubrosContables)