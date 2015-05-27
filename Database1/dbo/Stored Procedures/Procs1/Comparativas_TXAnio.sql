



CREATE Procedure [dbo].[Comparativas_TXAnio]
AS
SELECT 
 MIN(CONVERT(varchar, YEAR(Fecha))) AS Período,YEAR(Fecha)
FROM Comparativas
GROUP BY YEAR(Fecha) 
ORDER BY YEAR(Fecha) desc 



