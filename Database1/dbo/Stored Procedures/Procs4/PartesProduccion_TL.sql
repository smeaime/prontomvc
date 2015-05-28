CREATE Procedure [dbo].[PartesProduccion_TL]

AS 

SELECT IdParteProduccion, NumeroParteProduccion as [Titulo]
FROM PartesProduccion
ORDER BY NumeroParteProduccion