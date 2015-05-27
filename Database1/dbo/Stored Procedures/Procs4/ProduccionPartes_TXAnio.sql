
CREATE Procedure ProduccionPartes_TXAnio
As
SELECT 
 Min(CONVERT(varchar, YEAR(fechadia)))  AS Período,YEAR(fechadia)
FROM ProduccionPartes
WHERE fechadia is not null
GROUP BY  YEAR(fechadia) 
ORDER by  YEAR(fechadia)  desc
