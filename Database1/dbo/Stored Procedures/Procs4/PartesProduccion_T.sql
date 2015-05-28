CREATE Procedure [dbo].[PartesProduccion_T]

@IdParteProduccion int

AS 

SELECT*
FROM PartesProduccion
WHERE (IdParteProduccion=@IdParteProduccion)