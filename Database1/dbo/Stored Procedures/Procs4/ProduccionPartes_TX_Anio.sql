

CREATE Procedure [dbo].[ProduccionPartes_TX_Anio]
As
SELECT 
 Min(CONVERT(varchar, YEAR(fechadia)))  AS Período,YEAR(fechadia)
FROM ProduccionPartes
WHERE fechadia is not null
GROUP BY  YEAR(fechadia) 
ORDER by  YEAR(fechadia)  desc

