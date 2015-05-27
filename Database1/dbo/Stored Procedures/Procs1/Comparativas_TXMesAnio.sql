



CREATE Procedure [dbo].[Comparativas_TXMesAnio]
AS
SELECT 
 MIN(CONVERT(varchar, MONTH(Fecha)) + '/' + CONVERT(varchar, YEAR(Fecha))) AS Período,
 YEAR(Fecha), 
 MONTH(Fecha)  
FROM Comparativas
GROUP BY YEAR(Fecha) ,MONTH(Fecha)  
ORDER BY YEAR(Fecha) desc ,MONTH(Fecha) desc



