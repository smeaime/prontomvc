﻿CREATE Procedure [dbo].[DetPlazosFijosRubrosContables_E]

@IdDetallePlazoFijoRubrosContables int

AS

DELETE DetallePlazosFijosRubrosContables
WHERE (IdDetallePlazoFijoRubrosContables=@IdDetallePlazoFijoRubrosContables)